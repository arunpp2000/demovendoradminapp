import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../globals/colors.dart';
import '../../widgets/button.dart';
import '../../widgets/customButton.dart';
import '../../widgets/uploadmedia.dart';
import 'ImageView.dart';

class sellerDetails extends StatefulWidget {
  final String id;

  sellerDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<sellerDetails> createState() => _sellerDetailsState();
}

class _sellerDetailsState extends State<sellerDetails> {
  String? dropdownValue1;
  List? image;
  List<String> documents = [
    '',
    "GST Certificate",
    "FSSAI Registration",
    "Udyam",
    "Shop & Establishment License",
    "Trade Certificate/Licence",
    "Other(Any ID or Document with Business Name)"
  ];
  // String? accName;
  // String? acNo;
  // String? ifsc;
  // String? bankname;
  TextEditingController companyDetails = TextEditingController();
  TextEditingController accName = TextEditingController();
  TextEditingController acNo = TextEditingController();
  TextEditingController ifsc = TextEditingController();
  TextEditingController bankname = TextEditingController();
  TextEditingController companyAddress = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController soleproprietor = TextEditingController();
  TextEditingController organization = TextEditingController();
  TextEditingController gstNo = TextEditingController();
  TextEditingController companyDescription = TextEditingController();
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

  File? images;
  final picker = ImagePicker();
  String? url;
  String? fileContents;

