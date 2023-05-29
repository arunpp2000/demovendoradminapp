// import 'dart:io';
//
// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:im_stepper/stepper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:pinput/pinput.dart';
// import 'package:vendor_app/Registration/stepperCompletion.dart';
// import 'package:vendor_app/globals/colors.dart';
// import 'package:vendor_app/login/otplogin.dart';
//
// class Landing_Newseller extends StatefulWidget {
//   const Landing_Newseller({super.key});
//
//   @override
//   State<Landing_Newseller> createState() => _Landing_NewsellerState();
// }
//
// class _Landing_NewsellerState extends State<Landing_Newseller> {
//   List<String> documents = [
//     "GST Certificate",
//     "FSSAI Registration",
//     "Udyam",
//     "Shop & Establishment License",
//     "Trade Certificate/Licence",
//     "Other(Any ID or Document with Business Name)"
//   ];
//
//   late XFile photo;
//   File? image;
//
//   final picker = ImagePicker();
//
//   Future getImager() async {
//     var pickImage = await picker.pickImage(source: ImageSource.gallery);
//
//     setState(() {
//       if (pickImage != null) {
//         image = File(pickImage.path);
//         print(image);
//       } else {
//         print("no image selected");
//       }
//     });
//   }
//
//   TextEditingController job = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => Stepper_Completion()));
//               },
//               icon: Icon(Icons.forward))
//         ],
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
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(15),
//                       topRight: Radius.circular(15)),
//                   color: Colors.white,
//                 ),
//                 width: w * 0.90,
//                 height: h * 0.9,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: w * 0.10, top: h * 0.03),
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
//                             stepRadius: w * 0.054,
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
//                           Container(
//                               width: w * 0.7,
//                               height: h * 0.045,
//                               decoration:
//                                   BoxDecoration(color: Color(0xff66BD46)),
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     width: w * 0.03,
//                                   ),
//                                   SizedBox(
//                                     width: w * 0.03,
//                                   ),
//                                   Text(
//                                     'Company Details',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   SizedBox(
//                                     width: w * 0.03,
//                                   ),
//                                   Icon(
//                                     Icons.check_circle,
//                                     color: Colors.white,
//                                     size: 19,
//                                   ),
//                                 ],
//                               )),
//                           Padding(
//                             padding:
//                                 EdgeInsets.only(left: w * 0.56, top: h * 0.010),
//                             child: TextButton(
//                                 onPressed: () {},
//                                 child: Container(
//                                   width: w * 0.13,
//                                   height: h * 0.04,
//                                   color: Color(0xff822CEF),
//                                   child: Center(
//                                       child: Text(
//                                     "Edit",
//                                     style: TextStyle(color: Colors.white),
//                                   )),
//                                 )),
//                           ),
//                           // SizedBox(
//                           //   height: h * 0.01,
//                           // ),
//                           Container(
//                             width: w * 0.7,
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 hintText: "Company Description",
//                                 hintStyle: TextStyle(
//                                     color: primaryColor, fontSize: w * 0.035),
//                                 suffixText: "*",
//                                 suffixStyle: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: w * 0.04,
//                           ),
//                           Icon(Icons.check_circle, color: Colors.white),
//                           Container(
//                             width: w * 0.7,
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                   enabledBorder: UnderlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: Color(0xff8C31FF))),
//                                   focusedBorder: UnderlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: Color(0xff8C31FF))),
//                                   suffixStyle: TextStyle(color: Colors.red),
//                                   hintText: "Sole Proprietor/LLP/Partnership",
//                                   hintStyle: TextStyle(
//                                       color: primaryColor, fontSize: w * 0.035),
//                                   suffixText: "*"),
//                             ),
//                           ),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Container(
//                             width: w * 0.7,
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 hintText: "Organization/Business Name",
//                                 hintStyle: TextStyle(
//                                     color: primaryColor, fontSize: w * 0.035),
//                                 suffixText: "*",
//                                 suffixStyle: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Container(
//                             width: w * 0.7,
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 hintText: "Company Address",
//                                 hintStyle: TextStyle(
//                                     color: primaryColor, fontSize: w * 0.035),
//                                 suffixText: "*",
//                                 suffixStyle: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Container(
//                             width: w * 0.7,
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 hintText: "City",
//                                 hintStyle: TextStyle(
//                                     color: primaryColor, fontSize: w * 0.035),
//                                 suffixText: "*",
//                                 suffixStyle: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Container(
//                             width: w * 0.7,
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 hintText: "State",
//                                 hintStyle: TextStyle(
//                                     color: primaryColor, fontSize: w * 0.035),
//                                 suffixText: "*",
//                                 suffixStyle: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Container(
//                             width: w * 0.7,
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 hintText: "Pincode",
//                                 hintStyle: TextStyle(
//                                     color: primaryColor, fontSize: w * 0.035),
//                                 suffixText: "*",
//                                 suffixStyle: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Container(
//                             width: w * 0.7,
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 hintText: "GST NO ",
//                                 hintStyle: TextStyle(
//                                     color: primaryColor, fontSize: w * 0.035),
//                                 suffixText: "*",
//                                 suffixStyle: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                           CustomDropdown(
//                             items: documents,
//                             hintText: "Select Document type",
//                             hintStyle: TextStyle(
//                                 color: primaryColor, fontSize: w * 0.035),
//                             controller: job,
//                           ),
//                           SizedBox(
//                             height: h * 0.02,
//                           ),
//                           Row(
//                             children: [
//                               Stack(
//                                 clipBehavior: Clip.none,
//                                 children: [
//                                   image == null
//                                       ? Container(
//                                           width: w * 0.3,
//                                           height: h * 0.13,
//                                           decoration: BoxDecoration(
//                                               color: Color(0xffE9E9E9),
//                                               border: Border.all(
//                                                   color: Color(0xff530CAD))),
//                                         )
//                                       : Container(
//                                           width: w * 0.3,
//                                           height: h * 0.13,
//                                           decoration: BoxDecoration(
//                                               image: DecorationImage(
//                                                   image: FileImage(image!),
//                                                   fit: BoxFit.cover),
//                                               color: Color(0xffE9E9E9),
//                                               border: Border.all(
//                                                   color: Color(0xff530CAD))),
//                                         ),
//                                   Positioned(
//                                     left: w * 0.25,
//                                     bottom: h * 0.10,
//                                     child: InkWell(
//                                       onTap: () {
//                                         image = null;
//                                         setState(() {});
//                                       },
//                                       child: Container(
//                                         width: w * 0.09,
//                                         height: h * 0.06,
//                                         child: Icon(
//                                           Icons.cancel,
//                                           color: Color.fromARGB(
//                                               255, 254, 253, 255),
//                                           size: 30,
//                                         ),
//                                         decoration: BoxDecoration(
//                                             color: Color(0xff8C31FF),
//                                             shape: BoxShape.circle),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               SizedBox(
//                                 width: w * 0.07,
//                               ),
//                               Icon(
//                                 Icons.check_circle_outline,
//                                 color: Color(0xff66BD46),
//                               ),
//                               Text(
//                                 "GST CERTIFICATE",
//                                 style: TextStyle(fontSize: w * 0.03),
//                               )
//                             ],
//                           ),
//
//                           SizedBox(
//                             height: h * 0.02,
//                           ),
//
//                           SizedBox(
//                             height: h * 0.02,
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               getImager();
//                             },
//                             child: Container(
//                               width: w * 0.7,
//                               height: h * 0.05,
//                               decoration: BoxDecoration(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(8)),
//                                 gradient: LinearGradient(colors: [
//                                   Color(0xff8C31FF),
//                                   Color(0xff601AB9)
//                                 ]),
//                               ),
//                               child: Center(
//                                   child: Text(
//                                 "Upload Document",
//                                 style: TextStyle(color: Colors.white),
//                               )),
//                             ),
//                           ),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Text("*Supported file types JPEG, PNG OR PDF ",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   color: Color(0xff530CAD))),
//                           Text("*Upload Limit 1 MB",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   color: Color(0xff530CAD))),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Container(
//                             width: w * 0.7,
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 hintText: "Mobile number ",
//                                 hintStyle: TextStyle(
//                                     color: primaryColor, fontSize: w * 0.035),
//                                 suffixText: "*",
//                                 suffixStyle: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Container(
//                             width: w * 0.7,
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 hintText: "Email Address ",
//                                 hintStyle: TextStyle(
//                                     color: primaryColor, fontSize: w * 0.035),
//                                 suffixText: "*",
//                                 suffixStyle: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: h * 0.02,
//                           ),
//                           TextButton(
//                             onPressed: () {},
//                             child: Container(
//                               width: w * 0.7,
//                               height: h * 0.042,
//                               decoration: BoxDecoration(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(8)),
//                                 gradient: LinearGradient(colors: [
//                                   Color(0xff8C31FF),
//                                   Color(0xff601AB9)
//                                 ]),
//                               ),
//                               child: Center(
//                                   child: Text(
//                                 "Verify Mobile Number",
//                                 style: TextStyle(color: Colors.white),
//                               )),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Container(
//                                 width: w * 0.5,
//                                 child: TextFormField(
//                                   decoration: InputDecoration(
//                                     hintText: "+91| 1234567853",
//                                     hintStyle: TextStyle(fontSize: w * 0.035),
//                                     suffixText: "*",
//                                     suffixStyle: TextStyle(color: Colors.red),
//                                   ),
//                                 ),
//                               ),
//                               TextButton(
//                                 onPressed: () {},
//                                 child: Container(
//                                   width: w * 0.2,
//                                   height: h * 0.040,
//                                   decoration: BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(8)),
//                                     gradient: LinearGradient(colors: [
//                                       Color(0xff8C31FF),
//                                       Color(0xff601AB9)
//                                     ]),
//                                   ),
//                                   child: Center(
//                                       child: Text(
//                                     "Verify",
//                                     style: TextStyle(color: Colors.white),
//                                   )),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: h * 0.02,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: w * 0.11),
//                             child: Column(
//                               children: [
//                                 Text(
//                                   "Enter Verification Code",
//                                   style: TextStyle(fontWeight: FontWeight.w500),
//                                 ),
//                                 SizedBox(
//                                   height: h * 0.02,
//                                 ),
//                                 Pinput(
//                                   length: 4,
//                                   defaultPinTheme: PinTheme(
//                                       width: w * 0.09,
//                                       height: h * 0.034,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(10)),
//                                           border:
//                                               Border.all(color: primaryColor))),
//                                 ),
//                                 SizedBox(
//                                   height: h * 0.01,
//                                 ),
//                                 RichText(
//                                   text: TextSpan(children: [
//                                     TextSpan(
//                                         text: "Dont Recieve OTP? ",
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: w * 0.03)),
//                                     TextSpan(
//                                         text: "RESEND OTP",
//                                         style: TextStyle(
//                                             color: primaryColor,
//                                             fontSize: w * 0.03))
//                                   ]),
//                                 ),
//                                 SizedBox(
//                                   height: h * 0.03,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {},
//                             child: Container(
//                               width: w * 0.7,
//                               height: h * 0.042,
//                               decoration: BoxDecoration(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(8)),
//                                 gradient: LinearGradient(colors: [
//                                   Color(0xff8C31FF),
//                                   Color(0xff601AB9)
//                                 ]),
//                               ),
//                               child: Center(
//                                   child: Text(
//                                 "Verify Email Address",
//                                 style: TextStyle(color: Colors.white),
//                               )),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Container(
//                                 width: w * 0.5,
//                                 child: TextFormField(
//                                   decoration: InputDecoration(
//                                     hintText: "email@gmail.com",
//                                     hintStyle: TextStyle(fontSize: w * 0.035),
//                                     suffixText: "*",
//                                     suffixStyle: TextStyle(color: Colors.red),
//                                   ),
//                                 ),
//                               ),
//                               TextButton(
//                                 onPressed: () {},
//                                 child: Container(
//                                   width: w * 0.2,
//                                   height: h * 0.040,
//                                   decoration: BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(8)),
//                                     gradient: LinearGradient(colors: [
//                                       Color(0xff8C31FF),
//                                       Color(0xff601AB9)
//                                     ]),
//                                   ),
//                                   child: Center(
//                                       child: Text(
//                                     "Verify",
//                                     style: TextStyle(color: Colors.white),
//                                   )),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: h * 0.02,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: w * 0.11),
//                             child: Column(
//                               children: [
//                                 Text(
//                                   "Enter Verification Code",
//                                   style: TextStyle(fontWeight: FontWeight.w500),
//                                 ),
//                                 SizedBox(
//                                   height: h * 0.02,
//                                 ),
//                                 Pinput(
//                                   length: 4,
//                                   defaultPinTheme: PinTheme(
//                                       width: w * 0.09,
//                                       height: h * 0.034,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(10)),
//                                           border:
//                                               Border.all(color: primaryColor))),
//                                 ),
//                                 SizedBox(
//                                   height: h * 0.03,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             width: w * 0.7,
//                             height: h * 0.042,
//                             decoration: BoxDecoration(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(8)),
//                               gradient: LinearGradient(colors: [
//                                 Color(0xff8C31FF),
//                                 Color(0xff601AB9)
//                               ]),
//                             ),
//                             child: Center(
//                                 child: Text(
//                               "Add Bank Account",
//                               style: TextStyle(color: Colors.white),
//                             )),
//                           ),
//                           Container(
//                             width: w * 0.7,
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 hintText: "Bank Name ",
//                                 hintStyle: TextStyle(
//                                     color: primaryColor, fontSize: w * 0.035),
//                                 suffixText: "*",
//                                 suffixStyle: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: w * 0.7,
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 hintText: "Bank Accont Name ",
//                                 hintStyle: TextStyle(
//                                     color: primaryColor, fontSize: w * 0.035),
//                                 suffixText: "*",
//                                 suffixStyle: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: w * 0.7,
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 hintText: "Bank Accont Name ",
//                                 hintStyle: TextStyle(
//                                     color: primaryColor, fontSize: w * 0.035),
//                                 suffixText: "*",
//                                 suffixStyle: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: w * 0.7,
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 hintText: "IFSC CODE ",
//                                 hintStyle: TextStyle(
//                                     color: primaryColor, fontSize: w * 0.035),
//                                 suffixText: "*",
//                                 suffixStyle: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: h * 0.02,
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>Stepper_Completion()));
//                             },
//                             child: Container(
//                               width: w * 0.7,
//                               height: h * 0.042,
//                               decoration: BoxDecoration(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(8)),
//                                 gradient: LinearGradient(colors: [
//                                   Color(0xff8C31FF),
//                                   Color(0xff601AB9)
//                                 ]),
//                               ),
//                               child: Center(
//                                   child: Text(
//                                 "Submit",
//                                 style: TextStyle(color: Colors.white),
//                               )),
//
//                             ),
//                           ),
//                           SizedBox(height: h*0.2,)
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
