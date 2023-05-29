// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
//
// import '../globals/colors.dart';
// import '../navbar/tabbarview/tabbar.dart';
// import 'otplogin.dart';
//
// String? email;
// String? name;
//
// class Profile_Details extends StatefulWidget {
//   final String? userid;
//   const Profile_Details({Key? key, this.userid})
//       : super(
//           key: key,
//         );
//
//   @override
//   State<Profile_Details> createState() => _Profile_DetailsState();
// }
//
// class _Profile_DetailsState extends State<Profile_Details> {
//   final EmailController = TextEditingController();
//   final NameController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(w * 0.02),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//                 child: Text(
//               "Profile Details",
//               style: GoogleFonts.roboto(
//                   textStyle: TextStyle(
//                     decoration: TextDecoration.underline,
//                     color: primaryColor,
//                   ),
//                   fontWeight: FontWeight.bold,
//                   fontSize: w * 0.05),
//             )),
//             SizedBox(
//               height: h * 0.02,
//             ),
//             TextFormField(
//               controller: NameController,
//               decoration: InputDecoration(
//                   enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: primaryColor)),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(
//                     Radius.circular(h * 0.01),
//                   )),
//                   filled: true,
//                   fillColor: Colors.white,
//                   hintText: "Name"),
//             ),
//             SizedBox(
//               height: h * 0.02,
//             ),
//             TextFormField(
//               controller: EmailController,
//               decoration: InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: primaryColor)),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                   Radius.circular(h * 0.01),
//                 )),
//                 filled: true,
//                 fillColor: Colors.white,
//                 hintText: "Email",
//               ),
//             ),
//             SizedBox(
//               height: h * 0.02,
//             ),
//             InkWell(
//               onTap: () {
//                 print("test "+widget.userid.toString());
//                 FirebaseFirestore.instance
//                     .collection("vendor")
//                     .doc(widget.userid)
//                     .update({"name": NameController.text, "email": EmailController.text}).then(
//                   (value) {
//                   //   Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(
//                   //           builder: (context) => SellerRegistration(name: NameController.text,email: EmailController.text,userid: widget.userid,)));
//                   // },
//                 );
//               },
//
//               //
//               child: Container(
//                 height: h * 0.05,
//                 width: w * 0.700,
//                 decoration: BoxDecoration(
//                     color: primaryColor,
//                     borderRadius: BorderRadius.circular(w * 0.02)),
//                 child: Center(
//                     child: Text(
//                   "Confirm",
//                   style: GoogleFonts.roboto(
//                       textStyle: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold)),
//                 )),
//               ),
//             ),
//             SizedBox(
//               height: h * 0.02,
//             ),
//             Text(
//               "By Clicking Confirm you agree tp share your information.",
//               style:
//                   GoogleFonts.roboto(textStyle: TextStyle(fontSize: h * 0.013)),
//             ),
//             Text(
//               "Also Agree with our terms and conditions",
//               style:
//                   GoogleFonts.roboto(textStyle: TextStyle(fontSize: h * 0.013)),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
