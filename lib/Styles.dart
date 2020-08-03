
import 'package:flutter/material.dart';

bool dmodeval = false;

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
  return TextStyle(fontSize: size);
}

TextStyle whiteboldtxt(double size){
  return TextStyle(fontSize: size,fontWeight: FontWeight.bold);
}

TextStyle blacktxt(double size){
  return TextStyle(fontSize: size);
}

TextStyle blackboldtxt(double size){
  return TextStyle(fontSize: size, fontWeight: FontWeight.bold);
}

TextStyle whitetxtdef(double size){
  return TextStyle(fontSize: size, color: Colors.white);
}