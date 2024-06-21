import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sante_en_poche/constant/background/backgroundmain.dart';

import 'package:sante_en_poche/screens/signup/signup.dart';
import 'package:sante_en_poche/screens/signup/signup3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySignup2 extends StatefulWidget {
  const MySignup2({super.key});

  @override
  State<MySignup2> createState() => _MySignup2State();
}

class _MySignup2State extends State<MySignup2> {
  TextEditingController birthDateController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController civilController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController assuranceController = TextEditingController();
  TextEditingController regimeController = TextEditingController();
  TextEditingController affiliationController = TextEditingController();
  TextEditingController kidnameController = TextEditingController();
  TextEditingController kidlastnameController = TextEditingController();
  TextEditingController kidcinController = TextEditingController();

  String? valueChoose;
  List<String> listItem = ["Femme", "Homme"];

  String? valueChoose2;
  List<String> listItem2 = ["Célibataire", "Marié(e)", "Divorcé(e)"];

  String? valueChoose3;
  List<String> listItem3 = [
    "Tanger-Tétouan-Al Hoceïma",
    "Oriental",
    "Fès-Meknès",
    "Rabat-Salé-Kénitra",
    "Béni Mellal-Khénifra",
    "Casablanca-Settat",
    "Marrakech-ASSafi",
    "Drâa-Tafilalet",
    "Souss-Massa",
    "Guelmim-Oued Noun",
    "Laâyoune-Sakia El Hamra",
    "Dakhla-Oued Ed-Dahab"
  ];

  String? valueChoose4;
  List<String> listItem4 = ["CNSS", "AMO", "CNOPS"];

  String? valueChoose5;
  List<String> listItem5 = [
    "Régime de couverture sociale",
    "Régime de couverture médicale",
    "Régime de couverture en assurance"
  ];

  String name = "";
  String lastname = "";

