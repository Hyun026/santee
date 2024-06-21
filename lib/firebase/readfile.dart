import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class GetUser extends StatelessWidget {
  final String documentId;
  const GetUser({required this.documentId});

  @override
  Widget build(BuildContext context) {
    //get collection
   
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
           if (snapshot.hasData && snapshot.data!.exists) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Column(
            
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _costumField( text : '${data['lastname']}', prefixIcon: "assets/images/myfile/Icon awesome-user-tie.svg", labeltext: 'Nom'),
                Container(
                    //line
                    height: 1.0.h,
                    width: size.width*1,
                    color: Color(0xff35CBCC),
                  ),
                  SizedBox(height: 20.h,),
                   _costumField( text : '${data['name']}', prefixIcon: "assets/images/myfile/Icon awesome-user-tie.svg", labeltext: 'Prénom'),
                Container(
                    //line
                    height: 1.0.h,
                    width: 200.0.w,
                    color: Color(0xff35CBCC),
                  ),
                  SizedBox(height: 20.h,),
                   _costumField( text : '${data['cin']}', prefixIcon: "assets/images/myfile/Icon awesome-address-card.svg", labeltext: "N° Pièce d'Identité"),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: Color(0xff35CBCC),
                  ),
                  SizedBox(height: 20.h,),
                    _costumField( text : '${data['gender']}', prefixIcon: "assets/images/myfile/Icon ionic-md-male.svg", labeltext: "Sexe"),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: Color(0xff35CBCC),
                  ),
                  SizedBox(height: 20.h,),
                    _costumField( text : '${data['birthday']}', prefixIcon: "assets/images/myfile/Icon awesome-calendar-alt.svg", labeltext: "Date de naissance"),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: Color(0xff35CBCC),
                  ),
                  SizedBox(height: 20.h,),
                    _costumField( text : '${data['Etat Civil']}', prefixIcon: "assets/images/myfile/Icon awesome-globe-africa.svg", labeltext: "Etat Civil"),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: Color(0xff35CBCC),
                  ),
                  SizedBox(height: 20.h,),
                    _costumField( text : '${data['Phone']}', prefixIcon: "assets/images/myfile/Icon awesome-phone-alt.svg", labeltext: "Téléphone"),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: Color(0xff35CBCC),
                  ),
                  SizedBox(height: 20.h,),
                   _costumField( text : '${data['adress']}', prefixIcon: "assets/images/myfile/Icon material-location-on.svg", labeltext: "Adresse"),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: Color(0xff35CBCC),
                  ),
                  SizedBox(height: 20.h,),
                   _costumField( text : '${data['Région']}', prefixIcon: "assets/images/myfile/Icon material-location-on.svg", labeltext: "Région"),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: Color(0xff35CBCC),
                  ),
                  SizedBox(height: 20.h,),
                    _costumField( text : '${data['assurance']}', prefixIcon: "assets/images/myfile/Icon awesome-shield-alt(2).svg", labeltext: "Catégorie D'assurance Maladie"),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: Color(0xff35CBCC),
                  ),
                  SizedBox(height: 20.h,),
                    _costumField( text : '${data['Régime']}', prefixIcon: "assets/images/myfile/Icon awesome-shield-alt(2).svg", labeltext: "Régime De Couverture"),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: Color(0xff35CBCC),
                  ),
                  SizedBox(height: 20.h,),
                    _costumField( text : '${data['Affiliation']}', prefixIcon: "assets/images/myfile/Icon awesome-shield-alt(2).svg", labeltext: "N°D'affiliation"),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: Color(0xff35CBCC),
                  ),
                  SizedBox(height: 20.h,),
                   Container(
                    height: 40.h,
                    width: size.width*1,
                    decoration: BoxDecoration(
                      color: Color(0xff0074AF),
                      borderRadius: BorderRadius.circular(20.0),
            
                    ),
                    child: Center(child: Text('Tuteur Légal (Pour Les Mineurs)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 17.sp),)),
            
                   ),
                   SizedBox(height: 20.h,),
                    Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: Color(0xff35CBCC),
                  ),
                  SizedBox(height: 20.h,),
                   _costumField( text : '${data['kidLastName']}', prefixIcon: "assets/images/myfile/Icon awesome-user-tie.svg", labeltext: "Nom"),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: Color(0xff35CBCC),
                  ),
                  SizedBox(height: 20.h,),
                   _costumField( text : '${data['kidName']}', prefixIcon: "assets/images/myfile/Icon awesome-user-tie.svg", labeltext: "Prénom"),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: Color(0xff35CBCC),
                  ),
                  SizedBox(height: 20.h,),
                   _costumField( text : '${data['kidCIN']}', prefixIcon: "assets/images/myfile/Icon awesome-address-card.svg", labeltext: "N°Pièce D'identité"),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: Color(0xff35CBCC),
                  ),
                  SizedBox(height: 50.h,),
            
              
              ],
            ),
          );
           }else {
            return Text('Document does not exist');
           }
        }
        return Text('loading..');
  }),
      future:  FirebaseFirestore.instance.collection('users').doc(documentId).get(),
    );
  }
}

Widget _costumField({
  required String text,
  required String prefixIcon,
  required String labeltext,
}) {
  return Container(
    color: Colors.white,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: SvgPicture.asset(prefixIcon),
        ),
        Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: [
            Text(labeltext, style: TextStyle(color: Color(0xffA1A1A1), fontSize: 10.sp), ),
            Text(text, style: TextStyle(color: Color(0xff044289),fontSize: 20.sp, fontWeight: FontWeight.bold),),
          ],
        ),
      ],
    ),
  );
}

