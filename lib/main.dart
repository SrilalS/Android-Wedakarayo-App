import 'package:awapp/Pages/Home.dart';
import 'package:awapp/Styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    defaultTransition: Transition.cupertinoDialog,
    theme: ThemeData(primaryColor: Colors.green),
    home: Home(),
  ));

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool dmode = sharedPreferences.getBool("DMODE") ?? false;

  if (dmode) {
    Get.changeTheme(ThemeData.dark());
    dmodeval = true;
  } else {
    Get.changeTheme(
        ThemeData(brightness: Brightness.light, primaryColor: Colors.green));
        dmodeval = false;
  }

}
