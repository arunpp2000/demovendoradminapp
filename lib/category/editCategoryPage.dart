import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../globals/colors.dart';

import '../model/brandModel.dart';
import '../model/cateogryModel.dart';
import '../model/usermodel.dart';
import '../navbar/Navbar.dart';
import '../navbar/tabbarview/seller_dashboard.dart';

import '../widgets/uploadmedia.dart';
import 'editCategory.dart';

class CategoryEdit extends StatefulWidget {
  var id;
  CategoryEdit({Key? key, this.id});

  @override
  State<CategoryEdit> createState() => _CategoryEditState();
}

bool Brandaffiliate = false;

String? brandUrl;

class _CategoryEditState extends State<CategoryEdit> {
  List youtubelink = [];
  List featureImage = [];


  // getBrand() async {
  //   FirebaseFirestore.instance
  //       .collection('vendor')
  //       .where("brand", isEqualTo: currentBrand!.brand)
  //       .snapshots()
  //       .listen((event) {
  //     if (event.docs.isNotEmpty) {
  //       currentBrand = AddBrand.fromJson(event.docs[0].data());
  //     }
  //
  //     if (mounted) {
  //       setState(() {});
  //       print(currentUser?.id);
  //       print('=============================');
  //     }
  //   });
  // }
// updateMessages(){
//     FirebaseFirestore.instance.collection('brands').get().then((value) {
//       for(DocumentSnapshot snap in value.docs){
//         FirebaseFirestore.instance.collection('brands').doc(snap.id)
//             .update({
//          'affiliatedProgram':false,
//          'commissionPer':0,
//          'couponColorCode':'',
//
//
//         });
//       }
//     });
//   }


  final catorgory = TextEditingController();
  final categoryDropDown = TextEditingController();
  final sub_catorgory = TextEditingController();
  final child_catorgory = TextEditingController();
  final catorgory_badgeText = TextEditingController();
  final description = TextEditingController();
  final product_Brand = TextEditingController();
  final madeIn = TextEditingController();
  List<String> commision = ["percentage %", "Amount"];

  List galaryimageUrl = [];

  File? image1;
  File? image2;

