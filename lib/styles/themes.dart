import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

var defaultColor = Colors.blue;

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: defaultColor,
      backgroundColor: HexColor('333739'),
      elevation: 20.0,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey),
  appBarTheme: AppBarTheme(
      elevation: 0.0,
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light),
      backgroundColor: HexColor("333739"),
      titleTextStyle: const TextStyle(
          color: Colors.blue, fontSize: 22.0, fontWeight: FontWeight.bold),
      actionsIconTheme: IconThemeData(color: defaultColor)),
  textTheme: const TextTheme(
      bodyText2: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white)),
  fontFamily: 'times',
);

ThemeData lightTheme = ThemeData(
    textTheme: const TextTheme(
        bodyText2: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black)),
    primarySwatch: defaultColor,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: defaultColor),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.black),
      actionsIconTheme: IconThemeData(color: defaultColor),
      titleSpacing: 20.0,
      titleTextStyle: TextStyle(
          color: defaultColor, fontSize: 22, fontWeight: FontWeight.bold),
      elevation: 0.0,
      backgroundColor: Colors.white,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: defaultColor,
        elevation: 20.0),
    fontFamily: 'times');
