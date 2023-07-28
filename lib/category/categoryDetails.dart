import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demovendoradminapp/model/cateogryModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../globals/colors.dart';

import '../model/brandModel.dart';
import '../model/usermodel.dart';
import '../navbar/Navbar.dart';
import '../navbar/tabbarview/seller_dashboard.dart';

import '../widgets/customButton.dart';
import '../widgets/uploadmedia.dart';
import 'editCategory.dart';
import 'editCategoryPage.dart';

class CategoryViewPage extends StatefulWidget {
  var id;

  var data;
  CategoryViewPage({Key? key, this.id, required this.data});

  @override
  State<CategoryViewPage> createState() => _CategoryViewPageState();
}

bool Brandaffiliate = false;
String? bannerUrl;
String? brandUrl;

class _CategoryViewPageState extends State<CategoryViewPage> {
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

  uploadBanner(File imageFile) async {
    String fileName = (image2!.path);
    Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL();
    bannerUrl = await taskSnapshot.ref.getDownloadURL();
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
    brandUrl = await taskSnapshot.ref.getDownloadURL();
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
  TextEditingController parentId = TextEditingController();


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
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: primaryColor,
      ),
      body: ListView(children: [
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.01,
                ),
                Container(
                  width: w,
                  height: h * 0.83,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w * 0.025),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: w * 0.01,
                        ),
                      ]),
                  child: DefaultTabController(
                    length: 2,
                    initialIndex: selectedIndex,
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: h * 0.05,
                              width: w * 0.98,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              child: const TabBar(
                                indicatorColor: Colors.transparent,
                                indicator: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                tabs: <Widget>[
                                  Tab(text: 'Upload'),
                                  Tab(text: 'Edit'),
                                ],
                                labelColor: Colors
                                    .white, // Customize the appearance of the TabBar
                              ),
                            ),
                            SizedBox(
                              height: h*1.5,
                              width: double.maxFinite,
                              child: TabBarView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 10,
                                        bottom: 10),
                                    child: StreamBuilder<DocumentSnapshot>(
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
                                            parentId.text=parentCatIdToName[data['parentId']];
                                            // brandtitle.text=data!['head'];
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
                                                            data!['imageUrl'],
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
                                                    Text("Parent Category",style: GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor1,fontSize: h*0.01,fontWeight: FontWeight.bold)),),
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
                                                height: h * 0.0,
                                              ),

                                              SizedBox(
                                                height: h * 0.02,
                                              ),
                                              SizedBox(
                                                height: h * 0.01,
                                              ),
                                              data['status'] == 0
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        CustomButton(text: 'Approve', onPressed: () async {
                                                          bool pressed =
                                                              await alert(
                                                              context,
                                                              'Do you want accept this category.');
                                                          if (pressed) {
                                                            data.reference
                                                                .update({
                                                              'status': 1,
                                                              'acceptedDate':
                                                              DateTime
                                                                  .now()
                                                            });
                                                            showUploadMessage(
                                                                context,
                                                                'Accepted');
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        }, color: primaryColor,),
                                                        CustomButton(text: 'Reject', onPressed: () async {
                                                          bool pressed =
                                                              await alert(
                                                              context,
                                                              'Do you want reject this category.');
                                                          if (pressed) {
                                                            data.reference
                                                                .update({
                                                              'status': 2,
                                                              'rejectedDate':
                                                              DateTime
                                                                  .now()
                                                            });
                                                            showUploadMessage(
                                                                context,
                                                                'rejected');
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        }, color: Colors.red,),
                                                        ])
                                                  : data['status'] == 1
                                                      ? Center(
                                                          child: CustomButton(text: 'Reject', onPressed: () async {
                                                            bool pressed =
                                                            await alert(
                                                                context,
                                                                'Do you want reject this category.');
                                                            if (pressed) {
                                                              data.reference
                                                                  .update({
                                                                'status': 2,
                                                                'rejectedDate':
                                                                DateTime
                                                                    .now()
                                                              });
                                                              showUploadMessage(
                                                                  context,
                                                                  'rejected');
                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                          }, color: Colors.red,),
                                                        )
                                                      : Center(
                                                          child:  CustomButton(text: 'Approve', onPressed: () async {
                                                            bool pressed =
                                                            await alert(
                                                                context,
                                                                'Do you want accept this category.');
                                                            if (pressed) {
                                                              data.reference
                                                                  .update({
                                                                'status': 1,
                                                                'acceptedDate':
                                                                DateTime
                                                                    .now()
                                                              });
                                                              showUploadMessage(
                                                                  context,
                                                                  'Accepted');
                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                          }, color: primaryColor,),
                                                        ),
                                            ],
                                          );
                                        }),
                                  ),
                                  CategoryEdit(id:widget.id)
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: h * 0.025,),

      ]),
    );
  }
}
