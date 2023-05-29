import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';



import '../../../globals/colors.dart';

import '../../../model/usermodel.dart';
import '../login/otplogin.dart';
import '../model/productModel.dart';
import '../widgets/uploadmedia.dart';
import 'media.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  String? brandvalue;

  String ImageUrl = "";
  late XFile photo;
  File? image;
var typeId;
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
    print("starts");
    String uniquefilename = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child("files");
    Reference referenceImagetoUpload = referenceDirImages.child(uniquefilename);

    await referenceImagetoUpload.putFile(File(image!.path));
    var downloadUrl = await (referenceImagetoUpload).getDownloadURL();
    print(downloadUrl);
    ImageUrl = downloadUrl;
    print("---------------------------------");
    print(ImageUrl);
  }

  String? _selectedValue;
  List<dynamic> _dropdownValues = [];


  TextEditingController sellername = TextEditingController();
  TextEditingController productname = TextEditingController();
  TextEditingController productcode = TextEditingController();
  TextEditingController productBarcode = TextEditingController();
  // TextEditingController barcode = TextEditingController();
  TextEditingController moq = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController hsncode = TextEditingController();
  TextEditingController dateAvaliable = TextEditingController();
  // TextEditingController warranty = TextEditingController();
  // TextEditingController guaranty = TextEditingController();
  TextEditingController prowarranty = TextEditingController();
  TextEditingController proguranty = TextEditingController();
  TextEditingController sold = TextEditingController();
  TextEditingController qtylimit = TextEditingController();


  TextEditingController L = TextEditingController();
  TextEditingController B = TextEditingController();
  TextEditingController H = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController ingredients = TextEditingController();
  TextEditingController nutrition = TextEditingController();
  TextEditingController instruction = TextEditingController();
  TextEditingController fssai = TextEditingController();
  TextEditingController shelf = TextEditingController();
  TextEditingController madefrom = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController discountprice = TextEditingController();
  TextEditingController oneLprice = TextEditingController();
  TextEditingController onesku = TextEditingController();
  TextEditingController onestock = TextEditingController();
  TextEditingController twoprice = TextEditingController();
  TextEditingController twosku = TextEditingController();
  TextEditingController twostock = TextEditingController();
  TextEditingController percentage = TextEditingController();
  TextEditingController giftWrapCharge = TextEditingController();

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
  late DateTime picked;

  TextEditingController brand = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController parentCat = TextEditingController();
  TextEditingController childcat = TextEditingController();
  TextEditingController color = TextEditingController();
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
  List<String> brand1 = ['1'];
  Map brandNametoId = {};

  getBrand() {
    FirebaseFirestore.instance.collection("brands").where('status',isEqualTo: 1).get().then((value) {
      for (DocumentSnapshot doc in value.docs) {
        brandNametoId[doc.get("brand")] = doc.id;
        brand1.add(doc['brand']);

      }
      print('ppppp');
      print(brand1.length);
    });
    setState(() {

    });
  }
  List<String> parentCategory = [''];
  Map parentCatNametoId = {};

  getParentCategory() {
    FirebaseFirestore.instance.collection("parentCategory").where('status',isEqualTo:1).where('delete',isEqualTo:false).get().then((value) {
      for (DocumentSnapshot doc in value.docs) {
        brandNametoId[doc.get("name")] = doc.id;
        parentCategory.add(doc['name']);
      }
    });
    setState(() {

    });
  }