  bool _lights = false;
  bool _isUnderage = false;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name")!;
      lastname = prefs.getString("lastname")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.27,
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: Container(
                    width: size.width * 1,
                    height: size.height * 0.60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(75.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100.h,
                            ),
                            _buildInputField(
                              enabled: !_isUnderage,
                              controller: cinController,
                              context: context,
                              hintText: "N° Pièce d'Identité",
                              prefixIcon:
                                  'assets/images/signup/Icon awesome-address-card.svg',
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              width: 350.w,
                              height: size.height * 0.06,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffCAEBF3)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: SvgPicture.asset(
                                        'assets/images/signup/Icon ionic-md-male.svg'),
                                  ),
                                ),
                                child: DropdownButton<String>(
                                  hint: const Text(
                                    'Sexe',
                                    style: TextStyle(
                                      color: Color(0xffafafaf),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xff35CBCC),
                                  ),
                                  value: valueChoose,
                                  onChanged: !_isUnderage
                                      ? (newValue) {
                                          setState(() {
                                            valueChoose = newValue;
                                            genderController.text = newValue!;
                                          });
                                        }
                                      : null,
                                  items: listItem.map((valueItem) {
                                    return DropdownMenuItem<String>(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              width: 350.w,
                              height: size.height * 0.06,
                              child: TextFormField(
                                controller: birthDateController,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: SvgPicture.asset(
                                        'assets/images/signup/Icon awesome-calendar-alt.svg'),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: ' Enter your birthday',
                                  hintStyle: const TextStyle(
                                    color: Color(0xffafafaf),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: Color(0xffCAEBF3),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: Color(0xffCAEBF3),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                                onTap: () async {
                                  DateTime date = DateTime(1900);
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  date = (await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                            colorScheme:
                                                const ColorScheme.light()
                                                    .copyWith(
                                              primary: const Color(0xff35CBCC),
                                              onPrimary: Colors.white,
                                            ),
                                            canvasColor: Colors.white),
                                        child: child!,
                                      );
                                    },
                                  ))!;

                                  String dateFormatter = date.toIso8601String();
                                  DateTime dt = DateTime.parse(dateFormatter);
                                  var formatter = DateFormat('dd-MM-yyyy');
                                  birthDateController.text =
                                      formatter.format(dt);

                                  DateTime now = DateTime.now();
                                  int age = now.year - dt.year;
                                  if (now.month < dt.month ||
                                      (now.month == dt.month &&
                                          now.day < dt.day)) {
                                    age--;
                                  }

                                  if (age < 18) {
                                    setState(() {
                                      _isUnderage = true;
                                    });
                                  } else {
                                    setState(() {
                                      _isUnderage = false;
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              width: 350.w,
                              height: size.height * 0.06,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffCAEBF3)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: SvgPicture.asset(
                                        'assets/images/signup/Icon awesome-globe-africa.svg'),
                                  ),
                                ),
                                child: DropdownButton<String>(
                                  hint: const Text(
                                    'Etat Civil',
                                    style: TextStyle(
                                      color: Color(0xffafafaf),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xff35CBCC),
                                  ),
                                  value: valueChoose2,
                                  onChanged: !_isUnderage
                                      ? (newValue) {
                                          setState(() {
                                            valueChoose2 = newValue;
                                            civilController.text = newValue!;
                                          });
                                        }
                                      : null,
                                  items: listItem2.map((valueItem) {
                                    return DropdownMenuItem<String>(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            _buildInputField(
                              enabled: !_isUnderage,
                              controller: phoneController,
                              context: context,
                              hintText: "Téléphone",
                              prefixIcon:
                                  'assets/images/signup/Icon awesome-phone-alt.svg',
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            _buildInputField(
                              enabled: !_isUnderage,
                              controller: adresseController,
                              context: context,
                              hintText: "Adresse",
                              prefixIcon:
                                  'assets/images/signup/Icon material-location-on.svg',
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              width: 350.w,
                              height: size.height * 0.06,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffCAEBF3)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: SvgPicture.asset(
                                        'assets/images/signup/Icon material-location-on.svg'),
                                  ),
                                ),
                                child: DropdownButton<String>(
                                  hint: const Text(
                                    'Région',
                                    style: TextStyle(
                                      color: Color(0xffafafaf),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xff35CBCC),
                                  ),
                                  value: valueChoose3,
                                  onChanged: !_isUnderage
                                      ? (newValue) {
                                          setState(() {
                                            valueChoose3 = newValue;
                                            regionController.text = newValue!;
                                          });
                                        }
                                      : null,
                                  items: listItem3.map((valueItem) {
                                    return DropdownMenuItem<String>(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              width: 350.w,
                              height: size.height * 0.06,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffCAEBF3)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: SvgPicture.asset(
                                        'assets/images/signup/Icon awesome-shield-alt(2).svg'),
                                  ),
                                ),
                                child: DropdownButton<String>(
                                  hint: const Text(
                                    "Catégorie D'assurance Maladie",
                                    style: TextStyle(
                                      color: Color(0xffafafaf),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xff35CBCC),
                                  ),
                                  value: valueChoose4,
                                  onChanged: !_isUnderage
                                      ? (newValue) {
                                          setState(() {
                                            valueChoose4 = newValue;
                                            assuranceController.text =
                                                newValue!;
                                          });
                                        }
                                      : null,
                                  items: listItem4.map((valueItem) {
                                    return DropdownMenuItem<String>(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              width: 350.w,
                              height: size.height * 0.06,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffCAEBF3)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: SvgPicture.asset(
                                        'assets/images/signup/Icon awesome-shield-alt(2).svg'),
                                  ),
                                ),
                                child: DropdownButton<String>(
                                  hint: const Text(
                                    'Régime de couverture',
                                    style: TextStyle(
                                      color: Color(0xffafafaf),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xff35CBCC),
                                  ),
                                  value: valueChoose5,
                                  onChanged: !_isUnderage
                                      ? (newValue) {
                                          setState(() {
                                            valueChoose5 = newValue;
                                            regimeController.text = newValue!;
                                          });
                                        }
                                      : null,
                                  items: listItem5.map((valueItem) {
                                    return DropdownMenuItem<String>(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            _buildInputField(
                              enabled: !_isUnderage,
                              controller: affiliationController,
                              context: context,
                              hintText: "N° D'affiliation",
                              prefixIcon:
                                  'assets/images/signup/Icon awesome-shield-alt(2).svg',
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                CupertinoSwitch(
                                    activeColor: Colors.blue,
                                    value: _lights,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _lights = value;
                                      });
                                    }),
                                Text('Tuteur Légal (Pour Les Mineurs)'),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 165.w,
                                  height: size.height * 0.06,
                                  child: TextFormField(
                                    enabled: _lights,
                                    controller: kidlastnameController,
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(13.0),
                                        child: SvgPicture.asset(
                                            'assets/images/signup/Icon awesome-user-tiegreen.svg'),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: '   Nom',
                                      hintStyle: const TextStyle(
                                        color: Color(0xffafafaf),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color(0xffCAEBF3),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color(0xffCAEBF3),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 165.w,
                                  height: size.height * 0.06,
                                  child: TextFormField(
                                    enabled: _lights,
                                    controller: kidnameController,
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(13.0),
                                        child: SvgPicture.asset(
                                            'assets/images/signup/Icon awesome-user-tiegreen.svg'),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Prénom',
                                      hintStyle: const TextStyle(
                                        color: Color(0xffafafaf),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color(0xffCAEBF3),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color(0xffCAEBF3),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            _buildInputField(
                              enabled: _lights,
                              controller: kidcinController,
                              context: context,
                              hintText: "N° Pièce d'Identité",
                              prefixIcon:
                                  'assets/images/signup/Icon awesome-address-card.svg',
                            ),
                            SizedBox(
                              height: 100.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 50.w,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(colors: [
                          Color(0xffffffff),
                          Color(0xffd0e0fc),
                        ]),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: SvgPicture.asset(
                              'assets/images/signup/icons8_inscription_2.svg')),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Inscriptions',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                                'assets/images/signup/Icon awesome-user-tie.svg'),
                            SizedBox(
                              width: 10.w,
                            ),
                            const Text('Informations')
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: size.height * 0.1,
            width: size.width * 1,
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyBackground1(
                            useAppBar: true,
                            useMenuBar: false,
                            child: const MySignup(),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Retour',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(155.w, 45.h),
                      backgroundColor: const Color(0xff35cbcc),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () async {
                      if (cinController.text.isEmpty ||
                          genderController.text.isEmpty ||
                          birthDateController.text.isEmpty ||
                          civilController.text.isEmpty ||
                          phoneController.text.isEmpty ||
                          adresseController.text.isEmpty ||
                          regionController.text.isEmpty ||
                          assuranceController.text.isEmpty ||
                          regimeController.text.isEmpty ||
                          affiliationController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('All fields  are required.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString("CIN", cinController.text);
                      prefs.setString("Gender", genderController.text);
                      prefs.setString("Birthday", birthDateController.text);
                      prefs.setString("Etat Civil", civilController.text);
                      prefs.setString("Phone", phoneController.text);
                      prefs.setString("Adresse", adresseController.text);
                      prefs.setString("Région", regionController.text);
                      prefs.setString("Assurance", assuranceController.text);
                      prefs.setString("Régime", regimeController.text);
                      prefs.setString(
                          "Affiliation", affiliationController.text);
                      prefs.setString("kidName", kidnameController.text);
                      prefs.setString(
                          "kidLastName", kidlastnameController.text);
                      prefs.setString("kidCIN", kidcinController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyBackground2(
                            useMenuBar: false,
                            useAppBar: true,
                            child: const MySignup3(),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Suivant',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildInputField({
  required TextEditingController controller,
  required BuildContext context,
  required String hintText,
  required String prefixIcon,
  required bool enabled,
}) {
  Size size = MediaQuery.of(context).size;
  return SizedBox(
    width: 350.w,
    height: size.height * 0.06,
    child: TextFormField(
      enabled: enabled,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(13.0),
          child: SvgPicture.asset(prefixIcon),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xffafafaf),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.5,
            color: Color(0xffCAEBF3),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.5,
            color: Color(0xffCAEBF3),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}
