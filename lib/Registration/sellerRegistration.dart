// import 'dart:io';
//
// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:vendor_app/Registration/landing-Newseller.dart';
// import 'package:vendor_app/login/otplogin.dart';
// import 'package:vendor_app/main.dart';
//
// import '../globals/colors.dart';
// import '../model/usermodel.dart';
//
// class SellerRegistration extends StatefulWidget {
//   String? name;
//   String? email;
//   String? userid;
//   SellerRegistration({super.key, this.name, this.email, this.userid});
//
//   @override
//   State<SellerRegistration> createState() => _SellerRegistrationState();
// }
//
// class _SellerRegistrationState extends State<SellerRegistration> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneNoController = TextEditingController();
//   TextEditingController solePropritorController = TextEditingController();
//   TextEditingController organizationController = TextEditingController();
//   TextEditingController companyAddressController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//   TextEditingController stateController = TextEditingController();
//   TextEditingController pincodeController = TextEditingController();
//   TextEditingController gstNoController = TextEditingController();
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
//   List<String> documents = [
//     "GST Certificate",
//     "FSSAI Registration",
//     "Udyam",
//     "Shop & Establishment License",
//     "Trade Certificate/Licence",
//     "Other(Any ID or Document with Business Name)"
//   ];
//
//   TextEditingController job = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
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
//                   borderRadius: BorderRadius.circular(15),
//                   color: Colors.white,
//                 ),
//                 width: w * 0.90,
//                 height: h * 0.8,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: w * 0.10, top: h * 0.03),
//                   child: SingleChildScrollView(
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Seller Registration",
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
//                           Text("CONTACT INFORMATION",
//                               style: GoogleFonts.roboto(
//                                   textStyle: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w700))),
//                           Container(
//                             width: w * 0.7,
//                             child: TextFormField(
//                               readOnly: true,
//                               decoration: InputDecoration(
//                                   enabledBorder: UnderlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: Color(0xff8C31FF))),
//                                   focusedBorder: UnderlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: Color(0xff8C31FF))),
//                                   suffixStyle: TextStyle(color: Colors.red),
//                                   hintText: widget.name,
//                                   suffixText: "*"),
//                             ),
//                           ),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Container(
//                             width: w * 0.7,
//                             child: TextFormField(
//                               readOnly: true,
//                               decoration: InputDecoration(
//                                 enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Color(0xff8C31FF))),
//                                 hintText: widget.email,
//                                 suffixText: "*",
//                                 suffixStyle: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           SizedBox(
//                             height: h * 0.02,
//                           ),
//                           Text("COMPANY INFORMATION",
//                               style: GoogleFonts.roboto(
//                                   textStyle: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w700))),
//                           SizedBox(
//                             height: h * 0.02,
//                           ),
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
//                                 hintText:
//                                     "GST NO: Leave Empty.if you don't have one",
//                                 suffixText: "*",
//                                 suffixStyle: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                           CustomDropdown(
//                             items: documents,
//                             hintText: "Select Document type",
//                             controller: job,
//                           ),
//                           SizedBox(
//                             height: h * 0.02,
//                           ),
//                           Stack(
//                             clipBehavior: Clip.none,
//                             children: [
//                               image == null
//                                   ? Container(
//                                       width: w * 0.3,
//                                       height: h * 0.13,
//                                       decoration: BoxDecoration(
//                                           color: Color(0xffE9E9E9),
//                                           border: Border.all(
//                                               color: Color(0xff530CAD))),
//                                     )
//                                   : Container(
//                                       width: w * 0.3,
//                                       height: h * 0.13,
//                                       decoration: BoxDecoration(
//                                           image: DecorationImage(
//                                               image: FileImage(image!),
//                                               fit: BoxFit.cover),
//                                           color: Color(0xffE9E9E9),
//                                           border: Border.all(
//                                               color: Color(0xff530CAD))),
//                                     ),
//                               Positioned(
//                                 left: w * 0.24,
//                                 bottom: h * 0.10,
//                                 child: InkWell(
//                                   onTap: () {
//                                     image = null;
//                                     setState(() {});
//                                   },
//                                   child: Container(
//                                     width: w * 0.09,
//                                     height: h * 0.05,
//                                     child: Icon(
//                                       Icons.cancel,
//                                       color: Color.fromARGB(255, 254, 253, 255),
//                                       size: 30,
//                                     ),
//                                     decoration: BoxDecoration(
//                                         color: Color(0xff8C31FF),
//                                         shape: BoxShape.circle),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: h * 0.02,
//                           ),
//                           Text(
//                             "GST CERTIFICATE",
//                             style: GoogleFonts.roboto(
//                                 textStyle:
//                                     TextStyle(fontWeight: FontWeight.w400)),
//                           ),
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
//                           Text("*d Limit 1 MB",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   color: Color(0xff530CAD))),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           TextButton(
//                             onPressed: () async {
//                               var updateData = UserModel(
//                                 Soleproprietor: solePropritorController.text,
//                                 Organization: organizationController.text,
//                                 CompanyAddress: companyAddressController.text,
//                                 city: cityController.text,
//                                 state: stateController.text,
//                                 pincode: pincodeController.text,
//                                 gstNo: gstNoController.text,
//                                 status: 0,
//                               );
//                               print("test"+widget.userid.toString());
//                               await FirebaseFirestore.instance
//                                   .collection("vendor")
//                                   .doc(widget.userid)
//                                   .update(updateData.toJson())
//                                   .then((value) => {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     Landing_Newseller()))
//                                       });
//                             },
//                             child: Container(
//                               width: w * 0.7,
//                               height: h * 0.05,
//                               decoration: BoxDecoration(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(17)),
//                                 gradient: LinearGradient(colors: [
//                                   Color(0xff8C31FF),
//                                   Color(0xff601AB9)
//                                 ]),
//                               ),
//                               child: Center(
//                                   child: Text(
//                                 "SUBMIT FOR APPROVAL ",
//                                 style: TextStyle(color: Colors.white),
//                               )),
//                             ),
//                           ),
//                           SizedBox(
//                             height: h * 0.01,
//                           ),
//                           Text(
//                             "By Continuing you agree to tharacart Terms and Conditions & Privacy Policy",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 color: Color(0xff530CAD)),
//                           ),
//                           SizedBox(
//                             height: h * 0.2,
//                           ),
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
