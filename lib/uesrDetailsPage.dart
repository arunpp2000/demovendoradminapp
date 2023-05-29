
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demovendoradminapp/widgets/button.dart';
import 'package:demovendoradminapp/widgets/uploadmedia.dart';
import 'package:flutter/material.dart';


import 'globals/colors.dart';



class UserDetailPage extends StatefulWidget {
  final String id;

  const UserDetailPage({Key? key,  required this.id,}) : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //productupdate
  final productPrice = TextEditingController();
  final productGst = TextEditingController();
  final productGty = TextEditingController();
  final productunitPrice = TextEditingController();
  final productDiscount = TextEditingController();
  bool submit = false;
  //total update
  final Price = TextEditingController();
  final discount = TextEditingController();
  final deliverycharge = TextEditingController();
  final Gst = TextEditingController();
  final totalgst = TextEditingController();
  List items = [];
  var sum=0;
  int totalExcel=0;
  var q=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  String? accName;
  String? acNo;
  String? ifsc;
  String? bankname;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Details',
          style: TextStyle(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF151B1E),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(1, 0, 0, 0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('vendor').doc(widget.id).snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator(),);
                  }





                  var data=snapshot.data;

                  try{
                    accName       =    data!['bankDetails']['accontName'];
                    acNo       =data!['bankDetails']['accountNumber'];
                    ifsc         =data!['bankDetails']['ifsc'];
                    bankname       =data!['bankDetails']['bankname'];

                  }catch(e){
                    accName='';
                    acNo='';
                    bankname='';
                    ifsc='';
                  }
                  String name=data!['name'];
                  String email=data!['email'];
                  String mobile=data!['phone'];
                  String state=data!['state'];
                  String city=data!['city'];
                  String pincode=data!['pincode'];
                  String companyAddress=data!['companyAddress'];
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Column(
                      //   mainAxisSize: MainAxisSize.max,
                      //   children: [
                      //     ListView.builder(
                      //         shrinkWrap: true,
                      //         physics: BouncingScrollPhysics(),
                      //         itemCount: items.length,
                      //         itemBuilder: (buildContext,int index){
                      //           String name=data![index]['name'];
                      //           String email=data![index]['email'];
                      //           String mobile=data![index]['phone'];
                      //           String state=data![index]['state'];
                      //           String city=data![index]['city'];
                      //           String pincode=data![index]['pincode'];
                      //           String companyAddress=data![index]['companyAddress'];
                      //           return Padding(
                      //             padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                      //             child: Row(
                      //               mainAxisSize: MainAxisSize.max,
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Expanded(
                      //                   child: Padding(
                      //                     padding:
                      //                     EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                      //                     child: Material(
                      //                       color: Colors.transparent,
                      //                       elevation: 0,
                      //                       shape: RoundedRectangleBorder(
                      //                         borderRadius: BorderRadius.circular(0),
                      //                       ),
                      //                       child: Container(
                      //                         decoration: BoxDecoration(
                      //                           color: Colors.white,
                      //                           borderRadius: BorderRadius.circular(0),
                      //                           border: Border.all(
                      //                             color: Colors.white,
                      //                             width: 0,
                      //                           ),
                      //                         ),
                      //                         child: Column(
                      //                           mainAxisSize: MainAxisSize.max,
                      //                           children: [
                      //                             Row(
                      //                               mainAxisSize: MainAxisSize.max,
                      //                               mainAxisAlignment:
                      //                               MainAxisAlignment.center,
                      //                               crossAxisAlignment:
                      //                               CrossAxisAlignment.center,
                      //                               children: [
                      //                                 Column(
                      //                                   mainAxisSize: MainAxisSize.max,
                      //                                   mainAxisAlignment:
                      //                                   MainAxisAlignment.start,
                      //                                   children: [
                      //                                     Padding(
                      //                                       padding: EdgeInsetsDirectional
                      //                                           .fromSTEB(12, 0, 0, 0),
                      //                                       child: InkWell(
                      //
                      //                                         onTap:() {
                      //                                           showDialog(
                      //                                               context: context,
                      //                                               barrierDismissible: false,
                      //                                               builder: (buildContext) {
                      //                                                 return AlertDialog(
                      //                                                   title: Text(
                      //                                                       'Edit Product  Details'),
                      //                                                   content:
                      //                                                   SingleChildScrollView(
                      //                                                     child: Container(
                      //                                                       child: Column(
                      //                                                         children: [
                      //                                                           Container(
                      //                                                             width: 350,
                      //                                                             decoration:
                      //                                                             BoxDecoration(
                      //                                                               color: Colors
                      //                                                                   .white,
                      //                                                               borderRadius:
                      //                                                               BorderRadius
                      //                                                                   .circular(8),
                      //                                                               border:
                      //                                                               Border
                      //                                                                   .all(
                      //                                                                 color: Color(
                      //                                                                     0xFFE6E6E6),
                      //                                                               ),
                      //                                                             ),
                      //                                                             child:
                      //                                                             Padding(
                      //                                                               padding: EdgeInsets
                      //                                                                   .fromLTRB(
                      //                                                                   16,
                      //                                                                   0,
                      //                                                                   0,
                      //                                                                   0),
                      //                                                               child:
                      //                                                               TextFormField(
                      //                                                                 autovalidateMode:
                      //                                                                 AutovalidateMode
                      //                                                                     .onUserInteraction,
                      //                                                                 validator:
                      //                                                                     (value) {
                      //                                                                   RegExp
                      //                                                                   regex =
                      //                                                                   RegExp(r'^\d+(\.\d+)?$');
                      //                                                                   if (!regex
                      //                                                                       .hasMatch(value)) {
                      //                                                                     return "Enter only numbers";
                      //                                                                   }
                      //                                                                 },
                      //                                                                 controller:
                      //                                                                 productPrice,
                      //                                                                 obscureText:
                      //                                                                 false,
                      //                                                                 decoration:
                      //                                                                 InputDecoration(
                      //                                                                   labelText:
                      //                                                                   'price',
                      //                                                                   labelStyle:
                      //                                                                   TextStyle(
                      //                                                                     fontFamily:
                      //                                                                     'Montserrat',
                      //                                                                     color:
                      //                                                                     Color(0xFF8B97A2),
                      //                                                                     fontWeight:
                      //                                                                     FontWeight.w500,
                      //                                                                   ),
                      //                                                                   hintText:
                      //                                                                   'Enter Name',
                      //                                                                   hintStyle:
                      //                                                                   TextStyle(
                      //                                                                     fontFamily:
                      //                                                                     'Montserrat',
                      //                                                                     color:
                      //                                                                     Color(0xFF8B97A2),
                      //                                                                     fontWeight:
                      //                                                                     FontWeight.w500,
                      //                                                                   ),
                      //                                                                   enabledBorder:
                      //                                                                   UnderlineInputBorder(
                      //                                                                     borderSide:
                      //                                                                     BorderSide(
                      //                                                                       color:
                      //                                                                       Colors.transparent,
                      //                                                                       width:
                      //                                                                       1,
                      //                                                                     ),
                      //                                                                     borderRadius:
                      //                                                                     const BorderRadius.only(
                      //                                                                       topLeft:
                      //                                                                       Radius.circular(4.0),
                      //                                                                       topRight:
                      //                                                                       Radius.circular(4.0),
                      //                                                                     ),
                      //                                                                   ),
                      //                                                                   focusedBorder:
                      //                                                                   UnderlineInputBorder(
                      //                                                                     borderSide:
                      //                                                                     BorderSide(
                      //                                                                       color:
                      //                                                                       Colors.transparent,
                      //                                                                       width:
                      //                                                                       1,
                      //                                                                     ),
                      //                                                                     borderRadius:
                      //                                                                     const BorderRadius.only(
                      //                                                                       topLeft:
                      //                                                                       Radius.circular(4.0),
                      //                                                                       topRight:
                      //                                                                       Radius.circular(4.0),
                      //                                                                     ),
                      //                                                                   ),
                      //                                                                 ),
                      //                                                                 style:
                      //                                                                 TextStyle(
                      //                                                                   fontFamily:
                      //                                                                   'Montserrat',
                      //                                                                   color: Color(
                      //                                                                       0xFF8B97A2),
                      //                                                                   fontWeight:
                      //                                                                   FontWeight.w500,
                      //                                                                 ),
                      //                                                               ),
                      //                                                             ),
                      //                                                           ),
                      //                                                           SizedBox(
                      //                                                             height: 10,
                      //                                                           ),
                      //                                                           Container(
                      //                                                             width: 350,
                      //                                                             decoration:
                      //                                                             BoxDecoration(
                      //                                                               color: Colors
                      //                                                                   .white,
                      //                                                               borderRadius:
                      //                                                               BorderRadius
                      //                                                                   .circular(8),
                      //                                                               border:
                      //                                                               Border
                      //                                                                   .all(
                      //                                                                 color: Color(
                      //                                                                     0xFFE6E6E6),
                      //                                                               ),
                      //                                                             ),
                      //                                                             child:
                      //                                                             Padding(
                      //                                                               padding: EdgeInsets
                      //                                                                   .fromLTRB(
                      //                                                                   16,
                      //                                                                   0,
                      //                                                                   0,
                      //                                                                   0),
                      //                                                               child:
                      //                                                               TextFormField(
                      //                                                                 autovalidateMode:
                      //                                                                 AutovalidateMode
                      //                                                                     .onUserInteraction,
                      //                                                                 validator:
                      //                                                                     (value) {
                      //                                                                   RegExp
                      //                                                                   regex =
                      //                                                                   RegExp(r'^\d+(\.\d+)?$');
                      //                                                                   if (!regex
                      //                                                                       .hasMatch(value)) {
                      //                                                                     return "Enter only numbers";
                      //                                                                   }
                      //                                                                 },
                      //                                                                 controller:
                      //                                                                 productGty,
                      //                                                                 obscureText:
                      //                                                                 false,
                      //                                                                 decoration:
                      //                                                                 InputDecoration(
                      //                                                                   labelText:
                      //                                                                   'Quanity',
                      //                                                                   labelStyle:
                      //                                                                   TextStyle(
                      //                                                                     fontFamily:
                      //                                                                     'Montserrat',
                      //                                                                     color:
                      //                                                                     Color(0xFF8B97A2),
                      //                                                                     fontWeight:
                      //                                                                     FontWeight.w500,
                      //                                                                   ),
                      //                                                                   hintText:
                      //                                                                   'Enter Quanity',
                      //                                                                   hintStyle:
                      //                                                                   TextStyle(
                      //                                                                     fontFamily:
                      //                                                                     'Montserrat',
                      //                                                                     color:
                      //                                                                     Color(0xFF8B97A2),
                      //                                                                     fontWeight:
                      //                                                                     FontWeight.w500,
                      //                                                                   ),
                      //                                                                   enabledBorder:
                      //                                                                   UnderlineInputBorder(
                      //                                                                     borderSide:
                      //                                                                     BorderSide(
                      //                                                                       color:
                      //                                                                       Colors.transparent,
                      //                                                                       width:
                      //                                                                       1,
                      //                                                                     ),
                      //                                                                     borderRadius:
                      //                                                                     const BorderRadius.only(
                      //                                                                       topLeft:
                      //                                                                       Radius.circular(4.0),
                      //                                                                       topRight:
                      //                                                                       Radius.circular(4.0),
                      //                                                                     ),
                      //                                                                   ),
                      //                                                                   focusedBorder:
                      //                                                                   UnderlineInputBorder(
                      //                                                                     borderSide:
                      //                                                                     BorderSide(
                      //                                                                       color:
                      //                                                                       Colors.transparent,
                      //                                                                       width:
                      //                                                                       1,
                      //                                                                     ),
                      //                                                                     borderRadius:
                      //                                                                     const BorderRadius.only(
                      //                                                                       topLeft:
                      //                                                                       Radius.circular(4.0),
                      //                                                                       topRight:
                      //                                                                       Radius.circular(4.0),
                      //                                                                     ),
                      //                                                                   ),
                      //                                                                 ),
                      //                                                                 style:
                      //                                                                 TextStyle(
                      //                                                                   fontFamily:
                      //                                                                   'Montserrat',
                      //                                                                   color: Color(
                      //                                                                       0xFF8B97A2),
                      //                                                                   fontWeight:
                      //                                                                   FontWeight.w500,
                      //                                                                 ),
                      //                                                               ),
                      //                                                             ),
                      //                                                           ),
                      //                                                           SizedBox(
                      //                                                             height: 10,
                      //                                                           ),
                      //                                                         ],
                      //                                                       ),
                      //                                                     ),
                      //                                                   ),
                      //                                                   actions: [
                      //                                                     TextButton(
                      //                                                         onPressed: () {
                      //                                                           Navigator.pop(
                      //                                                               context);
                      //                                                         },
                      //                                                         child: Text(
                      //                                                             'Cancel')),
                      //                                                     TextButton(
                      //                                                         onPressed:
                      //                                                             () async {
                      //                                                           bool pressed =
                      //                                                           await alert(
                      //                                                               context,
                      //                                                               'Do you want update Product Details?');
                      //                                                           if (pressed) {
                      //                                                             items.removeAt(
                      //                                                                 index);
                      //                                                             items.insert(
                      //                                                                 index,
                      //                                                                 {
                      //                                                                   'color':
                      //                                                                   null,
                      //                                                                   'cut':
                      //                                                                   null,
                      //                                                                   'expectedPrice':
                      //                                                                   exP,
                      //                                                                   'expectedQty':
                      //                                                                   exQ,
                      //                                                                   'gst':
                      //                                                                   gst,
                      //                                                                   'hsnCode':
                      //                                                                   hcode,
                      //                                                                   'id':
                      //                                                                   id,
                      //                                                                   'image':
                      //                                                                   image,
                      //                                                                   'name':
                      //                                                                   name,
                      //                                                                   'price':
                      //                                                                   int.tryParse(productPrice.text),
                      //                                                                   'productCode':
                      //                                                                   productCode,
                      //                                                                   'quantity':
                      //                                                                   int.tryParse(productGty.text),
                      //                                                                   'shopDiscount':
                      //                                                                   null,
                      //                                                                   'shopId':
                      //                                                                   null,
                      //                                                                   'size':
                      //                                                                   null,
                      //                                                                   'status':
                      //                                                                   0,
                      //                                                                   'unit':
                      //                                                                   null,
                      //                                                                 });
                      //                                                             setState(
                      //                                                                     () {});
                      //                                                             FirebaseFirestore
                      //                                                                 .instance
                      //                                                                 .collection(
                      //                                                                 'quotation')
                      //                                                                 .doc(widget
                      //                                                                 .id)
                      //                                                                 .update({
                      //                                                               'items': items,
                      //                                                             }).then((value) {
                      //                                                               FirebaseFirestore
                      //                                                                   .instance
                      //                                                                   .collection(
                      //                                                                   'quotation')
                      //                                                                   .doc(widget
                      //                                                                   .id)
                      //                                                                   .update({
                      //                                                                 'price':sum+order['deliveryCharge'],
                      //                                                               });
                      //                                                             });
                      //
                      //                                                             submit = true;
                      //                                                             Navigator.pop(
                      //                                                                 context);
                      //                                                             showUploadMessage(
                      //                                                                 context,
                      //                                                                 '  Updated...');
                      //                                                             setState(() {
                      //
                      //                                                             });
                      //                                                           }
                      //                                                         },
                      //                                                         child: Text(
                      //                                                             'Update')),
                      //                                                   ],
                      //                                                 );
                      //                                               });
                      //                                         },
                      //
                      //                                         child: Card(
                      //                                           clipBehavior: Clip
                      //                                               .antiAliasWithSaveLayer,
                      //                                           color: Color(0xFFF1F5F8),
                      //                                           shape: RoundedRectangleBorder(
                      //                                             borderRadius:
                      //                                             BorderRadius.circular(
                      //                                                 8),
                      //                                           ),
                      //                                           child: Padding(
                      //                                             padding:
                      //                                             EdgeInsetsDirectional
                      //                                                 .fromSTEB(
                      //                                                 2, 2, 2, 2),
                      //                                             child: ClipRRect(
                      //                                               borderRadius:
                      //                                               BorderRadius.circular(
                      //                                                   8),
                      //                                               child: CachedNetworkImage(
                      //                                                 imageUrl: items[index]['image'],
                      //                                                 width: 90,
                      //                                                 height: 90,
                      //                                                 fit: BoxFit.cover,
                      //                                               ),
                      //                                             ),
                      //                                           ),
                      //                                         ),
                      //                                       ),
                      //                                     ),
                      //                                   ],
                      //                                 ),
                      //                                 Expanded(
                      //                                   child: Padding(
                      //                                     padding: EdgeInsetsDirectional
                      //                                         .fromSTEB(12, 0, 0, 0),
                      //                                     child: Column(
                      //                                       mainAxisSize: MainAxisSize.max,
                      //                                       mainAxisAlignment:
                      //                                       MainAxisAlignment.center,
                      //                                       crossAxisAlignment:
                      //                                       CrossAxisAlignment.start,
                      //                                       children: [
                      //                                         Text(
                      //                                           items[index]['name'],
                      //                                           style: FlutterFlowTheme
                      //                                               .subtitle1
                      //                                               .override(
                      //                                             fontFamily:
                      //                                             'Lexend Deca',
                      //                                             color:
                      //                                             Color(0xFF111417),
                      //                                             fontSize: 12,
                      //                                             fontWeight:
                      //                                             FontWeight.w600,
                      //                                           ),
                      //                                         ),
                      //                                         Padding(
                      //                                           padding:
                      //                                           EdgeInsetsDirectional
                      //                                               .fromSTEB(
                      //                                               0, 4, 0, 4),
                      //                                           child: Text(
                      //                                             items[index]['quantity'].toString()+' x '+items[index]['price'].toString(),
                      //                                             style:
                      //                                             FlutterFlowTheme
                      //                                                 .bodyText1
                      //                                                 .override(
                      //                                               fontFamily:
                      //                                               'Lexend Deca',
                      //                                               color: Color(
                      //                                                   0xFF090F13),
                      //                                               fontSize: 14,
                      //                                               fontWeight:
                      //                                               FontWeight
                      //                                                   .normal,
                      //                                             ),
                      //                                           ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ),
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                             // Padding(
                      //                             //   padding: EdgeInsetsDirectional.fromSTEB(
                      //                             //       16, 4, 16, 4),
                      //                             //   child: Row(
                      //                             //     mainAxisSize: MainAxisSize.max,
                      //                             //     mainAxisAlignment:
                      //                             //     MainAxisAlignment.spaceBetween,
                      //                             //     children: [
                      //                             //       Text(
                      //                             //         '[Price]',
                      //                             //         style: FlutterFlowTheme
                      //                             //             .subtitle1
                      //                             //             .override(
                      //                             //           fontFamily: 'Lexend Deca',
                      //                             //           color: Color(0xFF151B1E),
                      //                             //           fontSize: 18,
                      //                             //           fontWeight: FontWeight.w500,
                      //                             //         ),
                      //                             //       ),
                      //                             //     ],
                      //                             //   ),
                      //                             // ),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           );
                      //         })
                      //   ],
                      // ),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xFFDBE2E7),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Customer Details',
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF090F13),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Name : $name',
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF8B97A2),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mobile : $mobile',
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF8B97A2),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Address : $companyAddress',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF8B97A2),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'City : $city',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF8B97A2),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'State : $state',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF8B97A2),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Pincode : $pincode',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF8B97A2),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      Divider(
                        height: 2,
                        thickness: 2,
                        color: Color(0xFFDBE2E7),
                      ),
                      //bank Details

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Bank Details',
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF090F13),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Account Name : '+accName!,
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF8B97A2),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Account Number : '+acNo!,
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF8B97A2),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bank Name : '+bankname!,
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF8B97A2),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'IFCS code : '+ifsc!,
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF8B97A2),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),

                          ],
                        ),
                      ),
                      data['status']==0?Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: FFButtonWidget(
                              onPressed: () async {
                                bool proceed = await alert(
                                    context, 'Do you Want Reject this vendor?');
                                if(proceed){
                                  data.reference.update({
                                    'status':2
                                  });
                                  Navigator.pop(context);
                                  showUploadMessage(context, 'Accepted');
                                }
                              },
                              text: 'Reject',
                              options: FFButtonOptions(
                                width: 110,
                                height: 40,
                                color: Colors.red,
                                textStyle:TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13
                                ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: FFButtonWidget(
                              onPressed: () async {
                                bool proceed = await alert(
                                    context, 'Do you Want Accept this Vendor?');
                                if(proceed){
                                 data.reference.update({
                                   'status':1
                                 });
                                  Navigator.pop(context);
                                  showUploadMessage(context, 'Accepted');
                                }

                              },
                              text: 'Accept',
                              options: FFButtonOptions(
                                width: 110,
                                height: 40,
                                color: Colors.teal,
                                textStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13
                                ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 12,
                              ),
                            ),
                          ),
                        ],
                      ):
                      data['status']==1?Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: FFButtonWidget(
                              onPressed: () async {
                                bool proceed = await alert(
                                    context, 'Do you Want Reject this vendor?');
                                if(proceed){
                                  data.reference.update({
                                    'status':2
                                  });
                                  Navigator.pop(context);
                                  showUploadMessage(context, 'Accepted');
                                }
                              },
                              text: 'Reject',
                              options: FFButtonOptions(
                                width: 110,
                                height: 40,
                                color: Colors.red,
                                textStyle:TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13
                                ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 12,
                              ),
                            ),
                          ),
                        ],
                      ):Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: FFButtonWidget(
                              onPressed: () async {
                                bool proceed = await alert(
                                    context, 'Do you Want Accept this Vendor?');
                                if(proceed){
                                  data.reference.update({
                                    'status':1
                                  });
                                  Navigator.pop(context);
                                  showUploadMessage(context, 'Accepted');
                                }

                              },
                              text: 'Accept',
                              options: FFButtonOptions(
                                width: 110,
                                height: 40,
                                color: Colors.teal,
                                textStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13
                                ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
            ),
          ),
        ),
      ),
    );
  }
}
