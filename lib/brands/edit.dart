import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../category/cateogryTab.dart';
import '../globals/colors.dart';

import '../model/brandModel.dart';
import '../model/usermodel.dart';
import '../widgets/uploadmedia.dart';
import 'AddBrand.dart';
import 'brands.dart';


AddBrand? brands1;
class Edit extends StatefulWidget {


  // AddBrand? brandData;

  Edit({key,});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  Stream<List<AddBrand>> getBrands() => FirebaseFirestore.instance
      .collection('brands')
      .where('delete', isEqualTo: false)
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => AddBrand.fromJson(doc.data())).toList());
  Stream<List<AddBrand>> getSearchBrands() => FirebaseFirestore.instance
      .collection('brands')
      .where('delete', isEqualTo: false)
      .where('search', arrayContains: searchController.text.toUpperCase())
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => AddBrand.fromJson(doc.data())).toList());

  TextEditingController searchController = TextEditingController();

  List brands = [];
  List edityoutubelink = [];
  var brandId;
  bool editBrandaffiliate = false;
  String? editebannerUrl;
  String? editbrandUrl;

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
    String fileName = (editimage2!.path);
    Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL();
    editebannerUrl = await taskSnapshot.ref.getDownloadURL();
    setState(() {});
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
    setState(() {});
  }

  List editdownloadUrls = [];
  getMultipleimages() async {
    List editfeatureimages = [];

    final List<XFile>? pickedimages = await picker.pickMultiImage();

    if (pickedimages != null) {
      pickedimages.forEach((e) async {
        editfeatureimages.add(File(e.path));
      });
      setState(() {});
    }
    for (int i = 0; i < editfeatureimages.length; i++) {
      String url = await uploadfiles(editfeatureimages[i]);
      editdownloadUrls.add({
        'link': url,
        // "link":featureimages,
        'name': editfeatureName.text,
      });
    }
    editfeatureName.clear();
    setState(() {});
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

  List editgalaryImagesUrls = [];
  getGallaryimages() async {
    List editgalaryImages = [];
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
    getBrands();

    if(reEdit>=0){
      editbrandName.text = brands1!.brand!;
      editbrandtitle = TextEditingController(
          text: brands1!.head);
      editcouponCode = TextEditingController(
          text: brands1!.color);
      editcontentDetails = TextEditingController(
          text: brands1!.content);

      // editpercentage = TextEditingController(
      //     text: brands1!.percentage.toString());
      editbrandUrl = brands1!.imageUrl!;
      editebannerUrl = brands1!.banner!;
      editgalaryImagesUrls =
      brands1!.galleryImage!;
      editdownloadUrls = brands1!.imageList!;
      // editcommissionPer = TextEditingController(text:brands1!.percentage.toString());
      edityoutubelink = brands1!.youTube!;
    }
    super.initState();
  }


  bool? edit=false;
  TextEditingController editbrandName = TextEditingController();
  TextEditingController editbrandtitle = TextEditingController();
  TextEditingController editcouponCode = TextEditingController();
  TextEditingController editcontentDetails = TextEditingController();
  TextEditingController editfeatureName = TextEditingController();
  TextEditingController editYoutubeVideoUrl = TextEditingController();
  TextEditingController editpercentage = TextEditingController();
  TextEditingController editcommissionPer = TextEditingController();
  // editbrandUrl = brands1!.imageUrl;
  List<String> editcommision = ["percentage %", "Amount"];
  var brandindex;
  var data;
  List? feature;

  @override
  Widget build(BuildContext context) {

    // edit=false;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: reEdit<0?
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        SizedBox(
          height: 10,
        ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: h * 0.04,
                  width: w * 0.899,
                  decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (v){
                        setState(() {

                        });
                      },

                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: w * 0.030, color: Colors.black),
                        hintText: 'Search Product',
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
                // Container(
                //     height: h * 0.04,
                //     width: w * 0.25,
                //     decoration:
                //         BoxDecoration(borderRadius: BorderRadius.circular(5)),
                //     child: CustomDropdown(
                //       borderRadius: BorderRadius.circular(5),
                //       fieldSuffixIcon: Icon(
                //         Icons.arrow_drop_down_outlined,
                //         color: Colors.white,
                //         size: h * 0.035,
                //       ),
                //       listItemStyle: TextStyle(fontSize: w * 0.025),
                //       selectedStyle:
                //           TextStyle(fontSize: w * 0.025, color: Colors.white),
                //       fillColor: primaryColor,
                //       hintText: "Sellers",
                //       hintStyle:
                //           TextStyle(fontSize: h * 0.014, color: Colors.white),
                //       items: sellers,
                //       controller: seller,
                //     )),
              ],
            ),
            SizedBox(
              height: h * 0.02,
            ),
        SizedBox(
          width: h*0.4,
          height: 0.5,
          child: ColoredBox(color: Colors.grey),
        ),
        StreamBuilder<List<AddBrand>>(
            stream: searchController.text.isEmpty?getBrands():getSearchBrands(),
            builder: (context, snapshot) {
              print(snapshot.error);

              if(snapshot.hasError){
                print('snapshot.hasError');
                print('');
              }
              if (!snapshot.hasData) {
                return Center(child: Text("no brands"));
              }
              data = snapshot.data!;
              return Expanded(

                child: Stack(children: [
                  ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        // brands1 = snapshot.data![index];
                        // brands1 = data[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(data[index].brand!
                              ),
                              trailing: TextButton(
                                  onPressed: () {
                                    print(1);

                                    print(2);
                                     brands1 = data[index];
                                    print(3);
                                    edit = true;
                                    print(4);

                                    // brands1=AddBrand(
                                    //   venderId: brands1?.venderId,
                                    //   color: brands1?.color,
                                    //   banner: brands1?.banner,
                                    //   branchId: brands1!.branchId,
                                    //  content: brands1!.content,
                                    //   imageList: brands1!.imageList,
                                    //   youTube: brands1!.youTube,
                                    //   galleryImage: brands1!.galleryImage
                                    //
                                    // );

                                   // editBrandaffiliate = brands1!.Brandaffiliate!;
                                    editbrandName.text = brands1!.brand!;
                                    editbrandtitle = TextEditingController(text: brands1!.head);
                                    editcouponCode = TextEditingController(text: brands1!.color);
                                    editcontentDetails = TextEditingController(text: brands1!.content);
                                    editbrandUrl = brands1!.imageUrl!;
                                    editebannerUrl = brands1!.banner!;
                                    editgalaryImagesUrls = brands1!.galleryImage!;
                                    editdownloadUrls = brands1!.imageList!;
                                    // editcommissionPer = TextEditingController(text:brands1!.percentage.toString());
                                    edityoutubelink = brands1!.youTube!;
                                    setState(() {
                                    });

                                  },
                                  child: Container(
                                    width: w * 0.200,
                                    height: h * 0.035,
                                    decoration: BoxDecoration(
                                        border:
                                        Border.all(color: primaryColor1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Center(
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(color: primaryColor1),
                                        )),
                                  )),
                            ),
                            SizedBox(
                              width: 320,
                              height: 0.5,
                              child: ColoredBox(color: Colors.grey),
                            ),
                          ],
                        );
                      }),
                  edit == true
                      ? SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: h,
                    width: w,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Padding(
                            padding: EdgeInsets.all(w * 0.02),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Upload Brand Logo",
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
                                            image: DecorationImage(
                                                image:
                                                NetworkImage(brands1!.imageUrl.toString()),
                                                fit: BoxFit.fill),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            color: Color(0xffE9E9E9),
                                          ),
                                        )
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
                                              "Upload Brand Logo",
                                              style: TextStyle(color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.013,
                                  ),
                                  Text(".Brand Logo : 1000 x 1000 px",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: w * 0.025,
                                              color: primaryColor))),
                                  SizedBox(
                                    height: h * 0.013,
                                  ),
                                  Text("Upload Brand Logo",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: w * 0.03,
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
                                          width: w * 0.55,
                                          height: h * 0.12,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  brands1!.banner.toString(),
                                                ),
                                                fit: BoxFit.fill),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            color: Color(0xffE9E9E9),
                                          ),
                                        )

                                        // Positioned(
                                        //   left: w * 0.49,
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
                                              style: TextStyle(color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.013,
                                  ),
                                  Text(".Banner Size : 1916 x 700 px",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: w * 0.025,
                                              color: primaryColor))),
                                  SizedBox(
                                    height: h * 0.015,
                                  ),
                                  Container(
                                    width: w * 0.9,
                                    child: TextFormField(
                                      controller: editbrandName,
                                      decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          suffixStyle:
                                          TextStyle(color: Colors.red),
                                          labelText: "Brand name",
                                          labelStyle: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.025,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          hintText: "Brand name",
                                          //"Enter Brand name",
                                          hintStyle: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.025)),
                                          suffixText: "*"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.013,
                                  ),
                                  Container(
                                    width: w * 0.9,
                                    child: TextFormField(
                                      controller: editbrandtitle,
                                      decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          suffixStyle:
                                          TextStyle(color: Colors.red),
                                          labelText: "Brand Page Title/Head",
                                          labelStyle: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.025,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          hintText: 'title',
                                          // "Enter Brand name",
                                          hintStyle: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.025)),
                                          suffixText: "*"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.013,
                                  ),
                                  Container(
                                    width: w * 0.9,
                                    child: TextFormField(
                                      controller: editcouponCode,
                                      decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          suffixStyle:
                                          TextStyle(color: Colors.red),
                                          labelText: "Coupon Color Code",
                                          labelStyle: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.025,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          hintText:
                                          "Enter your color code eg.#HDK345",
                                          hintStyle: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.025)),
                                          suffixText: "*"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.013,
                                  ),
                                  Container(
                                    width: w * 0.9,
                                    child: TextFormField(
                                      controller: editcontentDetails,
                                      decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          suffixStyle:
                                          TextStyle(color: Colors.red),
                                          labelText: "Content/Details",
                                          labelStyle: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.025,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          suffixText: "*"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.018,
                                  ),
                                  Text("Feature Image List (1000x1000 px)",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: w * 0.025,
                                              color: Colors.black))),
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
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: w * 0.6,
                                        child: TextFormField(
                                          controller: editfeatureName,
                                          //controller: ,
                                          decoration: InputDecoration(
                                            hintText: "Enter feature Name",
                                            hintStyle: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: w * 0.025,
                                                    color: Colors.black)),
                                            suffixText: "*",
                                            suffixStyle:
                                            TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w * 0.02,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (editfeatureName.text.isNotEmpty) {
                                            getMultipleimages();
                                            // featureName.clear();
                                          } else {
                                            showUploadMessage(
                                                context, "Enter Feature Name");
                                          }
                                        },
                                        child: Container(
                                          width: w * 0.22,
                                          height: h * 0.047,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            gradient: LinearGradient(colors: [
                                              Color(0xff8C31FF),
                                              Color(0xff601AB9)
                                            ]),
                                          ),
                                          child: Center(
                                              child: Text(
                                                "Upload",
                                                style:
                                                TextStyle(color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: h * 0.025),
                                  Padding(
                                    padding: EdgeInsets.all(w * 0.02),
                                    child: GridView.builder(
                                        physics: ScrollPhysics(),
                                        itemCount: editdownloadUrls.length,
                                        //editfeatureimages.length,
                                        shrinkWrap: true,
                                        gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: w * 0.5,
                                            mainAxisExtent: h * 0.15,
                                            childAspectRatio: 2 / 2,
                                            crossAxisSpacing: w * 0.03,
                                            mainAxisSpacing: h * 0.02),
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          return editdownloadUrls.isNotEmpty
                                              ? Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: w * 0.800,
                                                      height: h * 0.1,
                                                      decoration: BoxDecoration(
                                                          color:
                                                          Colors.white,
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  editdownloadUrls[index]
                                                                  [
                                                                  'link']),
                                                              fit: BoxFit
                                                                  .fill)),

                                                      // child: Image.file(
                                                      //   File(editdownloadUrls[index]
                                                      //       .path),
                                                      //   fit: BoxFit.fill,
                                                      // ),
                                                    ),
                                                    Text(
                                                      editdownloadUrls[
                                                      index]["name"],
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: h *
                                                                  0.02)),
                                                    )
                                                  ],
                                                ),
                                                Positioned(
                                                  left: w * 0.29,
                                                  bottom: h * 0.12,
                                                  child: InkWell(
                                                    onTap: () {
                                                      // productImages.removeAt(0);
                                                      // image = null;
                                                      setState(() {});
                                                    },
                                                    child: InkWell(
                                                      onTap: () {
                                                        editdownloadUrls
                                                            .removeAt(
                                                            index);
                                                        setState(() {
                                                        });
                                                      },
                                                      child: Container(
                                                        width: w * 0.2,
                                                        height: h * 0.04,
                                                        child: const Icon(
                                                          Icons.clear,
                                                          color: Color
                                                              .fromARGB(
                                                              255,
                                                              254,
                                                              253,
                                                              255),
                                                          size: 25,
                                                        ),
                                                        decoration: const BoxDecoration(
                                                            color: Color(
                                                                0xff8C31FF),
                                                            shape: BoxShape
                                                                .circle),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ])
                                              : Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Container(
                                                  width: w * 0.800,
                                                  height: h * 0.95,
                                                  decoration:
                                                  BoxDecoration(
                                                      color: Colors
                                                          .white),
                                                ),
                                                Positioned(
                                                  left: w * 0.30,
                                                  bottom: h * 0.10,
                                                  child: InkWell(
                                                    onTap: () {
                                                      // productImages.removeAt(0);
                                                      // image = null;
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      width: w * 0.2,
                                                      height: h * 0.04,
                                                      child: const Icon(
                                                        Icons.clear,
                                                        color: Color
                                                            .fromARGB(
                                                            255,
                                                            254,
                                                            253,
                                                            255),
                                                        size: 25,
                                                      ),
                                                      decoration: const BoxDecoration(
                                                          color: Color(
                                                              0xff8C31FF),
                                                          shape: BoxShape
                                                              .circle),
                                                    ),
                                                  ),
                                                )
                                              ]);
                                        }),
                                  ),
                                  SizedBox(
                                    height: h * 0.020,
                                  ),
                                  Text("Gallery images",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: w * 0.025,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold))),
                                  SizedBox(
                                    height: h * 0.010,
                                  ),
                                  SizedBox(
                                    width: w * 0.9,
                                    height: h * 0.0009,
                                    child: ColoredBox(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: h * 0.020,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(w * 0.02),
                                    child: Container(
                                      child: GridView.builder(
                                          physics: ScrollPhysics(),
                                          itemCount:
                                          editgalaryImagesUrls.length,
                                          shrinkWrap: true,
                                          gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: w * 0.6,
                                              mainAxisExtent: h * 0.15,
                                              childAspectRatio: 2 / 2,
                                              crossAxisSpacing: w * 0.015,
                                              mainAxisSpacing: h * 0.01),
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Container(
                                                    width: w * 0.400,
                                                    height: h * 85,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                editgalaryImagesUrls[
                                                                index]!),
                                                            fit: BoxFit.fill)),
                                                    // child: Image.file(
                                                    //   File(editgalaryImagesUrls!),
                                                    //   fit: BoxFit.fill,
                                                    // ),
                                                  ),
                                                  Positioned(
                                                    left: w * 0.28,
                                                    bottom: h * 0.12,
                                                    child: InkWell(
                                                      onTap: () {
                                                        editgalaryImagesUrls
                                                            .removeAt(index);
                                                        // image = null;
                                                        setState(() {
                                                          print(
                                                              editgalaryImagesUrls);
                                                          print(
                                                              ">>>>>>>>>>>>>>>>>");
                                                        });
                                                      },
                                                      child: Container(
                                                        width: w * 0.2,
                                                        height: h * 0.04,
                                                        child: const Icon(
                                                          Icons.clear,
                                                          color: Color.fromARGB(
                                                              255,
                                                              254,
                                                              253,
                                                              255),
                                                          size: 25,
                                                        ),
                                                        decoration:
                                                        const BoxDecoration(
                                                            color: Color(
                                                                0xff8C31FF),
                                                            shape: BoxShape
                                                                .circle),
                                                      ),
                                                    ),
                                                  )
                                                ]);
                                          }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.012,
                                  ),
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        getGallaryimages();
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
                                              "Upload ",
                                              style: TextStyle(color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.012,
                                  ),
                                  Text(
                                    "YouTube Link",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontSize: w * 0.025,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    height: h * 0.012,
                                  ),
                                  SizedBox(
                                    width: w * 0.9,
                                    height: h * 0.0009,
                                    child: ColoredBox(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: h * 0.024,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: w * 0.6,
                                        child: TextFormField(
                                          controller: editYoutubeVideoUrl,
                                          decoration: InputDecoration(
                                            hintText: "Enter Video Url",
                                            hintStyle: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: w * 0.025,
                                                    color:
                                                    Colors.grey.shade400)),
                                            suffixText: "*",
                                            suffixStyle:
                                            TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w * 0.01,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (editYoutubeVideoUrl
                                              .text.isNotEmpty) {
                                            edityoutubelink.add({
                                              "link": editYoutubeVideoUrl.text,
                                              "thumbnail": "",
                                            });
                                            showUploadMessage(
                                                context, "upload success");
                                          }
                                          setState(() {
                                            editYoutubeVideoUrl.clear();
                                          });
                                        },
                                        child: Container(
                                          width: w * 0.22,
                                          height: h * 0.047,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            gradient: LinearGradient(colors: [
                                              Color(0xff8C31FF),
                                              Color(0xff601AB9)
                                            ]),
                                          ),
                                          child: Center(
                                              child: Text(
                                                "Upload",
                                                style:
                                                TextStyle(color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: h * 0.024,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //   MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text("Enable Affiliate Program",
                                  //         style: GoogleFonts.roboto(
                                  //             textStyle: TextStyle(
                                  //                 fontSize: w * 0.025,
                                  //                 color: Colors.black,
                                  //                 fontWeight:
                                  //                 FontWeight.bold))),
                                  //     SizedBox(
                                  //       width: w * 0.200,
                                  //     ),
                                  //     Row(
                                  //       children: [
                                  //         FlutterSwitch(
                                  //           activeColor:
                                  //           const Color(0xff66BD46),
                                  //           width: w * 0.13,
                                  //           height: h * 0.028,
                                  //           valueFontSize: 0.0,
                                  //           toggleSize: 15.0,
                                  //           value: editBrandaffiliate,
                                  //           borderRadius: 30.0,
                                  //           padding: 8.0,
                                  //           onToggle: (val) {
                                  //             setState(() {
                                  //               editBrandaffiliate = val;
                                  //             });
                                  //           },
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: h * 0.02,
                                  // ),
                                  // Text("Commission for this brand products",
                                  //     style: GoogleFonts.roboto(
                                  //         textStyle: TextStyle(
                                  //             fontSize: w * 0.025,
                                  //             color: Colors.black,
                                  //             fontWeight: FontWeight.bold))),
                                  // SizedBox(
                                  //   height: h * 0.012,
                                  // ),
                                  // SizedBox(
                                  //   width: w * 0.9,
                                  //   height: h * 0.0009,
                                  //   child: ColoredBox(color: Colors.grey),
                                  // ),
                                  // SizedBox(
                                  //   height: h * 0.030,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //   MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Container(
                                  //         decoration: BoxDecoration(
                                  //             border: Border.all(
                                  //                 color: primaryColor),
                                  //             borderRadius:
                                  //             BorderRadius.circular(5)),
                                  //         height: h * 0.050,
                                  //         width: w * 0.340,
                                  //         child: CustomDropdown(
                                  //            hintText: "select",
                                  //
                                  //           fieldSuffixIcon: Icon(
                                  //             Icons.arrow_drop_down_outlined,
                                  //             color: Colors.black,
                                  //             size: h * 0.035,
                                  //           ),
                                  //           listItemStyle:
                                  //           TextStyle(fontSize: w * 0.02),
                                  //           selectedStyle: TextStyle(
                                  //               fontSize: w * 0.02,
                                  //               color: Colors.black),
                                  //           hintStyle: TextStyle(
                                  //               fontSize: w * 0.020,
                                  //               color: Colors.black),
                                  //           items: editcommision,
                                  //           controller: editpercentage,
                                  //         )),
                                  //     SizedBox(
                                  //       width: w * 0.04,
                                  //     ),
                                  //     Container(
                                  //       width: w * 0.45,
                                  //       child: TextFormField(
                                  //         controller: editcommissionPer,
                                  //         decoration: InputDecoration(
                                  //           hintText: "Enter Video Url",
                                  //           hintStyle: GoogleFonts.roboto(
                                  //               textStyle: TextStyle(
                                  //                 fontSize: w * 0.025,
                                  //                 color: Colors.grey.shade400,
                                  //               )),
                                  //           suffixText: "*",
                                  //           suffixStyle:
                                  //           TextStyle(color: Colors.red),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: 16,
                                  // ),
                                  // SizedBox(
                                  //   width: w * 0.9,
                                  //   height: h * 0.0011,
                                  //   child: ColoredBox(color: Colors.grey),
                                  // ),
                                  // SizedBox(
                                  //   height: 27,
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          if (editimage1 != "" &&
                                              editimage1 != "" &&
                                              editbrandName.text != "" &&
                                              editbrandtitle.text != "" &&
                                              editcouponCode.text != "" &&
                                              editcontentDetails.text != "") {
                                            {
                                              await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                        title:
                                                        Text('Edit Brand?'),
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
                                                              onPressed: () {
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
                                                                  ()  {
                                                                final updatebrand = brands1!.copyWith(
                                                                    imageUrl: editbrandUrl,
                                                                    banner: editebannerUrl,
                                                                    imageList: editdownloadUrls,
                                                                    galleryImage: editgalaryImagesUrls,
                                                                    brand: editbrandName.text,
                                                                    content: editcontentDetails.text,
                                                                    color: editcouponCode.text,
                                                                    // Brandaffiliate: editBrandaffiliate,
                                                                    head: editbrandtitle.text,
                                                                    youTube: edityoutubelink,
                                                                    // percentage: double.tryParse(editpercentage.text),
                                                                    // commissionPer: editcommissionPer.text,
                                                                  date:DateTime.now(),
                                                                  brandId: brands1!.brandId
                                                                );
                                                                print('first edit');
                                                                print(brands1!.brandId);

                                                                 FirebaseFirestore.instance.collection(
                                                                    "brands").doc(brands1!.brandId)
                                                                    .update(updatebrand.toJson());


                                                                showUploadMessage(context, 'Brand edited Successfully',);
                                                                editbrandName
                                                                    .text = '';
                                                                editcontentDetails
                                                                    .text = '';
                                                                editbrandtitle
                                                                    .text = '';
                                                                editYoutubeVideoUrl
                                                                    .text = '';
                                                                editcommissionPer
                                                                    .text = '';
                                                                editcouponCode
                                                                    .text = '';
                                                                editdownloadUrls
                                                                    .clear();
                                                                editgalaryImagesUrls
                                                                    .clear();
                                                                editimage1 ==
                                                                    '';
                                                                editimage2 ==
                                                                    '';
                                                                Navigator.pop(
                                                                    context);
                                                              }),
                                                        ]);
                                                  });
                                            }
                                          } else {
                                            editimage1 == ''
                                                ? showUploadMessage(context, 'Please upload Brand Logo')
                                                : editimage2 == ''
                                                ? showUploadMessage(context, 'Please upload  Banner')
                                                : editbrandName.text == '' ? showUploadMessage(
                                                context, 'Please enter Brand Name')
                                                : editbrandtitle.text == ''
                                                ? showUploadMessage(context,
                                                'Please enter Brand Title')
                                                : editcouponCode.text == '' ?
                                            showUploadMessage(context, 'Please enter CouponCode Colour') :
                                            showUploadMessage(context, 'Please enter Content');
                                          }

                                          setState(() {});
                                        },
                                        child: Container(
                                          width: w * 0.40,
                                          height: h * 0.05,
                                          decoration: BoxDecoration(
                                              gradient: gradient,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Center(
                                              child: Text(
                                                "SAVE ",
                                                style:
                                                TextStyle(color: Colors.white),
                                              )),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {

                                          FirebaseFirestore.instance
                                              .collection("brands")
                                              .doc(brands1!.brandId)
                                              .update({
                                            "delete": true,
                                          })
                                              .then((value) => {
                                            {
                                              FirebaseFirestore.instance
                                                  .collection('vendor')
                                                  .doc(currentUser!.id)
                                                  .update({
                                                'brandlist':
                                                FieldValue.arrayRemove(
                                                    [brands1!.brandId])
                                              }),

                                            }

                                          })
                                              .then((value) {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BrandDetails()));
                                          });
                                          showUploadMessage(
                                            context,
                                            'Brand Deleted Successfully',
                                          );
                                        },
                                        child: Container(
                                          width: w * 0.38,
                                          height: h * 0.05,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Center(
                                              child: Text(
                                                "Delete ",
                                                style:
                                                TextStyle(color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                          ],
                        ),
                      )
                      : SizedBox()
                ]),
              );
            }),
      ])
          :
      SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: h*0.4,
                height: 0.5,
                child: ColoredBox(color: Colors.grey),
              ),
              StreamBuilder<List<AddBrand>>(
                  stream: getBrands(),
                  builder: (context, snapshot) {
                    print(snapshot.error);

                    if(snapshot.hasError){
                      print('snapshot.hasError');
                      print('');
                    }
                    if (!snapshot.hasData) {
                      return Center(child: Text("no brands"));
                    }

                    data = snapshot.data;



                    // editBrandaffiliate =
                    // brands1!.Brandaffiliate!;


                    print('rededittttttttttttttttttt');
                    print(data[reEdit]);
                    return Expanded(
                      child: Stack(children: [
                        edit == true
                            ? Container(
                          width: w,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.all(w * 0.02),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Upload Brand Logo",
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
                                            image: DecorationImage(
                                                image:
                                                NetworkImage(editbrandUrl!),
                                                fit: BoxFit.fill),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            color: Color(0xffE9E9E9),
                                          ),
                                        )
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
                                              "Upload Brand Logo",
                                              style: TextStyle(color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.013,
                                  ),
                                  Text(".Brand Logo : 1000 x 1000 px",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: w * 0.025,
                                              color: primaryColor))),
                                  SizedBox(
                                    height: h * 0.013,
                                  ),
                                  Text("Upload Brand Logo",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: w * 0.03,
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
                                          width: w * 0.55,
                                          height: h * 0.12,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  editebannerUrl!,
                                                ),
                                                fit: BoxFit.fill),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            color: Color(0xffE9E9E9),
                                          ),
                                        )

                                        // Positioned(
                                        //   left: w * 0.49,
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
                                              style: TextStyle(color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.013,
                                  ),
                                  Text(".Banner Size : 1916 x 700 px",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: w * 0.025,
                                              color: primaryColor))),
                                  SizedBox(
                                    height: h * 0.015,
                                  ),
                                  Container(
                                    width: w * 0.9,
                                    child: TextFormField(
                                      controller: editbrandName,
                                      decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          suffixStyle:
                                          TextStyle(color: Colors.red),
                                          labelText: "Brand name",
                                          labelStyle: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.025,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          hintText: editbrandName.toString(),
                                          //"Enter Brand name",
                                          hintStyle: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.025)),
                                          suffixText: "*"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.013,
                                  ),
                                  Container(
                                    width: w * 0.9,
                                    child: TextFormField(
                                      controller: editbrandtitle,
                                      decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          suffixStyle:
                                          TextStyle(color: Colors.red),
                                          labelText: "Brand Page Title/Head",
                                          labelStyle: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.025,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          hintText: editbrandtitle.toString(),
                                          // "Enter Brand name",
                                          hintStyle: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.025)),
                                          suffixText: "*"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.013,
                                  ),
                                  Container(
                                    width: w * 0.9,
                                    child: TextFormField(
                                      controller: editcouponCode,
                                      decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          suffixStyle:
                                          TextStyle(color: Colors.red),
                                          labelText: "Coupon Color Code",
                                          labelStyle: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.025,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          hintText:
                                          "Enter your color code eg.#HDK345",
                                          hintStyle: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.025)),
                                          suffixText: "*"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.013,
                                  ),
                                  Container(
                                    width: w * 0.9,
                                    child: TextFormField(
                                      controller: editcontentDetails,
                                      decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          suffixStyle:
                                          TextStyle(color: Colors.red),
                                          labelText: "Content/Details",
                                          labelStyle: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.025,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          suffixText: "*"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.018,
                                  ),
                                  Text("Feature Image List (1000x1000 px)",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: w * 0.025,
                                              color: Colors.black))),
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
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: w * 0.6,
                                        child: TextFormField(
                                          controller: editfeatureName,
                                          //controller: ,
                                          decoration: InputDecoration(
                                            hintText: "Enter feature Name",
                                            hintStyle: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: w * 0.025,
                                                    color: Colors.black)),
                                            suffixText: "*",
                                            suffixStyle:
                                            TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w * 0.02,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (editfeatureName.text.isNotEmpty) {
                                            getMultipleimages();
                                            // featureName.clear();
                                          } else {
                                            showUploadMessage(
                                                context, "Enter Feature Name");
                                          }
                                        },
                                        child: Container(
                                          width: w * 0.22,
                                          height: h * 0.047,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            gradient: LinearGradient(colors: [
                                              Color(0xff8C31FF),
                                              Color(0xff601AB9)
                                            ]),
                                          ),
                                          child: Center(
                                              child: Text(
                                                "Upload",
                                                style:
                                                TextStyle(color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: h * 0.025),
                                  Padding(
                                    padding: EdgeInsets.all(w * 0.02),
                                    child: GridView.builder(
                                        physics: ScrollPhysics(),
                                        itemCount: editdownloadUrls.length,
                                        //editfeatureimages.length,
                                        shrinkWrap: true,
                                        gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: w * 0.5,
                                            mainAxisExtent: h * 0.15,
                                            childAspectRatio: 2 / 2,
                                            crossAxisSpacing: w * 0.03,
                                            mainAxisSpacing: h * 0.02),
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          return editdownloadUrls.isNotEmpty
                                              ? Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: w * 0.800,
                                                      height: h * 0.1,
                                                      decoration: BoxDecoration(
                                                          color:
                                                          Colors.white,
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  editdownloadUrls[index]
                                                                  [
                                                                  'link']),
                                                              fit: BoxFit
                                                                  .fill)),

                                                      // child: Image.file(
                                                      //   File(editdownloadUrls[index]
                                                      //       .path),
                                                      //   fit: BoxFit.fill,
                                                      // ),
                                                    ),
                                                    Text(
                                                      editdownloadUrls[
                                                      index]["name"],
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: h *
                                                                  0.02)),
                                                    )
                                                  ],
                                                ),
                                                Positioned(
                                                  left: w * 0.29,
                                                  bottom: h * 0.12,
                                                  child: InkWell(
                                                    onTap: () {
                                                      // productImages.removeAt(0);
                                                      // image = null;
                                                      setState(() {});
                                                    },
                                                    child: InkWell(
                                                      onTap: () {
                                                        editdownloadUrls
                                                            .removeAt(
                                                            index);
                                                        setState(() {
                                                        });
                                                      },
                                                      child: Container(
                                                        width: w * 0.2,
                                                        height: h * 0.04,
                                                        child: const Icon(
                                                          Icons.clear,
                                                          color: Color
                                                              .fromARGB(
                                                              255,
                                                              254,
                                                              253,
                                                              255),
                                                          size: 25,
                                                        ),
                                                        decoration: const BoxDecoration(
                                                            color: Color(
                                                                0xff8C31FF),
                                                            shape: BoxShape
                                                                .circle),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ])
                                              : Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Container(
                                                  width: w * 0.800,
                                                  height: h * 0.95,
                                                  decoration:
                                                  BoxDecoration(
                                                      color: Colors
                                                          .white),
                                                ),
                                                Positioned(
                                                  left: w * 0.30,
                                                  bottom: h * 0.10,
                                                  child: InkWell(
                                                    onTap: () {
                                                      // productImages.removeAt(0);
                                                      // image = null;
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      width: w * 0.2,
                                                      height: h * 0.04,
                                                      child: const Icon(
                                                        Icons.clear,
                                                        color: Color
                                                            .fromARGB(
                                                            255,
                                                            254,
                                                            253,
                                                            255),
                                                        size: 25,
                                                      ),
                                                      decoration: const BoxDecoration(
                                                          color: Color(
                                                              0xff8C31FF),
                                                          shape: BoxShape
                                                              .circle),
                                                    ),
                                                  ),
                                                )
                                              ]);
                                        }),
                                  ),
                                  SizedBox(
                                    height: h * 0.020,
                                  ),
                                  Text("Gallery images",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: w * 0.025,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold))),
                                  SizedBox(
                                    height: h * 0.010,
                                  ),
                                  SizedBox(
                                    width: w * 0.9,
                                    height: h * 0.0009,
                                    child: ColoredBox(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: h * 0.020,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(w * 0.02),
                                    child: Container(
                                      child: GridView.builder(
                                          physics: ScrollPhysics(),
                                          itemCount:
                                          editgalaryImagesUrls.length,
                                          shrinkWrap: true,
                                          gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: w * 0.6,
                                              mainAxisExtent: h * 0.15,
                                              childAspectRatio: 2 / 2,
                                              crossAxisSpacing: w * 0.015,
                                              mainAxisSpacing: h * 0.01),
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Container(
                                                    width: w * 0.400,
                                                    height: h * 85,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                editgalaryImagesUrls[
                                                                index]!),
                                                            fit: BoxFit.fill)),
                                                    // child: Image.file(
                                                    //   File(editgalaryImagesUrls!),
                                                    //   fit: BoxFit.fill,
                                                    // ),
                                                  ),
                                                  Positioned(
                                                    left: w * 0.28,
                                                    bottom: h * 0.12,
                                                    child: InkWell(
                                                      onTap: () {
                                                        editgalaryImagesUrls
                                                            .removeAt(index);
                                                        // image = null;
                                                        setState(() {
                                                          print(
                                                              editgalaryImagesUrls);
                                                          print(
                                                              ">>>>>>>>>>>>>>>>>");
                                                        });
                                                      },
                                                      child: Container(
                                                        width: w * 0.2,
                                                        height: h * 0.04,
                                                        child: const Icon(
                                                          Icons.clear,
                                                          color: Color.fromARGB(
                                                              255,
                                                              254,
                                                              253,
                                                              255),
                                                          size: 25,
                                                        ),
                                                        decoration:
                                                        const BoxDecoration(
                                                            color: Color(
                                                                0xff8C31FF),
                                                            shape: BoxShape
                                                                .circle),
                                                      ),
                                                    ),
                                                  )
                                                ]);
                                          }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.012,
                                  ),
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        getGallaryimages();
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
                                              "Upload ",
                                              style: TextStyle(color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.012,
                                  ),
                                  Text(
                                    "YouTube Link",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontSize: w * 0.025,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    height: h * 0.012,
                                  ),
                                  SizedBox(
                                    width: w * 0.9,
                                    height: h * 0.0009,
                                    child: ColoredBox(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: h * 0.024,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: w * 0.6,
                                        child: TextFormField(
                                          controller: editYoutubeVideoUrl,
                                          decoration: InputDecoration(
                                            hintText: "Enter Video Url",
                                            hintStyle: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: w * 0.025,
                                                    color:
                                                    Colors.grey.shade400)),
                                            suffixText: "*",
                                            suffixStyle:
                                            TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w * 0.01,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (editYoutubeVideoUrl
                                              .text.isNotEmpty) {
                                            edityoutubelink.add({
                                              "link": editYoutubeVideoUrl.text,
                                              "thumbnail": "",
                                            });
                                            showUploadMessage(
                                                context, "upload success");
                                          }
                                          setState(() {
                                            editYoutubeVideoUrl.clear();
                                          });
                                        },
                                        child: Container(
                                          width: w * 0.22,
                                          height: h * 0.047,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            gradient: LinearGradient(colors: [
                                              Color(0xff8C31FF),
                                              Color(0xff601AB9)
                                            ]),
                                          ),
                                          child: Center(
                                              child: Text(
                                                "Upload",
                                                style:
                                                TextStyle(color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: h * 0.024,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //   MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text("Enable Affiliate Program",
                                  //         style: GoogleFonts.roboto(
                                  //             textStyle: TextStyle(
                                  //                 fontSize: w * 0.025,
                                  //                 color: Colors.black,
                                  //                 fontWeight:
                                  //                 FontWeight.bold))),
                                  //     SizedBox(
                                  //       width: w * 0.200,
                                  //     ),
                                  //     Row(
                                  //       children: [
                                  //         FlutterSwitch(
                                  //           activeColor:
                                  //           const Color(0xff66BD46),
                                  //           width: w * 0.13,
                                  //           height: h * 0.028,
                                  //           valueFontSize: 0.0,
                                  //           toggleSize: 15.0,
                                  //           value: editBrandaffiliate,
                                  //           borderRadius: 30.0,
                                  //           padding: 8.0,
                                  //           onToggle: (val) {
                                  //             setState(() {
                                  //               editBrandaffiliate = val;
                                  //             });
                                  //           },
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: h * 0.02,
                                  // ),
                                  // Text("Commission for this brand products",
                                  //     style: GoogleFonts.roboto(
                                  //         textStyle: TextStyle(
                                  //             fontSize: w * 0.025,
                                  //             color: Colors.black,
                                  //             fontWeight: FontWeight.bold))),
                                  // SizedBox(
                                  //   height: h * 0.012,
                                  // ),
                                  // SizedBox(
                                  //   width: w * 0.9,
                                  //   height: h * 0.0009,
                                  //   child: ColoredBox(color: Colors.grey),
                                  // ),
                                  // SizedBox(
                                  //   height: h * 0.030,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //   MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Container(
                                  //         decoration: BoxDecoration(
                                  //             border: Border.all(
                                  //                 color: primaryColor),
                                  //             borderRadius:
                                  //             BorderRadius.circular(5)),
                                  //         height: h * 0.050,
                                  //         width: w * 0.340,
                                  //         child: CustomDropdown(
                                  //           hintText: "select",
                                  //
                                  //           fieldSuffixIcon: Icon(
                                  //             Icons.arrow_drop_down_outlined,
                                  //             color: Colors.black,
                                  //             size: h * 0.035,
                                  //           ),
                                  //           listItemStyle:
                                  //           TextStyle(fontSize: w * 0.02),
                                  //           selectedStyle: TextStyle(
                                  //               fontSize: w * 0.02,
                                  //               color: Colors.black),
                                  //           hintStyle: TextStyle(
                                  //               fontSize: w * 0.020,
                                  //               color: Colors.black),
                                  //           items: editcommision,
                                  //           controller: editpercentage,
                                  //         )),
                                  //     SizedBox(
                                  //       width: w * 0.04,
                                  //     ),
                                  //     Container(
                                  //       width: w * 0.45,
                                  //       child: TextFormField(
                                  //         controller: editcommissionPer,
                                  //         decoration: InputDecoration(
                                  //           hintText: "Enter Video Url",
                                  //           hintStyle: GoogleFonts.roboto(
                                  //               textStyle: TextStyle(
                                  //                 fontSize: w * 0.025,
                                  //                 color: Colors.grey.shade400,
                                  //               )),
                                  //           suffixText: "*",
                                  //           suffixStyle:
                                  //           TextStyle(color: Colors.red),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: 16,
                                  // ),
                                  // SizedBox(
                                  //   width: w * 0.9,
                                  //   height: h * 0.0011,
                                  //   child: ColoredBox(color: Colors.grey),
                                  // ),
                                  // SizedBox(
                                  //   height: 27,
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          if (editbrandUrl != null &&
                                              editebannerUrl!= null &&
                                              editbrandName.text != "" &&
                                              editbrandtitle.text != "" &&
                                              editcouponCode.text != "" &&
                                              editcontentDetails.text != "") {
                                            {
                                              await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                        title:
                                                        Text('Edit Brand?'),
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
                                                              onPressed: () {
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
                                                                  ()  {
                                                                final updatebrand = brands1!.copyWith(
                                                                    imageUrl: editbrandUrl,
                                                                    banner: editebannerUrl,
                                                                    imageList: editdownloadUrls,
                                                                    galleryImage: editgalaryImagesUrls,
                                                                    brand: editbrandName.text,
                                                                    content: editcontentDetails.text,
                                                                    color: editcouponCode.text,
                                                                    //Brandaffiliate: editBrandaffiliate,
                                                                    head: editbrandtitle.text,
                                                                    youTube: edityoutubelink,
                                                                    // percentage: double.tryParse(editpercentage.text),
                                                                    // commissionPer: editcommissionPer.text,
                                                                    date:DateTime.now(),
                                                                  venderId: brands1!.venderId

                                                                );
                                                                print('"""""""""editbrandName.text"""""""""');
                                                                print(editbrandName.text);

                                                                 FirebaseFirestore.instance.collection(
                                                                    "brands").doc(brands1!.brandId)
                                                                    .update(updatebrand.toJson()).then((value) {
                                                                   showUploadMessage(context, 'Brand edited Successfully',);
                                                                   Navigator.pop(context);
                                                                   Navigator.pop(context);

                                                                   editbrandName
                                                                       .text = '';
                                                                   editcontentDetails
                                                                       .text = '';
                                                                   editbrandtitle
                                                                       .text = '';
                                                                   editYoutubeVideoUrl
                                                                       .text = '';
                                                                   editcommissionPer
                                                                       .text = '';
                                                                   editcouponCode
                                                                       .text = '';
                                                                   editdownloadUrls
                                                                       .clear();
                                                                   editgalaryImagesUrls
                                                                       .clear();
                                                                   editimage1 =
                                                                   null;
                                                                   editimage2 =
                                                                   null;
                                                                 });



                                                              }),
                                                        ]);


                                                  });

                                            }
                                          } else {
                                            editbrandUrl == null
                                                ? showUploadMessage(context, 'Please upload Brand Logo')
                                                : editebannerUrl == null
                                                ? showUploadMessage(context, 'Please upload  Banner')
                                                : editbrandName.text == '' ?
                                            showUploadMessage(context, 'Please enter Brand Name')
                                                : editbrandtitle.text == ''
                                                ? showUploadMessage(context, 'Please enter Brand Title')
                                                : editcouponCode.text == '' ?
                                            showUploadMessage(context, 'Please enter CouponCode Colour') :
                                            showUploadMessage(context, 'Please enter Content');
                                          }

                                          setState(() {});
                                        },
                                        child: Container(
                                          width: w * 0.40,
                                          height: h * 0.05,
                                          decoration: BoxDecoration(
                                              gradient: gradient,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Center(
                                              child: Text(
                                        "SAVE",
                                                style:
                                                TextStyle(color: Colors.white),
                                              )),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {

                                          FirebaseFirestore.instance
                                              .collection("brands")
                                              .doc(brands1!.brandId)
                                              .update({
                                            "delete": true,
                                          })
                                              .then((value) => {
                                            {
                                              FirebaseFirestore.instance
                                                  .collection('vendor')
                                                  .doc(currentUser!.id)
                                                  .update({
                                                'brandlist':
                                                FieldValue.arrayRemove(
                                                    [brands1!.brandId])
                                              }),

                                            }

                                          })
                                              .then((value) {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BrandDetails()));
                                          });
                                          showUploadMessage(
                                            context,
                                            'Brand Deleted Successfully',
                                          );
                                        },
                                        child: Container(
                                          width: w * 0.38,
                                          height: h * 0.05,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Center(
                                              child: Text(
                                                "Delete ",
                                                style:
                                                TextStyle(color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                            : SizedBox()
                      ]),
                    );
                  }),
            ]),
      ),
    );
  }
}