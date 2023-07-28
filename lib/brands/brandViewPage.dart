import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../globals/colors.dart';
import '../model/brandModel.dart';
import '../widgets/customButton.dart';
import '../widgets/uploadmedia.dart';
import 'Edit.dart';
import 'editbrand.dart';


class BrandViewPage extends StatefulWidget {
  AddBrand? brandData;

  final String id;

  BrandViewPage({Key? key, required this.id});

  @override
  State<BrandViewPage> createState() => _BrandViewPageState();
}

bool Brandaffiliate = false;
String? bannerUrl;
String? brandUrl;

class _BrandViewPageState extends State<BrandViewPage> {
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
//         });
//       }
//     });
//   }
  TextEditingController brandName = TextEditingController();
  TextEditingController brandtitle = TextEditingController();
  TextEditingController couponCode = TextEditingController();
  TextEditingController contentDetails = TextEditingController();
  TextEditingController featureName = TextEditingController();
  List<String> sellers = ["Today", "This Week", " This Month", "This Year"];
  TextEditingController seller = TextEditingController();
  TextEditingController percentage = TextEditingController();
  TextEditingController YoutubeVideoUrl = TextEditingController();
  TextEditingController commissionPer = TextEditingController();
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

  getMultipleimages() async {
    List featureimages = [];
    final List<XFile>? pickedimages = await picker.pickMultiImage();

    if (pickedimages != null) {
      pickedimages.forEach((e) async {
        featureimages.add(File(e.path));
      });
      setState(() {});
    }

    // downloadUrls=[];
    for (int i = 0; i < featureimages.length; i++) {
      String url = await uploadfiles(featureimages[i]);

      downloadUrls.add({
        'link': url,
        // "link":featureimages,
        'name': featureName.text,
      });
    }

    featureName.clear();
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

  int selectedIndex = 0;

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
                  height: h * 0.80,
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
                          // crossAxisAlignment: CrossAxisAlignment.,
                          children: [
                            Container(
                              height: h * 0.05,
                              width: w * 0.92,
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
                              height: h * 5,
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
                                            .collection('brands')
                                            .doc(widget.id)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                                child:
                                                CircularProgressIndicator());
                                          }
                                          String? link;
                                          var data = snapshot.data;
                                          try{
                                           link =  data!['youTube'][0]['link'];
                                          }catch(e){
                                            link='';

                                          }
                                          brandName.text = data!['brand'];
                                          brandtitle.text = data!['head'];
                                          YoutubeVideoUrl.text = link!;
                                          couponCode.text = data!['color'];
                                          contentDetails.text = data!['content'];
                                          for (var a in data['imageList']) {
                                            downloadUrls.add(a);
                                          }
                                          for (var a in data['galleryImage']) {
                                            galaryImagesUrls.add(a);
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
                                                          "Upload Brand Logo",
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
                                              Text("Upload Brand Banner",
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
                                              Container(
                                                width: w * 0.8,
                                                child: TextFormField(
                                                  controller: brandName,
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Color.fromARGB(
                                                                  255,
                                                                  0,
                                                                  0,
                                                                  0))),
                                                      focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .black)),
                                                      suffixStyle: TextStyle(
                                                          color: Colors.red),
                                                      labelText: "Brand name",
                                                      labelStyle: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: w * 0.025,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold)),
                                                      hintText: "Enter Brand name",
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
                                                  controller: brandtitle,
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Color.fromARGB(
                                                                  255,
                                                                  0,
                                                                  0,
                                                                  0))),
                                                      focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .black)),
                                                      suffixStyle: TextStyle(
                                                          color: Colors.red),
                                                      labelText:
                                                      "Brand Page Title/Head",
                                                      labelStyle: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: w * 0.025,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold)),
                                                      hintText: "Enter Brand name",
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
                                                  controller: couponCode,
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Color.fromARGB(
                                                                  255,
                                                                  0,
                                                                  0,
                                                                  0))),
                                                      focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .black)),
                                                      suffixStyle: TextStyle(
                                                          color: Colors.red),
                                                      labelText:
                                                      "Coupon Color Code",
                                                      labelStyle: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: w * 0.025,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold)),
                                                      hintText: "Enter your color code eg.#HDK345",
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
                                                  controller: contentDetails,
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Color.fromARGB(
                                                                  255,
                                                                  0,
                                                                  0,
                                                                  0))),
                                                      focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .black)),
                                                      suffixStyle: TextStyle(
                                                          color: Colors.red),
                                                      labelText:
                                                      "Content/Details",
                                                      labelStyle: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: w * 0.025,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold)),
                                                      suffixText: "*"),
                                                ),
                                              ),
                                              SizedBox(
                                                height: h * 0.020,
                                              ),
                                              Text(
                                                  "Feature Image List (1000x1000 px)",
                                                  style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          fontSize: w * 0.035,
                                                          color:
                                                          Colors.black))),
                                              SizedBox(
                                                height: h * 0.020,
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
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: w * 0.55,
                                                    child: TextFormField(
                                                      controller: featureName,
                                                      //controller: ,
                                                      decoration:
                                                      InputDecoration(
                                                        hintText:
                                                        "Enter feature Name",
                                                        hintStyle: GoogleFonts.roboto(
                                                            textStyle: TextStyle(
                                                                fontSize:
                                                                w * 0.030,
                                                                color: Colors
                                                                    .black)),
                                                        suffixText: "*",
                                                        suffixStyle: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: w * 0.030,
                                                  // ),
                                                  TextButton(
                                                    onPressed: () {
                                                      if (featureName
                                                          .text.isNotEmpty) {
                                                        getMultipleimages();
                                                        // featureName.clear();

                                                      } else {
                                                        showUploadMessage(
                                                            context,
                                                            "Enter Feature Name");
                                                      }
                                                      print(featureImage);
                                                      print(featureName.text);
                                                      print(
                                                          ">>>>>>>>>>>>>>>>>>>>>>");
                                                    },
                                                    child: Container(
                                                      width: w * 0.22,
                                                      height: h * 0.047,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8)),
                                                        gradient:
                                                        LinearGradient(
                                                            colors: [
                                                              Color(0xff8C31FF),
                                                              Color(0xff601AB9)
                                                            ]),
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                            "Upload",
                                                            style: TextStyle(
                                                                color:
                                                                Colors.white),
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: h * 0.025),
                                              Padding(
                                                padding:
                                                EdgeInsets.all(w * 0.02),
                                                child: Container(
                                                  height: h * 0.15,
                                                  child: GridView.builder(
                                                      physics: ScrollPhysics(),
                                                      itemCount:
                                                      downloadUrls.length,
                                                      shrinkWrap: true,
                                                      gridDelegate:
                                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                                          maxCrossAxisExtent:
                                                          w * 0.5,
                                                          mainAxisExtent:
                                                          h * 0.15,
                                                          childAspectRatio:
                                                          2 / 2,
                                                          crossAxisSpacing:
                                                          w * 0.03,
                                                          mainAxisSpacing:
                                                          h * 0.01),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                          index) {
                                                        return downloadUrls
                                                            .isNotEmpty
                                                            ? Stack(
                                                            clipBehavior:
                                                            Clip.none,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(
                                                                        top: 10,
                                                                        right: 10),
                                                                    child:
                                                                    Container(
                                                                      width:
                                                                      w * 0.400,
                                                                      height:
                                                                      h * 0.1,
                                                                      decoration:
                                                                      BoxDecoration(color: Colors.white, image: DecorationImage(image: NetworkImage(downloadUrls[index]["link"]), fit: BoxFit.fill)),
                                                                      // child: Image.file(
                                                                      //         File(featureimages[index]
                                                                      //             .path),
                                                                      //         fit: BoxFit.fill,
                                                                      // ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    downloadUrls[index]
                                                                    [
                                                                    "name"],
                                                                    style:
                                                                    TextStyle(color: Colors.black),
                                                                  )
                                                                ],
                                                              ),
                                                              Positioned(
                                                                left: w *
                                                                    0.25,
                                                                bottom: h *
                                                                    0.115,
                                                                child:
                                                                InkWell(
                                                                  onTap:
                                                                      () {
                                                                    downloadUrls
                                                                        .removeAt(index);
                                                                    setState(
                                                                            () {});
                                                                  },
                                                                  child:
                                                                  Container(
                                                                    width:
                                                                    w * 0.2,
                                                                    height:
                                                                    h * 0.035,
                                                                    child:
                                                                    const Icon(
                                                                      Icons.clear,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          254,
                                                                          253,
                                                                          255),
                                                                      size:
                                                                      20,
                                                                    ),
                                                                    decoration: const BoxDecoration(
                                                                        color: Color(0xff8C31FF),
                                                                        shape: BoxShape.circle),
                                                                  ),
                                                                ),
                                                              )
                                                            ])
                                                            : SizedBox();
                                                        // Stack(
                                                        //     clipBehavior: Clip.none,
                                                        //     children:[
                                                        //       Padding(
                                                        //         padding: const EdgeInsets.only(top: 10,right: 10),                                                            child: Container(
                                                        //         width: w * 0.800,
                                                        //         height: h * 0.50,
                                                        //         decoration: BoxDecoration(
                                                        //             color: Colors.blue),
                                                        //
                                                        //     ),
                                                        //       ),
                                                        //       Positioned(
                                                        //         left: w * 0.30,
                                                        //         bottom: h * 0.10,
                                                        //         child: InkWell(
                                                        //           onTap: () {
                                                        //             // productImages.removeAt(0);
                                                        //             // image = null;
                                                        //             setState(() {});
                                                        //           },
                                                        //           child: Container(
                                                        //             width: w * 0.2,
                                                        //             height: h * 0.04,
                                                        //             child: const Icon(
                                                        //               Icons.clear,
                                                        //               color: Color.fromARGB(255, 254, 253, 255),
                                                        //               size: 25,
                                                        //             ),
                                                        //             decoration: const BoxDecoration(
                                                        //                 color: Color(0xff8C31FF), shape: BoxShape.circle),
                                                        //           ),
                                                        //         ),
                                                        //       )
                                                        //     ]
                                                        // );
                                                      }),
                                                ),
                                              ),
                                              SizedBox(
                                                height: h * 0.020,
                                              ),
                                              Text("Gallery images",
                                                  style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          fontSize: w * 0.030,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .bold))),
                                              SizedBox(
                                                height: h * 0.010,
                                              ),
                                              SizedBox(
                                                width: w * 0.9,
                                                height: h * 0.0009,
                                                child: ColoredBox(
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                height: h * 0.01,
                                              ),
                                              Container(
                                                // height: h*0.2,
                                                child: GridView.builder(
                                                    physics: ScrollPhysics(),
                                                    itemCount:
                                                    galaryImagesUrls.length,
                                                    shrinkWrap: true,
                                                    gridDelegate:
                                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                                        maxCrossAxisExtent:
                                                        w * 0.6,
                                                        mainAxisExtent:
                                                        h * 0.15,
                                                        childAspectRatio:
                                                        2 / 2,
                                                        crossAxisSpacing:
                                                        w * 0.03,
                                                        mainAxisSpacing:
                                                        h * 0.03),
                                                    itemBuilder:
                                                        (BuildContext context,
                                                        index) {
                                                      return Stack(
                                                          clipBehavior:
                                                          Clip.none,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 10,
                                                                  left: 10),
                                                              child: Container(
                                                                width:
                                                                w * 0.400,
                                                                height: h * 100,
                                                                decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(galaryImagesUrls[
                                                                        index]),
                                                                        fit: BoxFit
                                                                            .fill)),
                                                                // child: Image.file(
                                                                //   File(galaryImages[index].path),
                                                                //   fit: BoxFit.fill,
                                                                // ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              left: w * 0.29,
                                                              bottom: h * 0.115,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  galaryImagesUrls
                                                                      .removeAt(
                                                                      index);
                                                                  // productImages.removeAt(2);
                                                                  //  image1 = null;
                                                                  setState(
                                                                          () {});
                                                                },
                                                                child:
                                                                Container(
                                                                  width:
                                                                  w * 0.2,
                                                                  height:
                                                                  h * 0.035,
                                                                  child:
                                                                  const Icon(
                                                                    Icons.clear,
                                                                    color: Color
                                                                        .fromARGB(
                                                                        255,
                                                                        254,
                                                                        253,
                                                                        255),
                                                                    size: 20,
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
                                                height: h * 0.01,
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
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                    child: Center(
                                                        child: Text(
                                                          "Upload ",
                                                          style: TextStyle(
                                                              color: Colors.white),
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
                                                        fontWeight:
                                                        FontWeight.bold)),
                                              ),
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
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: w * 0.5,
                                                    child: TextFormField(
                                                      controller:
                                                      YoutubeVideoUrl,
                                                      decoration:
                                                      InputDecoration(
                                                        hintText:
                                                        "Enter Video Url",
                                                        hintStyle: GoogleFonts.roboto(
                                                            textStyle: TextStyle(
                                                                fontSize:
                                                                w * 0.025,
                                                                color: Colors
                                                                    .grey
                                                                    .shade400)),
                                                        suffixText: "*",
                                                        suffixStyle: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      if (YoutubeVideoUrl
                                                          .text.isNotEmpty) {
                                                        youtubelink.add({
                                                          "link":
                                                          YoutubeVideoUrl
                                                              .text,
                                                          "thumbnail": "",
                                                        });
                                                        showUploadMessage(
                                                            context,
                                                            "upload success");
                                                      }
                                                      setState(() {
                                                        YoutubeVideoUrl.clear();
                                                      });
                                                      print(youtubelink);
                                                    },
                                                    child: Container(
                                                      width: w * 0.19,
                                                      height: h * 0.047,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8)),
                                                        gradient:
                                                        LinearGradient(
                                                            colors: [
                                                              Color(0xff8C31FF),
                                                              Color(0xff601AB9)
                                                            ]),
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                            "Upload",
                                                            style: TextStyle(
                                                                color:
                                                                Colors.white),
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: h * 0.01,
                                              ),
                                              SizedBox(
                                                height: h * 0.01,
                                              ),
                                              SizedBox(
                                                width: w * 0.9,
                                                height: h * 0.0009,
                                                child: ColoredBox(
                                                    color: Colors.grey),
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
                                                            'Accepted');
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
                                                        'Accepted');
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
                                  EditBrand(id:widget.id)
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
        SizedBox(height: h*0.025,),
        Container(
          height: h * 0.04,
          width: w * 2,
          decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(w * 0.04),
                  topRight: Radius.circular(w * 0.04))),
        )
      ]),
    );
  }
}