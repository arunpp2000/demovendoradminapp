import 'dart:convert';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demovendoradminapp/products/relatedProduct.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';



import 'package:video_player/video_player.dart';
import '../../globals/colors.dart';
import '../../model/addProductModel.dart';
import '../../model/addProductModel.dart';
import '../../model/usermodel.dart';
import '../login/splashscreen.dart';
import '../navbar/Navbar.dart';
import '../navbar/tabbarview/tabbar.dart';
import '../widgets/customButton.dart';
import '../widgets/uploadmedia.dart';
import 'addProduct.dart';
import 'edit/videoViewer.dart';
import 'media.dart';
import 'dart:io';



class pendingApprovalView extends StatefulWidget {
  final AddProductModel productData;
  pendingApprovalView( {Key? key,
    required this. productData}) : super(key: key);

  @override
  State<pendingApprovalView> createState() => _pendingApprovalViewState();
}

class _pendingApprovalViewState extends State<pendingApprovalView>with SingleTickerProviderStateMixin {
  getProducts(){
    FirebaseFirestore.instance.collection('products').get().then((value){
      for(DocumentSnapshot doc in value.docs){
        idToName[doc.get('name')]=doc.id;
        nameToId[doc.id]=doc.get('name');
      }
    });

  }
  bool AddproductTab=false;
  String? brandvalue;
  final picker = ImagePicker();
  List<Asset> productImages = [];
  List<String> productUrls = [];
  List productImage = [];
  List productImageUrls = [];
  File? _video;
  VideoPlayerController? _videoPlayerController;
  List  videoUrl=[];
  final storage = FirebaseStorage.instance;
  bool selectall = false;
  Map checkmap = {};
  bool video = false;

  Future<String?> fileToString(File file) async {
    try {
      // Read the contents of the file
      List<int> bytes = await file.readAsBytes();

      // Decode the bytes into a string using the appropriate encoding
      String contents = utf8.decode(bytes);

      return contents;
    } catch (e) {
      print('Error reading file: $e');
      return null;
    }
  }
  getDoc() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickImage != null) {
      images = File(pickImage.path);
      File file =File(pickImage.path);

      String? fileContents = await fileToString(file);
      if (fileContents != null) {
        print('File contents: $fileContents');
      }
      uploadDocument(images);
    } else {
      print("no image selected");
    }
    setState(() {

    });
  }
  String? imageUrl;
  late File images;
List<String>brand1=[];

