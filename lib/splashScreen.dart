// import 'package:flutter/material.dart';
//
//
// var currentUserMail;
//
// class SplashSreen extends StatefulWidget {
//   const SplashSreen({super.key});
//
//   @override
//   State<SplashSreen> createState() => _SplashSreenState();
// }
//
// class _SplashSreenState extends State<SplashSreen> {
//   final prefence = SharedPreferences.getInstance();
//   loginEvent() async {
//     final prefence = await SharedPreferences.getInstance();
//     if (currentUserMail != null) {
//       prefence.setString("userId", currentUserMail);
//     } else {
//       currentUserMail = prefence.getString("userId");
//     }
//   }
//
//   @override
//   void initState() {
//     loginEvent().whenComplete(() {
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>
//               currentUserMail == null || currentUserMail == ""
//                   ? const Login_page()
//                   : const Users()),
//               (route) => false);
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }