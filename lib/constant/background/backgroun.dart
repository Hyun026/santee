import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sante_en_poche/constant/background/back.dart';
import 'package:sante_en_poche/screens/appointement/search/searchlist.dart';


class Backmain extends StatelessWidget {
  final Widget child;
  final bool useAppBar;
  const Backmain( {Key? key,
      required this.child,
      this.useAppBar = true,
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget? appBarWidget;
    if (useAppBar == true) {
      appBarWidget = AppBar(
        elevation: 0,
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          'Retour',
          style: TextStyle(color: Colors.white, fontSize: 25.sp),
        ),
        backgroundColor: Colors.transparent,
        actions: [
      IconButton(
        color: Colors.white,
        icon: Icon(Icons.notifications),
        onPressed: () {
         
        },
      ),
    ],
      );
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBarWidget,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff3C7CDC),
                  Color(0Xff8BC2F8),
                ],
              ),
            ),
          ),
           Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              'assets/images/background/Intersection 1.svg',
            ),
          ),
          child,
        ]
      ),
     floatingActionButton: FloatingActionButton(
          onPressed: () {
             Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Back(useAppBar: true,
                            child: MyMainPage()) ),
                        );
          },
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0)),
          backgroundColor: Colors.white,
          child: Icon(Icons.add,color: Colors.blue,),
        ),

    );
    
  }
}