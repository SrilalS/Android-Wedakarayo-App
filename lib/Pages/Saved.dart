import 'package:awapp/Services/Service.dart';
import 'package:awapp/Services/UserData.dart';
import 'package:awapp/Services/Userdta.dart';
import 'package:awapp/Styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SavedItems extends StatefulWidget {
  @override
  _SavedItemsState createState() => _SavedItemsState();
}

class _SavedItemsState extends State<SavedItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: isLogged
            ? StreamBuilder(
                stream: dbmain
                    .collection('USERS')
                    .document(userEmail)
                    .collection('SAVED')
                    .getDocuments()
                    .asStream(),
                builder: (context, data) {
                  if (data.connectionState == ConnectionState.waiting) {
                    return LinearProgressIndicator(
                      backgroundColor: Colors.green,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    );
                  }

                  if (!data.hasData){
                    return Center(
                      child: Text('You Haven\'t Saved Anything',style: whiteboldtxt(16),),
                    );
                  }
                  return ListView.builder(
                      itemCount: data.hasData ? data.data.documents.length : 0,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(data.data.documents[index]['TITLE']),
                            trailing: FloatingActionButton(
                              mini: true,
                              backgroundColor: Colors.red,
                              child: Icon(Icons.remove),
                              onPressed: () {
                              setState(() {
                                dbmain
                                    .collection('USERS')
                                    .document(userEmail)
                                    .collection('SAVED')
                                    .document(
                                        data.data.documents[index].documentID)
                                    .delete();
                              });
                            }),
                          ),
                        );
                      });
                })
            : Center(
                child: Text(
                  'Please Log in First',
                  style: whiteboldtxt(16),
                ),
              ));
  }
}