  getDoc() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickImage != null) {
      images = File(pickImage.path);
      File file = File(pickImage.path);

      String? fileContents = await fileToString(file);
      if (fileContents != null) {
        print('File contents: $fileContents');
      }
      uploadDocument(images!);
    } else {
      print("no image selected");
    }
    setState(() {});
  }

  String? imageUrl;
  uploadDocument(File imageFile) async {
    print('Image uploaded to Firebase');
    String fileName = (images!.path);
    Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL();
    url = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
    FirebaseFirestore.instance.collection('vendor').doc(widget.id).update({
      'documentUrl': url,
    });
    showUploadMessage(context, 'Uploaded');
  }

  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text("Details"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('vendor')
              .doc(widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var data = snapshot.data;
            print(data!['phone']);
            mobile.text = data!['phone'];
              //AccountDetails
              accName.text = data!['bankDetails']['accontName'];
              acNo.text = data!['bankDetails']['accountNumber'];
              ifsc.text = data!['bankDetails']['ifsc'];
              bankname.text = data!['bankDetails']['bankname'];
              //company detials
              companyAddress.text = data!['companyDetails'][0]['address'];
              companyDetails.text = data!['companyDescription'];
              gstNo.text = data!['gstNo'];
              organization.text = data!['companyDetails'][0]['companyName'];
              soleproprietor.text =data!['companyDetails'][0]['solePropritor'];
              state.text =data!['companyDetails'][0]['state'];
              city.text = data!['companyDetails'][0]['city'];
              //persondetails
              imageUrl = data!['photoUrl'];
              dropdownValue1 = data!['document'] ?? '';
              name.text = data!['name'];
              email.text = data!['email'];
              pincode.text = data!['companyDetails'][0]['pincode'];


            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: h * 0.8,
                    width: w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: w * 0.02)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: [
                          Text(
                            "Company Details",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: w * 0.025)),
                          ),
                          TextFormField(
                              controller: companyDetails,
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                              )),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            "Sole Proprietor/LLp/Partnership",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: w * 0.025)),
                          ),
                          TextFormField(
                              controller: soleproprietor,
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                              )),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            "Organization/Business Name",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: w * 0.025)),
                          ),
                          TextFormField(
                              controller: organization,
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                              )),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            "Company Address",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: w * 0.025)),
                          ),
                          TextFormField(
                              controller: companyAddress,
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                              )),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            "City",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: w * 0.025)),
                          ),
                          TextFormField(
                              controller: city,
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                              )),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            "State",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: w * 0.025)),
                          ),
                          TextFormField(
                              controller: state,
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                              )),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            "Pin code",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: w * 0.025)),
                          ),
                          TextFormField(
                              controller: pincode,
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                              )),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            "GST NO",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: w * 0.025)),
                          ),
                          TextFormField(
                              controller: gstNo,
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                              )),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            "Select Document Type",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: w * 0.025)),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: w * 0.010),
                            child: Container(
                              child: DropdownButton<String>(
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue1 = newValue!;
                                  });
                                },
                                value: dropdownValue1,
                                hint: Text(
                                  'Selecet document type',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                items: documents.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  imageUrl == ''
                                      ? Container(
                                          width: w * 0.3,
                                          height: h * 0.13,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Color(0xffE9E9E9),
                                              border: Border.all(
                                                  color: Color(0xff530CAD))),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Imageview(
                                                        image: imageUrl)));
                                          },
                                          child: Container(
                                            width: w * 0.3,
                                            height: h * 0.13,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              color: Color(0xffE9E9E9),
                                            ),
                                            child: CachedNetworkImage(
                                                imageUrl: imageUrl ?? '',
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                  Positioned(
                                    left: w * 0.24,
                                    bottom: h * 0.10,
                                    child: InkWell(
                                      onTap: () {
                                        FirebaseFirestore.instance
                                            .collection('vendor')
                                            .doc(widget.id)
                                            .update({
                                          'photoUrl': '',
                                        });
                                        showUploadMessage(context, 'Removed');
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: w * 0.07,
                                        height: h * 0.05,
                                        child: Icon(
                                          Icons.clear,
                                          color: Color.fromARGB(255, 254, 253, 255),
                                          size: 20,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Color(0xff8C31FF),
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                  )
                                ],
                              ),Spacer(),
                              
                             data!['document']==''?SizedBox():Icon(Icons.check_circle_outline,color: Colors.green,),
                             data!['document']==''?SizedBox():Text(data['document']),
                            ],
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          InkWell(
                            onTap: () {
                              if (dropdownValue1 != '' ||
                                  dropdownValue1 != null) {
                                getDoc();
                                print(url);
                              } else {
                                dropdownValue1 == ''
                                    ? errorMsg(
                                        context, 'please Select Document Type')
                                    : dropdownValue1 == null
                                        ? errorMsg(context,
                                            'please Select Document Type')
                                        : '';
                              }
                            },
                            child: Container(
                              height: h * 0.05,
                              width: w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: primaryColor),
                              child: Center(
                                child: Text(
                                  "Upload Document",
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: w * 0.025)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Row(
                            children: [
                              Text(
                                "* ",
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(
                                "Supported file types JPEG, PNG OR PDF",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: w * 0.02)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "* ",
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(
                                "Upload Limit 1 MB",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: w * 0.02)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            "Mobile Number",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: w * 0.025)),
                          ),
                          TextFormField(
                              controller: mobile,
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                              )),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            "Email Address",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: w * 0.025)),
                          ),
                          TextFormField(
                              controller: email,
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                              )),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            "Bank Account Details",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: w * 0.025)),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            "Bank Name",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: w * 0.025)),
                          ),
                          TextFormField(
                              controller: bankname,
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                              )),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            "Bank Account Name",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: w * 0.025)),
                          ),
                          TextFormField(
                              controller: accName,
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                              )),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            "Bank Account Number",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: w * 0.025)),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          TextFormField(
                              controller: acNo,
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                              )),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            "IFSC CODE",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: w * 0.025)),
                          ),
                          TextFormField(
                              controller: ifsc,
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8C31FF))),
                              )),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          data!['status'] == 0
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomButton(
                                      text: 'Approve',
                                      onPressed: () async {
                                        bool proceed = await alert(context,
                                            'Do you Want Accept this Vendor?');
                                        if (proceed) {
                                          data?.reference.update({'status': 1});
                                          Navigator.pop(context);
                                          showUploadMessage(
                                              context, 'Accepted');
                                        }
                                      },
                                      color: primaryColor,
                                    ),
                                    CustomButton(
                                      text: 'Reject',
                                      onPressed: () async {
                                        bool proceed = await alert(context,
                                            'Do you Want Reject this vendor?');
                                        if (proceed) {
                                          data?.reference.update({'status': 2});
                                          Navigator.pop(context);
                                          showUploadMessage(
                                              context, 'rejected');
                                        }
                                      },
                                      color: Colors.red,
                                    ),
                                  ],
                                )
                              : data['status'] == 1
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CustomButton(
                                          text: 'Reject',
                                          onPressed: () async {
                                            bool proceed = await alert(context,
                                                'Do you Want Reject this vendor?');
                                            if (proceed) {
                                              data?.reference
                                                  .update({'status': 2});
                                              Navigator.pop(context);
                                              showUploadMessage(
                                                  context, 'rejected');
                                            }
                                          },
                                          color: Colors.red,
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CustomButton(
                                          text: 'Approve',
                                          onPressed: () async {
                                            bool proceed = await alert(context,
                                                'Do you Want Accept this Vendor?');
                                            if (proceed) {
                                              data?.reference
                                                  .update({'status': 1});
                                              Navigator.pop(context);
                                              showUploadMessage(
                                                  context, 'Accepted');
                                            }
                                          },
                                          color: primaryColor,
                                        ),
                                      ],
                                    ),
                          SizedBox(
                            height: h * 0.01,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.018,
                ),
                Container(
                  height: h * 0.04,
                  width: w,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: (BorderRadius.only(
                          topRight: Radius.circular(5),
                          topLeft: Radius.circular(5)))),
                )
              ],
            );
          }),
    );
  }
}
