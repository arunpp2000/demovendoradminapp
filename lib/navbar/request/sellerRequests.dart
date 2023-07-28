import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';


import '../../globals/colors.dart';
import 'sellerDetails.dart';


class SellerRequests extends StatefulWidget {
  const SellerRequests({Key? key}) : super(key: key);

  @override
  _SellerRequestsState createState() => _SellerRequestsState();
}

class _SellerRequestsState extends State<SellerRequests> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController number;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    number=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.black),
    leading: IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text(
          'Seller Request',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Column(
          children: [
            TabBar(
                labelColor: primaryColor,
                // labelStyle: FlutterFlowTheme.bodyText1,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(text: 'Requests',),
                  Tab(text: 'Approved',),
                  Tab(text: 'Rejected',),
                ]),
            Expanded(child: TabBarView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Padding(
                    //   padding:
                    //   EdgeInsetsDirectional.fromSTEB(16, 4, 16, 10),
                    //   child: TextFormField(
                    //     controller: number,
                    //     obscureText: false,
                    //     onFieldSubmitted: (text){
                    //       setState(() {
                    //
                    //       });
                    //     },
                    //     decoration: InputDecoration(
                    //       labelText: 'Search',
                    //       labelStyle: TextStyle(
                    //         fontFamily: 'Poppins',
                    //         color: Color(0xFF57636C),
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.normal,
                    //       ),
                    //       hintText: 'Search Users',
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: Color(0x00000000),
                    //           width: 1,
                    //         ),
                    //         borderRadius: BorderRadius.circular(30),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: Color(0x00000000),
                    //           width: 1,
                    //         ),
                    //         borderRadius: BorderRadius.circular(30),
                    //       ),
                    //       filled: true,
                    //       fillColor: Color(0xFFF1F4F8),
                    //       prefixIcon: Icon(
                    //         Icons.search_outlined,
                    //         color: Color(0xFF57636C),
                    //       ),
                    //     ),
                    //     style: TextStyle(
                    //       fontFamily: 'Poppins',
                    //       color: Color(0xFF1D2429),
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.normal,
                    //     ),
                    //   ),
                    // ),
                    // number.text==''?Expanded(
                    //   child: StreamBuilder<QuerySnapshot>(
                    //       stream: FirebaseFirestore.instance.collection('b2bRequests')
                    //           .where('status',isEqualTo: 0)
                    //           .orderBy('time',descending: true).snapshots(),
                    //       builder: (context, snapshot) {
                    //         if(!snapshot.hasData){
                    //           return Center(child: CircularProgressIndicator());
                    //         }
                    //         var data=snapshot.data?.docs;
                    //         return data?.length==0?Center(child: Text('No Pending Request')): ListView.builder(
                    //           itemCount: data?.length,
                    //           itemBuilder: (context, index) {
                    //             return  Row(
                    //               mainAxisSize: MainAxisSize.max,
                    //               children: [
                    //                 InkWell(
                    //                   onTap: (){
                    //                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPageWidget(
                    //                     //   id:data[index]['userId'],
                    //                     // )));
                    //                     },
                    //                   child: Container(
                    //                     width: MediaQuery.of(context).size.width,
                    //                     height: 80,
                    //                     decoration: BoxDecoration(
                    //                       color: Colors.white,
                    //                       border: Border.all(
                    //                         color: Color(0xFFC8CED5),
                    //                         width: 1,
                    //                       ),
                    //                     ),
                    //                     child: Row(
                    //                       mainAxisSize: MainAxisSize.max,
                    //                       children: [
                    //                         Padding(
                    //                           padding:
                    //                           EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    //                           child: Column(
                    //                             mainAxisSize: MainAxisSize.max,
                    //                             mainAxisAlignment: MainAxisAlignment.center,
                    //                             children: [
                    //                               Container(
                    //                                   width: 60,
                    //                                   height: 60,
                    //                                   clipBehavior: Clip.antiAlias,
                    //                                   decoration: BoxDecoration(
                    //                                     shape: BoxShape.circle,
                    //                                   ),
                    //                                   child: CachedNetworkImage(
                    //                                     imageUrl: data![index]['imageUrl']==''?'https://cdn1.iconfinder.com/data/icons/ecommerce-gradient/512/ECommerce_Website_App_Online_Shop_Gradient_greenish_lineart_Modern_profile_photo_person_contact_account_buyer_seller-512.png':data[index]['imageUrl'],
                    //
                    //                                   )
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                         Expanded(
                    //                           child: Column(
                    //                             mainAxisSize: MainAxisSize.max,
                    //                             mainAxisAlignment: MainAxisAlignment.center,
                    //                             children: [
                    //                               Row(
                    //                                 mainAxisSize: MainAxisSize.max,
                    //                                 children: [
                    //                                   Text(
                    //                                     data[index]['userName'],
                    //                                     style:
                    //                                     TextStyle(
                    //                                       fontFamily: 'Lexend Deca',
                    //                                       color: Color(0xFF15212B),
                    //                                       fontSize: 18,
                    //                                       fontWeight: FontWeight.w500,
                    //                                     ),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                               Row(
                    //                                 mainAxisSize: MainAxisSize.max,
                    //                                 children: [
                    //                                   Expanded(
                    //                                     child: Padding(
                    //                                       padding:
                    //                                       EdgeInsetsDirectional.fromSTEB(
                    //                                           0, 4, 4, 0),
                    //                                       child: Text(
                    //                                         data[index]['email'],
                    //                                         style: TextStyle(
                    //                                           fontFamily: 'Lexend Deca',
                    //                                           color: Color(0xFF4B39EF),
                    //                                           fontSize: 12,
                    //                                           fontWeight: FontWeight.w500,
                    //                                         ),
                    //                                       ),
                    //                                     ),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                         Padding(
                    //                           padding:
                    //                           EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                    //                           child: Column(
                    //                             mainAxisSize: MainAxisSize.max,
                    //                             mainAxisAlignment: MainAxisAlignment.center,
                    //                             children: [
                    //                               Icon(
                    //                                 Icons.chevron_right_rounded,
                    //                                 color: Color(0xFF82878C),
                    //                                 size: 24,
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             );
                    //
                    //           },
                    //
                    //         );
                    //       }
                    //   ),
                    // ):
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('vendor')
                              .where('status',isEqualTo: 0)
                              // .where('officialNo',isEqualTo: number.text)
                              // .orderBy('time',descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if(!snapshot.hasData){
                              return Center(child: CircularProgressIndicator());
                            }
                            var data=snapshot.data?.docs;
                            return data?.length==0?Center(child: Text('No Requests')): ListView.builder(
                              itemCount: data?.length,
                              itemBuilder: (context, index) {
                                return  Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>sellerDetails(
                                          id:data![index]['id'],
                                        )));
                                        },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Color(0xFFC8CED5),
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: 60,
                                                      height: 60,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl: data![index]['photoUrl']==''?'https://cdn1.iconfinder.com/data/icons/ecommerce-gradient/512/ECommerce_Website_App_Online_Shop_Gradient_greenish_lineart_Modern_profile_photo_person_contact_account_buyer_seller-512.png':data[index]['photoUrl'],
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        data[index]['name'],
                                                        style:
                                                        TextStyle(
                                                          fontFamily: 'Lexend Deca',
                                                          color: Color(0xFF15212B),
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                              0, 4, 4, 0),
                                                          child: Text(
                                                            data[index]['email'],
                                                            style: TextStyle(
                                                              fontFamily: 'Lexend Deca',
                                                              color: Color(0xFF4B39EF),
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.chevron_right_rounded,
                                                    color: Color(0xFF82878C),
                                                    size: 24,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );

                              },

                            );
                          }
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Padding(
                    //   padding:
                    //   EdgeInsetsDirectional.fromSTEB(16, 4, 16, 10),
                    //   child: TextFormField(
                    //     controller: number,
                    //     obscureText: false,
                    //     onFieldSubmitted: (text){
                    //       setState(() {
                    //
                    //       });
                    //     },
                    //     decoration: InputDecoration(
                    //       labelText: 'Search',
                    //       labelStyle: TextStyle(
                    //         fontFamily: 'Poppins',
                    //         color: Color(0xFF57636C),
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.normal,
                    //       ),
                    //       hintText: 'Search Users',
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: Color(0x00000000),
                    //           width: 1,
                    //         ),
                    //         borderRadius: BorderRadius.circular(30),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: Color(0x00000000),
                    //           width: 1,
                    //         ),
                    //         borderRadius: BorderRadius.circular(30),
                    //       ),
                    //       filled: true,
                    //       fillColor: Color(0xFFF1F4F8),
                    //       prefixIcon: Icon(
                    //         Icons.search_outlined,
                    //         color: Color(0xFF57636C),
                    //       ),
                    //     ),
                    //     style: TextStyle(
                    //       fontFamily: 'Poppins',
                    //       color: Color(0xFF1D2429),
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.normal,
                    //     ),
                    //   ),
                    // ),
                    //
                    // number.text==''?
                    // Expanded(
                    //   child: StreamBuilder<QuerySnapshot>(
                    //       stream: FirebaseFirestore.instance.collection('b2bRequests')
                    //           .where('status',isEqualTo: 1)
                    //           .orderBy('time',descending: true).snapshots(),
                    //       builder: (context, snapshot) {
                    //         if(!snapshot.hasData){
                    //           return Center(child: CircularProgressIndicator());
                    //         }
                    //         var data=snapshot.data?.docs;
                    //         return data?.length==0?Center(child: Text('No Approved Users')): ListView.builder(
                    //           itemCount: data?.length,
                    //           itemBuilder: (context, index) {
                    //             return  Row(
                    //               mainAxisSize: MainAxisSize.max,
                    //               children: [
                    //                 InkWell(
                    //                   onTap: (){
                    //                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>B2BDetailsPageWidget(
                    //                     //   id:data![index]['userId'],
                    //                     //   zone:data![index]['zone'],
                    //                     //   ebZone: data![index]['ebZone'],
                    //                     // )));
                    //                     },
                    //                   child: Container(
                    //                     width: MediaQuery.of(context).size.width,
                    //                     height: 80,
                    //                     decoration: BoxDecoration(
                    //                       color: Colors.white,
                    //                       border: Border.all(
                    //                         color: Color(0xFFC8CED5),
                    //                         width: 1,
                    //                       ),
                    //                     ),
                    //                     child: Row(
                    //                       mainAxisSize: MainAxisSize.max,
                    //                       children: [
                    //                         Padding(
                    //                           padding:
                    //                           EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    //                           child: Column(
                    //                             mainAxisSize: MainAxisSize.max,
                    //                             mainAxisAlignment: MainAxisAlignment.center,
                    //                             children: [
                    //                               Container(
                    //                                   width: 60,
                    //                                   height: 60,
                    //                                   clipBehavior: Clip.antiAlias,
                    //                                   decoration: BoxDecoration(
                    //                                     shape: BoxShape.circle,
                    //                                   ),
                    //                                   child: CachedNetworkImage(
                    //                                     imageUrl: data![index]['imageUrl']==''?'https://cdn1.iconfinder.com/data/icons/ecommerce-gradient/512/ECommerce_Website_App_Online_Shop_Gradient_greenish_lineart_Modern_profile_photo_person_contact_account_buyer_seller-512.png':data[index]['imageUrl'],
                    //                                   )
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                         Expanded(
                    //                           child: Column(
                    //                             mainAxisSize: MainAxisSize.max,
                    //                             mainAxisAlignment: MainAxisAlignment.center,
                    //                             children: [
                    //                               Row(
                    //                                 mainAxisSize: MainAxisSize.max,
                    //                                 children: [
                    //                                   Expanded(
                    //                                     child: Text(
                    //                                       data[index]['userName'],
                    //                                       style:
                    //                                       TextStyle(
                    //                                         fontFamily: 'Lexend Deca',
                    //                                         color: Color(0xFF15212B),
                    //                                         fontSize: 18,
                    //                                         fontWeight: FontWeight.w500,
                    //                                       ),
                    //                                     ),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                               Row(
                    //                                 mainAxisSize: MainAxisSize.max,
                    //                                 children: [
                    //                                   Expanded(
                    //                                     child: Padding(
                    //                                       padding:
                    //                                       EdgeInsetsDirectional.fromSTEB(
                    //                                           0, 4, 4, 0),
                    //                                       child: Text(
                    //                                         data![index]['email'],
                    //                                         style: TextStyle(
                    //                                           fontFamily: 'Lexend Deca',
                    //                                           color: Color(0xFF4B39EF),
                    //                                           fontSize: 12,
                    //                                           fontWeight: FontWeight.w500,
                    //                                         ),
                    //                                       ),
                    //                                     ),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                         Padding(
                    //                           padding:
                    //                           EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                    //                           child: Column(
                    //                             mainAxisSize: MainAxisSize.max,
                    //                             mainAxisAlignment: MainAxisAlignment.center,
                    //                             children: [
                    //                               Icon(
                    //                                 Icons.chevron_right_rounded,
                    //                                 color: Color(0xFF82878C),
                    //                                 size: 24,
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             );
                    //
                    //           },
                    //
                    //         );
                    //       }
                    //   ),
                    // ):
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('vendor')
                              .where('status',isEqualTo: 1)
                          // .where('officialNo',isEqualTo: number.text)
                          // .orderBy('time',descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if(!snapshot.hasData){
                              return Center(child: CircularProgressIndicator());
                            }
                            var data=snapshot.data?.docs;
                            return data?.length==0?Center(child: Text('Empty')): ListView.builder(
                              itemCount: data?.length,
                              itemBuilder: (context, index) {
                                return  Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>sellerDetails(
                                          id:data![index]['id'],
                                        )));
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Color(0xFFC8CED5),
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: 60,
                                                      height: 60,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl: data![index]['photoUrl']==''?'https://cdn1.iconfinder.com/data/icons/ecommerce-gradient/512/ECommerce_Website_App_Online_Shop_Gradient_greenish_lineart_Modern_profile_photo_person_contact_account_buyer_seller-512.png':data[index]['photoUrl'],

                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        data[index]['name'],
                                                        style:
                                                        TextStyle(
                                                          fontFamily: 'Lexend Deca',
                                                          color: Color(0xFF15212B),
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                              0, 4, 4, 0),
                                                          child: Text(
                                                            data[index]['email'],
                                                            style: TextStyle(
                                                              fontFamily: 'Lexend Deca',
                                                              color: Color(0xFF4B39EF),
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.chevron_right_rounded,
                                                    color: Color(0xFF82878C),
                                                    size: 24,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );

                              },

                            );
                          }
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Padding(
                    //   padding:
                    //   EdgeInsetsDirectional.fromSTEB(16, 4, 16, 10),
                    //   child: TextFormField(
                    //     controller: number,
                    //     obscureText: false,
                    //     onFieldSubmitted: (text){
                    //       setState(() {
                    //
                    //       });
                    //     },
                    //     decoration: InputDecoration(
                    //       labelText: 'Search',
                    //       labelStyle: TextStyle(
                    //         fontFamily: 'Poppins',
                    //         color: Color(0xFF57636C),
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.normal,
                    //       ),
                    //       hintText: 'Search Users',
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: Color(0x00000000),
                    //           width: 1,
                    //         ),
                    //         borderRadius: BorderRadius.circular(30),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: Color(0x00000000),
                    //           width: 1,
                    //         ),
                    //         borderRadius: BorderRadius.circular(30),
                    //       ),
                    //       filled: true,
                    //       fillColor: Color(0xFFF1F4F8),
                    //       prefixIcon: Icon(
                    //         Icons.search_outlined,
                    //         color: Color(0xFF57636C),
                    //       ),
                    //     ),
                    //     style: TextStyle(
                    //       fontFamily: 'Poppins',
                    //       color: Color(0xFF1D2429),
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.normal,
                    //     ),
                    //   ),
                    // ),
                    //
                    // number.text==''?
                    // Expanded(
                    //   child: StreamBuilder<QuerySnapshot>(
                    //       stream: FirebaseFirestore.instance.collection('b2bRequests')
                    //           .where('status',isEqualTo: 1)
                    //           .orderBy('time',descending: true).snapshots(),
                    //       builder: (context, snapshot) {
                    //         if(!snapshot.hasData){
                    //           return Center(child: CircularProgressIndicator());
                    //         }
                    //         var data=snapshot.data?.docs;
                    //         return data?.length==0?Center(child: Text('No Approved Users')): ListView.builder(
                    //           itemCount: data?.length,
                    //           itemBuilder: (context, index) {
                    //             return  Row(
                    //               mainAxisSize: MainAxisSize.max,
                    //               children: [
                    //                 InkWell(
                    //                   onTap: (){
                    //                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>B2BDetailsPageWidget(
                    //                     //   id:data![index]['userId'],
                    //                     //   zone:data![index]['zone'],
                    //                     //   ebZone: data![index]['ebZone'],
                    //                     // )));
                    //                     },
                    //                   child: Container(
                    //                     width: MediaQuery.of(context).size.width,
                    //                     height: 80,
                    //                     decoration: BoxDecoration(
                    //                       color: Colors.white,
                    //                       border: Border.all(
                    //                         color: Color(0xFFC8CED5),
                    //                         width: 1,
                    //                       ),
                    //                     ),
                    //                     child: Row(
                    //                       mainAxisSize: MainAxisSize.max,
                    //                       children: [
                    //                         Padding(
                    //                           padding:
                    //                           EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    //                           child: Column(
                    //                             mainAxisSize: MainAxisSize.max,
                    //                             mainAxisAlignment: MainAxisAlignment.center,
                    //                             children: [
                    //                               Container(
                    //                                   width: 60,
                    //                                   height: 60,
                    //                                   clipBehavior: Clip.antiAlias,
                    //                                   decoration: BoxDecoration(
                    //                                     shape: BoxShape.circle,
                    //                                   ),
                    //                                   child: CachedNetworkImage(
                    //                                     imageUrl: data![index]['imageUrl']==''?'https://cdn1.iconfinder.com/data/icons/ecommerce-gradient/512/ECommerce_Website_App_Online_Shop_Gradient_greenish_lineart_Modern_profile_photo_person_contact_account_buyer_seller-512.png':data[index]['imageUrl'],
                    //                                   )
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                         Expanded(
                    //                           child: Column(
                    //                             mainAxisSize: MainAxisSize.max,
                    //                             mainAxisAlignment: MainAxisAlignment.center,
                    //                             children: [
                    //                               Row(
                    //                                 mainAxisSize: MainAxisSize.max,
                    //                                 children: [
                    //                                   Expanded(
                    //                                     child: Text(
                    //                                       data[index]['userName'],
                    //                                       style:
                    //                                       TextStyle(
                    //                                         fontFamily: 'Lexend Deca',
                    //                                         color: Color(0xFF15212B),
                    //                                         fontSize: 18,
                    //                                         fontWeight: FontWeight.w500,
                    //                                       ),
                    //                                     ),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                               Row(
                    //                                 mainAxisSize: MainAxisSize.max,
                    //                                 children: [
                    //                                   Expanded(
                    //                                     child: Padding(
                    //                                       padding:
                    //                                       EdgeInsetsDirectional.fromSTEB(
                    //                                           0, 4, 4, 0),
                    //                                       child: Text(
                    //                                         data![index]['email'],
                    //                                         style: TextStyle(
                    //                                           fontFamily: 'Lexend Deca',
                    //                                           color: Color(0xFF4B39EF),
                    //                                           fontSize: 12,
                    //                                           fontWeight: FontWeight.w500,
                    //                                         ),
                    //                                       ),
                    //                                     ),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                         Padding(
                    //                           padding:
                    //                           EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                    //                           child: Column(
                    //                             mainAxisSize: MainAxisSize.max,
                    //                             mainAxisAlignment: MainAxisAlignment.center,
                    //                             children: [
                    //                               Icon(
                    //                                 Icons.chevron_right_rounded,
                    //                                 color: Color(0xFF82878C),
                    //                                 size: 24,
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             );
                    //
                    //           },
                    //
                    //         );
                    //       }
                    //   ),
                    // ):
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('vendor')
                              .where('status',isEqualTo: 2)
                          // .where('officialNo',isEqualTo: number.text)
                          // .orderBy('time',descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if(!snapshot.hasData){
                              return Center(child: CircularProgressIndicator());
                            }
                            var data=snapshot.data?.docs;
                            return data?.length==0?Center(child: Text('empty')): ListView.builder(
                              itemCount: data?.length,
                              itemBuilder: (context, index) {
                                return  Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>sellerDetails(
                                          id:data![index]['id'],
                                        )));
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Color(0xFFC8CED5),
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: 60,
                                                      height: 60,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl: data![index]['photoUrl']==''?'https://cdn1.iconfinder.com/data/icons/ecommerce-gradient/512/ECommerce_Website_App_Online_Shop_Gradient_greenish_lineart_Modern_profile_photo_person_contact_account_buyer_seller-512.png':data![index]['photoUrl']

                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        data[index]['name'],
                                                        style:
                                                        TextStyle(
                                                          fontFamily: 'Lexend Deca',
                                                          color: Color(0xFF15212B),
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                              0, 4, 4, 0),
                                                          child: Text(
                                                            data[index]['email'],
                                                            style: TextStyle(
                                                              fontFamily: 'Lexend Deca',
                                                              color: Color(0xFF4B39EF),
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.chevron_right_rounded,
                                                    color: Color(0xFF82878C),
                                                    size: 24,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );

                              },

                            );
                          }
                      ),
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