Map  brandNametoId={};
Map  brandIdtoName={};
  getBrand() {
    FirebaseFirestore.instance
        .collection("brands")
        .where('status', isEqualTo: 1)
        .get()
        .then((value) {
      brand1=[];
      for (DocumentSnapshot doc in value.docs) {
        brandNametoId[doc.get("brand")] = doc.id;
        brandIdtoName[doc.id] = doc.get("brand");
        brand1.add(doc['brand']);
      }
      print('4444444444444444444444');
      print(brandIdtoName[widget.productData.brand]);
      productBrand=TextEditingController(
          text:brandIdtoName[widget.productData.brand]);

      setState(() {});
    });

  }

  Map categoryNametoId = {};
  Map colorNameToId = {};
  Map attributeNameToId = {};
  Map catIdToName={};
  List<String> categoryList =[];
  getCategory() {
    FirebaseFirestore.instance
        .collection("category")
        .where('status', isEqualTo: 1)
        .get()
        .then((value) {
      categoryList=[];
      for (DocumentSnapshot doc in value.docs) {
        categoryList.add(doc['name']);
        categoryNametoId[doc.get("name")] = doc.id;
        catIdToName[doc.id]=doc.get('name');
      }
      category=TextEditingController(
          text:catIdToName[widget.productData.category]);
      print('55555555555555555555');
      print(catIdToName[widget.productData.category]);
      setState(() {

      });
    });
  }
  uploadDocument(File imageFile) async {
    String fileName = (images.path);
    Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL();
    String? url = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      imageUrl = url;
      productImageUrls.add(imageUrl);
    });
  }
  getGallaryimages() async {
    final List<XFile>? pickedimage = await picker.pickMultiImage();

    if (pickedimage != null) {
      pickedimage.forEach((e) async {
        productImage.add(File(e.path));
      });
      setState(() {});
    }

    for (int i = 0; i < productImage.length; i++) {
      productImageUrls=[];
      String url = await uploadfiles(productImage[i]);
      productImageUrls.add(url);
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
  Future<void> _pickvideo() async {
    final video = await picker.getVideo(source: ImageSource.gallery);
    final videoFile = File(video!.path);
    setState(() {
      _video = videoFile;
    });

    // Get a reference to the location where the video will be stored in Firebase storage.
    final videoRef = storage
        .ref()
        .child('videos/${DateTime.now().millisecondsSinceEpoch}.mp4');

    // Upload the video to Firebase storage.
    final uploadTask = videoRef.putFile(videoFile);
    final snapshot = await uploadTask.whenComplete(() {});

    // Get the download URL of the uploaded video.
    final downloadURL = await snapshot.ref.getDownloadURL();
    videoUrl.add(downloadURL);

    // Save the download URL to Firestore or wherever you need it.
    // ...

    // Initialize a VideoPlayerController with the selected video file.
    _videoPlayerController = VideoPlayerController.file(videoFile)
      ..initialize().then((_) {
        setState(() {
          _videoPlayerController?.pause();
        });
      });
    setState(() {});
  }
  List image = [];
  // List video = [];
  List b2cTierPrice=[];
  List b2bTierPrice=[];
  List b2bDelhiTierPrice=[];
  List b2cDelhiTierPrice=[];
  List b2cKeralaTierPrice=[];
  List b2bKeralaTierPrice=[];
  List b2cNorthEast1TierPrice=[];
  List b2bNorthEast1TierPrice=[];
  List b2cTamilnaduTierPrice=[];
  List b2bTamilnaduTierPrice=[];
  bool B2c = false;
  bool B2b = false;
  bool imported = false;
  bool COD = false;
  bool nonveg = false;
  bool veg = false;
  bool sales = false;
  TextEditingController sellername = TextEditingController();
  TextEditingController productname = TextEditingController();
  TextEditingController productcode = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController hsncode = TextEditingController();
  TextEditingController sold = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController ingredients = TextEditingController();
  TextEditingController nutrition = TextEditingController();
  TextEditingController instruction = TextEditingController();
  TextEditingController madefrom = TextEditingController();
  TextEditingController B2cprice = TextEditingController();
  TextEditingController B2bprice = TextEditingController();
  TextEditingController B2cdelhiprice = TextEditingController();
  TextEditingController B2bdelhiprice = TextEditingController();
  TextEditingController B2ckeralaprice = TextEditingController();
  TextEditingController B2bkeralaprice = TextEditingController();
  TextEditingController B2cnortheast1price = TextEditingController();
  TextEditingController B2bnortheast1price = TextEditingController();
  TextEditingController B2ctamilnaduprice = TextEditingController();
  TextEditingController B2btamilnaduprice = TextEditingController();
  TextEditingController B2cdiscountprice = TextEditingController();
  TextEditingController B2bdiscountprice = TextEditingController();
  TextEditingController B2cdelhidiscountprice = TextEditingController();
  TextEditingController B2bdelhidiscountprice = TextEditingController();

  TextEditingController B2ckeraladiscountprice = TextEditingController();
  TextEditingController B2bkeraladiscountprice = TextEditingController();
  TextEditingController B2cnortheast1discountprice = TextEditingController();
  TextEditingController B2bnortheast1discountprice = TextEditingController();
  TextEditingController B2ctamilnadudiscountprice = TextEditingController();
  TextEditingController B2btamilnadudiscountprice = TextEditingController();
  TextEditingController B2cTierPriceVolum = TextEditingController();
  TextEditingController B2cDelhiTierPriceVolum = TextEditingController();
  TextEditingController B2bDelhiTierPriceVolum = TextEditingController();
  TextEditingController B2cKeralaTierPriceVolum = TextEditingController();
  TextEditingController B2bKeralaTierPriceVolum = TextEditingController();
  TextEditingController B2cNorthEast1TierPriceVolum = TextEditingController();
  TextEditingController B2bNorthEast1TierPriceVolum = TextEditingController();
  TextEditingController B2cTamilnaduTierPriceVolum = TextEditingController();
  TextEditingController B2bTamilnaduTierPriceVolum = TextEditingController();
  TextEditingController B2bTierPriceVolum = TextEditingController();
  TextEditingController B2cTierPriceAmount = TextEditingController();
  TextEditingController B2cDelhiTierPriceAmount = TextEditingController();
  TextEditingController B2bTamilnaduTierPriceAmount = TextEditingController();
  TextEditingController B2bDelhiTierPriceAmount = TextEditingController();
  TextEditingController B2cKeralaTierPriceAmount = TextEditingController();
  TextEditingController B2bKeralaTierPriceAmount = TextEditingController();
  TextEditingController B2cNorthEast1TierPriceAmount = TextEditingController();
  TextEditingController B2bNorthEast1TierPriceAmount = TextEditingController();
  TextEditingController B2cTamilnaduTierPriceAmount = TextEditingController();
  TextEditingController B2bTierPriceAmount = TextEditingController();
  TextEditingController productBrand = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController gst = TextEditingController();

  setSearchParam(String caseNumber) {
    List <String> caseSearchList = <String>[];
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
    tabController = TabController(vsync: this, length: myTabs.length);

    getProducts();
    getCategory();
    getBrand();
    print('555555');
    print(widget.productData.brand);
    // TODO: implement initState
    B2b=widget.productData.b2b!;
    B2c=widget.productData.b2c!;
    imported=widget.productData.imported!;
    COD=widget.productData.payOnDelivery!;
    sales=widget.productData.sales!;
    nonveg=widget.productData.nonveg ?? false;
    veg=widget.productData.veg!;
    sellername=TextEditingController(
        text: widget.productData.sellername);
    // productBrand=TextEditingController(
    //     text:brandIdtoName[widget.productData.brand]);
    // category=TextEditingController(
    //     text:catIdToName[widget.productData.category] );
    sellername=TextEditingController(
        text: widget.productData.sellername);
    hsncode= TextEditingController(
        text: widget.productData.hsnCode.toString());
    sold=TextEditingController(
        text: widget.productData.sold.toString());
    description=TextEditingController(
        text: widget.productData.description);
    ingredients=TextEditingController(
        text: widget.productData.ingredients);
    nutrition=TextEditingController(
        text: widget.productData.fact);
    instruction=TextEditingController(
        text: widget.productData.instructions);
    madefrom=TextEditingController(
        text: widget.productData.madeFrom.toString());
    gst=TextEditingController(
        text: widget.productData.gst.toString());
    productname=TextEditingController(
        text: widget.productData.name.toString());
    productcode=TextEditingController(
        text: widget.productData.productCode.toString());
    weight=TextEditingController(
        text: widget.productData.weight.toString());
    stock=TextEditingController(
        text: widget.productData.stock.toString());
    if(B2c){
      B2cprice=TextEditingController(
          text: widget.productData.b2cP.toString());
      B2cdiscountprice=TextEditingController(
          text: widget.productData.b2cD.toString());
      B2cdelhiprice=TextEditingController(
          text: widget.productData.b2cDelhiP.toString());
      B2ckeralaprice=TextEditingController(
          text: widget.productData.b2cKeralaP.toString());
      B2cnortheast1price=TextEditingController(
          text: widget.productData.b2cNorthEast1P.toString());
      B2ctamilnaduprice=TextEditingController(
          text: widget.productData.b2cTamilnaduP.toString());
      B2cdelhidiscountprice=TextEditingController(
          text: widget.productData.b2cDelhiD.toString());
      B2ckeraladiscountprice=TextEditingController(
          text: widget.productData.b2cKeralaD.toString());
      B2cnortheast1discountprice=TextEditingController(
          text: widget.productData.b2cNorthEast1D.toString());
      B2ctamilnadudiscountprice=TextEditingController(
          text: widget.productData.b2cTamilnaduD.toString());
    }
    if(B2b){
      B2bprice=TextEditingController(
          text: widget.productData.b2bP.toString());
      B2bdiscountprice=TextEditingController(
          text: widget.productData.b2bD.toString());
      B2bdelhiprice=TextEditingController(
          text: widget.productData.b2bDelhiP.toString());
      B2bkeralaprice=TextEditingController(
          text: widget.productData.b2bKeralaP.toString());
      B2bnortheast1price=TextEditingController(
          text: widget.productData.b2bNorthEast1P.toString());
      B2btamilnaduprice=TextEditingController(
          text: widget.productData.b2bTamilnaduP.toString());
      B2bdelhidiscountprice=TextEditingController(
          text: widget.productData.b2bDelhiD.toString());
      B2bkeraladiscountprice=TextEditingController(
          text: widget.productData.b2bKeralaD.toString());
      B2bnortheast1discountprice=TextEditingController(
          text: widget.productData.b2bNorthEast1D.toString());
      B2btamilnadudiscountprice=TextEditingController(
          text: widget.productData.b2bTamilnaduD.toString());
    }
    b2bDelhiTierPrice=widget.productData.b2bDelhiTier??[];
    b2bKeralaTierPrice=widget.productData.b2bKeralaTier??[];
    b2bTamilnaduTierPrice=widget.productData.b2bTamilnaduTier??[];
    b2bNorthEast1TierPrice=widget.productData.b2bNorthEast1Tier??[];
    b2bTierPrice=widget.productData.b2bTier??[];
    b2cNorthEast1TierPrice=widget.productData.b2cNorthEast1Tier??[];
    b2cTierPrice=widget.productData.b2cTier??[];
    b2cTamilnaduTierPrice=widget.productData.b2cTamilnaduTier??[];
    b2cKeralaTierPrice=widget.productData.b2cKeralaTier??[];
    b2cDelhiTierPrice=widget.productData.b2cDelhiTier??[];
    selectedProduct=widget.productData.relatedProducts!;
    productImage=widget.productData.imageId??[];
    productImageUrls=widget.productData.imageId??[];
    videoUrl=widget.productData.videoUrl??[];



    super.initState();
  }
  bool loaded=false;
  List<Tab> myTabs = <Tab>[
    Tab(text: 'Product Details'),
    Tab(text: 'Media'),
  ];
  late TabController tabController;

  set(){
    setState(() {

    });
  }


  /// ADDPRODUCT MODEL TO NEXT PAGE
  AddProductModel? editProductModel;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text("Product View"),
        ),

        body:  Column(
          children: [
            Expanded(
              child: DefaultTabController(
                  length: 2,
                  child: Column(children: [
                    Padding(
                      padding:EdgeInsets.only(left:10,right:10,top:10),
                      child: Container(
                        height: h * 0.05,
                        width: w * 0.98,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child:  TabBar(
                          controller: tabController,
                          indicatorColor: Colors.transparent,
                          indicator: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),

                          tabs: myTabs,
                          labelColor: Colors
                              .white, // Customize the appearance of the TabBar
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:EdgeInsets.only(left:10,right:10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.grey,
                                blurRadius: w * 0.015,
                              ),
                            ],
                          ),
                          height: h,
                          width: double.maxFinite,
                          child: TabBarView(
                              controller: tabController,
                              children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 5),
                                          child: Text("* ",
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: h * 0.015,
                                                    fontWeight: FontWeight.bold),
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {

                                          },
                                          child: Text(
                                              "Only enable options that are relevant to your product. Please \n complete all  required fields to get approval.",
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: h * 0.012,
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            height: h * 0.06,
                                            width: w * 0.450,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: ListTile(
                                              title: Text("B2C",
                                                  style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: h * 0.012,
                                                        fontWeight: FontWeight.bold),
                                                  )),
                                              trailing: Container(
                                                height: h * 0.03,
                                                width: 40,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: FlutterSwitch(
                                                  activeColor:
                                                  const Color(0xff66BD46),
                                                  width: w * 0.13,
                                                  height: h * 0.035,
                                                  valueFontSize: 0.0,
                                                  toggleSize: 15.0,
                                                  value: B2c,
                                                  borderRadius: 30.0,
                                                  padding: 8.0,
                                                  onToggle: (val) {
                                                    setState(() {
                                                      B2c = val;
                                                    });
                                                  },
                                                ),
                                              ),
                                            )),

                                        Container(
                                            height: h * 0.06,
                                            width: w * 0.450,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: ListTile(
                                              title: Text("B2B",
                                                  style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: h * 0.012,
                                                        fontWeight: FontWeight.bold),
                                                  )),
                                              trailing: Container(
                                                height: h * 0.03,
                                                width: 40,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: FlutterSwitch(
                                                  activeColor:
                                                  const Color(0xff66BD46),
                                                  width: w * 0.13,
                                                  height: h * 0.035,
                                                  valueFontSize: 0.0,
                                                  toggleSize: 15.0,
                                                  value: B2b,
                                                  borderRadius: 30.0,
                                                  padding: 8.0,
                                                  onToggle: (val) {
                                                    setState(() {
                                                      B2b = val;
                                                    });
                                                  },
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            height: h * 0.06,
                                            width: w * 0.450,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: ListTile(
                                              title: Text("Imported",
                                                  style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: h * 0.012,
                                                        fontWeight: FontWeight.bold),
                                                  )),
                                              trailing: Container(
                                                height: h * 0.03,
                                                width: 40,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: FlutterSwitch(
                                                  activeColor:
                                                  const Color(0xff66BD46),
                                                  width: w * 0.13,
                                                  height: h * 0.035,
                                                  valueFontSize: 0.0,
                                                  toggleSize: 15.0,
                                                  value: imported,
                                                  borderRadius: 30.0,
                                                  padding: 8.0,
                                                  onToggle: (val) {
                                                    setState(() {
                                                      imported = val;
                                                    });
                                                  },
                                                ),
                                              ),
                                            )),
                                        // SizedBox(
                                        //   width: w * 0.03,
                                        // ),
                                        Container(
                                            height: h * 0.06,
                                            width: w * 0.450,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: ListTile(
                                              title: Text("COD",
                                                  style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: h * 0.012,
                                                        fontWeight: FontWeight.bold),
                                                  )),
                                              trailing: Container(
                                                height: h * 0.03,
                                                width: 40,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: FlutterSwitch(
                                                  activeColor:
                                                  const Color(0xff66BD46),
                                                  width: w * 0.13,
                                                  height: h * 0.035,
                                                  valueFontSize: 0.0,
                                                  toggleSize: 15.0,
                                                  value: COD,
                                                  borderRadius: 30.0,
                                                  padding: 8.0,
                                                  onToggle: (val) {
                                                    setState(() {
                                                      COD = val;
                                                    });
                                                  },
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            height: h * 0.06,
                                            width: w * 0.450,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: ListTile(
                                              title: Text("Non Veg",
                                                  style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: h * 0.012,
                                                        fontWeight: FontWeight.bold),
                                                  )),
                                              trailing: Container(
                                                height: h * 0.03,
                                                width: 40,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: FlutterSwitch(
                                                  activeColor:
                                                  const Color(0xff66BD46),
                                                  width: w * 0.13,
                                                  height: h * 0.035,
                                                  valueFontSize: 0.0,
                                                  toggleSize: 15.0,
                                                  value: nonveg,
                                                  borderRadius: 30.0,
                                                  padding: 8.0,
                                                  onToggle: (val) {
                                                    setState(() {
                                                      nonveg = val;
                                                    });
                                                  },
                                                ),
                                              ),
                                            )),
                                        // SizedBox(
                                        //   width: w * 0.03,
                                        // ),
                                        Container(
                                            height: h * 0.06,
                                            width: w * 0.450,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: ListTile(
                                              title: Text("Veg",
                                                  style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: h * 0.012,
                                                        fontWeight: FontWeight.bold),
                                                  )),
                                              trailing: Container(
                                                height: h * 0.03,
                                                width: 40,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: FlutterSwitch(
                                                  activeColor:
                                                  const Color(0xff66BD46),
                                                  width: w * 0.13,
                                                  height: h * 0.035,
                                                  valueFontSize: 0.0,
                                                  toggleSize: 15.0,
                                                  value: veg,
                                                  borderRadius: 30.0,
                                                  padding: 8.0,
                                                  onToggle: (val) {
                                                    setState(() {
                                                      veg = val;
                                                    });
                                                  },
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),

                                    Row(
                                      children: [

                                        Container(
                                            height: h * 0.06,
                                            width: w * 0.450,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: ListTile(
                                              title: Text("Sale",
                                                  style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: h * 0.012,
                                                        fontWeight: FontWeight.bold),
                                                  )),
                                              trailing: Container(
                                                height: h * 0.03,
                                                width: 40,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: FlutterSwitch(
                                                  activeColor:
                                                  const Color(0xff66BD46),
                                                  width: w * 0.13,
                                                  height: h * 0.035,
                                                  valueFontSize: 0.0,
                                                  toggleSize: 15.0,
                                                  value: sales,
                                                  borderRadius: 30.0,
                                                  padding: 8.0,
                                                  onToggle: (val) {
                                                    setState(() {
                                                      sales = val;
                                                    });
                                                  },
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),

                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                    Divider(
                                      height: h * 0.01,
                                      thickness: h * 0.0015,
                                      color: Colors.grey,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: h * 0.02,
                                        ),
                                        Row(
                                          children: [
                                            Text("Seller Name",
                                                style: GoogleFonts.roboto(
                                                    textStyle:
                                                    TextStyle(fontSize: w * 0.03),
                                                    color: primaryColor)),
                                          ],
                                        ),
                                        TextFormField(
                                          controller: sellername,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            hintText: currentUser?.Fullname,
                                            enabledBorder: const UnderlineInputBorder(
                                              //<-- SEE HERE
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.black54),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: h * 0.02,
                                        ),
                                        Row(
                                          children: [
                                            Text("Product Name",
                                                style: GoogleFonts.roboto(
                                                    textStyle:
                                                    TextStyle(fontSize: w * 0.03),
                                                    color: primaryColor)),
                                            const Text(
                                              "*",
                                              style: TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        TextFormField(
                                          controller: productname,
                                          decoration: InputDecoration(
                                            hintText: "Enter Product Name",
                                            hintStyle: TextStyle(
                                                color: const Color(0xffB3B3B3),
                                                fontSize: h * 0.015),
                                            enabledBorder: const UnderlineInputBorder(
                                              //<-- SEE HERE
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.black54),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: h * 0.02,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Product Code(SKU)",
                                              style: GoogleFonts.roboto(
                                                  textStyle:
                                                  TextStyle(fontSize: w * 0.03),
                                                  color: primaryColor),
                                            ),
                                            const Text(
                                              "*",
                                              style: TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        TextFormField(
                                          controller: productcode,
                                          decoration: InputDecoration(
                                            hintText:
                                            "Add 9 Digit Product Code of your choice. eg. BRAND40PA",
                                            hintStyle: TextStyle(
                                                color: const Color(0xffB3B3B3),
                                                fontSize: h * 0.015),
                                            enabledBorder: const UnderlineInputBorder(
                                              //<-- SEE HERE
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.black54),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: h * 0.02,
                                        ),

                                        Row(
                                          children: [
                                            Text(
                                              "Product Description",
                                              style: GoogleFonts.roboto(
                                                  textStyle:
                                                  TextStyle(fontSize: w * 0.03),
                                                  color: primaryColor),
                                            ),
                                            const Text(
                                              "*",
                                              style: TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        TextFormField(
                                          controller: description,
                                          maxLines: 3,
                                          decoration: InputDecoration(
                                            hintText: "Description ",
                                            hintStyle: TextStyle(
                                                color: const Color(0xffB3B3B3),
                                                fontSize: h * 0.013),
                                            enabledBorder: const UnderlineInputBorder(
                                              //<-- SEE HERE
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.black54),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: h * 0.02,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Select Brand",
                                              style: GoogleFonts.roboto(
                                                  textStyle:
                                                  TextStyle(fontSize: w * 0.03),
                                                  color: primaryColor),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: h * 0.02,
                                        ),

                                        CustomDropdown(
                                          hintText:'select brand',
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
                                          items: brand1.isEmpty ? [''] : brand1,
                                          controller: productBrand,

                                        ),
                                        SizedBox(
                                          height: h * 0.02,
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Category",
                                              style: GoogleFonts.roboto(
                                                  textStyle:
                                                  TextStyle(fontSize: w * 0.03),
                                                  color: primaryColor),
                                            ),
                                            const Text(
                                              "*",
                                              style: TextStyle(color: Colors.red),
                                            ),

                                          ],
                                        ),
                                        SizedBox(
                                          height: h * 0.02,
                                        ),
                                        CustomDropdown(
                                          hintText: "select category",
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
                                          items: categoryList.isEmpty
                                              ? ['']
                                              : categoryList,
                                          controller: category,
                                        ),


                                        SizedBox(
                                          height: h * 0.02,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Ingredients",
                                              style: GoogleFonts.roboto(
                                                  textStyle:
                                                  TextStyle(fontSize: w * 0.03),
                                                  color: primaryColor),
                                            ),
                                            const Text(
                                              "*",
                                              style: TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        TextFormField(
                                          controller: ingredients,
                                          decoration: InputDecoration(
                                            hintText:
                                            "Ingredients List or Upload as product Image",
                                            hintStyle: TextStyle(
                                                color: const Color(0xffB3B3B3),
                                                fontSize: h * 0.015),
                                            enabledBorder: const UnderlineInputBorder(
                                              //<-- SEE HERE
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.black54),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: h * 0.02,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Nutrition Fact",
                                              style: GoogleFonts.roboto(
                                                  textStyle:
                                                  TextStyle(fontSize: w * 0.03),
                                                  color: primaryColor),
                                            ),
                                            const Text(
                                              "*",
                                              style: TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        TextFormField(
                                          controller: nutrition,
                                          decoration: InputDecoration(
                                            hintText:
                                            "Nutrition Info or Upload as product Image",
                                            hintStyle: TextStyle(
                                                color: const Color(0xffB3B3B3),
                                                fontSize: h * 0.015),
                                            enabledBorder: const UnderlineInputBorder(
                                              //<-- SEE HERE
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.black54),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: h * 0.02,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Instructions",
                                              style: GoogleFonts.roboto(
                                                  textStyle:
                                                  TextStyle(fontSize: w * 0.03),
                                                  color: primaryColor),
                                            ),
                                            const Text(
                                              "*",
                                              style: TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        TextFormField(
                                          controller: instruction,
                                          decoration: InputDecoration(
                                            hintText:
                                            "Product Instructions eg. Usage or N/A etc.",
                                            hintStyle: TextStyle(
                                                color: const Color(0xffB3B3B3),
                                                fontSize: h * 0.015),
                                            enabledBorder: const UnderlineInputBorder(
                                              //<-- SEE HERE
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.black54),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: h * 0.02,
                                        ),

                                        Row(
                                          children: [
                                            Text(
                                              "Made From",
                                              style: GoogleFonts.roboto(
                                                  textStyle:
                                                  TextStyle(fontSize: w * 0.03),
                                                  color: primaryColor),
                                            ),
                                            const Text(
                                              "*",
                                              style: TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        TextFormField(
                                          controller: madefrom,
                                          decoration: InputDecoration(
                                            hintText: "Product Origin  eg.India",
                                            hintStyle: TextStyle(
                                                color: const Color(0xffB3B3B3),
                                                fontSize: h * 0.015),
                                            enabledBorder: const UnderlineInputBorder(
                                              //<-- SEE HERE
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.black54),
                                            ),
                                          ),
                                        ),

                                        // // Text("Color"),
                                        // Align(
                                        //     alignment: Alignment.topRight,
                                        //     child: Text(
                                        //       "Add Color",
                                        //       style: GoogleFonts.roboto(
                                        //           textStyle: TextStyle(
                                        //               fontSize: w * 0.03),
                                        //           color: primaryColor),
                                        //     )),


                                        // Align(alignment:Alignment.topRight,child: Text("Add Attributes",style: TextStyle(color: primaryColor),)),


                                        // Align(alignment:Alignment.topRight,child: Text("Add Value",style: TextStyle(color: primaryColor),)),





                                        // SizedBox(height:h *0.02,),
                                        // Row(
                                        //
                                        //   children: [
                                        //
                                        //     Text("Select B2C Shipping Profile ",style: TextStyle(color: primaryColor),),
                                        //     Text("*",style: TextStyle(color: Colors.red),),
                                        //
                                        //
                                        //   ],
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     SizedBox(height: h*0.002,width: w*0.550,child: ColoredBox(color: primaryColor), ),
                                        //     SizedBox(height: h*0.002,width: w*0.350,child: ColoredBox(color: Colors.grey.shade200), ),
                                        //
                                        //
                                        //
                                        //   ],
                                        // ),
                                        // SizedBox(height: h*0.02,),
                                        // CustomDropdown(
                                        //
                                        //   hintText: "child category",
                                        //   borderSide: BorderSide(color:primaryColor),
                                        //   borderRadius: BorderRadius.circular(h * 0.01),
                                        //   fieldSuffixIcon: Icon(
                                        //     Icons.arrow_drop_down_outlined,
                                        //     color: primaryColor,
                                        //     size: h * 0.035,
                                        //   ),
                                        //   listItemStyle: TextStyle(fontSize: w * 0.025),
                                        //   selectedStyle: TextStyle(
                                        //       fontSize: w * 0.025, color: Colors.black),
                                        //   fillColor: Colors.white,
                                        //   hintStyle: TextStyle(
                                        //       fontSize: h * 0.015, color: Colors.black),
                                        //   items: gst1,
                                        //   controller: gst,
                                        // ),
                                        // SizedBox(height: h*0.02,),
                                        //
                                        // Row(
                                        //   children: [
                                        //     Text("*",style: TextStyle(color: Colors.red),),
                                        //
                                        //     Text("Tharacart default B2C shipping calculation is used.",style: TextStyle(fontSize: h*0.013,color: Color(0xff979797
                                        //     )),),
                                        //   ],
                                        // ),
                                        // SizedBox(height: h*0.02,),
                                        // Text("Select one shipping carrier ",style: TextStyle(color: primaryColor),),
                                        // Row(
                                        //   children: [
                                        //     SizedBox(height: h*0.002,width: w*0.550,child: ColoredBox(color: primaryColor), ),
                                        //     SizedBox(height: h*0.002,width: w*0.350,child: ColoredBox(color: Colors.grey.shade200), ),
                                        //
                                        //
                                        //
                                        //   ],
                                        // ),
                                        // ListTile(leading: IconButton(onPressed: () { setState(() {
                                        //   _iconColor=Colors.green;
                                        // }); }, icon: Icon(Icons.circle_outlined,color: _iconColor,),),
                                        // title: Text("Ship Rocket"),),
                                        // SizedBox(height: h*0.02,),
                                        // ListTile(leading: IconButton(onPressed: () { setState(() {
                                        //   _iconColor=Colors.green;
                                        // }); }, icon: Icon(Icons.circle_outlined,color: _iconColor,),),
                                        //   title: Text("Delhivery"),),
                                        // SizedBox(height: h*0.02,),
                                        // ListTile(leading:  IconButton(onPressed: () { setState(() {
                                        //   _iconColor=Colors.green;
                                        // }); }, icon: Icon(Icons.circle_outlined,color: _iconColor,),),
                                        //   title: Text("XpressBees"),),
                                        // SizedBox(height: h*0.02,),
                                        // Row(children: [
                                        //   Text("Group Pricing ",style: TextStyle(color: primaryColor),),
                                        //   Text("*",style: TextStyle(color: Colors.red),),
                                        //   SizedBox(width: w*0.350,),
                                        //   FlutterSwitch(
                                        //     activeColor: Color(0xff66BD46),
                                        //     width: w*0.13,
                                        //     height: h*0.035,
                                        //     valueFontSize: 0.0,
                                        //     toggleSize: 15.0,
                                        //     value: Gpricing,
                                        //     borderRadius: 30.0,
                                        //     padding: 8.0,
                                        //     onToggle: (val) {
                                        //       setState(() {
                                        //         Gpricing = val;
                                        //       });
                                        //     },
                                        //   ),
                                        //
                                        // ],),
                                        // SizedBox(height: h*0.02,),

                                        B2c?Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("B2C Global price ",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: w * 0.03),
                                                          color:
                                                          const Color(0xff298E03))),
                                                  const Text(
                                                    "*",
                                                    style: TextStyle(color: Colors.red),
                                                  ),
                                                  SizedBox(
                                                    width: w * 0.02,
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.0015,
                                                    width: w * 0.55,
                                                    child: ColoredBox(
                                                      color: primaryColor,
                                                    ),
                                                  )
                                                ]),

                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2cprice,
                                                    decoration: InputDecoration(

                                                      hintText: "Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w * 0.04,
                                                ),
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2cdiscountprice,
                                                    decoration: InputDecoration(
                                                      hintText: "Discount Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: h * 0.03,
                                            ),

                                            Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("B2C Delhi price ",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: w * 0.03),
                                                          color:
                                                          const Color(0xff298E03))),
                                                  const Text(
                                                    "*",
                                                    style: TextStyle(color: Colors.red),
                                                  ),
                                                  SizedBox(
                                                    width: w * 0.02,
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.0015,
                                                    width: w * 0.55,
                                                    child: ColoredBox(
                                                      color: primaryColor,
                                                    ),
                                                  )
                                                ]),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2cdelhiprice,
                                                    decoration: InputDecoration(
                                                      hintText: "Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w * 0.04,
                                                ),
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2cdelhidiscountprice,
                                                    decoration: InputDecoration(
                                                      hintText: "Discount Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: h * 0.03,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("B2C Kerala price ",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: w * 0.03),
                                                          color:
                                                          const Color(0xff298E03))),
                                                  const Text(
                                                    "*",
                                                    style: TextStyle(color: Colors.red),
                                                  ),
                                                  SizedBox(
                                                    width: w * 0.02,
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.0015,
                                                    width: w * 0.55,
                                                    child: ColoredBox(
                                                      color: primaryColor,
                                                    ),
                                                  )
                                                ]),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2ckeralaprice,
                                                    decoration: InputDecoration(
                                                      hintText: "Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w * 0.04,
                                                ),
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2ckeraladiscountprice,
                                                    decoration: InputDecoration(
                                                      hintText: "Discount Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: h * 0.03,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("B2C North East 1 price ",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: w * 0.03),
                                                          color:
                                                          const Color(0xff298E03))),
                                                  const Text(
                                                    "*",
                                                    style: TextStyle(color: Colors.red),
                                                  ),
                                                  SizedBox(
                                                    width: w * 0.03,
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.0015,
                                                    width: w * 0.45,
                                                    child: ColoredBox(
                                                      color: primaryColor,
                                                    ),
                                                  )
                                                ]),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2cnortheast1price,
                                                    decoration: InputDecoration(
                                                      hintText: "Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w * 0.04,
                                                ),
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2cnortheast1discountprice,
                                                    decoration: InputDecoration(
                                                      hintText: "Discount Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: h * 0.03,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("B2C Tamilnadu price ",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: w * 0.03),
                                                          color:
                                                          const Color(0xff298E03))),
                                                  const Text(
                                                    "*",
                                                    style: TextStyle(color: Colors.red),
                                                  ),
                                                  SizedBox(
                                                    width: w * 0.02,
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.0015,
                                                    width: w * 0.45,
                                                    child: ColoredBox(
                                                      color: primaryColor,
                                                    ),
                                                  )
                                                ]),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2ctamilnaduprice,
                                                    decoration: InputDecoration(
                                                      hintText: "Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w * 0.04,
                                                ),
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2ctamilnadudiscountprice,
                                                    decoration: InputDecoration(
                                                      hintText: "Discount Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),

                                          ],
                                        ):SizedBox(),
                                        SizedBox(),

                                        B2b?Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("B2B Global price ",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: w * 0.03),
                                                          color:
                                                          const Color(0xff298E03))),
                                                  const Text(
                                                    "*",
                                                    style: TextStyle(color: Colors.red),
                                                  ),
                                                  SizedBox(
                                                    width: w * 0.02,
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.0015,
                                                    width: w * 0.55,
                                                    child: ColoredBox(
                                                      color: primaryColor,
                                                    ),
                                                  )
                                                ]),

                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2bprice,
                                                    decoration: InputDecoration(
                                                      hintText: "Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w * 0.04,
                                                ),
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2bdiscountprice,
                                                    decoration: InputDecoration(
                                                      hintText: "Discount Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: h * 0.03,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("B2B Delhi price ",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: w * 0.03),
                                                          color:
                                                          const Color(0xff298E03))),
                                                  const Text(
                                                    "*",
                                                    style: TextStyle(color: Colors.red),
                                                  ),
                                                  SizedBox(
                                                    width: w * 0.02,
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.0015,
                                                    width: w * 0.55,
                                                    child: ColoredBox(
                                                      color: primaryColor,
                                                    ),
                                                  )
                                                ]),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2bdelhiprice,
                                                    decoration: InputDecoration(
                                                      hintText: "Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w * 0.04,
                                                ),
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2bdelhidiscountprice,
                                                    decoration: InputDecoration(
                                                      hintText: "Discount Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: h * 0.03,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("B2B Kerala price ",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: w * 0.03),
                                                          color:
                                                          const Color(0xff298E03))),
                                                  const Text(
                                                    "*",
                                                    style: TextStyle(color: Colors.red),
                                                  ),
                                                  SizedBox(
                                                    width: w * 0.02,
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.0015,
                                                    width: w * 0.55,
                                                    child: ColoredBox(
                                                      color: primaryColor,
                                                    ),
                                                  )
                                                ]),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2bkeralaprice,
                                                    decoration: InputDecoration(
                                                      hintText: "Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w * 0.04,
                                                ),
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2bkeraladiscountprice,
                                                    decoration: InputDecoration(
                                                      hintText: "Discount Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: h * 0.03,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("B2B North East 1 price ",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: w * 0.03),
                                                          color:
                                                          const Color(0xff298E03))),
                                                  const Text(
                                                    "*",
                                                    style: TextStyle(color: Colors.red),
                                                  ),
                                                  SizedBox(
                                                    width: w * 0.03,
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.0015,
                                                    width: w * 0.45,
                                                    child: ColoredBox(
                                                      color: primaryColor,
                                                    ),
                                                  )
                                                ]),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2bnortheast1price,
                                                    decoration: InputDecoration(
                                                      hintText: "Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w * 0.04,
                                                ),
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2bnortheast1discountprice,
                                                    decoration: InputDecoration(
                                                      hintText: "Discount Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: h * 0.03,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("B2B Tamilnadu price ",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: w * 0.03),
                                                          color:
                                                          const Color(0xff298E03))),
                                                  const Text(
                                                    "*",
                                                    style: TextStyle(color: Colors.red),
                                                  ),
                                                  SizedBox(
                                                    width: w * 0.02,
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.0015,
                                                    width: w * 0.45,
                                                    child: ColoredBox(
                                                      color: primaryColor,
                                                    ),
                                                  )
                                                ]),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2btamilnaduprice,
                                                    decoration: InputDecoration(
                                                      hintText: "Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w * 0.04,
                                                ),
                                                Container(
                                                  width: w * 0.40,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: B2btamilnadudiscountprice,
                                                    decoration: InputDecoration(
                                                      hintText: "Discount Price",
                                                      hintStyle: TextStyle(
                                                          color: const Color(0xffB3B3B3),
                                                          fontSize: h * 0.015),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),

                                          ],
                                        ):SizedBox(),

                                        SizedBox(height: h*0.02,),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: h * 0.11,
                                              width: w * 0.400,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Stock",
                                                        style: GoogleFonts.roboto(
                                                            textStyle: TextStyle(
                                                                fontSize: w * 0.03),
                                                            color: primaryColor),
                                                      ),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ],
                                                  ),
                                                  TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: stock,
                                                    decoration: InputDecoration(
                                                      hintText: " Stock Quantity",
                                                      hintStyle: TextStyle(
                                                          color:
                                                          const Color(0xffB3B3B3),
                                                          fontSize: h * 0.013),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Container(
                                              height: h * 0.11,
                                              width: w * 0.400,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Sold",
                                                        style: GoogleFonts.roboto(
                                                            textStyle: TextStyle(
                                                                fontSize: w * 0.03),
                                                            color: primaryColor),
                                                      ),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ],
                                                  ),
                                                  TextFormField(
                                                    keyboardType: TextInputType.number,

                                                    controller: sold,
                                                    decoration: InputDecoration(
                                                      hintText: "sold of the product",
                                                      hintStyle: TextStyle(
                                                          color:
                                                          const Color(0xffB3B3B3),
                                                          fontSize: h * 0.013),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                        SizedBox(height: h*0.02,),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: h * 0.11,
                                              width: w * 0.250,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "HSN Code",
                                                        style: GoogleFonts.roboto(
                                                            textStyle: TextStyle(
                                                                fontSize: w * 0.03),
                                                            color: primaryColor),
                                                      ),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ],
                                                  ),
                                                  TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: hsncode,
                                                    decoration: InputDecoration(
                                                      hintText: " Hsn Code ",
                                                      hintStyle: TextStyle(
                                                          color:
                                                          const Color(0xffB3B3B3),
                                                          fontSize: h * 0.013),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Container(
                                              height: h * 0.11,
                                              width: w * 0.250,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Weight",
                                                        style: GoogleFonts.roboto(
                                                            textStyle: TextStyle(
                                                                fontSize: w * 0.03),
                                                            color: primaryColor),
                                                      ),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ],
                                                  ),
                                                  TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: weight,
                                                    decoration: InputDecoration(
                                                      hintText: "Weight of the product",
                                                      hintStyle: TextStyle(
                                                          color:
                                                          const Color(0xffB3B3B3),
                                                          fontSize: h * 0.013),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: h * 0.11,
                                              width: w * 0.250,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "GST",
                                                        style: GoogleFonts.roboto(
                                                            textStyle: TextStyle(
                                                                fontSize: w * 0.03),
                                                            color: primaryColor),
                                                      ),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ],
                                                  ),
                                                  TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: gst,
                                                    decoration: InputDecoration(
                                                      hintText: " Stock Quantity",
                                                      hintStyle: TextStyle(
                                                          color:
                                                          const Color(0xffB3B3B3),
                                                          fontSize: h * 0.013),
                                                      enabledBorder:
                                                      const UnderlineInputBorder(
                                                        //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        B2c? Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('B2C Tier Price',
                                                  style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor,)

                                                  ) ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                              child: ListView.builder(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection: Axis.vertical,
                                                  shrinkWrap: true,
                                                  itemCount: b2cTierPrice.length+1,
                                                  itemBuilder: (context,index){
                                                    // TextEditingController admin$index=TextEditingController();
                                                    // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                    String name=index==(b2cTierPrice.length)?"":b2cTierPrice[index]['name'];
                                                    String price=index==(b2cTierPrice.length)?"":b2cTierPrice[index]['price'];
                                                    return    Padding(
                                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                      child: Container(
                                                        width: 350,
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(10),
                                                          border: Border.all(
                                                            color: primaryColor,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(name),
                                                              Text(price),

                                                              IconButton(
                                                                  onPressed: () async {

                                                                    if(index==(b2cTierPrice.length)){
                                                                      Map<String,dynamic> selected=  await
                                                                      showDialog(
                                                                          context: context,
                                                                          builder: (context) {
                                                                            return
                                                                              AlertDialog(
                                                                                title:  Text("Please Enter B2C Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                actions: <Widget>[


                                                                                  TextFormField(
                                                                                    keyboardType: TextInputType.number,
                                                                                    controller: B2cTierPriceVolum,
                                                                                    decoration: InputDecoration(
                                                                                      hintText: " name",
                                                                                      hintStyle: TextStyle(
                                                                                          color:
                                                                                          const Color(0xffB3B3B3),
                                                                                          fontSize: h * 0.013),
                                                                                      enabledBorder:
                                                                                      const UnderlineInputBorder(
                                                                                        //<-- SEE HERE
                                                                                        borderSide: BorderSide(
                                                                                            width: 1,
                                                                                            color: Colors.black54),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  TextFormField(
                                                                                    keyboardType: TextInputType.number,

                                                                                    controller: B2cTierPriceAmount,
                                                                                    decoration: InputDecoration(

                                                                                      hintText: " Enter Amount",
                                                                                      hintStyle: TextStyle(
                                                                                          color:
                                                                                          const Color(0xffB3B3B3),
                                                                                          fontSize: h * 0.013),
                                                                                      enabledBorder:
                                                                                      const UnderlineInputBorder(
                                                                                        //<-- SEE HERE
                                                                                        borderSide: BorderSide(
                                                                                            width: 1,
                                                                                            color: Colors.black54),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  TextButton(
                                                                                    onPressed: () {
                                                                                      if(B2cTierPriceVolum.text!=""&&B2cTierPriceAmount.text!=""){
                                                                                        b2cTierPrice.add({
                                                                                          "name": B2cTierPriceVolum.text,
                                                                                          "price":B2cTierPriceAmount.text
                                                                                        });
                                                                                        Navigator.of(context).pop();
                                                                                        B2cTierPriceVolum.clear();
                                                                                        B2cTierPriceAmount.clear();
                                                                                        setState(() {

                                                                                        });
                                                                                      }
                                                                                      else{
                                                                                        B2cTierPriceVolum.text==''?showUploadMessage(context, 'Enter volume'):
                                                                                        showUploadMessage(context, 'Enter amount');
                                                                                      }
                                                                                      },
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                      padding: const EdgeInsets.all(14),
                                                                                      child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              );

                                                                          });
                                                                      if(selected!=null) {
                                                                        b2cTierPrice.add(selected);
                                                                      }
                                                                      setState(() {
                                                                        // addon.add({
                                                                        // 'addOn':admins1[index]['addOn'],
                                                                        //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                        //   'imageUrl':admins1[index]['imageUrl']
                                                                        // });
                                                                        // print(addon.length);

                                                                      });
                                                                    }else
                                                                    {

                                                                      b2cTierPrice.removeAt(index);
                                                                      setState(() {

                                                                      });

                                                                    }

                                                                  }, icon: index==(b2cTierPrice.length)?Icon(Icons.add):
                                                              Icon(Icons.delete))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            SizedBox(height: h*0.02,),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('B2C Delhi Tier Price',
                                                style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor),),

                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                              child: Container(

                                                child: ListView.builder(
                                                    physics: NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection: Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: b2cDelhiTierPrice.length+1,
                                                    itemBuilder: (context,index){
                                                      // TextEditingController admin$index=TextEditingController();
                                                      // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                      String name=index==(b2cDelhiTierPrice.length)?"":b2cDelhiTierPrice[index]['name'];
                                                      String price=index==(b2cDelhiTierPrice.length)?"":b2cDelhiTierPrice[index]['price'];
                                                      return    Padding(
                                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                        child: Container(
                                                          width: 350,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10),
                                                            border: Border.all(
                                                              color: primaryColor,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(name),
                                                                Text(price),

                                                                IconButton(
                                                                    onPressed: () async {

                                                                      if(index==(b2cDelhiTierPrice.length)){
                                                                        Map selected=  await    showDialog(
                                                                            context: context,
                                                                            builder: (context) {
                                                                              return
                                                                                AlertDialog(
                                                                                  title:  Text("Please Enter B2C Delhi Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                  actions: <Widget>[


                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,
                                                                                      controller: B2cDelhiTierPriceVolum,
                                                                                      decoration: InputDecoration(
                                                                                        hintText: " Volume",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,

                                                                                      controller: B2cDelhiTierPriceAmount,
                                                                                      decoration: InputDecoration(

                                                                                        hintText: " Enter Amount",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        if(B2cDelhiTierPriceVolum.text!=""&&B2cDelhiTierPriceAmount.text!=""){
                                                                                          b2cDelhiTierPrice.add({
                                                                                            "name": B2cDelhiTierPriceVolum.text,
                                                                                            "price":B2cDelhiTierPriceAmount.text
                                                                                          });
                                                                                          Navigator.of(context).pop();
                                                                                          B2cDelhiTierPriceVolum.clear();
                                                                                          B2cDelhiTierPriceAmount.clear();
                                                                                          setState(() {

                                                                                          });
                                                                                        }
                                                                                        else{
                                                                                          B2cDelhiTierPriceVolum.text==''?showUploadMessage(context, 'Enter volume'):
                                                                                          showUploadMessage(context, 'Enter amount');
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                        padding: const EdgeInsets.all(14),
                                                                                        child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );

                                                                            });
                                                                        if(selected!=null) {
                                                                          b2cDelhiTierPrice.add(selected);
                                                                        }
                                                                        setState(() {
                                                                          // addon.add({
                                                                          // 'addOn':admins1[index]['addOn'],
                                                                          //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                          //   'imageUrl':admins1[index]['imageUrl']
                                                                          // });
                                                                          // print(addon.length);

                                                                        });
                                                                      }else
                                                                      {

                                                                        b2cDelhiTierPrice.removeAt(index);
                                                                        setState(() {

                                                                        });

                                                                      }

                                                                    }, icon: index==(b2cDelhiTierPrice.length)?Icon(Icons.add):
                                                                Icon(Icons.delete))
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                            SizedBox(height: h*0.02,),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('B2C Kerala Tier Price',
                                                  style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor,)

                                                  ) ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                              child: Container(

                                                child: ListView.builder(
                                                    physics: NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection: Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: b2cKeralaTierPrice.length+1,
                                                    itemBuilder: (context,index){
                                                      // TextEditingController admin$index=TextEditingController();
                                                      // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                      String name=index==(b2cKeralaTierPrice.length)?"":b2cKeralaTierPrice[index]['name'];
                                                      String price=index==(b2cKeralaTierPrice.length)?"":b2cKeralaTierPrice[index]['price'];
                                                      return    Padding(
                                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                        child: Container(
                                                          width: 350,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10),
                                                            border: Border.all(
                                                              color: primaryColor,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(name),
                                                                Text(price),

                                                                IconButton(
                                                                    onPressed: () async {

                                                                      if(index==(b2cKeralaTierPrice.length)){
                                                                        Map<String,dynamic> selected=  await    showDialog(
                                                                            context: context,
                                                                            builder: (context) {
                                                                              return
                                                                                AlertDialog(
                                                                                  title:  Text("Please Enter B2C Kerala Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                  actions: <Widget>[


                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,
                                                                                      controller: B2cKeralaTierPriceVolum,
                                                                                      decoration: InputDecoration(
                                                                                        hintText: " Volume",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,

                                                                                      controller: B2cKeralaTierPriceAmount,
                                                                                      decoration: InputDecoration(

                                                                                        hintText: " Enter Amount",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        if(B2cKeralaTierPriceVolum.text!=""&&B2cKeralaTierPriceAmount.text!=""){
                                                                                          b2cKeralaTierPrice.add({
                                                                                            "name": B2cKeralaTierPriceVolum.text,
                                                                                            "price":B2cKeralaTierPriceAmount.text
                                                                                          });
                                                                                          Navigator.of(context).pop();
                                                                                          B2cKeralaTierPriceVolum.clear();
                                                                                          B2cKeralaTierPriceAmount.clear();
                                                                                          setState(() {

                                                                                          });
                                                                                        }
                                                                                        else{
                                                                                          B2cKeralaTierPriceVolum.text==''?showUploadMessage(context, 'Enter volume'):
                                                                                          showUploadMessage(context, 'Enter amount');
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                        padding: const EdgeInsets.all(14),
                                                                                        child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );

                                                                            });
                                                                        if(selected!=null) {
                                                                          b2cKeralaTierPrice.add(selected);
                                                                        }
                                                                        setState(() {
                                                                          // addon.add({
                                                                          // 'addOn':admins1[index]['addOn'],
                                                                          //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                          //   'imageUrl':admins1[index]['imageUrl']
                                                                          // });
                                                                          // print(addon.length);

                                                                        });
                                                                      }else
                                                                      {

                                                                        b2cKeralaTierPrice.removeAt(index);
                                                                        setState(() {

                                                                        });

                                                                      }

                                                                    }, icon: index==(b2cKeralaTierPrice.length)?Icon(Icons.add):
                                                                Icon(Icons.delete))
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                            SizedBox(height: h*0.02,),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('B2C North East 1 Tier Price',
                                                  style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor,)

                                                  ) ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                              child: Container(

                                                child: ListView.builder(
                                                    physics: NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection: Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: b2cNorthEast1TierPrice.length+1,
                                                    itemBuilder: (context,index){
                                                      // TextEditingController admin$index=TextEditingController();
                                                      // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                      String name=index==(b2cNorthEast1TierPrice.length)?"":b2cNorthEast1TierPrice[index]['name'];
                                                      String price=index==(b2cNorthEast1TierPrice.length)?"":b2cNorthEast1TierPrice[index]['price'];
                                                      return    Padding(
                                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                        child: Container(
                                                          width: 350,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10),
                                                            border: Border.all(
                                                              color: primaryColor,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(name),
                                                                Text(price),

                                                                IconButton(
                                                                    onPressed: () async {

                                                                      if(index==(b2cNorthEast1TierPrice.length)){
                                                                        Map<String,dynamic> selected=  await    showDialog(
                                                                            context: context,
                                                                            builder: (context) {
                                                                              return
                                                                                AlertDialog(
                                                                                  title:  Text("Please Enter B2C North East 1 Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                  actions: <Widget>[


                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,
                                                                                      controller: B2cNorthEast1TierPriceVolum,
                                                                                      decoration: InputDecoration(
                                                                                        hintText: " Volume",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,

                                                                                      controller: B2cNorthEast1TierPriceAmount,
                                                                                      decoration: InputDecoration(

                                                                                        hintText: " Enter Amount",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        if(B2cNorthEast1TierPriceVolum.text!=""&&B2cNorthEast1TierPriceAmount.text!=""){
                                                                                          b2cNorthEast1TierPrice.add({
                                                                                            "name": B2cNorthEast1TierPriceVolum.text,
                                                                                            "price":B2cNorthEast1TierPriceAmount.text
                                                                                          });
                                                                                          Navigator.of(context).pop();
                                                                                          B2cNorthEast1TierPriceVolum.clear();
                                                                                          B2cNorthEast1TierPriceAmount.clear();
                                                                                          setState(() {

                                                                                          });
                                                                                        }
                                                                                        else{
                                                                                          B2cNorthEast1TierPriceVolum.text==''?showUploadMessage(context, 'Enter volume'):
                                                                                          showUploadMessage(context, 'Enter amount');
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                        padding: const EdgeInsets.all(14),
                                                                                        child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );

                                                                            });
                                                                        if(selected!=null) {
                                                                          b2cNorthEast1TierPrice.add(selected);
                                                                        }
                                                                        setState(() {
                                                                          // addon.add({
                                                                          // 'addOn':admins1[index]['addOn'],
                                                                          //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                          //   'imageUrl':admins1[index]['imageUrl']
                                                                          // });
                                                                          // print(addon.length);

                                                                        });
                                                                      }else
                                                                      {

                                                                        b2cNorthEast1TierPrice.removeAt(index);
                                                                        setState(() {

                                                                        });

                                                                      }

                                                                    }, icon: index==(b2cNorthEast1TierPrice.length)?Icon(Icons.add):
                                                                Icon(Icons.delete))
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                            SizedBox(height: h*0.02,),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('B2C Tamilnadu Tier Price',
                                                  style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor,)

                                                  ) ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                              child: Container(

                                                child: ListView.builder(
                                                    physics: NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection: Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: b2cTamilnaduTierPrice.length+1,
                                                    itemBuilder: (context,index){
                                                      // TextEditingController admin$index=TextEditingController();
                                                      // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                      String name=index==(b2cTamilnaduTierPrice.length)?"":b2cTamilnaduTierPrice[index]['name'];
                                                      String price=index==(b2cTamilnaduTierPrice.length)?"":b2cTamilnaduTierPrice[index]['price'];
                                                      return    Padding(
                                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                        child: Container(
                                                          width: 350,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10),
                                                            border: Border.all(
                                                              color: primaryColor,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(name),
                                                                Text(price),

                                                                IconButton(
                                                                    onPressed: () async {

                                                                      if(index==(b2cTamilnaduTierPrice.length)){
                                                                        Map selected=  await    showDialog(
                                                                            context: context,
                                                                            builder: (context) {
                                                                              return
                                                                                AlertDialog(
                                                                                  title:  Text("Please Enter B2C Tamilnadu Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                  actions: <Widget>[


                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,
                                                                                      controller: B2cTamilnaduTierPriceVolum,
                                                                                      decoration: InputDecoration(
                                                                                        hintText: " Volume",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,

                                                                                      controller: B2cTamilnaduTierPriceAmount,
                                                                                      decoration: InputDecoration(

                                                                                        hintText: " Enter Amount",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        if(B2cTamilnaduTierPriceVolum.text!=""&&B2cTamilnaduTierPriceAmount.text!=""){
                                                                                          b2cTamilnaduTierPrice.add({
                                                                                            "name": B2cTamilnaduTierPriceVolum.text,
                                                                                            "price":B2cTamilnaduTierPriceAmount.text
                                                                                          });
                                                                                          Navigator.of(context).pop();
                                                                                          B2cTamilnaduTierPriceVolum.clear();
                                                                                          B2cTamilnaduTierPriceAmount.clear();
                                                                                          setState(() {

                                                                                          });
                                                                                        }
                                                                                        else{
                                                                                          B2cTamilnaduTierPriceVolum.text==''?showUploadMessage(context, 'Enter volume'):
                                                                                          showUploadMessage(context, 'Enter amount');
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                        padding: const EdgeInsets.all(14),
                                                                                        child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );

                                                                            });
                                                                        if(selected!=null) {
                                                                          b2cTamilnaduTierPrice.add(selected);
                                                                        }
                                                                        setState(() {
                                                                          // addon.add({
                                                                          // 'addOn':admins1[index]['addOn'],
                                                                          //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                          //   'imageUrl':admins1[index]['imageUrl']
                                                                          // });
                                                                          // print(addon.length);

                                                                        });
                                                                      }else
                                                                      {

                                                                        b2cTamilnaduTierPrice.removeAt(index);
                                                                        setState(() {

                                                                        });

                                                                      }

                                                                    }, icon: index==(b2cTamilnaduTierPrice.length)?Icon(Icons.add):
                                                                Icon(Icons.delete))
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                          ],
                                        ):SizedBox(),
                                        B2b? Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('B2B Tier Price',
                                                  style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor,)

                                                  ) ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                              child: Container(

                                                child: ListView.builder(
                                                    physics: NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection: Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: b2bTierPrice.length+1,
                                                    itemBuilder: (context,index){
                                                      // TextEditingController admin$index=TextEditingController();
                                                      // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                      String name=index==(b2bTierPrice.length)?"":b2bTierPrice[index]['name'];
                                                      String price=index==(b2bTierPrice.length)?"":b2bTierPrice[index]['price'].toString();
                                                      return    Padding(
                                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                        child: Container(
                                                          width: 350,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10),
                                                            border: Border.all(
                                                              color: primaryColor,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(name),
                                                                Text(price.toString()),

                                                                IconButton(
                                                                    onPressed: () async {

                                                                      if(index==(b2bTierPrice.length)){
                                                                        Map<String,dynamic> selected=  await    showDialog(
                                                                            context: context,
                                                                            builder: (context) {
                                                                              return
                                                                                AlertDialog(
                                                                                  title:  Text("Please Enter B2B Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                  actions: <Widget>[


                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,
                                                                                      controller: B2bTierPriceVolum,
                                                                                      decoration: InputDecoration(
                                                                                        hintText: " Volume",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,

                                                                                      controller: B2bTierPriceAmount,
                                                                                      decoration: InputDecoration(

                                                                                        hintText: " Enter Amount",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        if(B2bTierPriceVolum.text!=""&&B2bTierPriceAmount.text!=""){
                                                                                          b2bTierPrice.add({
                                                                                            "name": B2bTierPriceVolum.text,
                                                                                            "price":B2bTierPriceAmount.text
                                                                                          });
                                                                                          Navigator.of(context).pop();
                                                                                          B2bTierPriceVolum.clear();
                                                                                          B2bTierPriceAmount.clear();
                                                                                          setState(() {

                                                                                          });
                                                                                        }
                                                                                        else{
                                                                                          B2bTierPriceVolum.text==''?showUploadMessage(context, 'Enter volume'):
                                                                                          showUploadMessage(context, 'Enter amount');
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                        padding: const EdgeInsets.all(14),
                                                                                        child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );

                                                                            });
                                                                        if(selected!=null) {
                                                                          b2bTierPrice.add(selected);
                                                                        }
                                                                        setState(() {
                                                                          // addon.add({
                                                                          // 'addOn':admins1[index]['addOn'],
                                                                          //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                          //   'imageUrl':admins1[index]['imageUrl']
                                                                          // });
                                                                          // print(addon.length);

                                                                        });
                                                                      }else
                                                                      {

                                                                        b2bTierPrice.removeAt(index);
                                                                        setState(() {

                                                                        });

                                                                      }

                                                                    }, icon: index==(b2bTierPrice.length)?Icon(Icons.add):
                                                                Icon(Icons.delete))
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                            SizedBox(height: h*0.02,),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('B2B Delhi Tier Price',
                                                style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor),),

                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                              child: Container(

                                                child: ListView.builder(
                                                    physics: NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection: Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: b2bDelhiTierPrice.length+1,
                                                    itemBuilder: (context,index){
                                                      // TextEditingController admin$index=TextEditingController();
                                                      // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                      String name=index==(b2bDelhiTierPrice.length)?"":b2bDelhiTierPrice[index]['name'];
                                                      String price=index==(b2bDelhiTierPrice.length)?"":b2bDelhiTierPrice[index]['price'].toString();

                                                      return    Padding(
                                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                        child: Container(
                                                          width: 350,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10),
                                                            border: Border.all(
                                                              color: primaryColor,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(name),
                                                                Text(price),

                                                                IconButton(
                                                                    onPressed: () async {

                                                                      if(index==(b2bDelhiTierPrice.length)){
                                                                        Map<String,dynamic> selected=  await    showDialog(
                                                                            context: context,
                                                                            builder: (context) {
                                                                              return
                                                                                AlertDialog(
                                                                                  title:  Text("Please Enter B2B Delhi Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                  actions: <Widget>[


                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,
                                                                                      controller: B2bDelhiTierPriceVolum,
                                                                                      decoration: InputDecoration(
                                                                                        hintText: " Volume",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,

                                                                                      controller: B2bDelhiTierPriceAmount,
                                                                                      decoration: InputDecoration(

                                                                                        hintText: " Enter Amount",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        if(B2bDelhiTierPriceVolum.text!=""&&B2bDelhiTierPriceAmount.text!=""){
                                                                                          b2bDelhiTierPrice.add({
                                                                                            "name": B2bDelhiTierPriceVolum.text,
                                                                                            "price":B2bDelhiTierPriceAmount.text
                                                                                          });
                                                                                          Navigator.of(context).pop();
                                                                                          B2bDelhiTierPriceVolum.clear();
                                                                                          B2bDelhiTierPriceAmount.clear();
                                                                                          setState(() {

                                                                                          });
                                                                                        }
                                                                                        else{
                                                                                          B2bDelhiTierPriceVolum.text==''?showUploadMessage(context, 'Enter volume'):
                                                                                          showUploadMessage(context, 'Enter amount');
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                        padding: const EdgeInsets.all(14),
                                                                                        child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );

                                                                            });
                                                                        if(selected!=null) {
                                                                          b2bDelhiTierPrice.add(selected);
                                                                        }
                                                                        setState(() {


                                                                        });
                                                                      }else
                                                                      {

                                                                        b2bDelhiTierPrice.removeAt(index);
                                                                        setState(() {

                                                                        });

                                                                      }

                                                                    }, icon: index==(b2bDelhiTierPrice.length)?Icon(Icons.add):
                                                                Icon(Icons.delete))
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                            SizedBox(height: h*0.02,),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('B2B Kerala Tier Price',
                                                  style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor,)

                                                  ) ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                              child: Container(

                                                child: ListView.builder(
                                                    physics: NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection: Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: b2bKeralaTierPrice.length+1,
                                                    itemBuilder: (context,index){
                                                      // TextEditingController admin$index=TextEditingController();
                                                      // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                      String name=index==(b2bKeralaTierPrice.length)?"":b2bKeralaTierPrice[index]['name'];
                                                      String price=index==(b2bKeralaTierPrice.length)?"":b2bKeralaTierPrice[index]['price'].toString();
                                                      return    Padding(
                                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                        child: Container(
                                                          width: 350,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10),
                                                            border: Border.all(
                                                              color: primaryColor,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(name),
                                                                Text(price),

                                                                IconButton(
                                                                    onPressed: () async {

                                                                      if(index==(b2bKeralaTierPrice.length)){
                                                                        Map<String,dynamic> selected=  await    showDialog(
                                                                            context: context,
                                                                            builder: (context) {
                                                                              return
                                                                                AlertDialog(
                                                                                  title:  Text("Please Enter B2B Kerala Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                  actions: <Widget>[


                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,
                                                                                      controller: B2bKeralaTierPriceVolum,
                                                                                      decoration: InputDecoration(
                                                                                        hintText: " Volume",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,

                                                                                      controller: B2bKeralaTierPriceAmount,
                                                                                      decoration: InputDecoration(

                                                                                        hintText: " Enter Amount",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        if(B2bKeralaTierPriceVolum.text!=""&&B2bKeralaTierPriceAmount.text!=""){
                                                                                          b2bKeralaTierPrice.add({
                                                                                            "name": B2bKeralaTierPriceVolum.text,
                                                                                            "price":B2bKeralaTierPriceAmount.text
                                                                                          });
                                                                                          Navigator.of(context).pop();
                                                                                          B2bKeralaTierPriceVolum.clear();
                                                                                          B2bKeralaTierPriceAmount.clear();
                                                                                          setState(() {

                                                                                          });
                                                                                        }
                                                                                        else{
                                                                                          B2bKeralaTierPriceVolum.text==''?showUploadMessage(context, 'Enter volume'):
                                                                                          showUploadMessage(context, 'Enter amount');
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                        padding: const EdgeInsets.all(14),
                                                                                        child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );

                                                                            });
                                                                        if(selected!=null) {
                                                                          b2bKeralaTierPrice.add(selected);
                                                                        }
                                                                        setState(() {
                                                                          // addon.add({
                                                                          // 'addOn':admins1[index]['addOn'],
                                                                          //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                          //   'imageUrl':admins1[index]['imageUrl']
                                                                          // });
                                                                          // print(addon.length);

                                                                        });
                                                                      }else
                                                                      {

                                                                        b2bKeralaTierPrice.removeAt(index);
                                                                        setState(() {

                                                                        });

                                                                      }

                                                                    }, icon: index==(b2bKeralaTierPrice.length)?Icon(Icons.add):
                                                                Icon(Icons.delete))
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                            SizedBox(height: h*0.02,),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('B2B North East 1 Tier Price',
                                                  style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor,)

                                                  ) ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                              child: Container(

                                                child: ListView.builder(
                                                    physics: NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection: Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: b2bNorthEast1TierPrice.length+1,
                                                    itemBuilder: (context,index){
                                                      // TextEditingController admin$index=TextEditingController();
                                                      // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                      String name=index==(b2bNorthEast1TierPrice.length)?"":b2bNorthEast1TierPrice[index]['name'];
                                                      String price=index==(b2bNorthEast1TierPrice.length)?"":b2bNorthEast1TierPrice[index]['price'];
                                                      return    Padding(
                                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                        child: Container(
                                                          width: 350,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10),
                                                            border: Border.all(
                                                              color: primaryColor,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(name),
                                                                Text(price),

                                                                IconButton(
                                                                    onPressed: () async {

                                                                      if(index==(b2bNorthEast1TierPrice.length)){
                                                                        Map<String,dynamic> selected=  await    showDialog(
                                                                            context: context,
                                                                            builder: (context) {
                                                                              return
                                                                                AlertDialog(
                                                                                  title:  Text("Please Enter B2B North East 1 Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                  actions: <Widget>[


                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,
                                                                                      controller: B2bNorthEast1TierPriceVolum,
                                                                                      decoration: InputDecoration(
                                                                                        hintText: " Volume",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,

                                                                                      controller: B2bNorthEast1TierPriceAmount,
                                                                                      decoration: InputDecoration(

                                                                                        hintText: " Enter Amount",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        if(B2bNorthEast1TierPriceVolum.text!=""&&B2bNorthEast1TierPriceAmount.text!=""){
                                                                                          b2bNorthEast1TierPrice.add({
                                                                                            "name": B2bNorthEast1TierPriceVolum.text,
                                                                                            "price":B2bNorthEast1TierPriceAmount.text
                                                                                          });
                                                                                          Navigator.of(context).pop();
                                                                                          B2bNorthEast1TierPriceVolum.clear();
                                                                                          B2bNorthEast1TierPriceAmount.clear();

                                                                                          setState(() {

                                                                                          });
                                                                                        }
                                                                                        else{
                                                                                          B2bNorthEast1TierPriceVolum.text==''?showUploadMessage(context, 'Enter volume'):
                                                                                          showUploadMessage(context, 'Enter amount');
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                        padding: const EdgeInsets.all(14),
                                                                                        child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );

                                                                            });
                                                                        if(selected!=null) {
                                                                          b2bNorthEast1TierPrice.add(selected);
                                                                        }
                                                                        setState(() {

                                                                        });
                                                                      }else
                                                                      {
                                                                        print(b2bNorthEast1TierPrice);

                                                                        b2bNorthEast1TierPrice.removeAt(index);
                                                                        setState(() {

                                                                        });

                                                                      }

                                                                    }, icon: index==(b2bNorthEast1TierPrice.length)?Icon(Icons.add):
                                                                Icon(Icons.delete))
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                            SizedBox(height: h*0.02,),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('B2B Tamilnadu Tier Price',
                                                  style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor,)

                                                  ) ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                              child: Container(

                                                child: ListView.builder(
                                                    physics: NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection: Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: b2bTamilnaduTierPrice.length+1,
                                                    itemBuilder: (context,index){
                                                      // TextEditingController admin$index=TextEditingController();
                                                      // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];


                                                      String name=index==(b2bTamilnaduTierPrice.length)?"":b2bTamilnaduTierPrice[index]['name'];
                                                      String price=index==(b2bTamilnaduTierPrice.length)?"":b2bTamilnaduTierPrice[index]['price'];
                                                      return    Padding(
                                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                        child: Container(
                                                          width: 350,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10),
                                                            border: Border.all(
                                                              color: primaryColor,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(name),
                                                                Text(price),

                                                                IconButton(
                                                                    onPressed: () async {

                                                                      if(index==(b2bTamilnaduTierPrice.length)){
                                                                        Map<String,dynamic> selected=  await    showDialog(
                                                                            context: context,
                                                                            builder: (context) {
                                                                              return
                                                                                AlertDialog(
                                                                                  title:  Text("Please Enter B2B Tamilnadu Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                  actions: <Widget>[


                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,
                                                                                      controller: B2bTamilnaduTierPriceVolum,
                                                                                      decoration: InputDecoration(
                                                                                        hintText: " Volume",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextFormField(
                                                                                      keyboardType: TextInputType.number,

                                                                                      controller: B2bTamilnaduTierPriceAmount,
                                                                                      decoration: InputDecoration(

                                                                                        hintText: " Enter Amount",
                                                                                        hintStyle: TextStyle(
                                                                                            color:
                                                                                            const Color(0xffB3B3B3),
                                                                                            fontSize: h * 0.013),
                                                                                        enabledBorder:
                                                                                        const UnderlineInputBorder(
                                                                                          //<-- SEE HERE
                                                                                          borderSide: BorderSide(
                                                                                              width: 1,
                                                                                              color: Colors.black54),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        if(B2bTamilnaduTierPriceVolum.text!=""&&B2bTamilnaduTierPriceAmount.text!=""){
                                                                                          b2bTamilnaduTierPrice.add({
                                                                                            "name": B2bTamilnaduTierPriceVolum.text,
                                                                                            "price":B2bTamilnaduTierPriceAmount.text
                                                                                          });
                                                                                          Navigator.of(context).pop();
                                                                                          B2bTamilnaduTierPriceVolum.clear();
                                                                                          B2bTamilnaduTierPriceAmount.clear();
                                                                                          setState(() {

                                                                                          });
                                                                                        }
                                                                                        else{
                                                                                          B2bTamilnaduTierPriceVolum.text==''?showUploadMessage(context, 'Enter volume'):
                                                                                          showUploadMessage(context, 'Enter amount');
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                        padding: const EdgeInsets.all(14),
                                                                                        child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );

                                                                            });
                                                                        if(selected!=null) {
                                                                          b2bTamilnaduTierPrice.add(selected);
                                                                        }
                                                                        setState(() {
                                                                          // addon.add({
                                                                          // 'addOn':admins1[index]['addOn'],
                                                                          //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                          //   'imageUrl':admins1[index]['imageUrl']
                                                                          // });
                                                                          // print(addon.length);

                                                                        });
                                                                      }else
                                                                      {

                                                                        b2bTamilnaduTierPrice.removeAt(index);
                                                                        setState(() {

                                                                        });

                                                                      }

                                                                    }, icon: index==(b2bTamilnaduTierPrice.length)?Icon(Icons.add):
                                                                Icon(Icons.delete))
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                          ],
                                        ):SizedBox(),

                                        SizedBox(
                                          height: h * 0.04,
                                        ),

                                        Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,

                                          children: [
                                            Text(
                                              'Related Products',
                                              style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                      color:primaryColor,
                                                      fontSize: h*0.015,fontWeight: FontWeight.bold
                                                  )),
                                            ),
                                            SizedBox(height:10),
                                            InkWell(onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RelatedProduct(set:set)));
                                            },
                                              child: Container(
                                                height: h * 0.06,
                                                width: w,
                                                decoration: BoxDecoration(
                                                    border:
                                                    Border.all(color: primaryColor),
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(5)),

                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Select Related Products ",
                                                            style:
                                                            TextStyle(color: Color(0xffB3B3B3)),
                                                          ),
                                                          Icon(Icons.menu,color: Color(0xffB3B3B3),)
                                                        ],
                                                      ),

                                                    ),


                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        selectedProduct.isNotEmpty?
                                        SizedBox(
                                          height: h*0.15,
                                          width: w,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: ListView.builder(
                                                  physics: ScrollPhysics(),
                                                  itemCount: selectedProduct.length,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: Container(
                                                          width: w,
                                                          height: h*0.06,

                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                                            border:
                                                            Border.all(color: primaryColor),),
                                                          child:
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [

                                                                Container(
                                                                  width: w * 0.70,
                                                                  child: Text(
                                                                    (nameToId[selectedProduct[index]].toString()),
                                                                    style: GoogleFonts.roboto(
                                                                      textStyle: TextStyle(
                                                                        fontSize: h * 0.012,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),


                                                              ],
                                                            ),
                                                          )


                                                      ),
                                                    );
                                                    },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ):SizedBox(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: w * 0.05, right: w * 0.05),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: h * 0.02,
                                              ),

                                              Row(
                                                children: [
                                              Text(
                                                "*",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: h * 0.020),
                                              ),
                                              Text(
                                                  "You can resubmit the Pending Approval \n Products from the Inventory list. ",
                                                  style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          fontSize:
                                                          w * 0.03),
                                                      color: primaryColor)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: h * 0.01,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "*",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.01,
                                                  ),
                                                  Text(
                                                      "Approval Time : 24 Hours ",
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize: w * 0.03,
                                                            color:
                                                            primaryColor),
                                                      )),
                                                ],
                                              ),

                                              SizedBox(
                                                height: h * 0.01,
                                              ),

                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     InkWell(
                                              //       onTap: () async {
                                              //         if(
                                              //         productname.text != '' &&
                                              //             productcode.text != "" &&
                                              //             stock.text != "" &&
                                              //             hsncode.text != '' &&
                                              //             description.text != ''&&
                                              //             weight.text!=""&&
                                              //             ingredients.text!=""&&
                                              //             nutrition.text!=""&&
                                              //             madefrom.text!=""&&
                                              //             gst.text!=""
                                              //         // B2c?B2cprice.text!=""&&
                                              //         // B2c?B2cdiscountprice.text!=""&&
                                              //         // B2c?B2cdelhiprice.text!=""&&
                                              //         // B2c?B2cdelhidiscountprice.text!=""&&
                                              //         // B2c?B2ckeralaprice.text!=""&&
                                              //         // B2c?B2ckeraladiscountprice.text!=""&&
                                              //         // B2c?B2cnortheast1price.text!=""&&
                                              //         // B2c?B2cnortheast1discountprice.text!=""&&
                                              //         // B2c?B2ctamilnaduprice!=""&&
                                              //         // B2c?B2ctamilnadudiscountprice!=""&&
                                              //         // B2b?B2bprice.text!=""&&
                                              //         // B2b?B2bdiscountprice.text!=""&&
                                              //         // B2b?B2bdelhiprice.text!=""&&
                                              //         // B2b?B2bdelhidiscountprice.text!=""&&
                                              //         // B2b?B2bkeralaprice.text!=""&&
                                              //         // B2b?B2bkeraladiscountprice.text!=""&&
                                              //         // B2b?B2bnortheast1price.text!=""&&
                                              //         // B2b?B2bnortheast1discountprice.text!=""&&
                                              //         // B2b?B2btamilnaduprice!=""&&
                                              //         // B2b?B2btamilnadudiscountprice!=""
                                              //         ){
                                              //           await
                                              //           showDialog(
                                              //               context: context,
                                              //               builder: (ctx) {
                                              //                 return AlertDialog(
                                              //                     title: Text(
                                              //                         'Resubmit Product?'),
                                              //                     content: Text(
                                              //                         'Do you want to Continue?'),
                                              //                     actions: [
                                              //                       TextButton(
                                              //                           child:
                                              //                           Text(
                                              //                             'Cancel',
                                              //                             style: TextStyle(
                                              //                                 color:
                                              //                                 primaryColor),
                                              //                           ),
                                              //                           onPressed:
                                              //                               () {
                                              //                             Navigator.of(context)
                                              //                                 .pop();
                                              //                           }),
                                              //                       TextButton(
                                              //                           child:
                                              //                           Text(
                                              //                             'Ok',
                                              //                             style: TextStyle(
                                              //                                 color:
                                              //                                 primaryColor),
                                              //                           ),
                                              //                           onPressed:
                                              //                               ()  async {
                                              //
                                              //                              editProductModel = Product?.copyWith(
                                              //                               sales: sales,
                                              //                               date: DateTime.now(),
                                              //                               vendorId: currentUser?.id,
                                              //                               available: false,
                                              //                               b2b: B2b,
                                              //                               b2c: B2c,
                                              //                               b2bP:double.tryParse(B2bprice.text),
                                              //                               b2bD:double.tryParse(B2bdiscountprice.text),
                                              //                               b2bDelhiD: double.tryParse(B2bdelhidiscountprice.text),
                                              //                               b2bDelhiP: double.tryParse(B2bdelhiprice.text),
                                              //                               b2bDelhiTier: b2bDelhiTierPrice,
                                              //                               b2bKeralaD: double.tryParse(B2bkeraladiscountprice.text),
                                              //                               b2bKeralaP: double.tryParse(B2bkeralaprice.text),
                                              //                               b2bKeralaTier: b2bKeralaTierPrice,
                                              //                               b2bTamilnaduD: double.tryParse(B2btamilnadudiscountprice.text),
                                              //                               b2bTamilnaduP: double.tryParse(B2btamilnaduprice.text),
                                              //                               b2bTamilnaduTier:b2bTamilnaduTierPrice,
                                              //                               b2bNorthEast1P: double.tryParse(B2bnortheast1discountprice.text),
                                              //                               b2bNorthEast1D: double.tryParse(B2bnortheast1discountprice.text),
                                              //                               b2bNorthEast1Tier: b2bNorthEast1TierPrice,
                                              //                               b2bTier: b2bTierPrice,
                                              //                               weight:double.tryParse(weight.text),
                                              //                               sold: int.tryParse(sold.text),
                                              //                               branchId: 'XaGJz72DaZdJ4S9g7PkO',
                                              //                               fives: 0,
                                              //                               fours: 0,
                                              //                               delete: false,
                                              //                               ones: 0,
                                              //                               open: false,
                                              //                               relatedProducts: widget.productData.relatedProducts,
                                              //                               search:setSearchParam(productname.text.toUpperCase()),
                                              //                               start: 0,
                                              //                               step: 0,
                                              //                               stop: 0,
                                              //                               threes: 0,
                                              //                               totalReviews: 0,
                                              //                               twos:0,
                                              //                                userId: 'GcSyOO9m5cOqp2miVy5WYwbSmqM2',
                                              //                               imported: imported,
                                              //                               payOnDelivery: COD,
                                              //                               nonveg: nonveg,
                                              //                               veg: veg,
                                              //                               sellername: currentUser!.Fullname,
                                              //                               name: productname.text,
                                              //                               productCode: productcode.text,
                                              //                               stock: int.tryParse(stock.text),
                                              //                               hsnCode:int.tryParse(hsncode.text),
                                              //                               description: description.text,
                                              //                                  brand: brandNametoId[productBrand.text],
                                              //                                  category: categoryNametoId[category.text],
                                              //                               categoryName: category.text,
                                              //                               ingredients: ingredients.text,
                                              //                               fact: nutrition.text,
                                              //                               instructions: instruction.text,
                                              //                               madeFrom: madefrom.text,
                                              //                               gst: double.tryParse(gst.text),
                                              //                               b2cP: double.tryParse(B2cprice.text),
                                              //                               b2cD: double.tryParse(B2cdiscountprice.text),
                                              //                               b2cDelhiD: double.tryParse(B2cdelhidiscountprice.text),
                                              //                               b2cDelhiP: double.tryParse(B2cdelhiprice.text),
                                              //                               b2cDelhiTier: b2cDelhiTierPrice,
                                              //                               b2cKeralaP: double.tryParse(B2ckeralaprice.text),
                                              //                               b2cKeralaD: double.tryParse(B2ckeraladiscountprice.text),
                                              //                               b2cKeralaTier: b2cKeralaTierPrice,
                                              //                               b2cTamilnaduD: double.tryParse(B2ctamilnadudiscountprice.text),
                                              //                               b2cTamilnaduP: double.tryParse(B2ctamilnaduprice.text),
                                              //                               b2cTamilnaduTier: b2cTamilnaduTierPrice,
                                              //                               b2cTier: b2cTierPrice,
                                              //                               b2cNorthEast1P: double.tryParse(B2cnortheast1price.text),
                                              //                               b2cNorthEast1D: double.tryParse(B2cnortheast1discountprice.text),
                                              //                               b2cNorthEast1Tier: b2cNorthEast1TierPrice,
                                              //                               status:0,
                                              //                                productId: widget.productData.productId
                                              //                             );
                                              //                             setState(() {
                                              //
                                              //                             });
                                              //                             tabController.animateTo(1);
                                              //                             await  Future.delayed(Duration(milliseconds: 1));
                                              //                             Navigator.pop(context);
                                              //
                                              //                             productname.text = '';
                                              //                             productcode.text = '';
                                              //                             stock.text = '';
                                              //                             hsncode.text ='';
                                              //                             description.text = '';
                                              //                             weight.text ='';
                                              //                             ingredients.text = '';
                                              //                             nutrition.text = '';
                                              //                             instruction.text = '';
                                              //                             sold.text = '';
                                              //                             madefrom.text = '';
                                              //                             // selectedProduct.clear();
                                              //
                                              //                             if(B2b){
                                              //                               B2bprice.text = '';
                                              //                               B2bdiscountprice.text = '';
                                              //                               B2btamilnadudiscountprice.text = '';
                                              //                               B2btamilnaduprice.text = '';
                                              //                               B2bdelhidiscountprice.text = '';
                                              //                               B2bdelhiprice.text = '';
                                              //                               B2bkeralaprice.text = '';
                                              //                               B2bkeraladiscountprice.text = '';
                                              //                               B2bnortheast1discountprice.text = '';
                                              //                               B2bnortheast1price.text = '';
                                              //                               b2bNorthEast1TierPrice=[];
                                              //                               b2bTierPrice=[];
                                              //                               b2bTamilnaduTierPrice=[];
                                              //                               b2bKeralaTierPrice=[];
                                              //                               b2bDelhiTierPrice=[]
                                              //                               ;
                                              //                             }
                                              //                             if(B2c){
                                              //                               B2cprice.text == '';
                                              //                               B2cdiscountprice.text = '';
                                              //                               B2ctamilnadudiscountprice.text = '';
                                              //                               B2ctamilnaduprice.text = '';
                                              //                               B2cdelhidiscountprice.text = '';
                                              //                               B2cdelhiprice.text = '';
                                              //                               B2ckeralaprice.text = '';
                                              //                               B2ckeraladiscountprice.text = '';
                                              //                               B2cnortheast1discountprice.text = '';
                                              //                               B2cnortheast1price.text = '';
                                              //                               b2cNorthEast1TierPrice=[];
                                              //                               b2cTierPrice=[];
                                              //                               b2cTamilnaduTierPrice=[];
                                              //                               b2cKeralaTierPrice=[];
                                              //                               b2cDelhiTierPrice=[];
                                              //
                                              //
                                              //                             }
                                              //                           }),
                                              //                     ]);
                                              //               });
                                              //         }else{
                                              //           print("2");
                                              //           productname.text == ''
                                              //               ? showUploadMessage(context, 'Please enter product Name')
                                              //               : productcode.text == '' ? showUploadMessage(context, 'Please enter productcode')
                                              //               : stock.text == ''
                                              //               ? showUploadMessage(
                                              //               context,
                                              //               'Please enter stock')
                                              //               : hsncode.text == ''
                                              //               ? showUploadMessage(
                                              //               context,
                                              //               'Please enter hsncode')
                                              //               : description.text ==
                                              //               ''
                                              //               ? showUploadMessage(
                                              //               context,
                                              //               'Please enter product description')
                                              //               :weight.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product weight')
                                              //               :ingredients.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product ingredients')
                                              //               :nutrition.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product nutrition fact')
                                              //               :instruction.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product instruction')
                                              //               :madefrom.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product made from')
                                              //               :gst.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product gst')
                                              //               :(B2c==true&&B2cprice.text=="")
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product B2c price')
                                              //               :(B2c==true&&B2cdiscountprice.text=="")
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product B2c discount price')
                                              //               :B2c==true&&B2cdelhiprice.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product B2c delhi price')
                                              //               :B2c==true&&B2cdelhidiscountprice.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product B2c B2c delhi discount price')
                                              //               :B2c==true&&B2ckeralaprice.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product  B2c kerala price')
                                              //               :B2c==true&&B2ckeraladiscountprice.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product  B2c kerala discount price')
                                              //               :B2c==true&&B2cnortheast1price.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product  B2c northeast 1 price')
                                              //               :B2c==true&&B2cnortheast1discountprice.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product B2c northeast 1 discount price')
                                              //               :B2c==true&&B2ctamilnaduprice.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product B2c tamilnadu price')
                                              //               :B2c==true&&B2ctamilnadudiscountprice.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product B2c amilnadu discount price')
                                              //               :B2b==true&&B2bprice.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product B2b price')
                                              //               :B2b==true&&B2bdiscountprice.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product B2b discount price')
                                              //               :B2b==true&&B2bdelhiprice.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product B2b delhi price')
                                              //               :B2b==true&&B2bdelhidiscountprice.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product B2b delhi discount price')
                                              //               :B2b==true&&B2bkeralaprice.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product  B2b kerala price')
                                              //               :B2b==true&&B2bkeraladiscountprice.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product  B2b kerala discount price')
                                              //               :B2b==true&&B2bnortheast1price.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product  B2b northeast 1 price')
                                              //               :B2b==true&&B2bnortheast1discountprice.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product B2b northeast 1 discount price')
                                              //               :B2b==true&&B2btamilnaduprice.text==""
                                              //               ?showUploadMessage(
                                              //               context,
                                              //               'Please enter product B2b tamilnadu price')
                                              //               :B2b==true&&B2btamilnadudiscountprice.text=="" ?showUploadMessage(context,
                                              //               'Please enter product B2b tamilnadu discount price'):'';
                                              //         }
                                              //
                                              //
                                              //
                                              //
                                              //         setState(() {});
                                              //       },
                                              //       child: Container(
                                              //         height: h * 0.06,
                                              //         width: w*0.40,
                                              //         decoration: BoxDecoration(
                                              //             color: primaryColor,
                                              //             borderRadius:
                                              //             BorderRadius.circular(
                                              //                 w * 0.02)),
                                              //         child: const Center(
                                              //             child: Text(
                                              //               "RESUBMIT",
                                              //               style: TextStyle(
                                              //                   color: Colors.white),
                                              //             )),
                                              //       ),
                                              //     ),
                                              //     InkWell(onTap: () async {
                                              //       await showDialog(context: context,
                                              //       builder: (context) {
                                              //         return AlertDialog(
                                              //             title: Text(
                                              //                 'Product Delete?'),
                                              //             content: Text(
                                              //                 'Do you want to Continue?'),
                                              //             actions: [
                                              //               TextButton(
                                              //                   child: Text(
                                              //                     'Cancel',style: TextStyle(color: Colors.black),),
                                              //                   onPressed: () {
                                              //                     Navigator.of(
                                              //                         context)
                                              //                         .pop();
                                              //                   }),
                                              //               TextButton(
                                              //                   child: Text('Ok',style: TextStyle(color: Colors.black),),
                                              //                   onPressed: () {
                                              //                     FirebaseFirestore.instance.collection("products").doc(widget.productData.productId).update(
                                              //                         {
                                              //                           "delete":true
                                              //                         }
                                              //                     );
                                              //                     Navigator.pop(context);
                                              //                   })]);}
                                              //       );
                                              //     },
                                              //       child: Container(
                                              //         height: h * 0.06,
                                              //         width: w*0.40,
                                              //         decoration: BoxDecoration(
                                              //             color: Colors.red,
                                              //             borderRadius:
                                              //             BorderRadius.circular(
                                              //                 w * 0.02)),
                                              //         child: const Center(
                                              //             child: Text(
                                              //               "CANCEL",
                                              //               style: TextStyle(
                                              //                   color: Colors.white),
                                              //             )),
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                            widget.productData.status ==0
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
                                                        FirebaseFirestore.instance.collection(
                                                          'products'
                                                        ).doc(widget.productData.productId).update({
                                                          'status': 1,
                                                          'acceptedDate': DateTime.now()
                                                        }
                                                        );

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
                                                        FirebaseFirestore.instance.collection(
                                                            'products'
                                                        ).doc(widget.productData.productId).update({
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
                                                  : widget.productData.status == 1
                                                  ? Center(
                                                child: CustomButton(text: 'Reject', onPressed: () async {
                                                  bool pressed =
                                                  await alert(
                                                      context,
                                                      'Do you want reject this category.');
                                                  if (pressed) {
                                                    FirebaseFirestore.instance.collection(
                                                        'products'
                                                    ).doc(widget.productData.productId).update({
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
                                                    FirebaseFirestore.instance.collection(
                                                        'products'
                                                    ).doc(widget.productData.productId).update({
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
                                          ),
                                        ),
                                        SizedBox(
                                          height: h * 0.04,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: SingleChildScrollView(
                               child: Column(
                                 children: [
                                   Row(
                                     children: [
                                       SizedBox(
                                         width: w * 0.1,
                                       ),
                                       Column(
                                         children: [
                                           InkWell(
                                             onTap: () {
                                               getDoc();
                                             },
                                             child: Container(
                                               height: h * 0.09,
                                               width: w * 0.250,
                                               decoration: BoxDecoration(
                                                   color: primaryColor,
                                                   borderRadius: BorderRadius.circular(5)),
                                               child: Center(
                                                   child: SvgPicture.asset(
                                                     "assets/uplodimage.svg",
                                                     height: h * 0.07,
                                                   )),
                                             ),
                                           ),
                                           SizedBox(
                                             height: h * 0.02,
                                           ),
                                           Text(
                                             "Upload Image",
                                             style: GoogleFonts.roboto(
                                                 textStyle: TextStyle(
                                                     color: primaryColor1,
                                                     fontSize: h * 0.015,
                                                     fontWeight: FontWeight.bold)),
                                           )
                                         ],
                                       ),
                                       SizedBox(
                                         width: w * 0.2,
                                       ),
                                       Column(
                                         children: [
                                           InkWell(
                                             onTap: () {
                                               _pickvideo();
                                             },
                                             child: Container(
                                               height: h * 0.09,
                                               width: w * 0.250,
                                               decoration: BoxDecoration(
                                                   color: primaryColor,
                                                   borderRadius: BorderRadius.circular(5)),
                                               child: Center(
                                                   child: SvgPicture.asset(
                                                     "assets/uplodvideo.svg",
                                                     height: h * 0.05,
                                                   )),
                                             ),
                                           ),
                                           SizedBox(
                                             height: h * 0.02,
                                           ),
                                           Text(
                                             "Upload Video",
                                             style: GoogleFonts.roboto(
                                                 textStyle: TextStyle(
                                                     color: primaryColor1,
                                                     fontSize: h * 0.015,
                                                     fontWeight: FontWeight.bold)),
                                           ),
                                         ],
                                       )
                                     ],
                                   ),
                                   SizedBox(
                                     height: h * 0.02,
                                   ),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Images",
                                         style: GoogleFonts.roboto(
                                             textStyle: TextStyle(
                                                 color: primaryColor1,
                                                 fontSize: h * 0.015,
                                                 fontWeight: FontWeight.bold)),
                                       ),
                                       SizedBox(
                                         width: w * 0.200,
                                       ),
                                       Row(
                                         children: [
                                           SvgPicture.asset("assets/selsecfrommedia.svg"),
                                           SizedBox(
                                             width: w * 0.015,
                                           ),
                                           Text(
                                             "Select From Media Library",
                                             style: GoogleFonts.roboto(
                                                 textStyle: TextStyle(
                                                     color: primaryColor1,
                                                     fontSize: h * 0.015,
                                                     fontWeight: FontWeight.bold)),
                                           ),
                                         ],
                                       ),
                                     ],
                                   ),
                                   Divider(
                                     height: h * 0.03,
                                     thickness: h * 0.002,
                                     color: Color(0xffB3B3B3),
                                   ),
                                   ListTile(
                                     leading:
                                     Checkbox(
                                       activeColor: primaryColor,
                                       value: selectall,
                                       onChanged: (bool? value) {
                                         if (selectall) {
                                           for (var a in productImageUrls) {
                                             checkmap.remove(a);
                                           }
                                           for (var a in videoUrl) {
                                             checkmap.remove(a);
                                           }
                                         } else {
                                           for (var a in productImageUrls) {
                                             checkmap[a] = true;
                                           }
                                           for (var a in videoUrl) {
                                             checkmap[a] = true;
                                           }
                                         }
                                         setState(() {
                                           selectall = value!;
                                         });
                                       },
                                     ),
                                     title: Text(
                                       "Select All",
                                       style: GoogleFonts.roboto(
                                           textStyle: TextStyle(
                                               color: Colors.black,
                                               fontSize: h * 0.015,
                                               fontWeight: FontWeight.bold)),
                                     ),
                                     trailing: InkWell(
                                       onTap: () {
                                         List keysToRemove = checkmap.keys.toList();
                                         for(var a in keysToRemove){
                                           videoUrl.remove(a);
                                           productImageUrls.remove(a);
                                           checkmap.clear();
                                         }
                                         setState(() {

                                         });
                                       },
                                       child: Container(
                                         height: h * 0.04,
                                         width: w * 0.220,
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(5),
                                             color: Color(0xffFF0000)),
                                         child: Center(
                                             child: Text(
                                               "Delete",
                                               style: GoogleFonts.roboto(
                                                   textStyle: TextStyle(
                                                       color: Colors.white,
                                                       fontSize: h * 0.015,
                                                       fontWeight: FontWeight.bold)),
                                             )),
                                       ),
                                     ),
                                   ),
                                   Divider(
                                     height: h * 0.03,
                                     thickness: h * 0.002,
                                     color: Color(0xffB3B3B3),
                                   ),
                                   Container(
                                     height: h * 0.35,
                                     width: w,
                                     child: ListView.builder(
                                         scrollDirection: Axis.vertical,
                                         physics: ScrollPhysics(),
                                         itemCount: productImageUrls.length,
                                         itemBuilder: (BuildContext context, int index) {
                                           return Stack(clipBehavior: Clip.none, children: [
                                             Padding(
                                               padding: const EdgeInsets.all(8.0),
                                               child: Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                   Checkbox(
                                                     activeColor: primaryColor,
                                                     value:
                                                     checkmap.containsKey(productImageUrls[index]),
                                                     onChanged: (val) {
                                                       if (checkmap
                                                           .containsKey(productImageUrls[index])) {
                                                         checkmap.remove(productImageUrls[index]);
                                                       } else {
                                                         checkmap[productImageUrls[index]] = true;
                                                       }

                                                       setState(() {});
                                                     },
                                                   ),
                                                   Container(
                                                     height: h * 0.15,
                                                     width: w * 0.350,
                                                     decoration:
                                                     BoxDecoration(color: Colors.grey.shade300),
                                                     child:CachedNetworkImage(
                                                       fit: BoxFit.fill, imageUrl:
                                                         productImageUrls[index].toString(),
                                                     ),
                                                   ),
                                                   InkWell(
                                                       onTap: () {

getDoc();
                                                         setState(() {
                                                           productImageUrls.removeAt(index);

                                                           productImage.removeAt(index);
                                                           getGallaryimages();


                                                         });
                                                       },
                                                       child: Container(
                                                         height: h * 0.04,
                                                         width: w * 0.200,
                                                         decoration: BoxDecoration(
                                                             color: primaryColor,
                                                             borderRadius: BorderRadius.circular(5)),
                                                         child: Center(
                                                           child: Text(
                                                             "Replace",
                                                             style: GoogleFonts.roboto(
                                                                 textStyle: TextStyle(
                                                                     color: Colors.white,
                                                                     fontSize: h * 0.015,
                                                                     fontWeight: FontWeight.bold)),
                                                           ),
                                                         ),
                                                       )),
                                                 ],
                                               ),
                                             ),
                                             Positioned(
                                               left: w * 0.49,
                                               bottom: h * 0.13,
                                               child: InkWell(
                                                 onTap: () {
                                                   productImageUrls.removeAt(index);

                                                   // productImage.removeAt(index);
                                                   setState(() {});
                                                 },
                                                 child: Container(
                                                   width: w * 0.2,
                                                   height: h * 0.04,
                                                   child: const Icon(
                                                     Icons.clear,
                                                     color: Color.fromARGB(255, 254, 253, 255),
                                                     size: 25,
                                                   ),
                                                   decoration: const BoxDecoration(
                                                       color: Color(0xff8C31FF),
                                                       shape: BoxShape.circle),
                                                 ),
                                               ),
                                             )
                                           ]);
                                         }),
                                   ),
                                   SizedBox(
                                     height: h * 0.02,
                                   ),

                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Row(
                                         children: [
                                           Text(
                                             "Videos",
                                             style: GoogleFonts.roboto(
                                                 textStyle: TextStyle(
                                                     color: primaryColor,
                                                     fontSize: h * 0.012,
                                                     fontWeight: FontWeight.bold)),
                                           ),
                                           SizedBox(
                                             width: w * 0.01,
                                           ),
                                           Text(
                                             "(Upload a Video or Add URL)",
                                             style: GoogleFonts.roboto(
                                                 textStyle: TextStyle(
                                                     color: primaryColor, fontSize: h * 0.011)),
                                           ),
                                           SizedBox(
                                             width: w * 0.02,
                                           ),
                                           SvgPicture.asset("assets/selsecfrommedia.svg"),
                                           SizedBox(
                                             width: w * 0.01,
                                           ),
                                           Text(
                                             "Select From Library",
                                             style: GoogleFonts.roboto(
                                                 textStyle: TextStyle(
                                                     color: primaryColor,
                                                     fontSize: h * 0.012,
                                                     fontWeight: FontWeight.bold)),
                                           ),
                                         ],
                                       ),

                                     ],
                                   ),
                                   Divider(
                                     height: h * 0.03,
                                     thickness: h * 0.002,
                                     color: Color(0xffB3B3B3),
                                   ),
                                   SizedBox(
                                     height: h * 0.01,
                                   ),
                                   Container(
                                     height: h * 0.30,
                                     width: w,
                                     child:
                                     ListView.builder(
                                         scrollDirection: Axis.vertical,
                                         physics: ScrollPhysics(),
                                         itemCount:widget.productData.videoUrl!.length,
                                         itemBuilder: (BuildContext context, int index) {
                                           return
                                             Padding(
                                               padding: const EdgeInsets.all(8.0),
                                               child: Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                 children: [
                                                   Checkbox(
                                                     activeColor: primaryColor,
                                                     value: checkmap.containsKey(widget.productData.videoUrl![index]),
                                                     onChanged: (val) {
                                                       if (checkmap
                                                           .containsKey(widget.productData.videoUrl![index])) {
                                                         checkmap.remove(widget.productData.videoUrl![index]);
                                                       } else {
                                                         checkmap[widget.productData.videoUrl![index]] = true;
                                                       }

                                                       setState(() {});
                                                     },

                                                   ),
                                                   Stack(clipBehavior: Clip.none, children: [
                                                     //videoPlayerController==null?
                                                     InkWell(
                                                       onTap: (){
                                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                             VideoViewer(video:widget.productData.videoUrl![index].toString())));
                                                       },
                                                       child:
                                                       Container(
                                                         height: h * 0.15,
                                                         width: w * 0.350,
                                                         decoration: BoxDecoration(
                                                             color: Colors.black
                                                         ),
                                                         child: Center(child: Icon(Icons.play_circle_fill_outlined,size: 50,color: Colors.white,),),
                                                       ),
                                                     ),
                                                     Positioned(
                                                       left: w * 0.23,
                                                       bottom: h * 0.13,
                                                       child: InkWell(
                                                         onTap: () {
                                                           videoUrl.removeAt(index);

                                                           setState(() {});
                                                         },
                                                         child: Container(
                                                           width: w * 0.2,
                                                           height: h * 0.04,
                                                           child: const Icon(
                                                             Icons.clear,
                                                             color: Color.fromARGB(255, 254, 253, 255),
                                                             size: 25,
                                                           ),
                                                           decoration: const BoxDecoration(
                                                               color: Color(0xff8C31FF), shape: BoxShape.circle),
                                                         ),
                                                       ),
                                                     )
                                                   ]),
                                                   InkWell(
                                                       onTap: () {
                                                         _pickvideo();
                                                         setState(() {});
                                                       },
                                                       child: Container(
                                                         height: h * 0.04,
                                                         width: w * 0.200,
                                                         decoration: BoxDecoration(
                                                             color: primaryColor,
                                                             borderRadius: BorderRadius.circular(5)),
                                                         child: Center(
                                                           child: Text(
                                                             "Replace",
                                                             style: GoogleFonts.roboto(
                                                                 textStyle: TextStyle(
                                                                     color: Colors.white,
                                                                     fontSize: h * 0.015,
                                                                     fontWeight: FontWeight.bold)),
                                                           ),
                                                         ),
                                                       )),
                                                 ],
                                               ),
                                             );


                                         }),
                                   ),
                                   SizedBox(
                                     height: h * 0.02,
                                   ),
                                   Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       Row(
                                         children: [
                                           Text(
                                             "*",
                                             style: TextStyle(color: Colors.red),
                                           ),
                                           Text(
                                             "Recommended Video Resolution - 1920x1080 (16:9 Ratio)",
                                             style: GoogleFonts.roboto(
                                                 textStyle: TextStyle(
                                                   color: primaryColor,
                                                   fontSize: h * 0.012,
                                                 )),
                                           )
                                         ],
                                       ),
                                       Row(
                                         children: [
                                           Text(
                                             "*",
                                             style: TextStyle(color: Colors.red),
                                           ),
                                           Text(
                                             "Upload Size Limit - 25 MB",
                                             style: GoogleFonts.roboto(
                                                 textStyle: TextStyle(
                                                   color: primaryColor,
                                                   fontSize: h * 0.010,
                                                 )),
                                           )
                                         ],
                                       ),
                                       Row(
                                         children: [
                                           Text(
                                             "*",
                                             style: TextStyle(color: Colors.red),
                                           ),
                                           Text(
                                             "Recommended Video Length - 1 Minute",
                                             style: GoogleFonts.roboto(
                                                 textStyle: TextStyle(
                                                   color: primaryColor,
                                                   fontSize: h * 0.010,
                                                 )),
                                           )
                                         ],
                                       ),
                                       Row(
                                         children: [
                                           Text(
                                             "*",
                                             style: TextStyle(color: Colors.red),
                                           ),
                                           Text(
                                             "Upload a video or Add url. Not Both at same time",
                                             style: GoogleFonts.roboto(
                                                 textStyle: TextStyle(
                                                   color: primaryColor,
                                                   fontSize: h * 0.010,
                                                 )),
                                           )
                                         ],
                                       )
                                     ],
                                   ),
                                   SizedBox(
                                     height: h * 0.01,
                                   ),
                                   SizedBox(
                                     height: h * 0.02,
                                   ),
                                   // InkWell(
                                   //   onTap: ()  async {
                                   //     if(productImageUrls!=[]){
                                   //       {
                                   //         await showDialog(context: context,
                                   //             builder: (context) {
                                   //               return AlertDialog(
                                   //                   title: Text(
                                   //                       'Add Product?'),
                                   //                   content: Text(
                                   //                       'Do you want to Continue?'),
                                   //                   actions: [
                                   //                     TextButton(
                                   //                         child: Text(
                                   //                           'Cancel',style: TextStyle(color: Colors.black),),
                                   //                         onPressed: () {
                                   //                           Navigator.of(
                                   //                               context)
                                   //                               .pop();
                                   //                         }),
                                   //                     TextButton(
                                   //                         child: Text('Ok',style: TextStyle(color: Colors.black),),
                                   //                         onPressed: () async {
                                   //                           final edit =  editProductModel?.copyWith(
                                   //                               imageId: productImageUrls,
                                   //                               videoUrl:videoUrl,
                                   //                           );
                                   //                           await FirebaseFirestore.instance
                                   //                               .collection("products").doc(widget.productData.productId).
                                   //                           update(edit!.toJson());
                                   //                           Navigator.push(context, MaterialPageRoute(builder: (context)=>NavBar()));
                                   //                           setState(() {
                                   //
                                   //                           });
                                   //
                                   //                         }),
                                   //
                                   //                   ]);
                                   //             }
                                   //         );
                                   //       }
                                   //     }
                                   //     else{
                                   //       productImageUrls == [] ?
                                   //       showUploadMessage(context, 'Please upload images'):Container();
                                   //     }
                                   //
                                   //
                                   //   },
                                   //   child: Container(
                                   //     height: h * 0.06,
                                   //     width: w * 0.800,
                                   //     decoration: BoxDecoration(
                                   //         color: primaryColor,
                                   //         borderRadius: BorderRadius.circular(15)),
                                   //     child: Center(
                                   //         child: Text(
                                   //           "Save",
                                   //           style: TextStyle(color: Colors.white),
                                   //         )),
                                   //   ),
                                   // ),
                                   SizedBox(
                                     height: h * 0.05,
                                   ),
                                 ],
                               ),
                             ),
                           ),
                          ]),
                        ),
                      ),
                    )
                  ])),
            ),
            SizedBox(height:15),

            Container(
              height: h * 0.05,
              width: w,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
            )
          ],

        ));
  }



}
