import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';


import '../globals/colors.dart';
import '../model/cateogryModel.dart';
import '../model/usermodel.dart';
import '../widgets/uploadmedia.dart';

class EditCategory extends StatefulWidget {
  // Category? categoryData;

  EditCategory({
    key,
    // this.categoryData,
  });

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  editControllers() {
    //sub_catorgoryController.text = category!.subCategory!;
  }

  final catorgoryController = TextEditingController();
  final sub_catorgoryController = TextEditingController();
  final child_catorgoryController = TextEditingController();
  final catorgory_badgeTextController = TextEditingController();
  final descriptionController = TextEditingController();
  final product_BrandController = TextEditingController();
  final madeInController = TextEditingController();
  bool update = false;
  bool edit = false;
  var catogoryData;

  Stream<List<Category>> getCategory() => FirebaseFirestore.instance
      .collection('category')
      .where('delete', isEqualTo: false)
      .where('vendorId', isEqualTo: currentUser!.id)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Category.fromJson(doc.data())).toList());

  // getBrand(){
  //   FirebaseFirestore.instance
  //       .collection('brands').where('delete',isEqualTo: false).where('venderId',isEqualTo: currentUser?.id)
  //       .snapshots().listen((event) {
  //         for(var doc in event.docs){
  //           b
  //         }
  //
  //   });
  // }
  List brands = [];
  Category? category;
  var brandId;
  bool editBrandaffiliate = false;
  String? editbannerUrl;
  String? editbrandUrl;

  List editgalaryimageUrl = [];

  File? editimage1;
  File? editimage2;
  final picker = ImagePicker();

  editgetBanner() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickImage != null) {
        editimage1= File(pickImage.path);
        edituploadBanner(editimage1!);
      } else {}
    });
  }

  edituploadBanner(File imageFile) async {
    String fileName = (editimage1!.path);
    Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL();
    editbannerUrl = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      
    });
  }

  final brandPicker = ImagePicker();

   getBrandlogo() async {
    var brandpickImage = await brandPicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (brandpickImage != null) {
        editimage2 = File(brandpickImage.path);
        edituploadBrand(editimage2!);
      } else {}
    });
  }

  edituploadBrand(File image) async {
    String fileName = (editimage2!.path);
    Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    editbrandUrl = await taskSnapshot.ref.getDownloadURL();
    setState(() {});
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

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 350,
            height: 0.5,
            child: ColoredBox(color: Colors.grey),
          ),
          StreamBuilder<List<Category>>(
              stream: getCategory(),
              // stream: FirebaseFirestore.instance
              //     .collection('brands').where('delete',isEqualTo: false).where('venderId',isEqualTo: currentUser?.id)
              //     .snapshots(),

              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                catogoryData = snapshot.data!;
                return Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                          itemCount: catogoryData.length,
                          itemBuilder: (BuildContext context, int index) {
                            category = catogoryData[index] as Category;
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(category!.name!),
                                    trailing: TextButton(
                                        onPressed: () {
                                          category =
                                              catogoryData[index] as Category;
                                          print(category!.name!);
                                          print(category!.imageUrl);
                                          catorgoryController.text =
                                              category!.name!;
                                          sub_catorgoryController.text =
                                              category!.subCategory!;
                                          child_catorgoryController.text =
                                              category!.childCategory!;
                                          catorgory_badgeTextController.text =
                                              category!.categoryBadge!;
                                          descriptionController.text =
                                              category!.description!;
                                          product_BrandController.text =
                                              category!.brand!;
                                          madeInController.text =
                                              category!.madeIn!;
                                          editbrandUrl = category!.imageUrl!;
                                          editbannerUrl = category!.banner!;

                                          edit = true;

                                          setState(() {});
                                          // print(data);
                                        },
                                        child: Container(
                                          width: w * 0.200,
                                          height: h * 0.035,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: primaryColor1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Center(
                                              child: Text(
                                            "Edit",
                                            style:
                                                TextStyle(color: primaryColor1),
                                          )),
                                        )),
                                  ),
                                  SizedBox(
                                    width: 350,
                                    height: 0.5,
                                    child: ColoredBox(color: Colors.grey),
                                  ),
                                ],
                              ),
                            );
                          }),
                      edit == true
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Upload Category image",
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                fontSize: w * 0.025,
                                                fontWeight: FontWeight.bold))),
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
                                          Container(
                                            width: w * 0.3,
                                            height: h * 0.13,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              color: Color(0xffE9E9E9),
                                            ),
                                          ),
                                          Container(
                                            width: w * 0.3,
                                            height: h * 0.13,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      editbrandUrl!),
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
                                            style:
                                                TextStyle(color: Colors.white),
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
                                                fontWeight: FontWeight.bold))),

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
                                          
                                               Container(
                                            width: w * 0.3,
                                            height: h * 0.13,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              color: Color(0xffE9E9E9),
                                            ),
                                          ),
                                              Container(
                                                  width: w * 0.55,
                                                  height: h * 0.12,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            editbannerUrl!),
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
                                          editgetBanner();
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
                                            style:
                                                TextStyle(color: Colors.white),
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
                                      padding: EdgeInsets.only(left: w * 0.030),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: w * 0.8,
                                            child: TextFormField(
                                              controller: catorgoryController,
                                              decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                                  suffixStyle: TextStyle(
                                                      color: Colors.red),
                                                  labelText: "category",
                                                  labelStyle: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          fontSize: w * 0.025,
                                                          color: primaryColor1,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  hintText: "Category name",
                                                  hintStyle: GoogleFonts.roboto(
                                                      textStyle: TextStyle(fontSize: w * 0.025)),
                                                  suffixText: "*"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: h * 0.013,
                                          ),
                                          Container(
                                            width: w * 0.8,
                                            child: TextFormField(
                                              controller:
                                                  sub_catorgoryController,
                                              decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                                  suffixStyle: TextStyle(
                                                      color: Colors.red),
                                                  labelText: "Sub-Category",
                                                  labelStyle: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          fontSize: w * 0.025,
                                                          color: primaryColor1,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  hintText: "Sub-Category name",
                                                  hintStyle: GoogleFonts.roboto(
                                                      textStyle: TextStyle(fontSize: w * 0.025)),
                                                  suffixText: "*"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: h * 0.013,
                                          ),
                                          Container(
                                            width: w * 0.8,
                                            child: TextFormField(
                                              controller:
                                                  child_catorgoryController,
                                              decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                                  suffixStyle: TextStyle(
                                                      color: Colors.red),
                                                  labelText: "Child-Category",
                                                  labelStyle: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          fontSize: w * 0.025,
                                                          color: primaryColor1,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  hintText:
                                                      "Child-Category name",
                                                  hintStyle: GoogleFonts.roboto(
                                                      textStyle: TextStyle(fontSize: w * 0.025)),
                                                  suffixText: "*"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: h * 0.013,
                                          ),
                                          Container(
                                            width: w * 0.8,
                                            child: TextFormField(
                                              controller:
                                                  catorgory_badgeTextController,
                                              decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                                  suffixStyle: TextStyle(
                                                      color: Colors.red),
                                                  labelText:
                                                      "Category Badge Text",
                                                  labelStyle: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          fontSize: w * 0.025,
                                                          color: primaryColor1,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  hintText:
                                                      "Category Badge Text Content",
                                                  hintStyle:
                                                      GoogleFonts.roboto(textStyle: TextStyle(fontSize: w * 0.025)),
                                                  suffixText: "*"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Container(
                                            width: w * 0.8,
                                            child: TextFormField(
                                              controller: descriptionController,
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
                                                              FontWeight.bold)),
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
                                              controller:
                                                  product_BrandController,
                                              decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                                  suffixStyle: TextStyle(
                                                      color: Colors.red),
                                                  labelText: "Product Brand",
                                                  labelStyle: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          fontSize: w * 0.025,
                                                          color: primaryColor1,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  hintText:
                                                      "product Brand name",
                                                  hintStyle: GoogleFonts.roboto(
                                                      textStyle: TextStyle(fontSize: w * 0.025)),
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
                                              controller: madeInController,
                                              decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                                  suffixStyle: TextStyle(
                                                      color: Colors.red),
                                                  labelText: "Made in",
                                                  labelStyle: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          fontSize: w * 0.025,
                                                          color: primaryColor1,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  hintText: "Made in",
                                                  hintStyle: GoogleFonts.roboto(
                                                      textStyle: TextStyle(fontSize: w * 0.025)),
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
                                          // print("helooo");
                                          // await FirebaseFirestore.instance
                                          //     .collection("category")
                                          //     .add(addCatogory.toJson())
                                          //     .then((val) => {
                                          //           val.update({
                                          //             "categoryId": val.id
                                          //           })
                                          //         });
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                update = true;
                                                if (update == true) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          content: Text(
                                                              "do you want edit"),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  var updateCatogory = Category(
                                                                      delete:
                                                                          false,
                                                                      name: catorgoryController
                                                                          .text,
                                                                      subCategory:
                                                                          sub_catorgoryController
                                                                              .text,
                                                                      childCategory:
                                                                          child_catorgoryController
                                                                              .text,
                                                                      categoryBadge:
                                                                          catorgory_badgeTextController
                                                                              .text,
                                                                      description:
                                                                          descriptionController
                                                                              .text,
                                                                      brand: product_BrandController
                                                                          .text,
                                                                      banner:
                                                                          editbannerUrl,
                                                                      imageUrl:
                                                                          editbrandUrl,
                                                                      branchId:
                                                                          "",
                                                                      madeIn: madeInController
                                                                          .text,
                                                                      vendorId:
                                                                          currentUser!
                                                                              .id,
                                                                      search: [],
                                                                      categoryId:
                                                                          category!
                                                                              .categoryId);
                                                                  editCatogory(
                                                                      updateCatogory);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    "Yes")),
                                                            TextButton(
                                                                onPressed:
                                                                    () {},
                                                                child:
                                                                    Text("No"))
                                                          ],
                                                          //TextButton(onPressed: onPressed, child: child)
                                                        );
                                                      });
                                                }
                                              },
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
                                                  "Update ",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Container(
                                              width: w * 0.35,
                                              height: h * 0.044,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Center(
                                                  child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                );
              }),
        ]),
      ),
    );
  }

  editCatogory(Category category) {
    FirebaseFirestore.instance
        .collection('category')
        .doc(category.categoryId)
        .update(category.toJson())
        .then((value) {
      showUploadMessage(context, "Update Success");
    });

    //Navigator.pop(context);
  }
}
