import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demovendoradminapp/navbar/request/sellerDetails.dart';
import 'package:flutter/material.dart';


import '../../globals/colors.dart';

class SellerPendingRequest extends StatefulWidget {
  const SellerPendingRequest({Key? key}) : super(key: key);

  @override
  State<SellerPendingRequest> createState() => _SellerPendingRequestState();
}

class _SellerPendingRequestState extends State<SellerPendingRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Seller Request',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body:    SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('vendor')
                    .where('status',isEqualTo: 0)
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
                                              imageUrl: data![index]['companyInformation']['photoUrl']==''?'https://cdn1.iconfinder.com/data/icons/ecommerce-gradient/512/ECommerce_Website_App_Online_Shop_Gradient_greenish_lineart_Modern_profile_photo_person_contact_account_buyer_seller-512.png':data[index]['photoUrl'],
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
          ],
        ),
      ),
    );
  }
}
