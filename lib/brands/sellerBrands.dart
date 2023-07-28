import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import '../category/cateogryTab.dart';
import '../globals/colors.dart';
import '../main.dart';
import '../model/brandModel.dart';
import '../model/usermodel.dart';
import '../navbar/tabbarview/seller_dashboard.dart';
import 'AddBrand.dart';
import 'Edit.dart';
import 'brandViewPage.dart';
import 'brands.dart';
class SellerBrands extends StatefulWidget {
  AddBrand? brandData;



  SellerBrands({Key? key, this.brandData});

  @override
  State<SellerBrands> createState() => _SellerBrandsState();
}

class _SellerBrandsState extends State<SellerBrands> {
  TextEditingController search = TextEditingController();
  Stream<List<AddBrand>> getBrands() => FirebaseFirestore.instance
      .collection('brands')
      .where('delete', isEqualTo: false)
      .where('vendorId',isNotEqualTo:currentUser?.id)
      .where('status', isEqualTo: 1)
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => AddBrand.fromJson(doc.data())).toList());
  Stream<List<AddBrand>> getSearchBrands() => FirebaseFirestore.instance
      .collection('brands')
      .where('delete', isEqualTo: false)
      .where('vendorId',isNotEqualTo:currentUser?.id)
      .where('status', isEqualTo: 1).where('search',arrayContains: search.text.toUpperCase())
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
setState(() {

});
    });
  }

  @override
  void initState() {

    super.initState();
    getBrandRef();
    getSellerName();
  }
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
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
                      child: TextFormField(
                        controller: search,
                        onFieldSubmitted: (v){
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
                        Text("Admin Brands",
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
                                      Timestamp atime =Timestamp.fromDate( brands[index].acceptedDate!);
                                      var approveddate = brands[index].acceptedDate;
                                      return
                                        brands[index].status!=2?
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
                                                    Text(
                                                      sellerName[brands[index].venderId!],
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                    ),
                                                    Text('Request Date : '+
                                                        time
                                                            .toDate()
                                                            .day
                                                            .toString() +
                                                        '/' +
                                                        time
                                                            .toDate()
                                                            .month
                                                            .toString() +
                                                        '/' +
                                                        time
                                                            .toDate()
                                                            .year
                                                            .toString(),
                                                      style: TextStyle(
                                                          color:
                                                          primaryColor,
                                                          fontWeight: FontWeight
                                                              .w500),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    Text('Accepted Date : '+
                                                        atime
                                                            .toDate()
                                                            .day
                                                            .toString() +
                                                        '/' +
                                                        atime
                                                            .toDate()
                                                            .month
                                                            .toString() +
                                                        '/' +
                                                        atime
                                                            .toDate()
                                                            .year
                                                            .toString(),
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
                                        ):Container();
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
        ])
      ),
    );
  }
}
