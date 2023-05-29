import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../navbar/Navbar.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          signInWithGoogle();
        }, child: Text('login')),
      ),
    );
  }
  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);
    var userid = userCredential.user?.uid;
    var username = userCredential.user?.displayName;
    var userimage = userCredential.user?.photoURL;
    var useremail = userCredential.user?.email;
    FirebaseFirestore.instance.collection('admin_users').doc(userid).set({
      "uid": userid,
      "display_name": username,
      "email": useremail,
      "delete": false,
      "verified": false,
      "photo_url": userimage,
      "created_time": FieldValue.serverTimestamp(),
    }).then((value) => {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>NavBar()))
    });
  }
}
