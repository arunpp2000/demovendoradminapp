import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


import '../globals/colors.dart';
import '../model/brandModel.dart';
import '../model/usermodel.dart';
import 'brandViewPage.dart';

class Brandrequest extends StatefulWidget {

  AddBrand? brandData;
  Brandrequest({super.key, this.brandData});

  @override
  State<Brandrequest> createState() => _BrandrequestState();
}

class _BrandrequestState extends State<Brandrequest> {

String ? vendorId;
String? vendorName;
getVendor(){
  FirebaseFirestore.instance.collection('vendor').doc(vendorId).get().then((value){
    vendorName=value.data()!['name'];
  });
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getVendor();
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
            EdgeInsets.only(top: h * 0.02, left: w * 0.02, right: w * 0.02),
            child: Column(children: [
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text("Brand requests",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: w * 0.035,
                                    fontWeight: FontWeight.bold))),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 350,
                          height: 1.5,
                          child: ColoredBox(color: Colors.grey),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("brands").where('status',isEqualTo: 0).orderBy('date',descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child:CircularProgressIndicator());
                              }
                              var brands = snapshot.data!.docs;




                              return
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: brands.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                            vendorId=brands[index]['venderId'];
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            children: [

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,

                                                children: [

                                                  RichText(
                                                    text: new TextSpan(
                                                      text: '',
                                                      children: <TextSpan>[
                                                        new TextSpan(
                                                            text: 'Ref No: ',
                                                            style: new TextStyle(
                                                                color: Colors.black,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize: w * 0.030)),
                                                        new TextSpan(
                                                            text: '4174747',
                                                            style: new TextStyle(
                                                                color: primaryColor,
                                                                fontSize: w * 0.030)),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                              Text( brands[index]["brand"].toString().toUpperCase()??"",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                              Text('Requested Date :'+ DateFormat("dd-MM-yyyy").format(
                                              brands[index]['date'].toDate()),style: TextStyle(color: primaryColor,),),

                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                              Text(brands[index]["brand"].toString().toUpperCase()??"",style: TextStyle(color: Colors.black,),),

                                              TextButton(
                                                    onPressed: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandViewPage(
                                                        id:brands[index]['brandId']
                                                      )));
                                                    },
                                                    child: Container(
                                                      width: w * 0.250,
                                                      height: h * 0.05,
                                                      decoration: BoxDecoration(
                                                          color: primaryColor,
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  6))),
                                                      child: Center(
                                                          child: Text(
                                                            "View",
                                                            style: TextStyle(
                                                                color: Colors.white),
                                                          )),
                                                    )),

                                                ],
                                              ),
                                              // ListTile(
                                              //   title: Text(
                                              //       vendorName??""),
                                              //   subtitle: Text(
                                              //       brands[index]["brand"]),
                                              //   trailing:
                                              // ),
                                              Divider(
                                                endIndent: 0,
                                                indent: 0,
                                                height: 5,
                                                thickness: 1,
                                                color: Colors.grey.shade400,
                                              )
                                            ],
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
            height: h * 0.05,
            width: w * 2,
            decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(w * 0.03),
                    topRight: Radius.circular(w * 0.02))),
          )
        ]),
      ),
    );
  }
}