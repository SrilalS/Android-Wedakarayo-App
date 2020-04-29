import 'package:awapp/Services/Service.dart';
import 'package:awapp/Services/UserData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  setIsLogged(true);
  if (isLogged){
    setData(user);
  }
  return user;
}
