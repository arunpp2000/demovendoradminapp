import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';


import '../globals/colors.dart';
import '../model/cateogryModel.dart';
import 'editCategory.dart';

class AddCategory extends StatefulWidget {
  // AddBrand? brandData;
  AddCategory({key, });

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

String? bannerUrl;
String? catogoryUrl;

class _AddCategoryState extends State<AddCategory> {
  // getUser() async {
  //   FirebaseFirestore.instance
  //       .collection('vendor')
  //       .where("email", isEqualTo: currentUser?.email)
  //       .snapshots()
  //       .listen((event) {
  //     if (event.docs.isNotEmpty) {
  //       currentUser = UserModel.fromJson(event.docs[0].data());
  //     }
  //
  //     if (mounted) {
  //       setState(() {});
  //       print(currentUser?.id);
  //       print('=============================');
  //     }
  //   });
  // }
  //
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
    setState(() {
      
    });
  }

  Future getBrandlogo() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickImage != null) {
        image1= File(pickImage.path);
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

  // Future featureImage() async {
  //   final List<XFile>? selectImg = await picker.pickMultiImage();

  //   setState(() {

  //     if (selectImg!.isNotEmpty) {

  //       imagefileList!.addAll(selectImg);
  //       for (int i = 0; i < imagefileList!.length;i++){
  //         uploadfiles(selectImg[i])
  //       }
  //         print("image list length:" + imagefileList!.length.toString());
  //     } else {
  //       print("no image selected");
  //     }
  //   });
  // }

  List featureimages = [];
  List downloadUrls = [];

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

  List galaryImages = [];
  List<String> galaryImagesUrls = [];

  getGallaryimages() async {
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
  

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final catorgory = TextEditingController();
    final sub_catorgory = TextEditingController();
    final child_catorgory = TextEditingController();
    final catorgory_badgeText = TextEditingController();
    final description = TextEditingController();
    final product_Brand = TextEditingController();
    final madeIn = TextEditingController();

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: h * 0.04,
                    width: w * 0.940,
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontSize: w * 0.030, color: Colors.black),
                          hintText: 'Search Categories',
                          contentPadding: EdgeInsets.only(top: 1),
                          prefixIcon: Icon(
                            Icons.search,
                            color: primaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              SizedBox(
                height: h * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Seller - ",
                    style: TextStyle(color: primaryColor),
                  ),
                  Text(
                    "Thara Online Store",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(fontSize: w * 0.025)),
                  ),
                  SizedBox(
                    width: w * 0.015,
                  ),
                  SizedBox(
                    width: w * 0.275,
                    height: 2,
                    child: ColoredBox(color: Colors.grey),
                  ),
                  TextButton(
                      onPressed: () {
                        print('pppp');
                        // FirebaseFirestore.instance.collection('brands'
                        // ).get().then((value){
                        //   for(DocumentSnapshot doc in value.docs){
                        //     FirebaseFirestore.instance.collection('brands').doc(doc.id).update({
                        //       'status':0
                        //     });
                        //   }
                        // });
                      },
                      child: Container(
                        width: w * 0.20,
                        height: h * 0.04,
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.circular(w * 0.01)),
                        child: Center(
                            child: Text(
                          "Manage",
                          style: TextStyle(color: primaryColor),
                        )),
                      )),
                ],
              ),
              SizedBox(
                height: h * 0.01,
              ),
              Container(
                width: w,
                height: h * 0.74,
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
                                Tab(text: 'Add Category'),
                                Tab(text: 'Edit Category'),
                              ],
                              labelColor: Colors
                                  .white, // Customize the appearance of the TabBar
                            ),
                          ),
                          SizedBox(
                            height: h * 2.3,
                            width: double.maxFinite,
                            child: TabBarView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Upload Category image",
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.025,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      SizedBox(
                                        height: h * 0.012,
                                      ),
                                      SizedBox(
                                        width: w * 0.9,
                                        height: h * 0.0009,
                                        child: ColoredBox(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: h * 0.02,
                                      ),
                                      Center(
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            image1 == null
                                                ? Container(
                                                    width: w * 0.3,
                                                    height: h * 0.13,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12)),
                                                      color: Color(0xffE9E9E9),
                                                    ),
                                                  )
                                                : Container(
                                                    width: w * 0.3,
                                                    height: h * 0.13,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12)),
                                                      image: DecorationImage(
                                                          image: FileImage(
                                                              image1!),
                                                          fit: BoxFit.cover),
                                                      color: Color(0xffE9E9E9),
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Center(
                                                child: Text(
                                              "Upload Category image",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: h * 0.013,
                                      ),
                                      Text("Upload Category Banner",
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.025,
                                                  fontWeight:
                                                      FontWeight.bold))),

                                      SizedBox(
                                        height: h * 0.012,
                                      ),
                                      SizedBox(
                                        width: w * 0.9,
                                        height: h * 0.0009,
                                        child: ColoredBox(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: h * 0.02,
                                      ),
                                      Center(
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            image2 == null
                                                ? Container(
                                                    width: w * 0.55,
                                                    height: h * 0.12,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12)),
                                                      color: Color(0xffE9E9E9),
                                                    ),
                                                  )
                                                : Container(
                                                    width: w * 0.55,
                                                    height: h * 0.12,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12)),
                                                      image: DecorationImage(
                                                          image: FileImage(
                                                              image2!),
                                                          fit: BoxFit.fill),
                                                      color: Color(0xffE9E9E9),
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
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
                                        "category",
                                        style: TextStyle(
                                            color: primaryColor1,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: h * 0.013,
                                      ),
                                      //   CustomDropdown(
                                      //   hintText: "category",
                                      //   borderSide:
                                      //       BorderSide(color: primaryColor),
                                      //   borderRadius:
                                      //       BorderRadius.circular(h * 0.01),
                                      //   fieldSuffixIcon: Icon(
                                      //     Icons.arrow_drop_down_outlined,
                                      //     color: primaryColor,
                                      //     size: h * 0.035,
                                      //   ),
                                      //   listItemStyle:
                                      //       TextStyle(fontSize: w * 0.025),
                                      //   selectedStyle: TextStyle(
                                      //       fontSize: w * 0.025,
                                      //       color: Colors.black),
                                      //   fillColor: Colors.white,
                                      //   hintStyle: TextStyle(
                                      //       fontSize: h * 0.015,
                                      //       color: Colors.black),
                                      //   items: ["f","t"],

                                      //   // onChanged: (value){
                                      //   //   brandvalue=value;
                                      //   //   setState(() {
                                      //   //
                                      //   //   });
                                      //   // },
                                      //   controller: category ,
                                      // ),
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
                                                            color: Color.fromARGB(
                                                                255, 0, 0, 0))),
                                                    focusedBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                    suffixStyle: TextStyle(
                                                        color: Colors.red),
                                                    labelText: "category",
                                                    labelStyle: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize: w * 0.025,
                                                            color: primaryColor1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    hintText: "Category name",
                                                    hintStyle:
                                                        GoogleFonts.roboto(textStyle: TextStyle(fontSize: w * 0.025)),
                                                    suffixText: "*"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.013,
                                            ),
                                            Container(
                                              width: w * 0.8,
                                              child: TextFormField(
                                                controller: sub_catorgory,
                                                decoration: InputDecoration(
                                                    enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color.fromARGB(
                                                                255, 0, 0, 0))),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .black)),
                                                    suffixStyle: TextStyle(
                                                        color: Colors.red),
                                                    labelText: "Sub-Category",
                                                    labelStyle: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize: w * 0.025,
                                                            color: primaryColor1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    hintText: "Sub-Category name",
                                                    hintStyle: GoogleFonts.roboto(textStyle: TextStyle(fontSize: w * 0.025)),
                                                    suffixText: "*"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.013,
                                            ),
                                            Container(
                                              width: w * 0.8,
                                              child: TextFormField(
                                                 
                                                controller: child_catorgory,
                                                decoration: InputDecoration(
                                                    enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color.fromARGB(
                                                                255, 0, 0, 0))),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .black)),
                                                    suffixStyle: TextStyle(
                                                        color: Colors.red),
                                                    labelText: "Child-Category",
                                                    labelStyle: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize: w * 0.025,
                                                            color: primaryColor1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    hintText: "Child-Category name",
                                                    hintStyle: GoogleFonts.roboto(textStyle: TextStyle(fontSize: w * 0.025)),
                                                    suffixText: "*"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.013,
                                            ),
                                            Container(
                                              width: w * 0.8,
                                              child: TextFormField(
                                                controller: catorgory_badgeText,
                                                decoration: InputDecoration(
                                                    enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color.fromARGB(
                                                                255, 0, 0, 0))),
                                                    focusedBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                    suffixStyle: TextStyle(
                                                        color: Colors.red),
                                                    labelText:
                                                        "Category Badge Text",
                                                    labelStyle: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize: w * 0.025,
                                                            color: primaryColor1,
                                                            fontWeight: FontWeight
                                                                .bold)),
                                                    hintText:
                                                        "Category Badge Text Content",
                                                    hintStyle: GoogleFonts.roboto(textStyle: TextStyle(fontSize: w * 0.025)),
                                                    suffixText: "*"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Container(
                                              width: w * 0.8,
                                              child: TextFormField(
                                                controller: description,
                                                decoration: InputDecoration(
                                                    enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color.fromARGB(
                                                                255, 0, 0, 0))),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black)),
                                                    suffixStyle: TextStyle(
                                                        color: Colors.red),
                                                    labelText: "Discription",
                                                    labelStyle: GoogleFonts.roboto(
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
                                              width: w * 0.050,
                                            ),
                                            SizedBox(
                                              height: h * 0.028,
                                            ),
                                            Container(
                                              width: w * 0.8,
                                              child: TextFormField(
                                                controller: product_Brand,
                                                decoration: InputDecoration(
                                                    enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color.fromARGB(
                                                                255, 0, 0, 0))),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .black)),
                                                    suffixStyle: TextStyle(
                                                        color: Colors.red),
                                                    labelText: "Product Brand",
                                                    labelStyle: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize: w * 0.025,
                                                            color: primaryColor1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    hintText: "Product Brand Name",
                                                    hintStyle: GoogleFonts.roboto(textStyle: TextStyle(fontSize: w * 0.025)),
                                                    suffixText: "*"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.010,
                                            ),
                                            SizedBox(
                                              height: h * 0.012,
                                            ),
                                            Container(
                                              width: w * 0.8,
                                              child: TextFormField(
                                                controller: madeIn,
                                                decoration: InputDecoration(
                                                    enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color.fromARGB(
                                                                255, 0, 0, 0))),
                                                    focusedBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                    suffixStyle: TextStyle(
                                                        color: Colors.red),
                                                    labelText: "Made in",
                                                    labelStyle: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize: w * 0.025,
                                                            color: primaryColor1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    hintText: "Made in",
                                                    hintStyle:
                                                        GoogleFonts.roboto(textStyle: TextStyle(fontSize: w * 0.025)),
                                                    suffixText: "*"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.024,
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: h * 0.030,
                                      ),

                                      Center(
                                        child: TextButton(
                                          onPressed: () async {
                                            var addCatogory = Category(
                                              delete: false,
                                              name: catorgory.text,
                                              subCategory: sub_catorgory.text,
                                              childCategory:
                                                  child_catorgory.text,
                                              categoryBadge:
                                                  catorgory_badgeText.text,
                                              description: description.text,
                                              brand: product_Brand.text,
                                              banner: bannerUrl,
                                              imageUrl: catogoryUrl,
                                              branchId: "",
                                              madeIn: madeIn.text,
                                              vendorId: '',
                                              search: [],
                                            );
                                            await FirebaseFirestore.instance
                                                .collection("parentCategory")
                                                .add(addCatogory.toJson())
                                                .then((val) => {
                                                      val.update({
                                                        "categoryId": val.id
                                                      })
                                                    });
                                          },
                                          child: Container(
                                            width: w * 0.9,
                                            height: h * 0.04,
                                            decoration: BoxDecoration(
                                                gradient: gradient,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Center(
                                                child: Text(
                                              "ADD CATEGORY ",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                EditCategory(),
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
        //  SizedBox(height: h*0.05,),
        Container(
          height: h * 0.05,
          width: w * 2,
          decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(w * 0.03),
                  topRight: Radius.circular(w * 0.02))),
        )
      ]),
    );
  }
}
