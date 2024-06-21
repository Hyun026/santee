import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

Widget _buildInputField({required String hintText, required String prefixIcon}) {
  Size size = MediaQuery.of(context as BuildContext).size;
  return SizedBox(
    width: 350.w,
    height: size.height * 0.06,
    child: TextFormField(
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(13.0),
          child: SvgPicture.asset(prefixIcon),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color(0xffafafaf),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: Color(0xffCAEBF3),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: Color(0xffCAEBF3),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}
