
import 'package:flutter/material.dart';

class MXX extends StatefulWidget {
  @override
  _MXXState createState() => _MXXState();
}

class _MXXState extends State<MXX> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RaisedButton(
        child: Row(
          children: <Widget>[
            Icon(Icons.call),
            Text('Your Text'),
          ],
        ),
        onPressed: (){
        //Actions
      }),
      
    );
  }
}