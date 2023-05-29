import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login/googleLogin.dart';
import 'navbar/Navbar.dart';
// var scrheight;
// var scrwidth;
// var primaeryColor;
String? uId;
var userdata;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data == null) {
                return const Login();
              } else {
                userdata=snapshot.data!;
                uId = userdata!.uid;
                print("Hello :  $uId");
                return  NavBar();
              }
            }
            return const Center(child: CircularProgressIndicator());
          }),

      // Login(),
    );
  }
}
