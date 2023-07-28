
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

import '../login/splashscreen.dart';
import '../main.dart';

import '../model/cateogryModel.dart';
import '../model/usermodel.dart';
import '../navbar/Navbar.dart';
import '../widgets/uploadmedia.dart';
import 'cateogryTab.dart';
import 'editCategory.dart';



bool resubmit=false;
Category? category;

class AddCategory extends StatefulWidget {
  // AddBrand? brandData;
  AddCategory({key,});

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
  int ctgRefNo=0;

  getCatRefNo(){
    FirebaseFirestore.instance.collection('settings').doc('referenceNo').get().then((value) {
      ctgRefNo=value['catRefNo'];
      if(mounted){
        setState(() {
        });
      }
    });

  }
  TextEditingController category = TextEditingController();
  TextEditingController catorgory_badgeText = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController product_Brand = TextEditingController();
  TextEditingController madeIn = TextEditingController();
  TextEditingController parentId = TextEditingController();
  List<String> parentCateogry = [];
  Map categoryNametoId = {};

  List featureimages = [];
  List downloadUrls = [];

  Future<String> uploadfiles(File file) async {
    final metaData = SettableMetadata(contentType: 'image/jpeg');
    final storageref = FirebaseStorage.instance.ref();
    Reference ref = storageref
        .child('pictures/${DateTime
        .now()
        .microsecondsSinceEpoch}.jpg');
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
        .child('pictures/${DateTime
        .now()
        .microsecondsSinceEpoch}.jpg');
    final uploadTask = ref.putFile(file, metaData);

    final taskSnapshot = await uploadTask.whenComplete(() => null);
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = [];
    String temp = "";

    List<String> nameSplits = caseNumber.split(" ");
    for (int i = 0; i < nameSplits.length; i++) {
      String name = "";

      for (int k = i; k < nameSplits.length; k++) {
        name = name + nameSplits[k] + " ";
      }
      temp = "";

      for (int j = 0; j < name.length; j++) {
        temp = temp + name[j];
        caseSearchList.add(temp.toUpperCase());
      }
    }
    return caseSearchList;
  }
  @override
  void initState() {
    // getUser();
    getCatRefNo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return  SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
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
                        "${currentUser?.Fullname}",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            textStyle: TextStyle(fontSize: w * 0.025)),
                      ),

                      SizedBox(
                        width: w * 0.2,
                        height: 2,
                        child: ColoredBox(color: Colors.grey),
                      ),
                      TextButton(
                          onPressed: () {

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
                    height: h * 0.68,
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
                      initialIndex: reEdit1 >= 0 ? 1 : 0,
                      //s
                      child: ListView(
                        children: [
                          Column(
                              mainAxisSize: MainAxisSize.max,
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
                                  child: TabBar(
                                    onTap:(value) {
                                      reEdit1=-5;
                                      print('===========');
                                      print(reEdit1);
                                    },
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
                                  height: h * 1.45,
                                  width: double.maxFinite,
                                  child: TabBarView(
                                    physics: NeverScrollableScrollPhysics(),
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

                                            Padding(
                                              padding:
                                              EdgeInsets.only(left: w * 0.030),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: w * 0.8,
                                                    child: TextFormField(
                                                      controller: category,
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
                                                          labelText: "category",
                                                          labelStyle: GoogleFonts
                                                              .roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize: w * 0.025,
                                                                  color: primaryColor1,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                          hintText: "Category name",
                                                          hintStyle:
                                                          GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize: w *
                                                                      0.025)),
                                                          suffixText: "*"),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.02,
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
                                                      controller: description,
                                                      maxLines: 3,
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
                                                          labelText: "Product Brand",
                                                          labelStyle: GoogleFonts
                                                              .roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize: w * 0.025,
                                                                  color: primaryColor1,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                          hintText: "Product Brand Name",
                                                          hintStyle: GoogleFonts
                                                              .roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize: w *
                                                                      0.025)),
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
                                                                  color: Color
                                                                      .fromARGB(
                                                                      255, 0, 0, 0))),
                                                          focusedBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color:
                                                                  Colors.black)),
                                                          suffixStyle: TextStyle(
                                                              color: Colors.red),
                                                          labelText: "Made in",
                                                          labelStyle: GoogleFonts
                                                              .roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize: w * 0.025,
                                                                  color: primaryColor1,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                          hintText: "Made in",
                                                          hintStyle:
                                                          GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize: w *
                                                                      0.025)),
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

                                            TextButton(
                                              onPressed: () async {

                                                if ( category.text != "" &&
                                                    catorgory_badgeText.text != "" &&
                                                    description.text != "" &&
                                                    product_Brand.text != "" &&
                                                    bannerUrl != "" &&
                                                    catogoryUrl != "")
                                                {
                                                  {
                                                    await showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                              title: Text(
                                                                  'Add Cateogry?'),
                                                              content: Text(
                                                                  'Do you want to Continue?'),
                                                              actions: [
                                                                TextButton(
                                                                    child: Text(
                                                                      'Cancel',
                                                                      style: TextStyle(
                                                                          color:
                                                                          primaryColor),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                          context)
                                                                          .pop();
                                                                    }),
                                                                TextButton(
                                                                    child: Text(
                                                                      'Ok',
                                                                      style: TextStyle(
                                                                          color:
                                                                          primaryColor),
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      var addCatogory = Category(
                                                                          parentId:parentCategoryNametoId[parentId.text] ,
                                                                          delete: false,
                                                                          name: category.text,
                                                                          categoryBadge: catorgory_badgeText.text,
                                                                          description: description.text,
                                                                          brand: product_Brand.text,
                                                                          banner: bannerUrl,
                                                                          imageUrl: catogoryUrl,
                                                                          branchId: "XaGJz72DaZdJ4S9g7PkO",
                                                                          madeIn: madeIn.text,
                                                                          vendorId: currentUser!.id,
                                                                          search: setSearchParam(category.text),
                                                                          date: DateTime.now(),
                                                                          status: 0,
                                                                          referNo: ctgRefNo+1
                                                                      );
                                                                      await FirebaseFirestore.instance.collection('category')
                                                                          .add(addCatogory.toJson()).then((value) {
                                                                        value.update({
                                                                          'categoryId': value.id
                                                                        }).then((val) =>
                                                                        {
                                                                          FirebaseFirestore.instance.collection('vendor').doc(currentUser!.id).update({
                                                                            'catogorylist': FieldValue.arrayUnion([
                                                                              value.id
                                                                            ])
                                                                          }),
                                                                        });
                                                                      });


                                                                      showUploadMessage(
                                                                        context,
                                                                        'Category Added Successfully',
                                                                      );


                                                                      category.text = '';
                                                                      catorgory_badgeText.text = '';
                                                                      description.text = '';
                                                                      product_Brand.text = '';
                                                                      madeIn.text = '';
                                                                      bannerUrl = '';
                                                                      catogoryUrl = '';


                                                                      Navigator.pop(context);
                                                                      Navigator.pop(context);
                                                                    }),
                                                              ]);
                                                        });
                                                  }
                                                }
                                                else {
                                                  category.text == ''
                                                      ? showUploadMessage(context,
                                                      'Please upload category Name')
                                                      : catorgory_badgeText == '' ? showUploadMessage(
                                                      context,
                                                      'Please upload  category badge name')
                                                      : description.text == ''
                                                      ? showUploadMessage(
                                                      context,
                                                      'Please enter description')
                                                      : bannerUrl ==
                                                      ''
                                                      ? showUploadMessage(
                                                      context,
                                                      'Please upload banner')
                                                      : showUploadMessage(
                                                      context,
                                                      'Please upload image');
                                                }

                                                setState(() {});
                                              },
                                              child: Container(
                                                width: w * 0.85,
                                                height: h * 0.05,
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
                                          ],
                                        ),
                                      ),
                                      EditCategory(),
                                    ],
                                  ),
                                ),
                              ]),
                        ],
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
