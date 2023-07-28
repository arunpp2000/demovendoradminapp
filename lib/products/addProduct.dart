import 'dart:io';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demovendoradminapp/products/relatedProduct.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';


import 'package:video_player/video_player.dart';
import '../../../../globals/colors.dart';
import '../../../../model/addProductModel.dart';
import '../../../../model/usermodel.dart';
import '../login/splashscreen.dart';
import '../navbar/tabbarview/tabbar.dart';
import '../widgets/uploadmedia.dart';
import 'media.dart';

class AddProducts2 extends StatefulWidget {
  final Function set;
  const AddProducts2({Key? key, required this.set}) : super(key: key);

  @override
  State<AddProducts2> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts2>with SingleTickerProviderStateMixin {
  String? brandvalue;
  String?  categoryvalue;

  bool? loadingstate;
  List<Map<String,dynamic>> b2cTierPrice=[];
  List<Map<String,dynamic>> b2bTierPrice=[];
  List<Map<String,dynamic>> b2bDelhiTierPrice=[];
  List<Map<String,dynamic>> b2cDelhiTierPrice=[];
  List<Map<String,dynamic>> b2cKeralaTierPrice=[];
  List<Map<String,dynamic>> b2bKeralaTierPrice=[];
  List<Map<String,dynamic>> b2cNorthEast1TierPrice=[];
  List<Map<String,dynamic>> b2bNorthEast1TierPrice=[];
  List<Map<String,dynamic>> b2cTamilnaduTierPrice=[];
  List<Map<String,dynamic>> b2bTamilnaduTierPrice=[];


  String ImageUrl = "";
  late XFile photo;
  File? image;
  File? Image;
  // List<Item> products = [];
  // List productsList = [];
  Future takeImage(ImageSource source, List currentList) async {
    final IMAGE = await ImagePicker().pickImage(source: source);
    if (IMAGE == null) {
      loadingstate = false;
      setState(() {});
    } else {
      setState(() {
        loadingstate = true;
      });
      Image = File(IMAGE.path);
      var storageReference =
      await store.ref().child(DateTime.now().toString()).putFile(Image!);
      var downloadUrl = await storageReference.ref.getDownloadURL();
      if (mounted) {
        setState(() {
          currentList.add(downloadUrl);
          loadingstate = false;
        });
      }
    }
  }

  final store = FirebaseStorage.instance;
  final picker = ImagePicker();

  Future getImager() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickImage != null) {
        image = File(pickImage.path);
        print(image);
        uploadImage();
      } else {
        print("no image selected");
      }
    });
  }

  Future uploadImage() async {
    String uniquefilename = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child("files");
    Reference referenceImagetoUpload = referenceDirImages.child(uniquefilename);

    await referenceImagetoUpload.putFile(File(image!.path));
    var downloadUrl = await (referenceImagetoUpload).getDownloadURL();
    print(downloadUrl);
    ImageUrl = downloadUrl;
    
  }

  String? _selectedValue;
  List<dynamic> _dropdownValues = [];

  List keyList = [];
  List ImageList = [];
  List ImageList1 = [];

  TextEditingController sellername = TextEditingController();
  TextEditingController productname = TextEditingController();
  TextEditingController productcode = TextEditingController();
  TextEditingController productBarcode = TextEditingController();
  TextEditingController keyFeatures = TextEditingController();
  // TextEditingController barcode = TextEditingController();
  TextEditingController moq = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController hsncode = TextEditingController();
  // TextEditingController warranty = TextEditingController();
  // TextEditingController guaranty = TextEditingController();
  TextEditingController prowarranty = TextEditingController();
  TextEditingController proguranty = TextEditingController();
  TextEditingController sold = TextEditingController();
  TextEditingController qtylimit = TextEditingController();

  TextEditingController pL = TextEditingController();
  TextEditingController bL = TextEditingController();
  TextEditingController pB = TextEditingController();
  TextEditingController bB = TextEditingController();
  TextEditingController pH = TextEditingController();
  TextEditingController bH = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController ingredients = TextEditingController();
  TextEditingController nutrition = TextEditingController();
  TextEditingController instruction = TextEditingController();
  TextEditingController fssai = TextEditingController();
  TextEditingController shelf = TextEditingController();
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

  //TextEditingController B2ctamilnadudiscountprice = TextEditingController();


  TextEditingController oneLprice = TextEditingController();
  TextEditingController onesku = TextEditingController();
  TextEditingController onestock = TextEditingController();
  TextEditingController twoprice = TextEditingController();
  TextEditingController twosku = TextEditingController();
  TextEditingController twostock = TextEditingController();
  TextEditingController percentage = TextEditingController();
  TextEditingController giftWrapCharge = TextEditingController();
  TextEditingController gstController = TextEditingController();



  Color _iconColor = Colors.grey;
  List<bool> _switchValues = List.generate(16, (index) => false);
  bool AddproductTab = false;
  bool status = false;
  bool Commission = false;
  bool AffiliatedP = false;
  bool Gpricing = false;
  bool B2c = false;
  bool B2b = false;
  bool imported = false;
  bool COD = false;
  bool nonveg = false;
  bool veg = false;
  bool Returnable = false;
  bool Cancellable = false;
  bool Refundable = false;
  bool Barcode = false;
  bool Warranty = false;
  bool Guaranty = false;
  bool VariableProduct = false;
  bool ManageStock = false;
  bool MinimumQty = false;
  bool QtyLimit = false;
  bool media = false;
  bool pd = false;
  bool sales = false;
  bool liquidContent = false;
  bool expirable = false;
  bool exchangable = false;
  bool giftWrap = false;

  TextEditingController brand = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController subcat = TextEditingController();
  TextEditingController childcat = TextEditingController();
  TextEditingController selectedColor = TextEditingController();
  TextEditingController attributes = TextEditingController();
  TextEditingController attrivalue = TextEditingController();
  TextEditingController gst = TextEditingController();
  TextEditingController Commission1 = TextEditingController();
  TextEditingController countType = TextEditingController();
  TextEditingController barcodeType = TextEditingController();
  TextEditingController expire = TextEditingController();
  TextEditingController expireType = TextEditingController();
  TextEditingController heatSensitive = TextEditingController();

  List details = [{}];
  List<String> brand1 = [];
  Map brandNametoId = {};

  //List<String> category1 = ["Today", "This Week", " This Month", "This Year"];
  List<String> subcat1 = ["Today", "This Week", " This Month", "This Year"];
  List<String> childcat1 = ["Today", "This Week", " This Month", "This Year"];
  List<String> color1 = ["Today", "This Week", " This Month", "This Year"];
  List<String> attributes1 = ["Today", "This Week", " This Month", "This Year"];
  List<String> attrivalue1 = ["Today", "This Week", " This Month", "This Year"];
  List<String> gst1 = ["Today", "This Week", " This Month", "This Year"];
  List<String> Commission2 = ["Percentage %", "Amount"];
  List<String> count = ["gram", "meter", 'millilitre', 'litre', 'square metre'];
  List<String> barcode = ['UPC', 'MPN', 'EAN', 'ISBN'];
  List<String> expire1 = ["yes", "no"];
  List<String> expirationType = ["Shelf Life", "Expiration on Package"];

  List brList = [];

  List cNAmeList = [];
  List<String> myColors = [];
  List<String> myAttributes = [];
  List<String> attributeValues = [];

  // getAttributes() {
  //   FirebaseFirestore.instance
  //       .collection("vendor")
  //       .doc(currentUser!.id)
  //       .collection('attributes')
  //       .get()
  //       .then((value) {
  //     for (DocumentSnapshot doc in value.docs) {
  //       myAttributes.add(doc['attributeName']);
  //       attributeNameToId[doc.get("attributeName")] = doc.id;
  //       attributeValues.add(doc['attributeValues']);
  //     }
  //   });
  //   setState(() {});
  // }
  // Map idToName={};
  // Map nameToId={};

 AddProductModel? updateProduct;

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

   List<Tab> myTabs = <Tab>[
     Tab(text: 'Product Details'),
     Tab(text: 'Media'),
  ];
  late TabController tabController;
  // updateMessages(){
  //   FirebaseFirestore.instance.collection('products').get().then((value) {
  //     for(DocumentSnapshot snap in value.docs){
  //       FirebaseFirestore.instance.collection('products').doc(snap.id)
  //           .update({
  //         'date':DateTime.now(),
  //         'acceptedDate':DateTime.now(),
  //         'status':0,
  //
  //       });
  //     }
  //   });
  // }



  Map  brandIdtoName={};
  getBrand() {
    FirebaseFirestore.instance
        .collection("brands")
        .where('vendorId', isEqualTo: currentUser?.id)
        .where('status', isEqualTo: 1)
        .get()
        .then((value) {
      brand1=[];
      for (DocumentSnapshot doc in value.docs) {
        brandNametoId[doc.get("brand")] = doc.id;
        brandIdtoName[doc.id] = doc.get("brand");
        brand1.add(doc['brand']);
      }
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
        .where('vendorId', isEqualTo: currentUser?.id)
        .where('status', isEqualTo: 1)
        .get()
        .then((value) {
      categoryList=[];
      for (DocumentSnapshot doc in value.docs) {
        categoryList.add(doc['name']);
        categoryNametoId[doc.get("name")] = doc.id;
        catIdToName[doc.id]=doc.get('name');
      }
      setState(() {
      });
    });
  }
  @override
  void initState() {
    super.initState();
    getCategory();
    getBrand();
    tabController = TabController(vsync: this, length: myTabs.length);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    selectedProduct.clear();
  }

  @override
  Widget build(BuildContext context) {

    return  Column(
        children: [
          Expanded(
            child: Padding(
              padding:EdgeInsets.all(10.0),
              child: Container(
                width: w,
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
                child: Column(
                    children: [
                      Container(
                        height: h * 0.05,
                        width: w *1,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child:  TabBar(
                          indicatorColor: Colors.transparent,
                          controller: tabController,
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
                      Expanded(
                        child: TabBarView(
                            controller:tabController,

                            children: [
                          Padding(
                            padding: EdgeInsets.all(w * 0.015),
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
                                            "Only enable options that are relevant to your product. Please complete all  required fields \n to get approval.",
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
                                    thickness: h * 0.0005,
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
                                        onChanged: (v){
                                          // brandvalue=v;
                                          // print(v);
                                          setState(() {

                                          });
                                        },
                                        hintText: "Select brand",
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
                                        controller: brand,
                                      ),
                                      SizedBox(
                                        height: h * 0.02,
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            " Select Category",
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
                                        onChanged: (v){
                                          categoryvalue=v;
                                          setState(() {

                                          });
                                        },


                                        hintText: "Select category",
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

                                          // Row(
                                          //     mainAxisAlignment:
                                          //     MainAxisAlignment.spaceBetween,
                                          //     children: [
                                          //       Text("B2B Global price ",
                                          //           style: GoogleFonts.roboto(
                                          //               textStyle: TextStyle(
                                          //                   fontSize: w * 0.03),
                                          //               color:
                                          //               const Color(0xff298E03))),
                                          //       const Text(
                                          //         "*",
                                          //         style: TextStyle(color: Colors.red),
                                          //       ),
                                          //       SizedBox(
                                          //         width: w * 0.02,
                                          //       ),
                                          //       SizedBox(
                                          //         height: h * 0.0015,
                                          //         width: w * 0.55,
                                          //         child: ColoredBox(
                                          //           color: primaryColor,
                                          //         ),
                                          //       )
                                          //     ]),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //   MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     Container(
                                          //       width: w * 0.40,
                                          //       child: TextFormField(
                                          //         controller: B2bprice,
                                          //         decoration: InputDecoration(
                                          //           hintText: "Price",
                                          //           hintStyle: TextStyle(
                                          //               color: const Color(0xffB3B3B3),
                                          //               fontSize: h * 0.015),
                                          //           enabledBorder:
                                          //           const UnderlineInputBorder(
                                          //             //<-- SEE HERE
                                          //             borderSide: BorderSide(
                                          //                 width: 1,
                                          //                 color: Colors.black54),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     SizedBox(
                                          //       width: w * 0.04,
                                          //     ),
                                          //     Container(
                                          //       width: w * 0.40,
                                          //       child: TextFormField(
                                          //         controller: B2bdiscountprice,
                                          //         decoration: InputDecoration(
                                          //           hintText: "Discount Price",
                                          //           hintStyle: TextStyle(
                                          //               color: const Color(0xffB3B3B3),
                                          //               fontSize: h * 0.015),
                                          //           enabledBorder:
                                          //           const UnderlineInputBorder(
                                          //             //<-- SEE HERE
                                          //             borderSide: BorderSide(
                                          //                 width: 1,
                                          //                 color: Colors.black54),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     )
                                          //   ],
                                          // ),
                                          // SizedBox(
                                          //   height: h * 0.03,
                                          // ),
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
                                      ):Container(height: h*0.015,),
                                      SizedBox(
                                        height: h * 0.03,
                                      ),

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
                                      ):Container(),

                                      SizedBox(
                                        height: h * 0.03,
                                      ),

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
                                            child: Container(

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
                                                                                        widget.set();
                                                                                      }
                                                                                      else{
                                                                                        B2cTierPriceVolum.text==''?showUploadMessage(context, 'enter volume'):
                                                                                       showUploadMessage(context, 'enter amount');
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
                                                                      Map<String,dynamic> selected=  await    showDialog(
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
                                                                                widget.set();
                                                                              }
                                                                                     else{
                                                                                B2cDelhiTierPriceVolum.text==''?showUploadMessage(context, 'enter volume'):
                                                                                showUploadMessage(context, 'enter amount');
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



                                                                                        widget.set();
                                                                                      }
                                                                                      else{
                                                                                        B2cKeralaTierPriceVolum.text==''?showUploadMessage(context, 'Enter volume'):
                                                                                        showUploadMessage(context, 'Enter amount');
                                                                                      }

                                                                                      // Navigator.of(ctx).pop();
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



                                                                                        widget.set();
                                                                                      }
                                                                                      else{
                                                                                        B2cNorthEast1TierPriceVolum.text==''?showUploadMessage(context, 'Enter volume'):
                                                                                        showUploadMessage(context, 'Enter amount');
                                                                                      }

                                                                                      // Navigator.of(ctx).pop();
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
                                                                      Map<String,dynamic> selected=  await    showDialog(
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
                                                                                        widget.set();
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
                                            padding: EdgeInsets.all(8),
                                            child: ListView.builder(
                                                physics: NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets.zero,
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: b2bTierPrice.length+1,
                                                itemBuilder: (context,index){
                                                  String name=index==(b2bTierPrice.length)?"":b2bTierPrice[index]['name'];
                                                  String price=index==(b2bTierPrice.length)?"":b2bTierPrice[index]['price'];
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

                                                                  if(index==(b2bTierPrice.length)){
                                                                    Map<String,dynamic> selected=  await showDialog(
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
                                                                                      widget.set();
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
                                          SizedBox(height: h*0.02,),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('B2B Delhi Tier Price',
                                              style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor),),

                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10,10,10,0),
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
                                                  String price=index==(b2bDelhiTierPrice.length)?"":b2bDelhiTierPrice[index]['price'];
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



                                                                                      widget.set();
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
                                                    String name=index==(b2bKeralaTierPrice.length)?"":b2bKeralaTierPrice[index]["name"];
                                                    String price=index==(b2bKeralaTierPrice.length)?"":b2bKeralaTierPrice[index]['price'];
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

                                                                                        widget.set();
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



                                                                                        widget.set();
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
                                                                        // addon.add({
                                                                        // 'addOn':admins1[index]['addOn'],
                                                                        //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                        //   'imageUrl':admins1[index]['imageUrl']
                                                                        // });
                                                                        // print(addon.length);

                                                                      });
                                                                    }else
                                                                    {

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
                                                                                        widget.set();
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

                                      SizedBox(height:h*0.02),
                                      Column(
                                        mainAxisAlignment:MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Related Products",
                                            style: GoogleFonts.roboto(

                                                color: primaryColor),
                                          ),
                                          SizedBox(height:h*0.01),
                                          InkWell(onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RelatedProduct(set:widget.set)));
                                          },
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
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
                                          ),
                                        ],
                                      ),
                                      selectedProduct.isNotEmpty? Container(
                                        height: h*0.2,
                                        width: w,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: ListView.builder(
                                                physics: ScrollPhysics(),
                                                itemCount: selectedProduct.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return
                                                    Padding(
                                                      padding: const EdgeInsets.all(8),
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
                                      ):Container(),

                                      SizedBox(
                                        height: h * 0.02,
                                      ),
                                      AddproductTab == false
                                          ? Padding(
                                        padding: EdgeInsets.only(
                                            left: w * 0.05, right: w * 0.05),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "*",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                InkWell(onTap: (){

                                                },
                                                  child: Text(
                                                      "Approval Time : 24 Hours ",
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize: w * 0.03,
                                                            color:
                                                            primaryColor),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: h * 0.01,
                                            ),
                                            Row(
                                              children: [
                                                // SizedBox(
                                                //   width: w * 0.02,
                                                // ),
                                                Text(
                                                  "*",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: h * 0.020),
                                                ),
                                                Text(
                                                    "You can resubmit the Pending Approval Products from the \n Inventory list. ",
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
                                            InkWell(
                                              onTap: () async {


                                                if(
                                                productname.text != '' &&
                                                    productcode.text != "" &&
                                                    stock.text != "" &&
                                                    hsncode.text != '' &&
                                                    description.text != ''&&
                                                    weight.text!=""&&
                                                    ingredients.text!=""&&
                                                    nutrition.text!=""&&
                                                    madefrom.text!=""&&
                                                    gst.text!=""
                                                // B2c?B2cprice.text!=""&&
                                                // B2c?B2cdiscountprice.text!=""&&
                                                // B2c?B2cdelhiprice.text!=""&&
                                                // B2c?B2cdelhidiscountprice.text!=""&&
                                                // B2c?B2ckeralaprice.text!=""&&
                                                // B2c?B2ckeraladiscountprice.text!=""&&
                                                // B2c?B2cnortheast1price.text!=""&&
                                                // B2c?B2cnortheast1discountprice.text!=""&&
                                                // B2c?B2ctamilnaduprice!=""&&
                                                // B2c?B2ctamilnadudiscountprice!=""&&
                                                // B2b?B2bprice.text!=""&&
                                                // B2b?B2bdiscountprice.text!=""&&
                                                // B2b?B2bdelhiprice.text!=""&&
                                                // B2b?B2bdelhidiscountprice.text!=""&&
                                                // B2b?B2bkeralaprice.text!=""&&
                                                // B2b?B2bkeraladiscountprice.text!=""&&
                                                // B2b?B2bnortheast1price.text!=""&&
                                                // B2b?B2bnortheast1discountprice.text!=""&&
                                                // B2b?B2btamilnaduprice!=""&&
                                                // B2b?B2btamilnadudiscountprice!=""
                                                ){
                                                  await
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                            title: Text(
                                                                'Add Product?'),
                                                            content: Text(
                                                                'Do you want to Continue?'),
                                                            actions: [
                                                              TextButton(
                                                                  child:
                                                                  Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        color:
                                                                        primaryColor),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(context)
                                                                        .pop();
                                                                  }),
                                                              TextButton(
                                                                  child:
                                                                  Text(
                                                                    'Ok',
                                                                    style: TextStyle(
                                                                        color:
                                                                        primaryColor),
                                                                  ),
                                                                  onPressed:
                                                                      ()  async {
                                                                     updateProduct =
                                                                    AddProductModel(
                                                                      // exchangable: exchangable,
                                                                      // expirable: exchangable,
                                                                      // giftWrap: giftWrap,
                                                                      // liquidContents: liquidContent,
                                                                      sales: sales,
                                                                      date: DateTime.now(),
                                                                      vendorId: currentUser?.id,
                                                                      available: false,
                                                                      b2b: B2b,
                                                                      b2c: B2c,
                                                                      b2bP:double.tryParse(B2bprice.text),
                                                                      b2bD:double.tryParse(B2bdiscountprice.text),
                                                                      b2bDelhiD: double.tryParse(B2bdelhidiscountprice.text),
                                                                      b2bDelhiP: double.tryParse(B2bdelhiprice.text),
                                                                      b2bDelhiTier: b2bDelhiTierPrice,
                                                                      b2bKeralaD: double.tryParse(B2bkeraladiscountprice.text),
                                                                      b2bKeralaP: double.tryParse(B2bkeralaprice.text),
                                                                      b2bKeralaTier: b2bKeralaTierPrice,
                                                                      b2bTamilnaduD: double.tryParse(B2btamilnadudiscountprice.text),
                                                                      b2bTamilnaduP: double.tryParse(B2btamilnaduprice.text),
                                                                      b2bTamilnaduTier:b2bTamilnaduTierPrice,
                                                                      b2bNorthEast1P: double.tryParse(B2bnortheast1discountprice.text),
                                                                      b2bNorthEast1D: double.tryParse(B2bnortheast1discountprice.text),
                                                                      b2bNorthEast1Tier: b2bNorthEast1TierPrice,
                                                                      b2bTier: b2bTierPrice,
                                                                      weight:double.tryParse(weight.text),
                                                                      sold: int.tryParse(sold.text),
                                                                      branchId: 'XaGJz72DaZdJ4S9g7PkO',
                                                                      fives: 0,
                                                                      fours: 0,
                                                                      delete: false,
                                                                      //imageId: [],
                                                                      ones: 0,
                                                                      open: false,
                                                                      relatedProducts: selectedProduct,
                                                                      //sales: false,
                                                                      search: setSearchParam(productname.text.toUpperCase()),
                                                                      start: 0,
                                                                      step: 0,
                                                                      stop: 0,
                                                                      threes: 0,
                                                                      totalReviews: 0,
                                                                      twos:0,
                                                                      userId: '',
                                                                      videoUrl: [],
                                                                      imported: imported,
                                                                      payOnDelivery: COD,
                                                                      nonveg: nonveg,
                                                                      veg: veg,
                                                                      status: 0,
                                                                      // Returnable: Returnable,
                                                                      //cancellable: Cancellable,
                                                                      //refundable: Refundable,
                                                                      //barcode: Barcode,
                                                                      //warranty: Warranty,
                                                                      //guaranty: Guaranty,
                                                                      //variableproduct: VariableProduct,
                                                                      //managestock: ManageStock,
                                                                      //minimumqty: MinimumQty,
                                                                      //qtylimit: QtyLimit,
                                                                      sellername: currentUser!.Fullname,
                                                                      name: productname.text,
                                                                      productCode: productcode.text,
                                                                      //productbarcode: productBarcode.text,
                                                                      // moq: moq.text,
                                                                      // unit: unit.text,
                                                                      // weight: int.tryParse(weight.text),
                                                                      stock: int.tryParse(stock.text),
                                                                      hsnCode: int.tryParse(hsncode.text),
                                                                      //prowarranty: prowarranty.text,
                                                                      //proGuaranty: proguranty.text,
                                                                      // sold: int.tryParse(sold.text),
                                                                      //qutlimit: int.tryParse(qtylimit.text),
                                                                      // productDimensionL: double.tryParse(pL.text),
                                                                      // boxDimensionL: double.tryParse(bL.text),
                                                                      // productDimensionB: double.tryParse(pB.text),
                                                                      // boxDimensionB: double.tryParse(bB.text),
                                                                      // productDimensionH: double.tryParse(pH.text),
                                                                      // boxDimensionH: double.tryParse(bH.text),
                                                                      description: description.text,
                                                                      brand: brandNametoId[brand.text],
                                                                      category: categoryNametoId[category.text],
                                                                      categoryName: category.text,
                                                                      //subcategory: subcat.text,
                                                                      //childcategory: childcat.text,
                                                                      ingredients: ingredients.text,
                                                                      fact: nutrition.text,
                                                                      instructions: instruction.text,
                                                                      //fssailicno: fssai.text,
                                                                      //shelflife: shelf.text,
                                                                      madeFrom: madefrom.text,
                                                                      //color: selectedColor.text,
                                                                      //attributes: attributes.text,
                                                                      //attributesvalue: attrivalue.text,
                                                                      gst: double.tryParse(gst.text),
                                                                      b2cP: double.tryParse(B2cprice.text),
                                                                      b2cD: double.tryParse(B2cdiscountprice.text),
                                                                      b2cDelhiD: double.tryParse(B2cdelhidiscountprice.text),
                                                                      b2cDelhiP: double.tryParse(B2cdelhiprice.text),
                                                                      b2cDelhiTier: b2cDelhiTierPrice,
                                                                      b2cKeralaP: double.tryParse(B2ckeralaprice.text),
                                                                      b2cKeralaD: double.tryParse(B2ckeraladiscountprice.text),
                                                                      b2cKeralaTier: b2cKeralaTierPrice,
                                                                      b2cTamilnaduD: double.tryParse(B2ctamilnadudiscountprice.text),
                                                                      b2cTamilnaduP: double.tryParse(B2ctamilnaduprice.text),
                                                                      b2cTamilnaduTier: b2cTamilnaduTierPrice,
                                                                      b2cTier: b2cTierPrice,
                                                                      b2cNorthEast1P: double.tryParse(B2cnortheast1price.text),
                                                                      b2cNorthEast1D: double.tryParse(B2cnortheast1discountprice.text),
                                                                      b2cNorthEast1Tier: b2cNorthEast1TierPrice,

                                                                    );

                                                                     setState(() {

                                                                     });
                                                                     await widget.set();


                                                                        await  Future.delayed(Duration(milliseconds: 1));

                                                                    tabController.animateTo(1);
                                                                    Navigator.pop(context);


                                                                    productname.text = '';
                                                                    productcode.text = '';
                                                                    stock.text = '';
                                                                    hsncode.text = '';
                                                                    description.text = '';
                                                                    weight.text ='';
                                                                    ingredients.text = '';
                                                                    nutrition.text = '';
                                                                    instruction.text = '';
                                                                    sold.text = '';
                                                                    madefrom.text = '';
                                                                    selectedProduct.clear();
                                                                    // // productBarcode.text =='';
                                                                    // //  moq.text ==
                                                                    // //      '';
                                                                    // //  unit.text ==
                                                                    // //      '';
                                                                    // //  prowarranty.text ==
                                                                    // //      '';
                                                                    // //  proguranty.text =='';

                                                                    //  qtylimit.text == '';
                                                                    //  pL.text == '';
                                                                    //  bL.text == '';
                                                                    //  pB.text ==
                                                                    //      '';
                                                                    //  bB.text ==
                                                                    //      '';
                                                                    //  pH.text ==
                                                                    //      '';
                                                                    //  bH.text ==
                                                                    //      '';

                                                                    //  fssai.text ==
                                                                    //      '';
                                                                    //  shelf.text ==
                                                                    //      '';

                                                                    if(B2b){
                                                                      B2bprice.text = '';
                                                                      B2bdiscountprice.text='';
                                                                      B2btamilnadudiscountprice.text="";
                                                                      B2btamilnaduprice.text="";
                                                                      B2bdelhidiscountprice.text="";
                                                                      B2bdelhiprice.text="";
                                                                      B2bkeralaprice.text="";
                                                                      B2bkeraladiscountprice.text="";
                                                                      B2bnortheast1discountprice.text="";
                                                                      B2bnortheast1price.text="";
                                                                      b2bNorthEast1TierPrice=[];
                                                                      b2bTierPrice=[];
                                                                      b2bTamilnaduTierPrice=[];
                                                                      b2bKeralaTierPrice=[];
                                                                      b2bDelhiTierPrice=[]
                                                                      ;
                                                                    }
                                                                    if(B2c){
                                                                      B2cprice.text = '';
                                                                      B2cdiscountprice.text='';
                                                                      B2ctamilnadudiscountprice.text="";
                                                                      B2ctamilnaduprice.text="";
                                                                      B2cdelhidiscountprice.text="";
                                                                      B2cdelhiprice.text="";
                                                                      B2ckeralaprice.text="";
                                                                      B2ckeraladiscountprice.text="";
                                                                      B2cnortheast1discountprice.text="";
                                                                      B2cnortheast1price.text="";
                                                                      b2cNorthEast1TierPrice=[];
                                                                      b2cTierPrice=[];
                                                                      b2cTamilnaduTierPrice=[];
                                                                      b2cKeralaTierPrice=[];
                                                                      b2cDelhiTierPrice=[];

                                                                    }

                                                                  }),
                                                            ]);
                                                      });
                                                }else{
                                                  productname.text == ''
                                                      ? showUploadMessage(context, 'Please enter product Name')
                                                      : productcode.text == '' ? showUploadMessage(context, 'Please enter productcode')
                                                      : stock.text == ''
                                                      ? showUploadMessage(
                                                      context,
                                                      'Please enter stock')
                                                      : hsncode.text == ''
                                                      ? showUploadMessage(
                                                      context,
                                                      'Please enter hsncode')
                                                      : description.text ==
                                                      ''
                                                      ? showUploadMessage(
                                                      context,
                                                      'Please enter product description')
                                                      :weight.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product weight')
                                                      :ingredients.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product ingredients')
                                                      :nutrition.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product nutrition fact')
                                                      :instruction.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product instruction')
                                                      :madefrom.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product made from')
                                                      :gst.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product gst')
                                                      :(B2c==true&&B2cprice.text=="")
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product B2c price')
                                                      :(B2c==true&&B2cdiscountprice.text=="")
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product B2c discount price')
                                                      :B2c==true&&B2cdelhiprice.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product B2c delhi price')
                                                      :B2c==true&&B2cdelhidiscountprice.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product B2c B2c delhi discount price')
                                                      :B2c==true&&B2ckeralaprice.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product  B2c kerala price')
                                                      :B2c==true&&B2ckeraladiscountprice.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product  B2c kerala discount price')
                                                      :B2c==true&&B2cnortheast1price.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product  B2c northeast 1 price')
                                                      :B2c==true&&B2cnortheast1discountprice.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product B2c northeast 1 discount price')
                                                      :B2c==true&&B2ctamilnaduprice.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product B2c tamilnadu price')
                                                      :B2c==true&&B2ctamilnadudiscountprice.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product B2c amilnadu discount price')
                                                      :B2b==true&&B2bprice.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product B2b price')
                                                      :B2b==true&&B2bdiscountprice.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product B2b discount price')
                                                      :B2b==true&&B2bdelhiprice.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product B2b delhi price')
                                                      :B2b==true&&B2bdelhidiscountprice.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product B2b delhi discount price')
                                                      :B2b==true&&B2bkeralaprice.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product  B2b kerala price')
                                                      :B2b==true&&B2bkeraladiscountprice.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product  B2b kerala discount price')
                                                      :B2b==true&&B2bnortheast1price.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product  B2b northeast 1 price')
                                                      :B2b==true&&B2bnortheast1discountprice.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product B2b northeast 1 discount price')
                                                      :B2b==true&&B2btamilnaduprice.text==""
                                                      ?showUploadMessage(
                                                      context,
                                                      'Please enter product B2b tamilnadu price')
                                                      :B2b==true&&B2btamilnadudiscountprice.text=="" ?showUploadMessage(context,
                                                      'Please enter product B2b tamilnadu discount price'):'';
                                                }




                                                setState(() {});
                                              },
                                              child: Container(
                                                height: h * 0.06,
                                                decoration: BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        w * 0.02)),
                                                child: const Center(
                                                    child: Text(
                                                      "Submit for Approval",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                          : Container(),
                                      SizedBox(
                                        height: h * 0.04,
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
                          Media(model:updateProduct)
                        ]),
                      )
                    ]),
              ),
            ),
          ),
          SizedBox(height:10),
          Container(
            height: h * 0.05,
            width: w,
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10))),
          )
        ]);
  }

  showAlertDialogue(List l1) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.grey.shade500,
        elevation: 500,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: h * 0.16,
          width: w * 0.2,
          color: Colors.grey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Ink(
                    decoration: ShapeDecoration(
                      color: Colors.pink,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      onPressed: () {
                        takeImage(ImageSource.camera, l1);
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.camera_alt_rounded, color: Colors.white),
                      iconSize: h * 0.1,
                      // splashRadius: 70,
                    ),
                  ),
                  Text("Camera",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                          fontSize: 20)),
                ],
              ),
              SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  Ink(
                    decoration: ShapeDecoration(
                      color: Colors.purple,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      onPressed: () {
                        takeImage(ImageSource.gallery, l1);
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.photo),
                      color: Colors.white,
                      iconSize: h * 0.1,
                      //   splashRadius: 40,
                    ),
                  ),
                  Text("Gallery",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                          fontSize: 20)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
