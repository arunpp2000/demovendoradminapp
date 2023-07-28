import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../globals/colors.dart';
import '../login/splashscreen.dart';
import '../model/cateogryModel.dart';
import '../model/usermodel.dart';
import 'addCategory.dart';
import 'categoryDetails.dart';



class AdminCategory extends StatefulWidget {
  AddCategory? CategoryData;
  AdminCategory({Key? key, this.CategoryData});
  @override
  State<AdminCategory> createState() => _AdminCategoryState();
}

class _AdminCategoryState extends State<AdminCategory> {


  TextEditingController searchController =TextEditingController();

  Stream<List<Category>> getCategory() =>
      FirebaseFirestore.instance
          .collection('category')
          .where('status',isEqualTo: 1)
          .where('delete', isEqualTo: false)
          .where('vendorId',isEqualTo: currentUser!.id)
          .orderBy('date')
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => Category.fromJson(doc.data())).toList());
  Stream<List<Category>> getSearchCategory() =>
      FirebaseFirestore.instance
          .collection('category')
          .where('status',isEqualTo: 1)
          .where('delete', isEqualTo: false)
          .where('vendorId',isEqualTo: currentUser!.id)
          .where('search',arrayContains:searchController.text.toUpperCase())
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => Category.fromJson(doc.data())).toList());
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
    // TODO: implement initState
    super.initState();
    getSellerName();

    print(currentUser?.id);
    print('=====');
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {

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
                        controller: searchController,
                        onFieldSubmitted: (v){
                          setState(() {

                          });
                        },
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontSize: w * 0.030, color: Colors.black),
                          hintText: 'Search Category',
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
                height: h * 0.01,
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
                        Text("Admin Category",
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
                        StreamBuilder<List<Category>>(
                            stream:searchController.text.isEmpty?getCategory():getSearchCategory(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              var data = snapshot.data!;
                              print(data.length.toString());
                              return Expanded(
                                child: ListView.builder(
                                    itemCount:data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // Timestamp time = brands[index]['date'];
                                      // var approveddate = brands[index]['approvedDate'];
                                      return

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
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
                                                      '${data[index].referNo}',
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
                                                      sellerName[data[index].vendorId]??'',
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                    ),
                                                    Text('Rejected Date : '+
                                                        DateFormat("dd-MM-yyyy")
                                                            .format( data[index].rejectedDate!),
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
                                                      data[index].name??'',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        setState(() {
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryViewPage(
                                                            id:data[index].categoryId,
                                                          )));
                                                        });
                                                      },
                                                      child: Container(
                                                        width: w * 0.285,
                                                        height: h * 0.05,
                                                        decoration: BoxDecoration(
                                                            color:  primaryColor,
                                                            borderRadius:
                                                            BorderRadius.all(
                                                                Radius
                                                                    .circular(
                                                                    6))),
                                                        child: Center(
                                                            child: Text(
                                                              "view",
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
