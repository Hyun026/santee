import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sante_en_poche/constant/background/back.dart';
import 'package:sante_en_poche/screens/appointement/search/booking.dart';

class MySearch extends StatefulWidget {
  const MySearch({super.key});

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  List<Map<String, dynamic>> allResults = [];
  List<Map<String, dynamic>> resultList = [];
  final TextEditingController searchController = TextEditingController();
  String? selectedField;

  @override
  void initState() {
    searchController.addListener(onSearchChanged);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getDoctorList();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void onSearchChanged() {
    searchResultList();
  }

  void searchResultList() {
    List<Map<String, dynamic>> showResults = [];
    if (searchController.text.isNotEmpty) {
      for (var clientSnapshot in allResults) {
        var name = clientSnapshot['name'].toString().toLowerCase();
        var lastname = clientSnapshot['lastname'].toString().toLowerCase();
        if (name.contains(searchController.text.toLowerCase()) ||
            lastname.contains(searchController.text.toLowerCase())) {
          showResults.add(clientSnapshot);
        }
      }
    } else {
      showResults.addAll(allResults);
    }
    setState(() {
      resultList = showResults;
    });
  }

  void getDoctorList() async {
    var data = await FirebaseFirestore.instance.collection("doctors").orderBy('name').get();
    List<Map<String, dynamic>> docs = data.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    setState(() {
      allResults = docs;
    });

    searchResultList();
  }

  void filterResults() {
    List<Map<String, dynamic>> filteredList = allResults;

    if (selectedField != null && selectedField!.isNotEmpty) {
      filteredList = filteredList.where((doctor) {
        String field = doctor['field'].toLowerCase();
        return field.contains(selectedField!.toLowerCase());
      }).toList();
    }

    setState(() {
      resultList = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Recherche par Prénom',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              showFilterDialog(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: resultList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(resultList[index]['name']),
            subtitle: Text(resultList[index]['field']),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(resultList[index]['imageLink']),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Back(useAppBar: true,child: MyBooking(doctorDetails: resultList[index])),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter by:'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    hint: const Text('Select Field'),
                    value: selectedField,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedField = newValue;
                      });
                      filterResults();
                      Navigator.pop(context);
                    },
                    items: <String>['Pédiatrie', 'Dermatologist', 'General', 'Cardiologist', 'Dentist', 'Endocrinologist', 'Nephrologist', 'Neurology', 'Ophthalmology', 'Orthopedics', 'Pathology', 'Pulmonology']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
