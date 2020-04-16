import 'package:awapp/Styles.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Sign extends StatefulWidget {
  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> {
  
final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<FirebaseUser> handleSignIn() async {
  final GoogleSignInAccount googleUser = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user = (await auth.signInWithCredential(credential)).user;
  print("signed in " + user.displayName);
  return user;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
              child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 64,
              width: 286,
              child: RaisedButton(
                shape: rounded(32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.verified_user),
                    Text('Sign in with Google')

                  ],
                ),
                onPressed: (){
                handleSignIn();
              }),
            )
          ],
        ),),
      ),
    );
  }
}