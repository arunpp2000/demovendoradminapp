import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../brands/brandViewPage.dart';
import '../../globals/colors.dart';
import '../../model/brandModel.dart';

class BrandPending extends StatefulWidget {
  AddBrand? brandData;
  BrandPending({Key? key, this.brandData});

  @override
  State<BrandPending> createState() => _BrandrequestState();
}

class _BrandrequestState extends State<BrandPending> {
  TextEditingController search = TextEditingController();
  Stream<List<AddBrand>> getBrands() => FirebaseFirestore.instance
      .collection('brands')
      .where('delete', isEqualTo: false)
      .where('status', isEqualTo: 0).orderBy('date',descending: true)
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => AddBrand.fromJson(doc.data())).toList());
  Stream<List<AddBrand>> getSearchBrands() => FirebaseFirestore.instance
      .collection('brands')
      .where('delete', isEqualTo: false)
      .where('status', isEqualTo: 0).where('search',arrayContains: search.text).orderBy('date',descending: true)
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => AddBrand.fromJson(doc.data())).toList());
  int brandRef=0;
  getBrandRef(){
    FirebaseFirestore.instance.collection('settings').doc('referenceNo').get().then((value) {
      brandRef=value['brandRef'];
      if(mounted){
        setState(() {
        });
      }
    });
  }
  Map sellerName={};
  Map sellerId={};
  getSellerName(){
    FirebaseFirestore.instance.collection('vendor').get().then((value){

      for(DocumentSnapshot a in value.docs){
        sellerName[a.id]=a.get('name');
      }

    });
  }

  @override
  void initState() {
    getBrandRef();
    super.initState();
    getSellerName();
  }
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Brand Requests',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding:
            EdgeInsets.only(top: h * 0.02, left: w * 0.04, right: w * 0.04),
            child: Column(children: [
              SizedBox(
                height: h * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: h * 0.04,
                    width: w * 0.900,
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: TextField(
                        controller: search,
                        onSubmitted: (v){
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
              Container(
                width: w,
                height: h * 0.75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(w * 0.02),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: w * 0.013,
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 5, top: 5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text("Brand Requests",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: w * 0.035,
                                    fontWeight: FontWeight.bold))),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 320,
                          height: 0.5,
                          child: ColoredBox(color: Colors.grey),
                        ),
                        StreamBuilder<List<AddBrand>>(
                            stream:search.text.isEmpty? getBrands():getSearchBrands(),
                            builder: (context, snapshot) {
                              print(snapshot.error);
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              var brands = snapshot.data!;
                              return Expanded(
                                child: ListView.builder(
                                    itemCount:brands.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Timestamp time =Timestamp.fromDate( brands[index].date!);
                                      var approveddate = brands[index].acceptedDate;
                                      return

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            //color: Colors.red.shade50,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      'Ref No:',
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black),
                                                    ),
                                                    Text(
                                                      '${brands[index].referNo}',
                                                      style: TextStyle(
                                                          color:primaryColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    // Text(
                                                    // sellerName[brands[index].venderId??''],
                                                    //   style: TextStyle(
                                                    //       color:
                                                    //       Colors.black,
                                                    //       fontWeight:
                                                    //       FontWeight
                                                    //           .bold),
                                                    // ),
                                                    Text('Request Date : '+
                                                        DateFormat("dd-MM-yyyy")
                                                            .format( brands[index].date!),
                                                      style: TextStyle(
                                                          color:
                                                          primaryColor,
                                                          fontWeight: FontWeight
                                                              .w500),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      brands[index].brand??'',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        setState(() {
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandViewPage(
                                                            id:brands[index].brandId??'',
                                                          )));
                                                        });
                                                      },
                                                      child: Container(
                                                        width: w * 0.285,
                                                        height: h * 0.05,
                                                        decoration: BoxDecoration(
                                                            color: brands[index].status ==
                                                                1
                                                                ? Colors.green
                                                                : primaryColor,
                                                            borderRadius:
                                                            BorderRadius.all(
                                                                Radius
                                                                    .circular(
                                                                    6))),
                                                        child: Center(
                                                            child: Text(
                                                              "View",
                                                              style: TextStyle(
                                                                  color:
                                                                  Colors.white),
                                                            )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                SizedBox(
                                                  width: 320,
                                                  height: 0.5,
                                                  child: ColoredBox(
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                    }),
                              );
                            }),
                      ]),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: h * 0.0142,
          ),
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
      ),
    );
  }
}