  final picker = ImagePicker();
String? catogoryUrl;
  getBanner() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickImage != null) {
        image2 = File(pickImage.path);
        print(image2);
        uploadBanner(image2!);
      } else {
        print("no image selected");
      }
    });
  }
  String? bannerUrl;
  uploadBanner(File imageFile) async {
    String fileName = (image2!.path);
    Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL();
    bannerUrl = await taskSnapshot.ref.getDownloadURL();
    setState(() {

    });
  }

  Future getBrandlogo() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickImage != null) {
        image1 = File(pickImage.path);
        print(image1);
        uploadBrand(image1!);
      } else {
        print("no image selected");
      }
    });
  }

  uploadBrand(File imageFile) async {
    String fileName = (image1!.path);
    Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    catogoryUrl = await taskSnapshot.ref.getDownloadURL();
    setState(() {

    });
  }

  List downloadUrls = [];

  // getMultipleimages() async {
  //   List featureimages = [];
  //   final List<XFile>? pickedimages = await picker.pickMultiImage();
  //
  //   if (pickedimages != null) {
  //     pickedimages.forEach((e) async {
  //       featureimages.add(File(e.path));
  //     });
  //     setState(() {});
  //   }
  //
  //   // downloadUrls=[];
  //   for (int i = 0; i < featureimages.length; i++) {
  //     String url = await uploadfiles(featureimages[i]);
  //
  //     downloadUrls.add({
  //       'link': url,
  //       // "link":featureimages,
  //       'name': featureName.text,
  //     });
  //   }
  //
  //   featureName.clear();
  //   setState(() {});
  // }

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

  //List galaryImages = [];
  List galaryImagesUrls = [];
  TextEditingController parentId = TextEditingController();
  getGallaryimages() async {
    List galaryImages = [];
    final List<XFile>? pickedimage = await picker.pickMultiImage();

    if (pickedimage != null) {
      pickedimage.forEach((e) async {
        galaryImages.add(File(e.path));
      });
      setState(() {});
    }

    for (int i = 0; i < galaryImages.length; i++) {
      String url = await uploadfiles(galaryImages[i]);
      galaryImagesUrls.add(url);
    }
    setState(() {});
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

  int selectedIndex = 0;
  var data;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: h * 0.01,
          ),
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('category')
                  .doc(widget.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child:
                      CircularProgressIndicator());
                }
                data = snapshot.data;
                print(data);
                try{
                  catorgory.text=data!['name'];
                  description.text=data!['description'];
                  product_Brand.text=data!['brand'];
                  madeIn.text=data!['madeIn'];
                  catorgory_badgeText.text=data!['categoryBadge'];
                  catogoryUrl=data['imageUrl'];
                  parentId.text=parentCatIdToName[data['parentId']];
                }catch(e){
                }
                return Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text("Brand Logo",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: w * 0.035,
                                fontWeight: FontWeight
                                    .bold))),
                    SizedBox(
                      height: h * 0.012,
                    ),
                    SizedBox(
                      width: w * 0.9,
                      height: h * 0.0009,
                      child: ColoredBox(
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: w * 0.3,
                            height: h * 0.13,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(
                                      12)),
                              color:
                              Color(0xffE9E9E9),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                              catogoryUrl??'',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          getBrandlogo();
                        },
                        child: Container(
                          width: w * 0.9,
                          height: h * 0.05,
                          decoration: BoxDecoration(
                              gradient: gradient,
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(
                                      10))),
                          child: Center(
                              child: Text(
                                "Category Logo",
                                style: TextStyle(
                                    color: Colors.white),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.013,
                    ),
                    Text(
                        ". Brand Logo : 1000 x 1000 px",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: w * 0.030,
                                color:
                                primaryColor1))),
                    SizedBox(
                      height: h * 0.013,
                    ),
                    Text(" Banner",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: w * 0.035,
                                fontWeight: FontWeight
                                    .bold))),
                    SizedBox(
                      height: h * 0.012,
                    ),
                    SizedBox(
                      width: w * 0.9,
                      height: h * 0.0009,
                      child: ColoredBox(
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: w * 0.55,
                            height: h * 0.12,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(
                                      12)),
                              color:
                              Color(0xffE9E9E9),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                              data!['banner'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          getBanner();
                        },
                        child: Container(
                          width: w * 0.9,
                          height: h * 0.05,
                          decoration: BoxDecoration(
                              gradient: gradient,
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(
                                      10))),
                          child: Center(
                              child: Text(
                                "Upload Banner",
                                style: TextStyle(
                                    color: Colors.white),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.013,
                    ),
                    Text(
                        ". Banner Size : 1916 x 700 px",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: w * 0.030,
                                color:
                                primaryColor1))),
                    SizedBox(
                      height: h * 0.015,
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(left: w * 0.030),
                      child: Column(
                        children: [
                          Container(
                            width: w * 0.8,
                            child: TextFormField(
                              controller: catorgory,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color
                                              .fromARGB(
                                              255, 0, 0, 0))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          Colors.black)),
                                  suffixStyle: TextStyle(
                                      color: Colors.red),
                                  labelText:
                                  "Category Name",
                                  labelStyle: GoogleFonts
                                      .roboto(
                                      textStyle: TextStyle(
                                          fontSize: w * 0.025,
                                          color: primaryColor1,
                                          fontWeight: FontWeight
                                              .bold)),
                                  hintText:
                                  "Category Name",
                                  hintStyle: GoogleFonts
                                      .roboto(
                                      textStyle: TextStyle(
                                          fontSize: w *
                                              0.025)),
                                  suffixText: "*"),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.013,
                          ),
                          Row(
                            children: [
                              Text("Parent Category",style: GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor1,fontSize: h*0.01,fontWeight: FontWeight.bold)),),
                            ],
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          CustomDropdown(
                            onChanged: (v){
                              // brandvalue=v;
                              // print(v);
                              setState(() {

                              });
                            },
                            hintText: "Select Parent Category",
                            borderSide: BorderSide(color: primaryColor),
                            borderRadius:
                            BorderRadius.circular(h * 0.01),
                            fieldSuffixIcon: Icon(
                              Icons.arrow_drop_down_outlined,
                              color: primaryColor,
                              size: h * 0.035,
                            ),
                            listItemStyle:
                            TextStyle(fontSize: w * 0.025),
                            selectedStyle: TextStyle(
                                fontSize: w * 0.025,
                                color: Colors.black),
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                                fontSize: h * 0.015,
                                color: Colors.black),
                            items: parentCategoryList.isEmpty ? [''] : parentCategoryList,
                            controller: parentId,
                          ),
                          Container(
                            width: w * 0.8,
                            child: TextFormField(
                              controller: catorgory_badgeText,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color
                                              .fromARGB(
                                              255, 0, 0, 0))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          Colors.black)),
                                  suffixStyle: TextStyle(
                                      color: Colors.red),
                                  labelText:
                                  "Category Badge Text",
                                  labelStyle: GoogleFonts
                                      .roboto(
                                      textStyle: TextStyle(
                                          fontSize: w * 0.025,
                                          color: primaryColor1,
                                          fontWeight: FontWeight
                                              .bold)),
                                  hintText:
                                  "Category Badge Text Content",
                                  hintStyle: GoogleFonts
                                      .roboto(
                                      textStyle: TextStyle(
                                          fontSize: w *
                                              0.025)),
                                  suffixText: "*"),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Container(
                            width: w * 0.8,
                            child: TextFormField(
                              maxLines: 3,
                              controller: description,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color
                                              .fromARGB(
                                              255, 0, 0, 0))),
                                  focusedBorder:
                                  UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(
                                          color: Colors
                                              .black)),
                                  suffixStyle: TextStyle(
                                      color: Colors.red),
                                  labelText: "Description",
                                  labelStyle: GoogleFonts
                                      .roboto(
                                      textStyle: TextStyle(
                                          fontSize: w * 0.025,
                                          color: primaryColor1,
                                          fontWeight:
                                          FontWeight
                                              .bold)),
                                  suffixText: "*"),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Container(
                            width: w * 0.8,
                            child: TextFormField(
                              controller: product_Brand,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color
                                              .fromARGB(
                                              255, 0, 0, 0))),
                                  focusedBorder:
                                  UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .black)),
                                  suffixStyle: TextStyle(
                                      color: Colors.red),
                                  labelText: "Product Brands",
                                  labelStyle: GoogleFonts
                                      .roboto(
                                      textStyle: TextStyle(
                                          fontSize: w * 0.025,
                                          color: primaryColor1,
                                          fontWeight:
                                          FontWeight
                                              .bold)),
                                  hintText: "Sub-Category name",
                                  hintStyle: GoogleFonts
                                      .roboto(
                                      textStyle: TextStyle(
                                          fontSize: w *
                                              0.025)),
                                  suffixText: "*"),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Container(
                            width: w * 0.8,
                            child: TextFormField(
                              controller: madeIn,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color
                                              .fromARGB(
                                              255, 0, 0, 0))),
                                  focusedBorder:
                                  UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .black)),
                                  suffixStyle: TextStyle(
                                      color: Colors.red),
                                  labelText: "Made In",
                                  labelStyle: GoogleFonts
                                      .roboto(
                                      textStyle: TextStyle(
                                          fontSize: w * 0.025,
                                          color: primaryColor1,
                                          fontWeight:
                                          FontWeight
                                              .bold)),
                                  hintText: "Made In",
                                  hintStyle: GoogleFonts
                                      .roboto(
                                      textStyle: TextStyle(
                                          fontSize: w *
                                              0.025)),
                                  suffixText: "*"),
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      height: h * 0.012,
                    ),

                    SizedBox(
                      height: h * 0.02,
                    ),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    // SizedBox(
                    //   width: w * 0.9,
                    //   height: h * 0.0009,
                    //   child: ColoredBox(
                    //       color: Colors.grey),
                    // ),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    InkWell(
                      onTap: () async {

                        if(bannerUrl!=''&&catogoryUrl!=''&&product_Brand.text!=''&&catorgory_badgeText.text!=''&&description.text!=''&&catorgory.text!=''){

                          bool pressed=await alert(context, 'Do you want update?');
                          if(pressed){
                            FirebaseFirestore.instance.collection('category').doc(widget.id).update({
                              'banner':bannerUrl,
                              'imageUrl':catogoryUrl,
                              "name":catorgory.text,
                              "description":description.text,
                              "brand":product_Brand.text,
                              "madeIn":madeIn.text,
                              "categoryBadge":catorgory_badgeText,
                              "search":setSearchParam(catorgory.text),
                              'parentId':parentCategoryNametoId[parentId.text] ,
                            });
                          }
                        }else{
                          catogoryUrl==''?     errorMsg(context,'please upload Gallery Image.'):
                          bannerUrl==''?        errorMsg(context,'please upload banner.'):
                          product_Brand.text==''?        errorMsg(context,'please enter brand name.'):
                          catorgory_badgeText.text==''?   errorMsg(context,'please enter badge name.'):
                          description.text==''?            errorMsg(context,'please enter description.'):
                          catorgory.text==''?        errorMsg(context,'please enter Category name.'):
                          parentId.text==''?        errorMsg(context,'please select ParentId.'):
                          '';
                        }
                      },
                      child: Center(
                        child: Container(
                          width: w * 0.36,
                          height: h * 0.044,
                          decoration: BoxDecoration(
                              gradient: gradient,
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(
                                      10))),
                          child: Center(
                              child: Text(
                                "Update",
                                style: TextStyle(
                                    color: Colors.white),
                              )),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ],
      ));

  }
}
