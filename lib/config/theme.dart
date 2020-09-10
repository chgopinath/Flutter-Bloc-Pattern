import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './colors.dart';

class AppTheme {

  static ThemeData getThemeConfig() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: AppColors.colorPrimarySwatch,
      primaryColor: AppColors.colorPrimary,
      primaryColorDark: AppColors.colorPrimaryDark,
      accentColor:  AppColors.colorAccent,
      scaffoldBackgroundColor: Colors.white,
      textSelectionHandleColor: Colors.black,
      textSelectionColor: Colors.black12,
      cursorColor: Colors.black,

      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: Colors.black,
      ),


      toggleableActiveColor: Colors.black,

     textTheme: TextTheme(
       headline1: TextStyle(fontSize: 18,color: AppColors.colorPrimaryDark,fontWeight: FontWeight.bold),
       headline2: TextStyle(fontSize: 16,color: Colors.black),
       headline3: TextStyle(fontSize: 14,color: Colors.deepOrange),
     ),


      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorAccent),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorAccent),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorAccent),
        ),
        labelStyle: const TextStyle(
          color: AppColors.colorAccent,
        ),
      ),
    );
  }
}
