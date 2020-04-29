import 'package:cloud_firestore/cloud_firestore.dart';

import 'UserData.dart';

final dbmain = Firestore.instance;

void addtoSaved(String title, String url, String pid){
  print(pid);
  dbmain.collection('USERS').document(userEmail).collection('SAVED').document(pid).setData({
    'TITLE': title,
    'URL' : url
  });
}

var savedList = [];

void dbgetSaved(){

}