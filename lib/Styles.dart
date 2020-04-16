
import 'package:flutter/material.dart';

RoundedRectangleBorder rounded(size){
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(size)
  );
}

RoundedRectangleBorder roundedSideMenu(size){
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.only(topRight: Radius.circular(size),bottomRight: Radius.circular(size), ));
}

TextStyle whitetxt(double size){
  return TextStyle(fontSize: size, color: Colors.white);
}

TextStyle whiteboldtxt(double size){
  return TextStyle(fontSize: size,fontWeight: FontWeight.bold,  color: Colors.white,);
}

TextStyle blacktxt(double size){
  return TextStyle(fontSize: size, color: Colors.grey[900]);
}

TextStyle blackboldtxt(double size){
  return TextStyle(fontSize: size, fontWeight: FontWeight.bold, color: Colors.grey[900]);
}