List? ImageList=[];
List? ImageList1=[];
  List<String> category1 = ["Today", "This Week", " This Month", "This Year"];
  List<String> subcat1 = ["Today", "This Week", " This Month", "This Year"];
  List<String> childcat1 = ["Today", "This Week", " This Month", "This Year"];
  List<String> color1 = ["Today", "This Week", " This Month", "This Year"];
  List<String> attributes1 = ["Today", "This Week", " This Month", "This Year"];
  List<String> attrivalue1 = ["Today", "This Week", " This Month", "This Year"];
  List<String> gst1 = ["Today", "This Week", " This Month", "This Year"];
  List<String> Commission2 = ["Percentage %", "Amount"];
  List<String> count = ["gram","meter",'millilitre','litre','square metre'];
  List<String> expire1 = ["yes","no",];
  List<String> barcodes = ["UPC",];
  List<String> expirationType = ["Shelf Life","Expiration on Package",];
  @override
  void initState() {
    super.initState();
    getBrand();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(
                height: h * 0.02,
              ),
              DefaultTabController(
                  length: 2,
                  child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:10,bottom: 10,left:15,right:15),

                          child: Container(
                            height: h * 0.05,
                            width: w * 0.98,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: const TabBar(
                              // onTap:AddproductTab=true,

                              indicatorColor: Colors.transparent,
                              indicator: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),

                              tabs: <Widget>[
                                Tab(text: 'Product Details'),
                                Tab(text: 'Media'),
                              ],
                              labelColor: Colors
                                  .white, // Customize the appearance of the TabBar
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(top:0,bottom: 10,left:10,right:13),
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
                            child: TabBarView(children: [
                              Padding(
                                padding: EdgeInsets.all(w * 0.02),
                                child: SingleChildScrollView(
                                  child: Column(

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
                                                      fontWeight:
                                                      FontWeight.bold),
                                                )),
                                          ),
                                          Text("Only enable options that are relevant to your product. Please complete all required \n fields to get approval.",
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: h * 0.012,
                                                ),
                                              )),
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
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                title: Text("B2B",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: h * 0.012,
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                      Row(
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
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                      Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                title: Text("Returnable",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: h * 0.012,
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                    value: Returnable,
                                                    borderRadius: 30.0,
                                                    padding: 8.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        Returnable = val;
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
                                                title: Text("Cancellable",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: h * 0.012,
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                    value: Cancellable,
                                                    borderRadius: 30.0,
                                                    padding: 8.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        Cancellable = val;
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
                                                title: Text("Refundable",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: h * 0.012,
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                    value: Refundable,
                                                    borderRadius: 30.0,
                                                    padding: 8.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        Refundable = val;
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
                                                title: Text("Barcode",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: h * 0.012,
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                    value: Barcode,
                                                    borderRadius: 30.0,
                                                    padding: 8.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        Barcode = val;
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
                                                title: Text("Warranty",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: h * 0.012,
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                    value: Warranty,
                                                    borderRadius: 30.0,
                                                    padding: 8.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        Warranty = val;
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
                                                title: Text("Guaranty",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: h * 0.012,
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                    value: Guaranty,
                                                    borderRadius: 30.0,
                                                    padding: 8.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        Guaranty = val;
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
                                                title: Text("Variable Product",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: h * 0.01095,
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                    value: VariableProduct,
                                                    borderRadius: 30.0,
                                                    padding: 8.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        VariableProduct = val;
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
                                                title: Text("Manage Stock",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: h * 0.012,
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                    value: ManageStock,
                                                    borderRadius: 30.0,
                                                    padding: 8.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        ManageStock = val;
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
                                                title: Text("Minimum Qty?",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: h * 0.012,
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                    value: MinimumQty,
                                                    borderRadius: 30.0,
                                                    padding: 8.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        MinimumQty = val;
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
                                                title: Text("Qty Purchase Limit?",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: h * 0.012,
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                    value: QtyLimit,
                                                    borderRadius: 30.0,
                                                    padding: 8.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        QtyLimit = val;
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
                                                title: Text("Exchangeable",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: h * 0.012,
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                    value: exchangable,
                                                    borderRadius: 30.0,
                                                    padding: 8.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        exchangable = val;
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
                                                title: Text("Product Expirable?",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: h * 0.012,
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                    value: expirable,
                                                    borderRadius: 30.0,
                                                    padding: 8.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        expirable = val;
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
                                                title: Text("Liquid Contents?",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: h * 0.012,
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                    value: liquidContent,
                                                    borderRadius: 30.0,
                                                    padding: 8.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        liquidContent = val;
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
                                                title: Text("Sale",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: h * 0.012,
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                      Row(
                                        children: [
                                          Container(
                                              height: h * 0.06,
                                              width: w * 0.450,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              child: ListTile(
                                                title: Text("Gift Wrap Available",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: h * 0.012,
                                                          fontWeight:
                                                          FontWeight.bold),
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
                                                    value: giftWrap,
                                                    borderRadius: 30.0,
                                                    padding: 8.0,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        giftWrap = val;
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            children: [
                                              Text("Seller Name",
                                                  style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          fontSize: w * 0.03),
                                                      color: primaryColor)),
                                            ],
                                          ),
                                          TextFormField(
                                            controller: sellername,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              hintText: currentUser?.Fullname,
                                              enabledBorder:
                                              const UnderlineInputBorder(
                                                //<-- SEE HERE
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.black54),
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
                                                      textStyle: TextStyle(
                                                          fontSize: w * 0.03),
                                                      color: primaryColor)),
                                              const Text(
                                                "*",
                                                style:
                                                TextStyle(color: Colors.red),
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
                                              enabledBorder:
                                              const UnderlineInputBorder(
                                                //<-- SEE HERE
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.black54),
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
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              const Text(
                                                "*",
                                                style:
                                                TextStyle(color: Colors.red),
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
                                              enabledBorder:
                                              const UnderlineInputBorder(
                                                //<-- SEE HERE
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.black54),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),

                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Barcode Type",
                                                    style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize:
                                                            w * 0.03),
                                                        color:
                                                        primaryColor),
                                                  ),
                                                  SizedBox(height:20),

                                                  Container(
                                                    height: h * 0.04,
                                                    width: w * 0.430,
                                                    child: CustomDropdown(
                                                      hintText: "UPC",
                                                      borderSide: BorderSide(
                                                          color: primaryColor),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5),
                                                      fieldSuffixIcon: Icon(
                                                        Icons
                                                            .arrow_drop_down_outlined,
                                                        color: primaryColor,
                                                        size: h * 0.035,
                                                      ),

                                                      listItemStyle: TextStyle(
                                                          fontSize: w * 0.025),
                                                      selectedStyle: TextStyle(
                                                          fontSize: w * 0.025,
                                                          color: Colors.black),
                                                      fillColor: Color(0xffDBB8FF),
                                                      hintStyle: TextStyle(
                                                          fontSize: h * 0.015,
                                                          color: Colors.black),
                                                      items: barcodes,
                                                      controller: barcodeType,
                                                    ),
                                                  ),
                                                  SizedBox(height:25),
                                                ],
                                              ),
                                              SizedBox(
                                                width: w * 0.03,
                                              ),
                                              Container(
                                                height: h * 0.11,
                                                width: w * 0.430,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "MOQ",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize:
                                                                  w * 0.03),
                                                              color:
                                                              primaryColor),
                                                        ),
                                                        const Text(
                                                          "*",
                                                          style: TextStyle(
                                                              color: Colors.red),
                                                        ),
                                                      ],
                                                    ),
                                                    TextFormField(
                                                      controller: moq,
                                                      decoration: InputDecoration(
                                                        hintText:
                                                        "Minimum Qty Required",
                                                        hintStyle: TextStyle(
                                                            color: const Color(
                                                                0xffB3B3B3),
                                                            fontSize: h * 0.013),
                                                        enabledBorder:
                                                        const UnderlineInputBorder(
                                                          //<-- SEE HERE
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color:
                                                              Colors.black54),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                  children:[      Text(
                                                    "Barcode(Universal Product Code - 12 digits)",
                                                    style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize:
                                                            w * 0.03),
                                                        color:
                                                        primaryColor),
                                                  ),]
                                              ),
                                        
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(


                                                      controller: unit,
                                                      decoration: InputDecoration(
                                                        hintText: "Scan or Type Barcode",
                                                        hintStyle: TextStyle(
                                                            color: const Color(
                                                                0xffB3B3B3),
                                                            fontSize: h * 0.013),
                                                        enabledBorder:
                                                        const UnderlineInputBorder(
                                                          //<-- SEE HERE
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color:
                                                              Colors.black54),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SvgPicture.asset(
                                                    "assets/barcode.svg",
                                                    color: primaryColor,
                                                    height: h * 0.03,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: h * 0.11,
                                                width: w * 0.430,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Unit Count",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize:
                                                                  w * 0.03),
                                                              color:
                                                              primaryColor),
                                                        ),
                                                        const Text(
                                                          "*",
                                                          style: TextStyle(
                                                              color: Colors.red),
                                                        ),
                                                      ],
                                                    ),
                                                    TextFormField(
                                                      controller: unit,
                                                      decoration: InputDecoration(
                                                        hintText: "eg. Kg ,pcs",
                                                        hintStyle: TextStyle(
                                                            color: const Color(
                                                                0xffB3B3B3),
                                                            fontSize: h * 0.013),
                                                        enabledBorder:
                                                        const UnderlineInputBorder(
                                                          //<-- SEE HERE
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color:
                                                              Colors.black54),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: w * 0.03,
                                              ),


                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Count Type",
                                                    style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize:
                                                            w * 0.03),
                                                        color:
                                                        primaryColor),
                                                  ),
                                                  SizedBox(height:20),

                                                  Container(
                                                    height: h * 0.04,
                                                    width: w * 0.430,
                                                    child: CustomDropdown(
                                                      hintText: "Count",
                                                      borderSide: BorderSide(
                                                          color: primaryColor),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5),
                                                      fieldSuffixIcon: Icon(
                                                        Icons
                                                            .arrow_drop_down_outlined,
                                                        color: primaryColor,
                                                        size: h * 0.035,
                                                      ),

                                                      listItemStyle: TextStyle(
                                                          fontSize: w * 0.025),
                                                      selectedStyle: TextStyle(
                                                          fontSize: w * 0.025,
                                                          color: Colors.black),
                                                      fillColor: Color(0xffDBB8FF),
                                                      hintStyle: TextStyle(
                                                          fontSize: h * 0.015,
                                                          color: Colors.black),
                                                      items: count,
                                                      controller: countType,
                                                    ),
                                                  ),
                                                  SizedBox(height:25),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "is Product Expirable",
                                                        style: GoogleFonts.roboto(
                                                            textStyle: TextStyle(
                                                                fontSize:
                                                                w * 0.03),
                                                            color:
                                                            primaryColor),
                                                      ),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height:20),

                                                  Container(
                                                    height: h * 0.04,
                                                    width: w * 0.430,
                                                    child: CustomDropdown(
                                                      hintText: "Select",
                                                      borderSide: BorderSide(
                                                          color: primaryColor),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5),
                                                      fieldSuffixIcon: Icon(
                                                        Icons
                                                            .arrow_drop_down_outlined,
                                                        color: primaryColor,
                                                        size: h * 0.035,
                                                      ),

                                                      listItemStyle: TextStyle(
                                                          fontSize: w * 0.025),
                                                      selectedStyle: TextStyle(
                                                          fontSize: w * 0.025,
                                                          color: Colors.black),
                                                      fillColor: Color(0xffDBB8FF),
                                                      hintStyle: TextStyle(
                                                          fontSize: h * 0.015,
                                                          color: Colors.black),
                                                      items: expire1,
                                                      controller: expire,
                                                    ),
                                                  ),
                                                  SizedBox(height:25),
                                                ],
                                              ),
                                              SizedBox(
                                                width: w * 0.03,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Product Expiration Type",
                                                    style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize:
                                                            w * 0.03),
                                                        color:
                                                        primaryColor),
                                                  ),
                                                  SizedBox(height:20),

                                                  Container(
                                                    height: h * 0.04,
                                                    width: w * 0.430,
                                                    child: CustomDropdown(
                                                      hintText: "select",
                                                      borderSide: BorderSide(
                                                          color: primaryColor),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5),
                                                      fieldSuffixIcon: Icon(
                                                        Icons
                                                            .arrow_drop_down_outlined,
                                                        color: primaryColor,
                                                        size: h * 0.035,
                                                      ),

                                                      listItemStyle: TextStyle(
                                                          fontSize: w * 0.025),
                                                      selectedStyle: TextStyle(
                                                          fontSize: w * 0.025,
                                                          color: Colors.black),
                                                      fillColor: Color(0xffDBB8FF),
                                                      hintStyle: TextStyle(
                                                          fontSize: h * 0.015,
                                                          color: Colors.black),
                                                      items: expirationType,
                                                      controller: expireType,
                                                    ),
                                                  ),
                                                  SizedBox(height:25),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Shelf Life",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              const Text(
                                                "*",
                                                style:
                                                TextStyle(color: Colors.red),
                                              ),
                                            ],
                                          ),
                                          TextFormField(
                                            controller: shelf,
                                            decoration: InputDecoration(
                                              hintText:
                                              "Product Lifespan: How long will it last? eg. 2 year",
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
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Liquid Contents",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              const Text(
                                                "*",
                                                style:
                                                TextStyle(color: Colors.red),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),

                                          Container(
                                              child:Text(liquidContent==true?'Yes':'No')
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Divider(color:Colors.black,height:4),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Heat Sensitive",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              const Text(
                                                "*",
                                                style:
                                                TextStyle(color: Colors.red),
                                              ),
                                            ],
                                          ),
                                          TextFormField(
                                            controller: heatSensitive,
                                            decoration: InputDecoration(
                                              hintText:
                                              "heat sensitive",
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
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: h * 0.11,
                                                width: w * 0.430,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Date First Available",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize:
                                                                  w * 0.03),
                                                              color:
                                                              primaryColor),
                                                        ),
                                                        const Text(
                                                          "*",
                                                          style: TextStyle(
                                                              color: Colors.red),
                                                        ),
                                                      ],
                                                    ),
                                                    TextFormField(
                                                      onTap:() async {
                                                        picked = (await showDatePicker(
                                                            context: context,
                                                            initialDate: DateTime.now(),
                                                            firstDate: DateTime(2023),
                                                            lastDate: DateTime(2025)))!;
                                                        if (picked != null) {
                                                          dateAvaliable.text =
                                                              DateFormat('dd MM yyyy').format(picked!);
                                                        }
                                                      },
                                                      
                                                      controller: dateAvaliable,
                                                      decoration: InputDecoration(
                                                        hintText:
                                                        "",
                                                        hintStyle: TextStyle(
                                                            color: const Color(
                                                                0xffB3B3B3),
                                                            fontSize: h * 0.013),
                                                        enabledBorder:
                                                        const UnderlineInputBorder(
                                                          //<-- SEE HERE
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color:
                                                              Colors.black54),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: w * 0.03,
                                              ),
                                              Container(
                                                height: h * 0.11,
                                                width: w * 0.430,
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
                                                                  fontSize:
                                                                  w * 0.03),
                                                              color:
                                                              primaryColor),
                                                        ),
                                                        const Text(
                                                          "*",
                                                          style: TextStyle(
                                                              color: Colors.red),
                                                        ),
                                                      ],
                                                    ),
                                                    TextFormField(
                                                      controller: weight,
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(
                                                        hintText:
                                                        "weight",
                                                        hintStyle: TextStyle(
                                                            color: const Color(
                                                                0xffB3B3B3),
                                                            fontSize: h * 0.013),
                                                        enabledBorder:
                                                        const UnderlineInputBorder(
                                                          //<-- SEE HERE
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color:
                                                              Colors.black54),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Product Dimension(Product Package Diamensions)",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              const Text(
                                                "*",
                                                style:
                                                TextStyle(color: Colors.red),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: h * 0.10,
                                                width: w * 0.230,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: TextFormField(
                                                  controller: L,
                                                  decoration: InputDecoration(
                                                    hintText: "Length (cm) ",
                                                    hintStyle: TextStyle(
                                                        color: const Color(
                                                            0xffB3B3B3),
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
                                              ),
                                              SizedBox(
                                                width: w * 0.02,
                                              ),
                                              const Icon(Icons.close_rounded),
                                              SizedBox(
                                                width: w * 0.02,
                                              ),
                                              Container(
                                                height: h * 0.10,
                                                width: w * 0.230,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: TextFormField(
                                                  controller: B,
                                                  decoration: InputDecoration(
                                                    hintText: "Breadth (cm) ",
                                                    hintStyle: TextStyle(
                                                        color: const Color(
                                                            0xffB3B3B3),
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
                                              ),
                                              SizedBox(
                                                width: w * 0.02,
                                              ),
                                              const Icon(Icons.close_rounded),
                                              SizedBox(
                                                width: w * 0.02,
                                              ),
                                              Container(
                                                height: h * 0.10,
                                                width: w * 0.230,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: TextFormField(
                                                  controller: H,
                                                  decoration: InputDecoration(
                                                    hintText: "Heigth (cm) ",
                                                    hintStyle: TextStyle(
                                                        color: const Color(
                                                            0xffB3B3B3),
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
                                              ),
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Text(
                                                "Box Dimension(Shipping Box Size Of The Product )",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              const Text(
                                                "*",
                                                style:
                                                TextStyle(color: Colors.red),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: h * 0.10,
                                                width: w * 0.230,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: TextFormField(
                                                  controller: L,
                                                  decoration: InputDecoration(
                                                    hintText: "L (cm) ",
                                                    hintStyle: TextStyle(
                                                        color: const Color(
                                                            0xffB3B3B3),
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
                                              ),
                                              SizedBox(
                                                width: w * 0.02,
                                              ),
                                              const Icon(Icons.close_rounded),
                                              SizedBox(
                                                width: w * 0.02,
                                              ),
                                              Container(
                                                height: h * 0.10,
                                                width: w * 0.230,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: TextFormField(
                                                  controller: B,
                                                  decoration: InputDecoration(
                                                    hintText: "B (cm) ",
                                                    hintStyle: TextStyle(
                                                        color: const Color(
                                                            0xffB3B3B3),
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
                                              ),
                                              SizedBox(
                                                width: w * 0.02,
                                              ),
                                              const Icon(Icons.close_rounded),
                                              SizedBox(
                                                width: w * 0.02,
                                              ),
                                              Container(
                                                height: h * 0.10,
                                                width: w * 0.230,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: TextFormField(
                                                  controller: H,
                                                  decoration: InputDecoration(
                                                    hintText: "H (cm) ",
                                                    hintStyle: TextStyle(
                                                        color: const Color(
                                                            0xffB3B3B3),
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
                                              ),
                                            ],
                                          ),

                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: h * 0.11,
                                                width: w * 0.430,
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
                                                                  fontSize:
                                                                  w * 0.03),
                                                              color:
                                                              primaryColor),
                                                        ),
                                                        const Text(
                                                          "*",
                                                          style: TextStyle(
                                                              color: Colors.red),
                                                        ),
                                                      ],
                                                    ),
                                                    TextFormField(
                                                      controller: stock,
                                                      decoration: InputDecoration(
                                                        hintText:
                                                        " Stock Quantity",
                                                        hintStyle: TextStyle(
                                                            color: const Color(
                                                                0xffB3B3B3),
                                                            fontSize: h * 0.013),
                                                        enabledBorder:
                                                        const UnderlineInputBorder(
                                                          //<-- SEE HERE
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color:
                                                              Colors.black54),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: w * 0.03,
                                              ),
                                              Container(
                                                height: h * 0.11,
                                                width: w * 0.430,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Hsn Code",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize:
                                                                  w * 0.03),
                                                              color:
                                                              primaryColor),
                                                        ),
                                                        const Text(
                                                          "*",
                                                          style: TextStyle(
                                                              color: Colors.red),
                                                        ),
                                                      ],
                                                    ),
                                                    TextFormField(
                                                      controller: hsncode,
                                                      decoration: InputDecoration(
                                                        hintText:
                                                        "HSN of the product",
                                                        hintStyle: TextStyle(
                                                            color: const Color(
                                                                0xffB3B3B3),
                                                            fontSize: h * 0.013),
                                                        enabledBorder:
                                                        const UnderlineInputBorder(
                                                          //<-- SEE HERE
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color:
                                                              Colors.black54),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: h * 0.11,
                                                width: w * 0.430,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Warranty",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize:
                                                                  w * 0.03),
                                                              color:
                                                              primaryColor),
                                                        ),
                                                        const Text(
                                                          "*",
                                                          style: TextStyle(
                                                              color: Colors.red),
                                                        ),
                                                      ],
                                                    ),
                                                    TextFormField(
                                                      controller: prowarranty,
                                                      decoration: InputDecoration(
                                                        hintText:
                                                        "eg. 1 month/7 Days/ 1 Year",
                                                        hintStyle: TextStyle(
                                                            color: const Color(
                                                                0xffB3B3B3),
                                                            fontSize: h * 0.013),
                                                        enabledBorder:
                                                        const UnderlineInputBorder(
                                                          //<-- SEE HERE
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color:
                                                              Colors.black54),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: w * 0.03,
                                              ),
                                              Container(
                                                height: h * 0.11,
                                                width: w * 0.430,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Guaranty",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize:
                                                                  w * 0.03),
                                                              color:
                                                              primaryColor),
                                                        ),
                                                        const Text(
                                                          "*",
                                                          style: TextStyle(
                                                              color: Colors.red),
                                                        ),
                                                      ],
                                                    ),
                                                    TextFormField(
                                                      controller: proguranty,
                                                      decoration: InputDecoration(
                                                        hintText:
                                                        "1 month/7 Days/ 1 Year",
                                                        hintStyle: TextStyle(
                                                            color: const Color(
                                                                0xffB3B3B3),
                                                            fontSize: h * 0.013),
                                                        enabledBorder:
                                                        const UnderlineInputBorder(
                                                          //<-- SEE HERE
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color:
                                                              Colors.black54),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: h * 0.1,
                                                width: w * 0.430,
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
                                                                  fontSize:
                                                                  w * 0.03),
                                                              color:
                                                              primaryColor),
                                                        ),
                                                        //Text("*",style: TextStyle(color: Colors.red),),
                                                      ],
                                                    ),
                                                    TextFormField(
                                                      controller: sold,
                                                      readOnly: false,
                                                      decoration: InputDecoration(
                                                        hintText:
                                                        "JHG33434HHJKHK",
                                                        hintStyle: TextStyle(
                                                            color: const Color(
                                                                0xffB3B3B3),
                                                            fontSize: h * 0.013),
                                                        enabledBorder:
                                                        const UnderlineInputBorder(
                                                          //<-- SEE HERE
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color:
                                                              Colors.black54),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: w * 0.03,
                                              ),
                                              Container(
                                                height: h * 0.12,
                                                width: w * 0.430,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Qty Limit",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize:
                                                                  w * 0.03),
                                                              color:
                                                              primaryColor),
                                                        ),
                                                        const Text(
                                                          "*",
                                                          style: TextStyle(
                                                              color: Colors.red),
                                                        ),
                                                      ],
                                                    ),
                                                    TextFormField(
                                                      controller: qtylimit,
                                                      decoration: InputDecoration(
                                                        hintText:
                                                        "Qty Purchase Limit. ",
                                                        hintStyle: TextStyle(
                                                            color: const Color(
                                                                0xffB3B3B3),
                                                            fontSize: h * 0.013),
                                                        enabledBorder:
                                                        const UnderlineInputBorder(
                                                          //<-- SEE HERE
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color:
                                                              Colors.black54),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),

                                          Row(
                                            children: [
                                              Text(
                                                "Product Description",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              const Text(
                                                "*",
                                                style:
                                                TextStyle(color: Colors.red),
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
                                              enabledBorder:
                                              const UnderlineInputBorder(
                                                //<-- SEE HERE
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.black54),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Select Brand",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              SizedBox(
                                                width: w * 0.350,
                                              ),
                                              Text(
                                                "Request Brand",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          CustomDropdown(
                                            hintText: "brand",
                                            borderSide:
                                            BorderSide(color: primaryColor),
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
                                            items:  brand1.isEmpty?['']:brand1,
                                            controller: brand,
                                            onChanged: (text) {
                                              setState(() {});
                                            },
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Parent Category",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          CustomDropdown(
                                            hintText: "Parent Category",
                                            borderSide:
                                            BorderSide(color: primaryColor),
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
                                            items: parentCategory,
                                            controller: parentCat,
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                            children: [
                                              Text(
                                                "Category",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              const Text(
                                                "*",
                                                style:
                                                TextStyle(color: Colors.red),
                                              ),
                                              SizedBox(
                                                width: w * 0.350,
                                              ),
                                              Text(
                                                "Request Category",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          CustomDropdown(
                                            hintText: "category",
                                            borderSide:
                                            BorderSide(color: primaryColor),
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
                                            items: category1,
                                            controller: category,
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),

                                          Row(
                                            children: [
                                              Text(
                                                "Child Category",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          CustomDropdown(
                                            hintText: "child category",
                                            borderSide:
                                            BorderSide(color: primaryColor),
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
                                            items: childcat1,
                                            controller: childcat,
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Ingredients",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              const Text(
                                                "*",
                                                style:
                                                TextStyle(color: Colors.red),
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
                                              enabledBorder:
                                              const UnderlineInputBorder(
                                                //<-- SEE HERE
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.black54),
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
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              const Text(
                                                "*",
                                                style:
                                                TextStyle(color: Colors.red),
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
                                              enabledBorder:
                                              const UnderlineInputBorder(
                                                //<-- SEE HERE
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.black54),
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
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              const Text(
                                                "*",
                                                style:
                                                TextStyle(color: Colors.red),
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
                                              enabledBorder:
                                              const UnderlineInputBorder(
                                                //<-- SEE HERE
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.black54),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "FSSAI LIC NO",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              const Text(
                                                "*",
                                                style:
                                                TextStyle(color: Colors.red),
                                              ),
                                            ],
                                          ),
                                          TextFormField(
                                            controller: fssai,
                                            decoration: InputDecoration(
                                              hintText:
                                              "Enter your FSSAI License Number",
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
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Made From",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              const Text(
                                                "*",
                                                style:
                                                TextStyle(color: Colors.red),
                                              ),
                                            ],
                                          ),
                                          TextFormField(
                                            controller: madefrom,
                                            decoration: InputDecoration(
                                              hintText:
                                              "Product Origin  eg.India",
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
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Product Variation",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              const Text(
                                                "*",
                                                style:
                                                TextStyle(color: Colors.red),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.01,
                                          ),
                                          const Text(
                                            "Product Variation Enabled! Select it attributes.",
                                            style: TextStyle(
                                                color: Color(0xff979797)),
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
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
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Color",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              SizedBox(
                                                width: w * 0.33,
                                              ),
                                              Container(
                                                height: h * 0.045,
                                                width: w * 0.470,
                                                child: CustomDropdown(
                                                  hintText: "Color",
                                                  borderSide: BorderSide(
                                                      color: primaryColor),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      5),
                                                  fieldSuffixIcon: Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                    color: primaryColor,
                                                    size: h * 0.035,
                                                  ),
                                                  listItemStyle: TextStyle(
                                                      fontSize: w * 0.025),
                                                  selectedStyle: TextStyle(
                                                      fontSize: w * 0.025,
                                                      color: Colors.black),
                                                  fillColor: Colors.white,
                                                  hintStyle: TextStyle(
                                                      fontSize: h * 0.015,
                                                      color: Colors.black),
                                                  items: color1,
                                                  controller: color,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          // Align(alignment:Alignment.topRight,child: Text("Add Attributes",style: TextStyle(color: primaryColor),)),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Attributes",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              SizedBox(
                                                width: w * 0.25,
                                              ),
                                              Container(
                                                height: h * 0.045,
                                                width: w * 0.470,
                                                child: CustomDropdown(
                                                  hintText: "Attributes",
                                                  borderSide: BorderSide(
                                                      color: primaryColor),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      5),
                                                  fieldSuffixIcon: Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                    color: primaryColor,
                                                    size: h * 0.035,
                                                  ),
                                                  listItemStyle: TextStyle(
                                                      fontSize: w * 0.025),
                                                  selectedStyle: TextStyle(
                                                      fontSize: w * 0.025,
                                                      color: Colors.black),
                                                  fillColor: Colors.white,
                                                  hintStyle: TextStyle(
                                                      fontSize: h * 0.015,
                                                      color: Colors.black),
                                                  items: attributes1,
                                                  controller: attributes,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          // Align(alignment:Alignment.topRight,child: Text("Add Value",style: TextStyle(color: primaryColor),)),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Attributes Value",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              SizedBox(
                                                width: w * 0.14,
                                              ),
                                              Container(
                                                height: h * 0.045,
                                                width: w * 0.470,
                                                child: CustomDropdown(
                                                  hintText: "Attributes value",
                                                  borderSide: BorderSide(
                                                      color: primaryColor),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      5),
                                                  fieldSuffixIcon: Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                    color: primaryColor,
                                                    size: h * 0.035,
                                                  ),
                                                  listItemStyle: TextStyle(
                                                      fontSize: w * 0.025),
                                                  selectedStyle: TextStyle(
                                                      fontSize: w * 0.025,
                                                      color: Colors.black),
                                                  fillColor: Colors.white,
                                                  hintStyle: TextStyle(
                                                      fontSize: h * 0.015,
                                                      color: Colors.black),
                                                  items: attrivalue1,
                                                  controller: attrivalue,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                "Add Tax Category %",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              )),
                                          SizedBox(
                                            height: h * 0.01,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "GST %",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              SizedBox(
                                                width: w * 0.45,
                                              ),
                                              Container(
                                                height: h * 0.045,
                                                width: w * 0.300,
                                                child: CustomDropdown(
                                                  hintText: "Tax",
                                                  borderSide: BorderSide(
                                                      color: primaryColor),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      5),
                                                  fieldSuffixIcon: Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                    color: primaryColor,
                                                    size: h * 0.035,
                                                  ),
                                                  listItemStyle: TextStyle(
                                                      fontSize: w * 0.025),
                                                  selectedStyle: TextStyle(
                                                      fontSize: w * 0.025,
                                                      color: Colors.black),
                                                  fillColor: Colors.white,
                                                  hintStyle: TextStyle(
                                                      fontSize: h * 0.015,
                                                      color: Colors.black),
                                                  items: gst1,
                                                  controller: gst,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height:h *0.02,),
                                          Row(

                                            children: [

                                              Text("Select B2C Shipping Profile ",style: TextStyle(color: primaryColor),),
                                              Text("*",style: TextStyle(color: Colors.red),),


                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(height: h*0.002,width: w*0.540,child: ColoredBox(color: primaryColor), ),
                                              SizedBox(height: h*0.002,width: w*0.330,child: ColoredBox(color: Colors.grey.shade200), ),



                                            ],
                                          ),
                                          SizedBox(height: h*0.02,),
                                          CustomDropdown(

                                            hintText: "child category",
                                            borderSide: BorderSide(color:primaryColor),
                                            borderRadius: BorderRadius.circular(h * 0.01),
                                            fieldSuffixIcon: Icon(
                                              Icons.arrow_drop_down_outlined,
                                              color: primaryColor,
                                              size: h * 0.035,
                                            ),
                                            listItemStyle: TextStyle(fontSize: w * 0.025),
                                            selectedStyle: TextStyle(
                                                fontSize: w * 0.025, color: Colors.black),
                                            fillColor: Colors.white,
                                            hintStyle: TextStyle(
                                                fontSize: h * 0.015, color: Colors.black),
                                            items: gst1,
                                            controller: gst,
                                          ),
                                          SizedBox(height: h*0.02,),

                                          Row(
                                            children: [
                                              Text("*",style: TextStyle(color: Colors.red),),

                                              Text("Tharacart default B2C shipping calculation is used.",style: TextStyle(fontSize: h*0.013,color: Color(0xff979797
                                              )),),
                                            ],
                                          ),
                                          SizedBox(height: h*0.02,),
                                          // Text("Select one shipping carrier ",style: TextStyle(color: primaryColor),),
                                          // Row(
                                          //   children: [
                                          //     SizedBox(height: h*0.002,width: w*0.540,child: ColoredBox(color: primaryColor), ),
                                          //     SizedBox(height: h*0.002,width: w*0.330,child: ColoredBox(color: Colors.grey.shade200), ),
                                          //   ],
                                          // ),
                                          // RadioListTile(
                                          //   activeColor:Colors.green,
                                          //   title: Text("Ship Rocket"),
                                          //   value: "Ship Rocket",
                                          //   groupValue: typeId,
                                          //   onChanged: (value){
                                          //     setState(() {
                                          //       typeId = value.toString();
                                          //     });
                                          //   },
                                          // ),
                                          // RadioListTile(
                                          //     activeColor:Colors.green,
                                          //   title: Text("Delhivery"),
                                          //   value: "Delhivery",
                                          //   groupValue: typeId,
                                          //   onChanged: (value){
                                          //     setState(() {
                                          //       typeId = value.toString();
                                          //     });
                                          //   },
                                          // ),
                                          // RadioListTile(
                                          //   activeColor:Colors.green,
                                          //   title: Text("XpressBees"),
                                          //   value: "XpressBees",
                                          //   groupValue: typeId,
                                          //   onChanged: (value){
                                          //     setState(() {
                                          //       typeId = value.toString();
                                          //     });
                                          //   },
                                          // ),
                                          SizedBox(height: h*0.02,),

                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Gift Wrap Charges (Enter '0' for free)",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: primaryColor),
                                              ),
                                              const Text(
                                                "*",
                                                style:
                                                TextStyle(color: Colors.red),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 150),
                                            child: TextFormField(
                                              controller: giftWrapCharge,
                                              decoration: InputDecoration(
                                                hintText:
                                                "0.0",
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
                                            height: h * 0.02,
                                          ),
                                          Row(children: [
                                            Text("Group Pricing ",style: TextStyle(color: primaryColor),),
                                            Text("*",style: TextStyle(color: Colors.red),),
                                            SizedBox(width: w*0.350,),
                                            FlutterSwitch(
                                              activeColor: Color(0xff66BD46),
                                              width: w*0.13,
                                              height: h*0.035,
                                              valueFontSize: 0.0,
                                              toggleSize: 15.0,
                                              value: Gpricing,
                                              borderRadius: 30.0,
                                              padding: 8.0,
                                              onToggle: (val) {
                                                setState(() {
                                                  Gpricing = val;
                                                });
                                              },
                                            ),

                                          ],),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("B2C Global price ",
                                                    style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize: w * 0.03),
                                                        color: const Color(
                                                            0xff298E03))),
                                                const Text(
                                                  "*",
                                                  style: TextStyle(
                                                      color: Colors.red),
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
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: w * 0.40,
                                                child: TextFormField(
                                                  controller: price,
                                                  decoration: InputDecoration(
                                                    hintText: "Price",
                                                    hintStyle: TextStyle(
                                                        color: const Color(
                                                            0xffB3B3B3),
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
                                                  controller: discountprice,
                                                  decoration: InputDecoration(
                                                    hintText: "Discount Price",
                                                    hintStyle: TextStyle(
                                                        color: const Color(
                                                            0xffB3B3B3),
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
                                            height: h * 0.02,
                                          ),

                                          ExpansionTile(
                                            initiallyExpanded: true,
                                            title: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "Variants ",
                                                    style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize: w * 0.03,
                                                            fontWeight: FontWeight.bold),
                                                        color: primaryColor),
                                                  ),
                                                  // SizedBox(
                                                  //   width: w * 0.02,
                                                  // ),
                                                  SizedBox(
                                                    height: h * 0.0015,
                                                    width: w * 0.58,
                                                    child: ColoredBox(
                                                      color: primaryColor,
                                                    ),
                                                  ),
                                                ]),
                                            children: [
                                              // SizedBox(
                                              //   width: w * 0.02,
                                              // ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "1 L",
                                                    style: GoogleFonts.roboto(
                                                        textStyle:
                                                        TextStyle(fontSize: w * 0.03),
                                                        color: primaryColor),
                                                  ),
                                                  SizedBox(
                                                    width: w * 0.02,
                                                  ),
                                                  Container(
                                                    width: w * 0.25,
                                                    child: TextFormField(
                                                      controller: oneLprice,
                                                      decoration: InputDecoration(
                                                        hintText: "Price",
                                                        hintStyle: TextStyle(
                                                            color:
                                                            const Color(0xffB3B3B3),
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
                                                    width: w * 0.02,
                                                  ),
                                                  Container(
                                                    width: w * 0.25,
                                                    child: TextFormField(
                                                      controller: onesku,
                                                      decoration: InputDecoration(
                                                        hintText: "SKU",
                                                        hintStyle: TextStyle(
                                                            color:
                                                            const Color(0xffB3B3B3),
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
                                                    width: w * 0.02,
                                                  ),
                                                  Container(
                                                    width: w * 0.25,
                                                    child: TextFormField(
                                                      controller: onestock,
                                                      decoration: InputDecoration(
                                                        hintText: "Stock Qty",
                                                        hintStyle: TextStyle(
                                                            color:
                                                            const Color(0xffB3B3B3),
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
                                              ImageList!.length != 0
                                                  ? Container(
                                                height: h * 0.12,
                                                child: ListView.separated(
                                                  shrinkWrap: true,
                                                  itemCount: ImageList!.length,
                                                  scrollDirection: Axis.horizontal,
                                                  itemBuilder: (context, index) {
                                                    return Stack(
                                                      clipBehavior: Clip.none,
                                                      children: [
                                                        ImageList![index] == null
                                                            ? Container(
                                                          width: w * 0.18,
                                                          height: h * 0.10,
                                                          decoration:
                                                          const BoxDecoration(
                                                            color: Color(
                                                                0xffE9E9E9),
                                                          ),
                                                        )
                                                            : Container(
                                                          width: w * 0.21,
                                                          height: h * 0.15,
                                                          decoration:
                                                          BoxDecoration(
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    ImageList![
                                                                    index]),
                                                                fit: BoxFit
                                                                    .cover),
                                                            color: const Color(
                                                                0xffE9E9E9),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: w * 0.096,
                                                          bottom: h * 0.090,
                                                          child: InkWell(
                                                            onTap: () {
                                                              ImageList!.removeAt(
                                                                  index);
                                                              setState(() {});
                                                            },
                                                            child: Container(
                                                              width: w * 0.2,
                                                              height: h * 0.035,
                                                              child: const Icon(
                                                                Icons.clear,
                                                                color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    254,
                                                                    253,
                                                                    255),
                                                                size: 22,
                                                              ),
                                                              decoration:
                                                              const BoxDecoration(
                                                                  color: Color(
                                                                      0xff8C31FF),
                                                                  shape: BoxShape
                                                                      .circle),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                      int index) {
                                                    return SizedBox(
                                                      width: 20,
                                                    );
                                                  },
                                                ),
                                              )
                                                  : Container(
                                                  color: Colors.grey.shade200,
                                                  height: h * 0.12,
                                                  width: double.maxFinite,
                                                  child: Center(
                                                    child: Text('Choose Image',
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: 18,color:Colors.grey.shade700)),
                                                  )),
                                              SizedBox(
                                                height: h * 0.02,
                                              ),
                                              Stack(children: [
                                                Container(
                                                    height: h * 0.05,
                                                    width: w * 0.700,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(5),
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: primaryColor)),
                                                    child: Center(
                                                        child: Text(
                                                          "Select Photo",
                                                          style:
                                                          TextStyle(color: primaryColor),
                                                        ))),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: InkWell(
                                                    onTap: () {
                                                      showAlertDialogue(ImageList!);
                                                    },
                                                    child: Container(
                                                        height: h * 0.05,
                                                        width: w * 0.300,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(5),
                                                            color: primaryColor,
                                                            border: Border.all(
                                                                color: primaryColor)),
                                                        child: const Center(
                                                            child: Text(
                                                              "Upload",
                                                              style: TextStyle(
                                                                  color: Colors.white),
                                                            ))),
                                                  ),
                                                ),
                                              ]),
                                              SizedBox(
                                                width: w * 0.01,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "2 L",
                                                    style: GoogleFonts.roboto(
                                                        textStyle:
                                                        TextStyle(fontSize: w * 0.03),
                                                        color: primaryColor),
                                                  ),
                                                  SizedBox(
                                                    width: w * 0.01,
                                                  ),
                                                  Container(
                                                    width: w * 0.25,
                                                    child: TextFormField(
                                                      controller: twoprice,
                                                      decoration: InputDecoration(
                                                        hintText: "Price",
                                                        hintStyle: TextStyle(
                                                            color:
                                                            const Color(0xffB3B3B3),
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
                                                    width: h * 0.02,
                                                  ),
                                                  Container(
                                                    width: w * 0.25,
                                                    child: TextFormField(
                                                      controller: twosku,
                                                      decoration: InputDecoration(
                                                        hintText: "SKU",
                                                        hintStyle: TextStyle(
                                                            color:
                                                            const Color(0xffB3B3B3),
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
                                                    width: w * 0.02,
                                                  ),
                                                  Container(
                                                    width: w * 0.25,
                                                    child: TextFormField(
                                                      controller: twostock,
                                                      decoration: InputDecoration(
                                                        hintText: "Stock Qty",
                                                        hintStyle: TextStyle(
                                                            color:
                                                            const Color(0xffB3B3B3),
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
                                              ImageList1!.length != 0
                                                  ? Container(
                                                height: h * 0.12,
                                                child: ListView.separated(
                                                  shrinkWrap: true,
                                                  itemCount: ImageList1!.length,
                                                  scrollDirection: Axis.horizontal,
                                                  itemBuilder: (context, index) {
                                                    return Stack(
                                                      clipBehavior: Clip.none,
                                                      children: [
                                                        ImageList1![index] == null
                                                            ? Container(
                                                          width: w * 0.18,
                                                          height: h * 0.10,
                                                          decoration:
                                                          const BoxDecoration(
                                                            color: Color(
                                                                0xffE9E9E9),
                                                          ),
                                                        )
                                                            : Container(
                                                          width: w * 0.21,
                                                          height: h * 0.15,
                                                          decoration:
                                                          BoxDecoration(
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    ImageList1![
                                                                    index]),
                                                                fit: BoxFit
                                                                    .cover),
                                                            color: const Color(
                                                                0xffE9E9E9),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: w * 0.096,
                                                          bottom: h * 0.090,
                                                          child: InkWell(
                                                            onTap: () {
                                                              ImageList1!.removeAt(
                                                                  index);
                                                              setState(() {});
                                                            },
                                                            child: Container(
                                                              width: w * 0.2,
                                                              height: h * 0.035,
                                                              child: const Icon(
                                                                Icons.clear,
                                                                color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    254,
                                                                    253,
                                                                    255),
                                                                size: 22,
                                                              ),
                                                              decoration:
                                                              const BoxDecoration(
                                                                  color: Color(
                                                                      0xff8C31FF),
                                                                  shape: BoxShape
                                                                      .circle),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                      int index) {
                                                    return SizedBox(
                                                      width: 20,
                                                    );
                                                  },
                                                ),
                                              )
                                                  : Container(
                                                  color: Colors.grey.shade200,
                                                  height: h * 0.12,
                                                  width: double.maxFinite,
                                                  child: Center(
                                                    child: Text('Choose Image',
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: 18,color:Colors.grey.shade700)),
                                                  )),
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.spaceEvenly,
                                              //   children: [
                                              //     Stack(
                                              //       clipBehavior: Clip.none,
                                              //       children: [
                                              //         image == null
                                              //             ? Container(
                                              //                 width: w * 0.18,
                                              //                 height: h * 0.10,
                                              //                 decoration:
                                              //                     const BoxDecoration(
                                              //                   color:
                                              //                       Color(0xffE9E9E9),
                                              //                 ),
                                              //               )
                                              //             : Container(
                                              //                 width: w * 0.2,
                                              //                 height: h * 0.10,
                                              //                 decoration: BoxDecoration(
                                              //                   image: DecorationImage(
                                              //                       image: FileImage(
                                              //                           image!),
                                              //                       fit: BoxFit.cover),
                                              //                   color: const Color(
                                              //                       0xffE9E9E9),
                                              //                 ),
                                              //               ),
                                              //         Positioned(
                                              //           left: w * 0.065,
                                              //           bottom: h * 0.0650,
                                              //           child: InkWell(
                                              //             onTap: () {
                                              //               image = null;
                                              //               setState(() {});
                                              //             },
                                              //             child: Container(
                                              //               width: w * 0.2,
                                              //               height: h * 0.04,
                                              //               child: const Icon(
                                              //                 Icons.clear,
                                              //                 color: Color.fromARGB(
                                              //                     255, 254, 253, 255),
                                              //                 size: 30,
                                              //               ),
                                              //               decoration:
                                              //                   const BoxDecoration(
                                              //                       color: Color(
                                              //                           0xff8C31FF),
                                              //                       shape: BoxShape
                                              //                           .circle),
                                              //             ),
                                              //           ),
                                              //         )
                                              //       ],
                                              //     ),
                                              //     SizedBox(
                                              //       width: w * 0.02,
                                              //     ),
                                              //     Stack(
                                              //       clipBehavior: Clip.none,
                                              //       children: [
                                              //         image == null
                                              //             ? Container(
                                              //                 width: w * 0.18,
                                              //                 height: h * 0.10,
                                              //                 decoration:
                                              //                     const BoxDecoration(
                                              //                   color:
                                              //                       Color(0xffE9E9E9),
                                              //                 ),
                                              //               )
                                              //             : Container(
                                              //                 width: w * 0.2,
                                              //                 height: h * 0.10,
                                              //                 decoration: BoxDecoration(
                                              //                   image: DecorationImage(
                                              //                       image: FileImage(
                                              //                           image!),
                                              //                       fit: BoxFit.cover),
                                              //                   color: const Color(
                                              //                       0xffE9E9E9),
                                              //                 ),
                                              //               ),
                                              //         Positioned(
                                              //           left: w * 0.065,
                                              //           bottom: h * 0.0650,
                                              //           child: InkWell(
                                              //             onTap: () {
                                              //               image = null;
                                              //               setState(() {});
                                              //             },
                                              //             child: Container(
                                              //               width: w * 0.2,
                                              //               height: h * 0.04,
                                              //               child: const Icon(
                                              //                 Icons.clear,
                                              //                 color: Color.fromARGB(
                                              //                     255, 254, 253, 255),
                                              //                 size: 30,
                                              //               ),
                                              //               decoration:
                                              //                   const BoxDecoration(
                                              //                       color: Color(
                                              //                           0xff8C31FF),
                                              //                       shape: BoxShape
                                              //                           .circle),
                                              //             ),
                                              //           ),
                                              //         )
                                              //       ],
                                              //     ),
                                              //     SizedBox(
                                              //       width: w * 0.02,
                                              //     ),
                                              //     Stack(
                                              //       clipBehavior: Clip.none,
                                              //       children: [
                                              //         image == null
                                              //             ? Container(
                                              //                 width: w * 0.18,
                                              //                 height: h * 0.10,
                                              //                 decoration:
                                              //                     const BoxDecoration(
                                              //                   color:
                                              //                       Color(0xffE9E9E9),
                                              //                 ),
                                              //               )
                                              //             : Container(
                                              //                 width: w * 0.2,
                                              //                 height: h * 0.10,
                                              //                 decoration: BoxDecoration(
                                              //                   image: DecorationImage(
                                              //                       image: FileImage(
                                              //                           image!),
                                              //                       fit: BoxFit.cover),
                                              //                   color: const Color(
                                              //                       0xffE9E9E9),
                                              //                 ),
                                              //               ),
                                              //         Positioned(
                                              //           left: w * 0.065,
                                              //           bottom: h * 0.0650,
                                              //           child: InkWell(
                                              //             onTap: () {
                                              //               image = null;
                                              //               setState(() {});
                                              //             },
                                              //             child: Container(
                                              //               width: w * 0.2,
                                              //               height: h * 0.04,
                                              //               child: const Icon(
                                              //                 Icons.clear,
                                              //                 color: Color.fromARGB(
                                              //                     255, 254, 253, 255),
                                              //                 size: 30,
                                              //               ),
                                              //               decoration:
                                              //                   const BoxDecoration(
                                              //                       color: Color(
                                              //                           0xff8C31FF),
                                              //                       shape: BoxShape
                                              //                           .circle),
                                              //             ),
                                              //           ),
                                              //         )
                                              //       ],
                                              //     ),
                                              //     SizedBox(
                                              //       width: w * 0.01,
                                              //     ),
                                              //     Stack(
                                              //       clipBehavior: Clip.none,
                                              //       children: [
                                              //         image == null
                                              //             ? Container(
                                              //                 width: w * 0.18,
                                              //                 height: h * 0.10,
                                              //                 decoration:
                                              //                     const BoxDecoration(
                                              //                   color:
                                              //                       Color(0xffE9E9E9),
                                              //                 ),
                                              //               )
                                              //             : Container(
                                              //                 width: w * 0.2,
                                              //                 height: h * 0.10,
                                              //                 decoration: BoxDecoration(
                                              //                   image: DecorationImage(
                                              //                       image: FileImage(
                                              //                           image!),
                                              //                       fit: BoxFit.cover),
                                              //                   color: const Color(
                                              //                       0xffE9E9E9),
                                              //                 ),
                                              //               ),
                                              //         Positioned(
                                              //           left: w * 0.065,
                                              //           bottom: h * 0.0650,
                                              //           child: InkWell(
                                              //             onTap: () {
                                              //               image = null;
                                              //               setState(() {});
                                              //             },
                                              //             child: Container(
                                              //               width: w * 0.2,
                                              //               height: h * 0.04,
                                              //               child: const Icon(
                                              //                 Icons.clear,
                                              //                 color: Color.fromARGB(
                                              //                     255, 254, 253, 255),
                                              //                 size: 30,
                                              //               ),
                                              //               decoration:
                                              //                   const BoxDecoration(
                                              //                       color: Color(
                                              //                           0xff8C31FF),
                                              //                       shape: BoxShape
                                              //                           .circle),
                                              //             ),
                                              //           ),
                                              //         )
                                              //       ],
                                              //     ),
                                              //   ],
                                              // ),
                                              SizedBox(
                                                height: h * 0.02,
                                              ),
                                              Stack(children: [
                                                Container(
                                                    height: h * 0.05,
                                                    width: w * 0.800,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(5),
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: primaryColor)),
                                                    child: Center(
                                                        child: Text(
                                                          "Select Photo",
                                                          style:
                                                          TextStyle(color: primaryColor),
                                                        ))),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: InkWell(
                                                    onTap: () {
                                                      showAlertDialogue(ImageList1!);
                                                    },
                                                    child: Container(
                                                        height: h * 0.05,
                                                        width: w * 0.300,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(5),
                                                            color: primaryColor,
                                                            border: Border.all(
                                                                color: primaryColor)),
                                                        child: Center(
                                                            child: Text(
                                                              "Upload",
                                                              style: TextStyle(
                                                                  color: Colors.white),
                                                            ))),
                                                  ),
                                                ),
                                              ])
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "Enable Affiliate Program ",
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                      fontSize: w * 0.03),
                                                ),
                                              ),
                                              SizedBox(
                                                width: w * 0.180,
                                              ),
                                              FlutterSwitch(
                                                activeColor:
                                                const Color(0xff66BD46),
                                                width: w * 0.13,
                                                height: h * 0.035,
                                                valueFontSize: 0.0,
                                                toggleSize: 15.0,
                                                value: AffiliatedP,
                                                borderRadius: 30.0,
                                                padding: 8.0,
                                                onToggle: (val) {
                                                  setState(() {
                                                    AffiliatedP = val;
                                                  });
                                                },
                                              ),
                                              Text(AffiliatedP == true
                                                  ? "Active"
                                                  : "Inactive")
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.04,
                                          ),
                                          Text(
                                            "Commission for this product",
                                            style: GoogleFonts.roboto(
                                              textStyle:
                                              TextStyle(fontSize: w * 0.03),
                                            ),
                                          ),
                                          Divider(
                                            height: h * 0.02,
                                            thickness: h * 0.0015,
                                            color: const Color(0xffDADADA),
                                          ),
                                          SizedBox(
                                            height: h * 0.04,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: h * 0.05,
                                                width: w * 0.400,
                                                child: CustomDropdown(
                                                  hintText: "select",
                                                  borderSide: BorderSide(
                                                      color: primaryColor),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      5),
                                                  fieldSuffixIcon: Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                    color: primaryColor,
                                                    size: h * 0.035,
                                                  ),
                                                  listItemStyle: TextStyle(
                                                      fontSize: w * 0.025),
                                                  selectedStyle: TextStyle(
                                                      fontSize: w * 0.025,
                                                      color: Colors.black),
                                                  fillColor: Colors.white,
                                                  hintStyle: TextStyle(
                                                      fontSize: h * 0.015,
                                                      color: Colors.black),
                                                  items: Commission2,
                                                  controller: Commission1,
                                                ),
                                              ),
                                              SizedBox(
                                                width: w * 0.04,
                                              ),
                                              Container(
                                                width: w * 0.40,
                                                child: TextFormField(
                                                  controller: percentage,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                    "Enter percentage eg.5 (No Symbols)",
                                                    hintStyle: TextStyle(
                                                        color: const Color(
                                                            0xffB3B3B3),
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
                                            height: h * 0.02,
                                          ),
                                          Stack(children: [
                                            Container(
                                              height: h * 0.06,
                                              width: w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: primaryColor),
                                                  color: Colors.white,
                                                  borderRadius:
                                                  BorderRadius.circular(5)),
                                              child: const Center(
                                                  child: Text(
                                                    "Select Related Products ",
                                                    style: TextStyle(
                                                        color: Color(0xffB3B3B3)),
                                                  )),
                                            ),
                                            Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                    onPressed: () {},
                                                    icon:
                                                    const Icon(Icons.menu))),
                                          ]),
                                          SizedBox(
                                            height: h * 0.04,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Media()
                            ]),
                          ),
                        )
                      ])),
              SizedBox(
                height: h * 0.02,
              ),


              AddproductTab == false
                  ? Padding(
                padding: EdgeInsets.only(left: w * 0.1, right: w * 0.1),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {

                        if(productname.text!=''&&productcode.text!=""&&stock.text!=""&&hsncode.text!=''&&
                            description.text!=''&&weight.text!='')
                        {
                          {
                            await showDialog(context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      title: Text(
                                          'Add Product?'),
                                      content: Text(
                                          'Do you want to Continue?'),
                                      actions: [
                                        TextButton(
                                            child: Text(
                                              'Cancel',style: TextStyle(color: primaryColor),),
                                            onPressed: () {
                                              Navigator.of(
                                                  context)
                                                  .pop();
                                            }),
                                        TextButton(
                                            child: Text('Ok',style: TextStyle(color: primaryColor),),
                                            onPressed: () async {
                                              var UpdateProduct = AddProductModel(
                                                exchangable: exchangable,
                                                expirable: exchangable,
                                                giftWrap: giftWrap,
                                                liquidContents: liquidContent,
                                                sale: sales,
                                                date: DateTime.now(),
                                                vendorId: currentUser?.id,
                                                available:false,
                                                b2b: B2b,
                                                b2c: B2c,
                                                b2bDelhiD:0,
                                                b2bDelhiP:0,
                                                b2bDelhiTier:[],
                                                b2bKeralaD:0,
                                                b2bKeralaP:0,
                                                b2bKeralaTier:[],
                                                b2bTamilnaduD:0,
                                                b2bTamilnaduP:0,
                                                b2bTamilnaduTier:[],
                                                b2bTier:[],
                                                branchId:'',
                                                fives:0,
                                                fours:0,
                                                imageId:[],
                                                ones:0,
                                                open:false,
                                                relatedProducts:[],
                                                sales:false,
                                                search:[],
                                                start:0,
                                                step:0,
                                                stop:0,
                                                threes:0,
                                                totalReviews:0,
                                                twos:0,
                                                userId:'',
                                                videoUrl:[],
                                                imported: imported,
                                                payOnDelivery: COD,
                                                nonveg: nonveg,
                                                veg: veg,
                                                Returnable: Returnable,
                                                cancellable: Cancellable,
                                                refundable: Refundable,
                                                barcode: Barcode,
                                                warranty: Warranty,
                                                guaranty: Guaranty,
                                                variableproduct: VariableProduct,
                                                managestock: ManageStock,
                                                minimumqty: MinimumQty,
                                                qtylimit: QtyLimit,
                                                sellername: currentUser!.Fullname,
                                                name: productname.text,
                                                productCode: productcode.text,
                                                productbarcode: productBarcode.text,
                                                moq: moq.text,
                                                unit: unit.text,
                                                weight: int.tryParse(weight.text),
                                                stock: int.tryParse(stock.text),
                                                hsnCode: int.tryParse(hsncode.text),
                                                prowarranty: prowarranty.text,
                                                proGuaranty: proguranty.text,
                                                sold: int.tryParse(sold.text),
                                                qutlimit: int.tryParse(qtylimit.text) ,
                                                productdimensionL:double.tryParse(L.text) ,
                                                productdimensionB:double.tryParse(B.text) ,
                                                productdimensionH: double.tryParse(H.text),
                                                description: description.text,
                                                brand: brandNametoId[brandvalue],
                                                category: category.text,
                                                categoryName: category.text,
                                                subcategory: parentCat.text,
                                                childcategory: childcat.text,
                                                ingredients: ingredients.text,
                                                fact: nutrition.text,
                                                intructions: instruction.text,
                                                fssailicno: fssai.text,
                                                shelflife: shelf.text,
                                                madeFrom: madefrom.text,
                                                color: color.text,
                                                attributes: attributes.text,
                                                attributesvalue: attrivalue.text,
                                                gst: int.tryParse(gst.text),
                                                b2cP:double.tryParse(price.text),
                                                b2cD: double.tryParse(discountprice.text),
                                                variants1Lprice: oneLprice.text,
                                                variants1Lsku: onesku.text,
                                                variants1Lstockqut: onestock.text,
                                                variants2Lprice: twoprice.text,
                                                variants2Lsku: twosku.text,
                                                variants2Lstockqut: twostock.text,
                                                enableaffiliate: AffiliatedP,
                                                commission: double.tryParse(Commission1.text),
                                                commissiontext: int.tryParse(percentage.text),
                                                expireType: expireType.text,
                                                heatSensitive: heatSensitive.text,
                                                giftWrapCharge: double.tryParse(giftWrapCharge.text),

                                              );
                                              FirebaseFirestore.instance
                                                  .collection("products")
                                                  .add(UpdateProduct.toJson())
                                                  .then((value) {
                                                value.update({"productId": value.id}).then((val) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Media(pId: value.id)));
                                                });
                                              });
                                              showUploadMessage(context, 'Product Added Successfully',);
                                              productname.text=='';
                                              productcode.text=='';
                                              stock.text=='';
                                              hsncode.text=='';
                                              description.text=='';
                                              weight.text=='';
                                              productBarcode.text=='';
                                              moq.text=='';
                                              unit.text=='';
                                              prowarranty.text=='';
                                              proguranty.text=='';
                                              sold.text=='';
                                              qtylimit.text=='';
                                              L.text=='';
                                              B.text=='';
                                              H.text=='';
                                              ingredients.text=='';
                                              nutrition.text=='';
                                              instruction.text=='';
                                              fssai.text=='';
                                              shelf.text=='';
                                              madefrom.text=='';
                                              price.text=='';
                                              Navigator.pop(context);

                                            }),

                                      ]);
                                }
                            );
                          }
                        }
                        else{
                          productname.text == '' ?
                          showUploadMessage(context, 'Please enter product Name'):
                          productcode.text == '' ?
                          showUploadMessage(context, 'Please enter productcode'):
                          stock.text == '' ?
                          showUploadMessage(context, 'Please enter stock'):
                          hsncode.text == '' ?
                          showUploadMessage(context, 'Please enter hsncode'):
                          description.text == '' ?
                          showUploadMessage(context, 'Please enter product description'):
                          showUploadMessage(context, 'Please enter product weight');
                        }


                        setState(() {

                        });





                      },
                      child: Container(
                        height: h * 0.06,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(w * 0.02)),
                        child: const Center(
                            child: Text(
                              "Submit for Approval",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: w * 0.04,
                        ),
                        const Text(
                          "*",
                          style: TextStyle(color: Colors.red),
                        ),
                        Text("Approval Time : 24 Hours ",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: w * 0.03, color: primaryColor),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: w * 0.04,
                        ),
                        Text(
                          "*",
                          style:
                          TextStyle(color: Colors.red, fontSize: h * 0.020),
                        ),
                        Text(
                            "You can resubmit the Pending Approval Products from  \n  the Inventory list. ",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(fontSize: w * 0.03),
                                color: primaryColor)
                        ),
                      ],
                    ),
                  ],
                ),
              )
                  : Container(),

              SizedBox(
                height: h * 0.04,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: h * 0.05,
                  width: w,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                ),
              )
            ]),
      ),
    );
  }
  bool? loadingstate;
  late File imageLink;
  File? Image;
  final store = FirebaseStorage.instance;

  Future takeImage(ImageSource source, List currentList) async {
    final IMAGE = await ImagePicker().pickImage(source: source);
    if (IMAGE == null) {
      loadingstate = false;
      setState(() {});
    } else {
      setState(() {
        loadingstate = true;
      });
      Image = File(IMAGE!.path);
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