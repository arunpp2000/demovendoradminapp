// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:icons_flutter/icons_flutter.dart';
// import 'package:im_stepper/stepper.dart';
// import 'package:vendor_app/login/otplogin.dart';
// import 'package:vendor_app/navbar/Navbar.dart';
//
//
// import '../globals/colors.dart';
//
// import '../globals/colors.dart';
// import '../navbar/tabbarview/tabbar.dart';
//
// class Stepper_Completion extends StatefulWidget {
//   const Stepper_Completion({super.key});
//
//   @override
//   State<Stepper_Completion> createState() => _Stepper_CompletionState();
// }
//
// class _Stepper_CompletionState extends State<Stepper_Completion> {
//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//
//         backgroundColor: primaryColor,
//         title: Image.asset("assets/tharacart.png"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(children: [
//           Stack(children: [
//             Container(
//               width: w * 1,
//               height: h * 0.45,
//               decoration: BoxDecoration(
//                   color: primaryColor,
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(23),
//                       bottomRight: Radius.circular(23))),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: w * 0.05, top: h * 0.07),
//               child: Container(
//                 decoration: BoxDecoration(
//                   boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10)],
//                   borderRadius: BorderRadius.circular(15
//                      ),
//                   color: Colors.white,
//                 ),
//                 width: w * 0.90,
//                 height: h * 0.8,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: w * 0.06, top: h * 0.03),
//                   child: SingleChildScrollView(
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Complete Your Seller Profile",
//                             style: GoogleFonts.roboto(
//                                 textStyle: TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.w500)),
//                           ),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Divider(
//                             thickness: 4,
//                             endIndent: 30,
//                             color: Color(0xff530CAD),
//                           ),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Text("Please Complete Your Company Details.",
//                               style: GoogleFonts.roboto(
//                                   textStyle: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w700))),
//                           IconStepper(
//                             stepRadius: w * 0.04,
//                             lineLength: w*0.06,
//
//                             stepColor: Color(0xff66BD46),
//                             icons: [
//                               Icon(
//                                 Icons.check_circle_outline,
//                                 color: Colors.white,
//                               ),
//                               Icon(
//                                 Icons.check_circle_outline,
//                                 color: Colors.white,
//                               ),
//                               Icon(
//                                 Icons.looks_3,
//                                 color: Colors.white,
//                               ),
//                               Icon(
//                                 Icons.looks_4,
//                                 color: Colors.white,
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: w * 0.05),
//                             child: Column(
//                               children: [
//                                 Container(
//                                     width: w * 0.7,
//                                     height: h * 0.045,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         color: Color(0xff66BD46)),
//                                     child: Row(
//                                       children: [
//                                         SizedBox(
//                                           width: w * 0.03,
//                                         ),
//                                         SizedBox(
//                                           width: w * 0.03,
//                                         ),
//                                         Text(
//                                           'Company Details',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                         SizedBox(
//                                           width: w * 0.03,
//                                         ),
//                                         Icon(
//                                           Icons.check_circle,
//                                           color: Colors.white,
//                                           size: 19,
//                                         ),
//                                       ],
//                                     )),
//                                 SizedBox(
//                                   height: h * 0.01,
//                                 ),
//                                 Container(
//                                     width: w * 0.7,
//                                     height: h * 0.045,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         color: Color(0xff66BD46)),
//                                     child: Row(
//                                       children: [
//                                         SizedBox(
//                                           width: w * 0.03,
//                                         ),
//                                         SizedBox(
//                                           width: w * 0.03,
//                                         ),
//                                         Text(
//                                           'Verify Mobile Number',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                         SizedBox(
//                                           width: w * 0.03,
//                                         ),
//                                         Icon(
//                                           Icons.check_circle,
//                                           color: Colors.white,
//                                           size: 19,
//                                         ),
//                                       ],
//                                     )),
//                                 SizedBox(
//                                   height: h * 0.01,
//                                 ),
//                                 Container(
//                                     width: w * 0.7,
//                                     height: h * 0.045,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         color: Color(0xff66BD46)),
//                                     child: Row(
//                                       children: [
//                                         SizedBox(
//                                           width: w * 0.03,
//                                         ),
//                                         SizedBox(
//                                           width: w * 0.03,
//                                         ),
//                                         Text(
//                                           'Verify Email Address',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                         SizedBox(
//                                           width: w * 0.03,
//                                         ),
//                                         Icon(
//                                           Icons.check_circle,
//                                           color: Colors.white,
//                                           size: 19,
//                                         ),
//                                       ],
//                                     )),
//                                 SizedBox(
//                                   height: h * 0.01,
//                                 ),
//                                 Container(
//                                     width: w * 0.7,
//                                     height: h * 0.045,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         color: Color(0xff66BD46)),
//                                     child: Row(
//                                       children: [
//                                         SizedBox(
//                                           width: w * 0.03,
//                                         ),
//                                         SizedBox(
//                                           width: w * 0.03,
//                                         ),
//                                         Text(
//                                           'Add Bank Details',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                         SizedBox(
//                                           width: w * 0.03,
//                                         ),
//                                         Icon(
//                                           Icons.check_circle,
//                                           color: Colors.white,
//                                           size: 19,
//                                         ),
//                                       ],
//                                     )),
//                               ],
//                             ),
//                           ),
//                           Divider(
//                             indent: w * 0.03,
//                             endIndent: w * 0.07,
//                             thickness: h * 0.001,
//                             height: h * 0.07,
//                             color: Colors.black54,
//                           ),
//                           Text(
//                             "You have successfully completed  your profile.",
//                             style: TextStyle(
//                                 color: Color(
//                                   0xff530CAD,
//                                 ),
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: w * 0.035),
//                           ),
//                           SizedBox(
//                             height: h * 0.03,
//                           ),
//                           Text(
//                             "CLICK BELOW TO VISIT YOUR  DASHBOARD",
//                             style: TextStyle(
//                                 color: Color.fromARGB(255, 0, 0, 0),
//                                 fontWeight: FontWeight.w700),
//                           ),
//                           SizedBox(
//                             height: h * 0.03,
//                           ),
//                           Center(
//                             child: InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => Tabbar()));
//                               },
//                               child: Container(
//                                 width: w * 0.38,
//                                 height: h * 0.054,
//                                 decoration: BoxDecoration(
//                                     color: Color(0xff7626DD),
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(6))),
//                                 child: TextButton(
//                                     onPressed: () {
//                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Example()));
//
//                                     },
//                                     child: Row(
//                                       children: [
//                                         Icon(Icons.view_comfortable_rounded,
//                                             color: Colors.white),
//                                         SizedBox(
//                                           width: w * 0.02,
//                                         ),
//                                         Text(
//                                           "Dashboard",
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: w * 0.035),
//                                         ),
//                                         SizedBox(
//                                           height: h * 0.03,
//                                         ),
//                                       ],
//                                     )),
//                               ),
//                             ),
//                           ),
//                           Text(
//                             "NOTES:",
//                             style: TextStyle(
//                                 color: Color(0xff530CAD),
//                                 fontWeight: FontWeight.w500),
//                           ),
//                           Divider(
//                             endIndent: w * 0.07,
//                             thickness: h * 0.001,
//                             height: h * 0.03,
//                             color: Colors.black54,
//                           ),
//                           Text(
//                             ".  Please fill in all details completely.",
//                             style: TextStyle(fontWeight: FontWeight.w500),
//                           ),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Text(
//                               ".  You can edit few registration details later.",
//                               style: TextStyle(fontWeight: FontWeight.w500)),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Text(
//                               ".  Add your bank details Correctly, Bank Account \n   used for settlements",
//                               style: TextStyle(fontWeight: FontWeight.w500)),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Text(
//                               ".  Please double-check your email address. \n   This email is used for communication and \n   business transactions.",
//                               style: TextStyle(fontWeight: FontWeight.w500)),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Text(
//                               ". If you have any queries please mail us at \n  support@tharacart.com",
//                               style: TextStyle(fontWeight: FontWeight.w500)),
//                               SizedBox(
//                                 height: h*0.2,
//                               )
//                         ]),
//                   ),
//                 ),
//               ),
//             )
//           ])
//         ]),
//       ),
//     );
//   }
// }
