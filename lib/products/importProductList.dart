import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../globals/colors.dart';

class ImportProductList extends StatefulWidget {
  const ImportProductList({Key? key}) : super(key: key);

  @override
  State<ImportProductList> createState() => _ImportProductListState();
}

class _ImportProductListState extends State<ImportProductList> {
  Future<void> _pickxlFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      // The user picked a file.
      File file = File(result.files.single.path!);
      // Do something with the file, e.g. parse it.
    } else {
      // The user canceled the picker.
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.all(w * 0.02),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Seller",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: primaryColor,
                            fontSize: w * 0.03,
                            fontWeight: FontWeight.bold)),
                  ),
                  Text(
                    "-Thara Online Store",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: w * 0.03,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: w * 0.01,
                  ),
                  SizedBox(
                    height: h * 0.0015,
                    width: w * 0.22,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Color(0xffB3B3B3)),
                    ),
                  ),
                  SizedBox(
                    width: w * 0.01,
                  ),
                  Container(
                    height: h * 0.04,
                    width: w * 0.250,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: primaryColor)),
                    child: Center(
                      child: Text(
                        "Manage",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: primaryColor,
                                fontSize: w * 0.03,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Container(
                height: h * 0.705,
                width: w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey, blurRadius: w * 0.01)
                    ],
                    borderRadius: BorderRadius.circular(w * 0.02)),
                child: Padding(
                  padding: EdgeInsets.all(w * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Upload New Price List",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: w * 0.030,
                                  fontWeight: FontWeight.bold))),
                      Divider(
                        thickness: h * 0.002,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.check_circle_outline,
                                color: Color(0xff66BD46),
                              )),
                          Text("Tosprices.csv",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: w * 0.025,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold))),
                          SizedBox(
                            width: w * 0.530,
                          ),
                          SvgPicture.asset(
                            "assets/Close.svg",
                            color: Colors.red,
                          )
                        ],
                      ),
                      InkWell(
                        onTap: _pickxlFile,
                        child: Container(
                          height: h * 0.05,
                          width: w,
                          decoration: BoxDecoration(
                              gradient: gradient,
                              borderRadius: BorderRadius.circular(w * 0.02)),
                          child: Center(
                            child: Text(
                              "UPLOAD",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: w * 0.030,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      Text(
                        " • ${"Upload Excel File(.csv)"}",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: w * 0.020,
                              color: primaryColor,
                            )),
                      ),
                      SizedBox(
                        height: h * 0.05,
                      ),
                      Text(
                        "Download Current Price List",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: w * 0.030,
                                fontWeight: FontWeight.bold)),
                      ),
                      Divider(
                        thickness: h * 0.002,
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      Container(
                        height: h * 0.05,
                        width: w,
                        decoration: BoxDecoration(
                            color: Color(0xff66BD46),
                            borderRadius: BorderRadius.circular(w * 0.02)),
                        child: Center(
                          child: Text(
                            "DOWNLOAD",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: w * 0.030,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
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