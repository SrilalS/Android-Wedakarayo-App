import 'package:awapp/Pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.green,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.green));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Android වැඩකාරයෝ',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(),
    );
  }
}