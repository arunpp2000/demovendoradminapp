// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'login/googleLogin.dart';
// import 'navbar/Navbar.dart';
//
// String? uId;
// var userdata;
//
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: CheckVerification(),
//     );
//   }
// }
//
// class CheckVerification extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         } else if (snapshot.hasData) {
//           final user = snapshot.data!;
//           return StreamBuilder<DocumentSnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection('admin_users')
//                 .doc(user.uid)
//                 .snapshots(),
//             builder: (BuildContext context,
//                 AsyncSnapshot<DocumentSnapshot> snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Scaffold(
//                   body: Center(child: CircularProgressIndicator()),
//                 );
//               } else if (snapshot.hasData) {
//                 final document = snapshot.data!;
//                 final bool verified = document.data()?['verified'] ?? false;
//                 return verified ? VerifiedPage() : UnverifiedPage();
//               } else if (snapshot.hasError) {
//                 return Scaffold(
//                   body: Center(child: Text(snapshot.error.toString())),
//                 );
//               } else {
//                 return Scaffold(
//                   body: Center(child: Text('No data available')),
//                 );
//               }
//             },
//           );
//         } else if (snapshot.hasError) {
//           return Scaffold(
//             body: Center(child: Text(snapshot.error.toString())),
//           );
//         } else {
//           return Login();
//         }
//       },
//     );
//   }
// }
//
// class VerifiedPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Verified Page'),
//       ),
//       body: Center(
//         child: Text('Welcome to the Verified Page'),
//       ),
//     );
//   }
// }
//
// class UnverifiedPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Unverified Page'),
//       ),
//       body: Center(
//         child: Text('Welcome to the Unverified Page'),
//       ),
//     );
//   }
// }
