import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../globals/colors.dart';
import '../model/brandModel.dart';
import '../model/usermodel.dart';

class Edit extends StatefulWidget {
  AddBrand? brandData;
  Edit({super.key, this.brandData});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  bool editBrandaffiliate = false;
  String? editebannerUrl;
  String? editbrandUrl;
  TextEditingController editbrandName = TextEditingController();
  TextEditingController editbrandtitle = TextEditingController();
  TextEditingController editcouponCode = TextEditingController();
  TextEditingController editcontentDetails = TextEditingController();
  TextEditingController editfeatureName = TextEditingController();
  List<String> editsellers = ["Today", "This Week", " This Month", "This Year"];
  TextEditingController editseller = TextEditingController();
  TextEditingController editpercentage = TextEditingController();
  TextEditingController editYoutubeVideoUrl = TextEditingController();
  TextEditingController editcommissionPer = TextEditingController();
  List<String> editcommision = ["percentage %", "Amount"];

  List editgalaryimageUrl = [];

  File? editimage1;
  File? editimage2;
  final picker = ImagePicker();

  editgetBanner() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickImage != null) {
        editimage2 = File(pickImage.path);
        print(editimage2);
        edituploadBanner(editimage2!);
      } else {
        print("no image selected");
      }
    });
  }

  edituploadBanner(File imageFile) async {
    String fileName = (editimage1!.path);
    Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL();
    editebannerUrl = await taskSnapshot.ref.getDownloadURL();
  }

  Future getBrandlogo() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickImage != null) {
        editimage1 = File(pickImage.path);
        print(editimage1);
        edituploadBrand(editimage1!);
      } else {
        print("no image selected");
      }
    });
  }

  edituploadBrand(File imageFile) async {
    String fileName = (editimage1!.path);
    Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    editbrandUrl = await taskSnapshot.ref.getDownloadURL();
  }

  List editfeatureimages = [];
  List<String> editdownloadUrls = [];
  getMultipleimages() async {
    final List<XFile>? pickedimages = await picker.pickMultiImage();

    if (pickedimages != null) {
      pickedimages.forEach((e) async {
        editfeatureimages.add(File(e.path));
      });
      setState(() {});
    }
    for (int i = 0; i < editfeatureimages.length; i++) {
      String url = await uploadfiles(editfeatureimages[i]);
      editdownloadUrls.add(url);
    }
  }

  Future<String> uploadfiles(File file) async {
    final metaData = SettableMetadata(contentType: 'image/jpeg');
    final storageref = FirebaseStorage.instance.ref();
    Reference ref = storageref
        .child('pictures/${DateTime.now().microsecondsSinceEpoch}.jpg');
    final uploadTask = ref.putFile(file, metaData);

    final taskSnapshot = await uploadTask.whenComplete(() => null);
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  List editgalaryImages = [];
  List<String> editgalaryImagesUrls = [];
  getGallaryimages() async {
    final List<XFile>? pickedimage = await picker.pickMultiImage();

    if (pickedimage != null) {
      pickedimage.forEach((e) async {
        editgalaryImages.add(File(e.path));
      });
      setState(() {});
    }
    for (int i = 0; i < editgalaryImages.length; i++) {
      String url = await uploadfiles(editgalaryImages[i]);
      editgalaryImagesUrls.add(url);
    }
  }

  Future<String> uploadGallaryImg(File file) async {
    final metaData = SettableMetadata(contentType: 'image/jpeg');
    final storageref = FirebaseStorage.instance.ref();
    Reference ref = storageref
        .child('pictures/${DateTime.now().microsecondsSinceEpoch}.jpg');
    final uploadTask = ref.putFile(file, metaData);

    final taskSnapshot = await uploadTask.whenComplete(() => null);
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  // @override
  // void initState() {
  //   getUser();
  //   getBrand();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      // body: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Container(
      //         height: h * 0.05,
      //         width: w * 0.98,
      //         decoration: BoxDecoration(
      //             color: primaryColor,
      //             borderRadius: const BorderRadius.only(
      //                 topLeft: Radius.circular(10),
      //                 topRight: Radius.circular(10))),
      //         child: const TabBar(
      //           indicatorColor: Colors.transparent,
      //           indicator: BoxDecoration(
      //               color: Colors.green,
      //               borderRadius: BorderRadius.only(
      //                   topLeft: Radius.circular(10),
      //                   topRight: Radius.circular(10))),
      //
      //           tabs: <Widget>[
      //             Tab(text: 'Upload'),
      //             Tab(text: 'Edit'),
      //           ],
      //           labelColor: Colors
      //               .white, // Customize the appearance of the TabBar
      //         ),
      //       ),
      //       // ToggleSwitch(
      //       //   minWidth: double.maxFinite,
      //       //   minHeight: h * 0.05,
      //       //   customWidths: [w*0.458, w*0.459],
      //       //   totalSwitches: 2,
      //       //   cornerRadius: 3,
      //       //   activeBgColor: [
      //       //     Color(0xff66BD46),
      //       //   ],
      //       //   inactiveBgColor: primaryColor,
      //       //   labels: ["Upload", "Edit"],
      //       //   activeFgColor: Colors.white,
      //       //   inactiveFgColor: Colors.white,
      //       // ),
      //       SizedBox(
      //         height: h * 2.3,
      //         width: double.maxFinite,
      //         child: TabBarView(
      //           children: [
      //             Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: SingleChildScrollView(
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text("Upload Brand Logo",
      //                         style: GoogleFonts.roboto(
      //                             textStyle: TextStyle(
      //                                 fontSize: w * 0.025,
      //                                 fontWeight: FontWeight.bold))),
      //                     SizedBox(
      //                       height: h * 0.012,
      //                     ),
      //                     SizedBox(
      //                       width: w * 0.9,
      //                       height: h * 0.0009,
      //                       child: ColoredBox(color: Colors.grey),
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.02,
      //                     ),
      //                     Center(
      //                       child: Stack(
      //                         clipBehavior: Clip.none,
      //                         children: [
      //                           image1 == null
      //                               ? Container(
      //                             width: w * 0.3,
      //                             height: h * 0.13,
      //                             decoration: BoxDecoration(
      //                               borderRadius:
      //                               BorderRadius.all(
      //                                   Radius.circular(
      //                                       12)),
      //                               color: Color(0xffE9E9E9),
      //                             ),
      //                           )
      //                               : Container(
      //                             width: w * 0.3,
      //                             height: h * 0.13,
      //                             decoration: BoxDecoration(
      //                               borderRadius:
      //                               BorderRadius.all(
      //                                   Radius.circular(
      //                                       12)),
      //                               image: DecorationImage(
      //                                   image:
      //                                   FileImage(image1!),
      //                                   fit: BoxFit.cover),
      //                               color: Color(0xffE9E9E9),
      //                             ),
      //                           ),
      //                           // Positioned(
      //                           //   left: w * 0.24,
      //                           //   bottom: h * 0.10,
      //                           //   child: InkWell(
      //                           //     onTap: () {
      //                           //       image1 = null;
      //                           //       setState(() {});
      //                           //     },
      //                           //     child: Container(
      //                           //       width: w * 0.09,
      //                           //       height: h * 0.05,
      //                           //       child: Icon(
      //                           //         Icons.cancel,
      //                           //         color:
      //                           //             Color.fromARGB(255, 254, 253, 255),
      //                           //         size: 30,
      //                           //       ),
      //                           //       decoration: BoxDecoration(
      //                           //           color: Color(0xff8C31FF),
      //                           //           shape: BoxShape.circle),
      //                           //     ),
      //                           //   ),
      //                           // )
      //                         ],
      //                       ),
      //                     ),
      //
      //                     SizedBox(
      //                       height: h * 0.02,
      //                     ),
      //                     Center(
      //                       child: TextButton(
      //                         onPressed: () {
      //                           getBrandlogo();
      //                         },
      //                         child: Container(
      //                           width: w * 0.9,
      //                           height: h * 0.05,
      //                           decoration: BoxDecoration(
      //                               gradient: gradient,
      //                               borderRadius: BorderRadius.all(
      //                                   Radius.circular(10))),
      //                           child: Center(
      //                               child: Text(
      //                                 "Upload Brand Logo",
      //                                 style:
      //                                 TextStyle(color: Colors.white),
      //                               )),
      //                         ),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.013,
      //                     ),
      //                     Text(".Brand Logo : 1000 x 1000 px",
      //                         style: GoogleFonts.roboto(
      //                             textStyle: TextStyle(
      //                                 fontSize: w * 0.025,
      //                                 color: primaryColor))),
      //                     SizedBox(
      //                       height: h * 0.013,
      //                     ),
      //                     Text("Upload Brand Logo",
      //                         style: GoogleFonts.roboto(
      //                             textStyle: TextStyle(
      //                                 fontSize: w * 0.03,
      //                                 fontWeight: FontWeight.bold))),
      //                     SizedBox(
      //                       height: h * 0.012,
      //                     ),
      //                     SizedBox(
      //                       width: w * 0.9,
      //                       height: h * 0.0009,
      //                       child: ColoredBox(color: Colors.grey),
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.02,
      //                     ),
      //                     Center(
      //                       child: Stack(
      //                         clipBehavior: Clip.none,
      //                         children: [
      //                           image2 == null
      //                               ? Container(
      //                             width: w * 0.55,
      //                             height: h * 0.12,
      //                             decoration: BoxDecoration(
      //                               borderRadius:
      //                               BorderRadius.all(
      //                                   Radius.circular(
      //                                       12)),
      //                               color: Color(0xffE9E9E9),
      //                             ),
      //                           )
      //                               : Container(
      //                             width: w * 0.55,
      //                             height: h * 0.12,
      //                             decoration: BoxDecoration(
      //                               borderRadius:
      //                               BorderRadius.all(
      //                                   Radius.circular(
      //                                       12)),
      //                               image: DecorationImage(
      //                                   image:
      //                                   FileImage(image2!),
      //                                   fit: BoxFit.fill),
      //                               color: Color(0xffE9E9E9),
      //                             ),
      //                           ),
      //                           // Positioned(
      //                           //   left: w * 0.49,
      //                           //   bottom: h * 0.091,
      //                           //   child: InkWell(
      //                           //     onTap: () {
      //                           //       image2 = null;
      //                           //       setState(() {});
      //                           //     },
      //                           //     child: Container(
      //                           //       width: w * 0.09,
      //                           //       height: h * 0.05,
      //                           //       child: Icon(
      //                           //         Icons.cancel,
      //                           //         color:
      //                           //             Color.fromARGB(255, 254, 253, 255),
      //                           //         size: 30,
      //                           //       ),
      //                           //       decoration: BoxDecoration(
      //                           //           color: Color(0xff8C31FF),
      //                           //           shape: BoxShape.circle),
      //                           //     ),
      //                           //   ),
      //                           // )
      //                         ],
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.02,
      //                     ),
      //                     Center(
      //                       child: TextButton(
      //                         onPressed: () {
      //                           getBanner();
      //                         },
      //                         child: Container(
      //                           width: w * 0.9,
      //                           height: h * 0.05,
      //                           decoration: BoxDecoration(
      //                               gradient: gradient,
      //                               borderRadius: BorderRadius.all(
      //                                   Radius.circular(10))),
      //                           child: Center(
      //                               child: Text(
      //                                 "Upload Banner",
      //                                 style:
      //                                 TextStyle(color: Colors.white),
      //                               )),
      //                         ),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.013,
      //                     ),
      //                     Text(".Banner Size : 1916 x 700 px",
      //                         style: GoogleFonts.roboto(
      //                             textStyle: TextStyle(
      //                                 fontSize: w * 0.025,
      //                                 color: primaryColor))),
      //                     SizedBox(
      //                       height: h * 0.015,
      //                     ),
      //                     Container(
      //                       width: w * 0.8,
      //                       child: TextFormField(
      //                         controller: brandName,
      //                         decoration: InputDecoration(
      //                             enabledBorder: UnderlineInputBorder(
      //                                 borderSide: BorderSide(
      //                                     color: Color.fromARGB(
      //                                         255, 0, 0, 0))),
      //                             focusedBorder: UnderlineInputBorder(
      //                                 borderSide: BorderSide(
      //                                     color: Colors.black)),
      //                             suffixStyle:
      //                             TextStyle(color: Colors.red),
      //                             labelText: "Brand name",
      //                             labelStyle: GoogleFonts.roboto(
      //                                 textStyle: TextStyle(
      //                                     fontSize: w * 0.025,
      //                                     color: Colors.black,
      //                                     fontWeight:
      //                                     FontWeight.bold)),
      //                             hintText: "Enter Brand name",
      //                             hintStyle: GoogleFonts.roboto(
      //                                 textStyle: TextStyle(
      //                                     fontSize: w * 0.025)),
      //                             suffixText: "*"),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.013,
      //                     ),
      //                     Container(
      //                       width: w * 0.8,
      //                       child: TextFormField(
      //                         controller: brandtitle,
      //                         decoration: InputDecoration(
      //                             enabledBorder: UnderlineInputBorder(
      //                                 borderSide: BorderSide(
      //                                     color: Color.fromARGB(
      //                                         255, 0, 0, 0))),
      //                             focusedBorder: UnderlineInputBorder(
      //                                 borderSide: BorderSide(
      //                                     color: Colors.black)),
      //                             suffixStyle:
      //                             TextStyle(color: Colors.red),
      //                             labelText: "Brand Page Title/Head",
      //                             labelStyle: GoogleFonts.roboto(
      //                                 textStyle: TextStyle(
      //                                     fontSize: w * 0.025,
      //                                     color: Colors.black,
      //                                     fontWeight:
      //                                     FontWeight.bold)),
      //                             hintText: "Enter Brand name",
      //                             hintStyle: GoogleFonts.roboto(
      //                                 textStyle: TextStyle(
      //                                     fontSize: w * 0.025)),
      //                             suffixText: "*"),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.013,
      //                     ),
      //                     Container(
      //                       width: w * 0.8,
      //                       child: TextFormField(
      //                         controller: couponCode,
      //                         decoration: InputDecoration(
      //                             enabledBorder: UnderlineInputBorder(
      //                                 borderSide: BorderSide(
      //                                     color: Color.fromARGB(
      //                                         255, 0, 0, 0))),
      //                             focusedBorder: UnderlineInputBorder(
      //                                 borderSide: BorderSide(
      //                                     color: Colors.black)),
      //                             suffixStyle:
      //                             TextStyle(color: Colors.red),
      //                             labelText: "Coupon Color Code",
      //                             labelStyle: GoogleFonts.roboto(
      //                                 textStyle: TextStyle(
      //                                     fontSize: w * 0.025,
      //                                     color: Colors.black,
      //                                     fontWeight:
      //                                     FontWeight.bold)),
      //                             hintText:
      //                             "Enter your color code eg.#HDK345",
      //                             hintStyle: GoogleFonts.roboto(
      //                                 textStyle: TextStyle(
      //                                     fontSize: w * 0.025)),
      //                             suffixText: "*"),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.013,
      //                     ),
      //                     Container(
      //                       width: w * 0.8,
      //                       child: TextFormField(
      //                         controller: contentDetails,
      //                         decoration: InputDecoration(
      //                             enabledBorder: UnderlineInputBorder(
      //                                 borderSide: BorderSide(
      //                                     color: Color.fromARGB(
      //                                         255, 0, 0, 0))),
      //                             focusedBorder: UnderlineInputBorder(
      //                                 borderSide: BorderSide(
      //                                     color: Colors.black)),
      //                             suffixStyle:
      //                             TextStyle(color: Colors.red),
      //                             labelText: "Content/Details",
      //                             labelStyle: GoogleFonts.roboto(
      //                                 textStyle: TextStyle(
      //                                     fontSize: w * 0.025,
      //                                     color: Colors.black,
      //                                     fontWeight:
      //                                     FontWeight.bold)),
      //                             suffixText: "*"),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.018,
      //                     ),
      //                     Text("Feature Image List (1000x1000 px)",
      //                         style: GoogleFonts.roboto(
      //                             textStyle: TextStyle(
      //                                 fontSize: w * 0.025,
      //                                 color: Colors.black))),
      //                     SizedBox(
      //                       height: h * 0.012,
      //                     ),
      //                     SizedBox(
      //                       width: w * 0.9,
      //                       height: h * 0.0009,
      //                       child: ColoredBox(color: Colors.grey),
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.02,
      //                     ),
      //                     Row(
      //                       children: [
      //                         Container(
      //                           width: w * 0.55,
      //                           child: TextFormField(
      //                             controller: featureName,
      //                             //controller: ,
      //                             decoration: InputDecoration(
      //                               hintText: "Enter feature Name",
      //                               hintStyle: GoogleFonts.roboto(
      //                                   textStyle: TextStyle(
      //                                       fontSize: w * 0.025,
      //                                       color: Colors.black)),
      //                               suffixText: "*",
      //                               suffixStyle:
      //                               TextStyle(color: Colors.red),
      //                             ),
      //                           ),
      //                         ),
      //                         SizedBox(
      //                           width: w * 0.050,
      //                         ),
      //                         TextButton(
      //                           onPressed: () {
      //                             getMultipleimages();
      //                           },
      //                           child: Container(
      //                             width: w * 0.22,
      //                             height: h * 0.047,
      //                             decoration: BoxDecoration(
      //                               borderRadius: BorderRadius.all(
      //                                   Radius.circular(8)),
      //                               gradient: LinearGradient(colors: [
      //                                 Color(0xff8C31FF),
      //                                 Color(0xff601AB9)
      //                               ]),
      //                             ),
      //                             child: Center(
      //                                 child: Text(
      //                                   "Upload",
      //                                   style: TextStyle(
      //                                       color: Colors.white),
      //                                 )),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     SizedBox(height: h * 0.025),
      //                     //   Row(
      //                     //     children: [
      //                     //       SizedBox(
      //                     //         width: 17,
      //                     //       ),
      //                     //       Stack(
      //                     //         clipBehavior: Clip.none,
      //                     //         children: [
      //                     //           imagefileList!.isEmpty
      //                     //               ? Container(
      //                     //                   width: w * 0.3,
      //                     //                   height: h * 0.13,
      //                     //                   decoration: BoxDecoration(
      //                     //                       color: Color(0xffE9E9E9),
      //                     //                       border: Border.all(
      //                     //                           color: Color(0xff530CAD))),
      //                     //                 )
      //                     //               : Container(
      //                     //                   width: w * 0.3,
      //                     //                   height: h * 0.13,
      //                     //                   decoration: BoxDecoration(
      //                     //                       image: DecorationImage(
      //                     //                           image: FileImage(imagefileList![0] as File),
      //                     //                           fit: BoxFit.cover),
      //                     //                       color: Color(0xffE9E9E9),
      //                     //                       border: Border.all(
      //                     //                           color: Color(0xff530CAD))),
      //                     //                 ),
      //                     //           Positioned(
      //                     //             left: w * 0.24,
      //                     //             bottom: h * 0.10,
      //                     //             child: InkWell(
      //                     //               onTap: () {
      //                     //                 image = null;
      //                     //                 setState(() {});
      //                     //               },
      //                     //               child: Container(
      //                     //                 width: w * 0.09,
      //                     //                 height: h * 0.05,
      //                     //                 child: Icon(
      //                     //                   Icons.cancel,
      //                     //                   color: Color.fromARGB(
      //                     //                       255, 254, 253, 255),
      //                     //                   size: 30,
      //                     //                 ),
      //                     //                 decoration: BoxDecoration(
      //                     //                     color: Color(0xff8C31FF),
      //                     //                     shape: BoxShape.circle),
      //                     //               ),
      //                     //             ),
      //                     //           )
      //                     //         ],
      //                     //       ),
      //                     //       SizedBox(
      //                     //         width: w * 0.10,
      //                     //       ),
      //                     //       Stack(
      //                     //         clipBehavior: Clip.none,
      //                     //         children: [
      //                     //           imagefileList!.isEmpty
      //                     //               ? Container(
      //                     //                   width: w * 0.3,
      //                     //                   height: h * 0.13,
      //                     //                   decoration: BoxDecoration(
      //                     //                       color: Color(0xffE9E9E9),
      //                     //                       border: Border.all(
      //                     //                           color: Color(0xff530CAD))),
      //                     //                 )
      //                     //               : Container(
      //                     //                   width: w * 0.3,
      //                     //                   height: h * 0.13,
      //                     //                   decoration: BoxDecoration(
      //                     //                       image: DecorationImage(
      //                     //                           image: FileImage(imagefileList![1] as File),
      //                     //                           fit: BoxFit.cover),
      //                     //                       color: Color(0xffE9E9E9),
      //                     //                       border: Border.all(
      //                     //                           color: Color(0xff530CAD))),
      //                     //                 ),
      //                     //           Positioned(
      //                     //             left: w * 0.24,
      //                     //             bottom: h * 0.10,
      //                     //             child: InkWell(
      //                     //               onTap: () {
      //                     //                 //imagefileList![1] = null;
      //                     //                 setState(() {});
      //                     //               },
      //                     //               child: Container(
      //                     //                 width: w * 0.09,
      //                     //                 height: h * 0.05,
      //                     //                 child: Icon(
      //                     //                   Icons.cancel,
      //                     //                   color: Color.fromARGB(
      //                     //                       255, 254, 253, 255),
      //                     //                   size: 30,
      //                     //                 ),
      //                     //                 decoration: BoxDecoration(
      //                     //                     color: Color(0xff8C31FF),
      //                     //                     shape: BoxShape.circle),
      //                     //               ),
      //                     //             ),
      //                     //           )
      //                     //         ],
      //                     //       ),
      //                     //     ],
      //                     //   ),
      //                     //   SizedBox(
      //                     //     height: h * 0.030,
      //                     //   ),
      //                     //   Row(
      //
      //                     //     children: [
      //                     //       SizedBox(
      //                     //         width: 17,
      //                     //       ),
      //                     //       Stack(
      //                     //         clipBehavior: Clip.none,
      //                     //         children: [
      //                     //           image == null
      //                     //               ? Container(
      //                     //                   width: w * 0.3,
      //                     //                   height: h * 0.13,
      //                     //                   decoration: BoxDecoration(
      //                     //                       color: Color(0xffE9E9E9),
      //                     //                       border: Border.all(
      //                     //                           color: Color(0xff530CAD))),
      //                     //                 )
      //                     //               : Container(
      //                     //                   width: w * 0.3,
      //                     //                   height: h * 0.13,
      //                     //                   decoration: BoxDecoration(
      //                     //                       image: DecorationImage(
      //                     //                           image: FileImage(image!),
      //                     //                           fit: BoxFit.cover),
      //                     //                       color: Color(0xffE9E9E9),
      //                     //                       border: Border.all(
      //                     //                           color: Color(0xff530CAD))),
      //                     //                 ),
      //                     //           Positioned(
      //                     //             left: w * 0.24,
      //                     //             bottom: h * 0.10,
      //                     //             child: InkWell(
      //                     //               onTap: () {
      //                     //                 image = null;
      //                     //                 setState(() {});
      //                     //               },
      //                     //               child: Container(
      //                     //                 width: w * 0.09,
      //                     //                 height: h * 0.05,
      //                     //                 child: Icon(
      //                     //                   Icons.cancel,
      //                     //                   color: Color.fromARGB(
      //                     //                       255, 254, 253, 255),
      //                     //                   size: 30,
      //                     //                 ),
      //                     //                 decoration: BoxDecoration(
      //                     //                     color: Color(0xff8C31FF),
      //                     //                     shape: BoxShape.circle),
      //                     //               ),
      //                     //             ),
      //                     //           )
      //                     //         ],
      //                     //       ),
      //                     //       SizedBox(
      //                     //         width: w * 0.10,
      //                     //       ),
      //                     //       Stack(
      //                     //         clipBehavior: Clip.none,
      //                     //         children: [
      //                     //           image == null
      //                     //               ? Container(
      //                     //                   width: w * 0.3,
      //                     //                   height: h * 0.13,
      //                     //                   decoration: BoxDecoration(
      //                     //                       color: Color(0xffE9E9E9),
      //                     //                       border: Border.all(
      //                     //                           color: Color(0xff530CAD))),
      //                     //                 )
      //                     //               : Container(
      //                     //                   width: w * 0.3,
      //                     //                   height: h * 0.13,
      //                     //                   decoration: BoxDecoration(
      //                     //                       image: DecorationImage(
      //                     //                           image: FileImage(image!),
      //                     //                           fit: BoxFit.cover),
      //                     //                       color: Color(0xffE9E9E9),
      //                     //                       border: Border.all(
      //                     //                           color: Color(0xff530CAD))),
      //                     //                 ),
      //                     //           Positioned(
      //                     //             left: w * 0.24,
      //                     //             bottom: h * 0.10,
      //                     //             child: InkWell(
      //                     //               onTap: () {
      //                     //                 image = null;
      //                     //                 setState(() {});
      //                     //               },
      //                     //               child: Container(
      //                     //                 width: w * 0.09,
      //                     //                 height: h * 0.05,
      //                     //                 child: Icon(
      //                     //                   Icons.cancel,
      //                     //                   color: Color.fromARGB(
      //                     //                       255, 254, 253, 255),
      //                     //                   size: 30,
      //                     //                 ),
      //                     //                 decoration: BoxDecoration(
      //                     //                     color: Color(0xff8C31FF),
      //                     //                     shape: BoxShape.circle),
      //                     //               ),
      //                     //             ),
      //                     //           )
      //                     //         ],
      //                     //       ),
      //                     //     ],
      //                     //   )
      //
      //                     Padding(
      //                       padding: EdgeInsets.all(w * 0.02),
      //                       child: Expanded(
      //                         flex: 0,
      //                         child: Container(
      //                           child: GridView.builder(
      //                               physics: ScrollPhysics(),
      //                               itemCount: featureimages.length,
      //                               shrinkWrap: true,
      //                               gridDelegate:
      //                               SliverGridDelegateWithMaxCrossAxisExtent(
      //                                   maxCrossAxisExtent:
      //                                   w * 0.5,
      //                                   mainAxisExtent: h * 0.15,
      //                                   childAspectRatio: 2 / 2,
      //                                   crossAxisSpacing:
      //                                   w * 0.03,
      //                                   mainAxisSpacing:
      //                                   h * 0.02),
      //                               itemBuilder:
      //                                   (BuildContext context,
      //                                   index) {
      //                                 return
      //                                   featureimages.isNotEmpty?
      //                                   Stack(clipBehavior: Clip.none,
      //                                       children:[ Container(
      //                                         width: w * 0.800,
      //                                         height: h * 0.95,
      //                                         decoration: BoxDecoration(
      //                                             color: Colors.blue),
      //                                         child: Image.file(
      //                                           File(featureimages[index]
      //                                               .path),
      //                                           fit: BoxFit.fill,
      //                                         ),
      //                                       ),
      //                                         Positioned(
      //                                           left: w * 0.29,
      //                                           bottom: h * 0.12,
      //                                           child: InkWell(
      //                                             onTap: () {
      //                                               // productImages.removeAt(0);
      //                                               // image = null;
      //                                               setState(() {});
      //                                             },
      //                                             child: Container(
      //                                               width: w * 0.2,
      //                                               height: h * 0.04,
      //                                               child: const Icon(
      //                                                 Icons.clear,
      //                                                 color: Color.fromARGB(255, 254, 253, 255),
      //                                                 size: 25,
      //                                               ),
      //                                               decoration: const BoxDecoration(
      //                                                   color: Color(0xff8C31FF), shape: BoxShape.circle),
      //                                             ),
      //                                           ),
      //                                         )
      //                                       ]
      //                                   ):
      //                                   Stack(clipBehavior: Clip.none,
      //                                       children:[ Container(
      //                                         width: w * 0.800,
      //                                         height: h * 0.95,
      //                                         decoration: BoxDecoration(
      //                                             color: Colors.blue),
      //
      //                                       ),
      //                                         Positioned(
      //                                           left: w * 0.30,
      //                                           bottom: h * 0.10,
      //                                           child: InkWell(
      //                                             onTap: () {
      //                                               // productImages.removeAt(0);
      //                                               // image = null;
      //                                               setState(() {});
      //                                             },
      //                                             child: Container(
      //                                               width: w * 0.2,
      //                                               height: h * 0.04,
      //                                               child: const Icon(
      //                                                 Icons.clear,
      //                                                 color: Color.fromARGB(255, 254, 253, 255),
      //                                                 size: 25,
      //                                               ),
      //                                               decoration: const BoxDecoration(
      //                                                   color: Color(0xff8C31FF), shape: BoxShape.circle),
      //                                             ),
      //                                           ),
      //                                         )
      //                                       ]
      //                                   );
      //                               }),
      //                         ),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.020,
      //                     ),
      //                     Text("Gallery images",
      //                         style: GoogleFonts.roboto(
      //                             textStyle: TextStyle(
      //                                 fontSize: w * 0.025,
      //                                 color: Colors.black,
      //                                 fontWeight: FontWeight.bold))),
      //                     SizedBox(
      //                       height: h * 0.010,
      //                     ),
      //                     SizedBox(
      //                       width: w * 0.9,
      //                       height: h * 0.0009,
      //                       child: ColoredBox(color: Colors.grey),
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.020,
      //                     ),
      //                     Padding(
      //                       padding: EdgeInsets.all(w * 0.02),
      //                       child: Container(
      //                         child: GridView.builder(
      //                             physics: ScrollPhysics(),
      //                             itemCount: galaryImages.length,
      //                             shrinkWrap: true,
      //                             gridDelegate:
      //                             SliverGridDelegateWithMaxCrossAxisExtent(
      //                                 maxCrossAxisExtent: w * 0.6,
      //                                 mainAxisExtent: h * 0.15,
      //                                 childAspectRatio: 2 / 2,
      //                                 crossAxisSpacing: w * 0.015,
      //                                 mainAxisSpacing: h * 0.01),
      //                             itemBuilder:
      //                                 (BuildContext context, index) {
      //                               return Stack(clipBehavior: Clip.none,
      //                                   children:[ Container(
      //                                     width: w * 0.400,
      //                                     height: h * 85,
      //                                     child: Image.file(
      //                                       File(galaryImages[index].path),
      //                                       fit: BoxFit.fill,
      //                                     ),
      //                                   ),
      //                                     Positioned(
      //                                       left: w * 0.28,
      //                                       bottom: h * 0.12,
      //                                       child: InkWell(
      //                                         onTap: () {
      //                                           // productImages.removeAt(2);
      //                                           // image = null;
      //                                           setState(() {});
      //                                         },
      //                                         child: Container(
      //                                           width: w * 0.2,
      //                                           height: h * 0.04,
      //                                           child: const Icon(
      //                                             Icons.clear,
      //                                             color: Color.fromARGB(255, 254, 253, 255),
      //                                             size: 25,
      //                                           ),
      //                                           decoration: const BoxDecoration(
      //                                               color: Color(0xff8C31FF), shape: BoxShape.circle),
      //                                         ),
      //                                       ),
      //                                     )
      //                                   ]
      //                               );
      //                             }),
      //                       ),
      //                     ),
      //
      //                     SizedBox(
      //                       height: h * 0.012,
      //                     ),
      //                     Center(
      //                       child: TextButton(
      //                         onPressed: () {
      //                           getGallaryimages();
      //                         },
      //                         child: Container(
      //                           width: w * 0.9,
      //                           height: h * 0.05,
      //                           decoration: BoxDecoration(
      //                               gradient: gradient,
      //                               borderRadius: BorderRadius.all(
      //                                   Radius.circular(10))),
      //                           child: Center(
      //                               child: Text(
      //                                 "Upload ",
      //                                 style:
      //                                 TextStyle(color: Colors.white),
      //                               )),
      //                         ),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.012,
      //                     ),
      //                     Text(
      //                       "YouTube Link",
      //                       style: GoogleFonts.roboto(
      //                           textStyle: TextStyle(
      //                               fontSize: w * 0.025,
      //                               color: Colors.black,
      //                               fontWeight: FontWeight.bold)),
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.012,
      //                     ),
      //                     SizedBox(
      //                       width: w * 0.9,
      //                       height: h * 0.0009,
      //                       child: ColoredBox(color: Colors.grey),
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.024,
      //                     ),
      //                     Row(
      //                       children: [
      //                         Container(
      //                           width: w * 0.6,
      //                           child: TextFormField(
      //                             controller: YoutubeVideoUrl ,
      //                             decoration: InputDecoration(
      //                               hintText: "Enter Video Url",
      //                               hintStyle: GoogleFonts.roboto(
      //                                   textStyle: TextStyle(
      //                                       fontSize: w * 0.025,
      //                                       color: Colors
      //                                           .grey.shade400)),
      //                               suffixText: "*",
      //                               suffixStyle:
      //                               TextStyle(color: Colors.red),
      //                             ),
      //                           ),
      //                         ),
      //                         SizedBox(
      //                           width: w * 0.01,
      //                         ),
      //                         TextButton(
      //                           onPressed: () {},
      //                           child: Container(
      //                             width: w * 0.22,
      //                             height: h * 0.047,
      //                             decoration: BoxDecoration(
      //                               borderRadius: BorderRadius.all(
      //                                   Radius.circular(8)),
      //                               gradient: LinearGradient(colors: [
      //                                 Color(0xff8C31FF),
      //                                 Color(0xff601AB9)
      //                               ]),
      //                             ),
      //                             child: Center(
      //                                 child: Text(
      //                                   "Upload",
      //                                   style: TextStyle(
      //                                       color: Colors.white),
      //                                 )),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.024,
      //                     ),
      //                     Row(
      //                       children: [
      //                         Text("Enable Affiliate Program",
      //                             style: GoogleFonts.roboto(
      //                                 textStyle: TextStyle(
      //                                     fontSize: w * 0.025,
      //                                     color: Colors.black,
      //                                     fontWeight:
      //                                     FontWeight.bold))),
      //                         SizedBox(width: w*0.200,),
      //                         FlutterSwitch(
      //                           activeColor: const Color(0xff66BD46),
      //                           width: w * 0.13,
      //                           height: h * 0.028,
      //                           valueFontSize: 0.0,
      //                           toggleSize: 15.0,
      //                           value: Brandaffiliate,
      //                           borderRadius: 30.0,
      //                           padding: 8.0,
      //                           onToggle: (val) {
      //                             setState(() {
      //                               Brandaffiliate = val;
      //                             });
      //                           },
      //                         ),
      //
      //                         SizedBox(
      //                           width: w * 0.01,
      //                         ),
      //                         Text(Brandaffiliate==true?
      //                         'active':"Inactive",
      //                           style: GoogleFonts.roboto(
      //                               textStyle: TextStyle(
      //                                   fontSize: w * 0.035,
      //                                   color: primaryColor)),
      //                         )
      //                       ],
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.02,
      //                     ),
      //                     Text("Commission for this brand products",
      //                         style: GoogleFonts.roboto(
      //                             textStyle: TextStyle(
      //                                 fontSize: w * 0.025,
      //                                 color: Colors.black,
      //                                 fontWeight: FontWeight.bold))),
      //                     SizedBox(
      //                       height: h * 0.012,
      //                     ),
      //                     SizedBox(
      //                       width: w * 0.9,
      //                       height: h * 0.0009,
      //                       child: ColoredBox(color: Colors.grey),
      //                     ),
      //                     SizedBox(
      //                       height: h * 0.030,
      //                     ),
      //                     Row(
      //                       children: [
      //                         Container(
      //                             decoration: BoxDecoration(
      //                                 border: Border.all(
      //                                     color: primaryColor),
      //                                 borderRadius:
      //                                 BorderRadius.circular(5)),
      //                             height: h * 0.050,
      //                             width: w * 0.340,
      //                             child: CustomDropdown(
      //                               // hintText: "sellect",
      //
      //                               fieldSuffixIcon: Icon(
      //                                 Icons.arrow_drop_down_outlined,
      //                                 color: Colors.black,
      //                                 size: h * 0.035,
      //                               ),
      //                               listItemStyle:
      //                               TextStyle(fontSize: w * 0.02),
      //                               selectedStyle: TextStyle(
      //                                   fontSize: w * 0.02,
      //                                   color: Colors.black),
      //                               hintStyle: TextStyle(
      //                                   fontSize: w * 0.020,
      //                                   color: Colors.black),
      //                               items: commision,
      //                               controller: percentage,
      //                             )),
      //                         SizedBox(
      //                           width: w * 0.062,
      //                         ),
      //                         Container(
      //                           width: w * 0.40,
      //                           child: TextFormField(
      //                             controller:commissionPer ,
      //                             decoration: InputDecoration(
      //                               hintText: "Enter Video Url",
      //                               hintStyle: GoogleFonts.roboto(
      //                                   textStyle: TextStyle(
      //                                     fontSize: w * 0.025,
      //                                     color: Colors.grey.shade400,
      //                                   )),
      //                               suffixText: "*",
      //                               suffixStyle:
      //                               TextStyle(color: Colors.red),
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     SizedBox(
      //                       height: 16,
      //                     ),
      //                     SizedBox(
      //                       width: w * 0.9,
      //                       height: h * 0.0011,
      //                       child: ColoredBox(color: Colors.grey),
      //                     ),
      //                     SizedBox(
      //                       height: 27,
      //                     ),
      //                     Center(
      //                       child: TextButton(
      //                         onPressed: () async {
      //                           print(currentUser?.id);
      //                           print(brandName.text);
      //                           print(contentDetails.text);
      //                           print(couponCode.text);
      //                           print(featureName.text);
      //                           print(brandtitle.text);
      //                           var branddata = AddBrand(
      //                             // venderId: currentUser!.id,
      //                             // imageUrl:brandUrl,
      //                             // banner: bannerUrl,
      //                             // imageList:downloadUrls,
      //                             // // featureimages: downloadUrls,
      //                             // galaryimage: galaryImagesUrls,
      //                             // brand: brandName.text,
      //                             // content:
      //                             // contentDetails.text,
      //                             // couponColorCode: couponCode.text,
      //                             // // featureName: featureName.text,
      //                             // Brandaffiliate:Brandaffiliate,
      //                             // head: brandtitle.text,
      //                             // youTube:[{
      //                             //   "like": YoutubeVideoUrl.text,
      //                             //   "tumbnail":""
      //                             // }],
      //                             // commissionPer:commissionPer.text,
      //                             // percentage:percentage.text,
      //                             // branchId: "",
      //                             // color:"",
      //                             // status: 0,
      //                             // delete:false
      //                             // ,);
      //
      //
      //
      //                           print(branddata.brand);
      //                           print("=================");
      //
      //                           await FirebaseFirestore.instance
      //                               .collection('brands')
      //                               .add(branddata.toJson())
      //                               .then((value) {
      //                             value.update({
      //                               'brandId': value.id
      //                             }).then((val) => {
      //                               FirebaseFirestore.instance
      //                                   .collection('vendor')
      //                                   .doc(currentUser!.id)
      //                                   .update({
      //                                 'brandlist':
      //                                 FieldValue.arrayUnion(
      //                                     [value.id])
      //                               }),
      //                               Navigator.push(
      //                                   context,
      //                                   MaterialPageRoute(
      //                                       builder: (context) =>
      //                                           Brandrequest(
      //                                             brandData:
      //                                             branddata,
      //                                           )))
      //                             });
      //                           });
      //
      //                           // await FirebaseFirestore.instance
      //                           //     .collection("brands")
      //                           //     .doc(currentUser?.id)
      //                           //     .update(branddata.toJson())
      //                           //     .then((value) => {});
      //                         },
      //                         child: Container(
      //                           width: w * 0.9,
      //                           height: h * 0.04,
      //                           decoration: BoxDecoration(
      //                               gradient: gradient,
      //                               borderRadius: BorderRadius.all(
      //                                   Radius.circular(10))),
      //                           child: Center(
      //                               child: Text(
      //                                 "SAVE ",
      //                                 style:
      //                                 TextStyle(color: Colors.white),
      //                               )),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //
      //           ],
      //         ),
      //       ),
      //     ]),
    );
  }
}