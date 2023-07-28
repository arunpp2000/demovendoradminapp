import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login/splashscreen.dart';
import '../widgets/uploadmedia.dart';
import 'addProduct.dart';
import '../globals/colors.dart';
List selectedProduct=[];
Map idToName={};
Map nameToId={};


class RelatedProduct extends StatefulWidget {
  final Function set;
  const RelatedProduct({Key? key, required this.set, }) : super(key: key);

  @override
  State<RelatedProduct> createState() => _RelatedProductState();
}

class _RelatedProductState extends State<RelatedProduct> {
  late Stream<QuerySnapshot> productStream;
  TextEditingController productSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    productStream = FirebaseFirestore.instance
        .collection("products")
        .where("delete", isEqualTo: false)
        .snapshots();

  }



  getProducts(){

    FirebaseFirestore.instance.collection('products').get().then((value){
      for(DocumentSnapshot doc in value.docs){
        idToName[doc.get('name')]=doc.id;
        nameToId[doc.id]=doc.get('name');
      }
    });
  }
 @override
  Widget build(BuildContext context) {
    getProducts();
    return Scaffold(
      appBar: AppBar(title:Text( "Related Products",),
      leading: IconButton(onPressed: () { Navigator.pop(context);
        setState(() {

        });}, icon: Icon(Icons.arrow_back),),
      backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: h,
          width: w,
          decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [BoxShadow(color: Colors.grey,blurRadius: w*0.02)]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                selectedProduct.isNotEmpty?
            Expanded(
              child: ListView.builder(
              itemCount: selectedProduct.length,
                itemBuilder: (BuildContext context, int index) {

                  return
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                          },
                          child: Container(

                            width: w,
                            height: h*0.06,

                            decoration: BoxDecoration(color: Color(0xffD5CBCB),borderRadius: BorderRadius.circular(5)),
                            child:
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                              Container(
                                                width: w * 0.70,
                                                child: Text(
                                                  (nameToId[selectedProduct[index]].toString()),
                                                  style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                      fontSize: h * 0.012,
                                                    ),
                                                  ),
                                                ),
                                              ),





                                    InkWell(onTap: (){
                                      selectedProduct.removeAt(index);
                                      setState(() {

                                      });
                                    },
                                        child: SvgPicture.asset("assets/Close.svg",color: Colors.red,))
                                  ],
                              ),
                               )


                          ),
                        ),
                      );


                },
              ),
            ):SizedBox(),
                selectedProduct.isNotEmpty?
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    ElevatedButton(onPressed:(){
                      selectedProduct.clear();
                      setState(() {

                      });
                    },style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,), child: Text("Clear All"))
                  ],
                ):SizedBox(),


                Container(
                  height: h*0.05,
                  width: w,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                  color: Color(0xffDADADA)),
                  child: TextField(

                    controller: productSearch,
                    onChanged: (value) {
                      setState(() {
                        productStream = FirebaseFirestore.instance
                            .collection("products")
                            .where('search',
                            arrayContains: productSearch.text.toUpperCase())
                            //.where("delete", isEqualTo: false)
                            .snapshots();
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:const EdgeInsets.all(9.0),

                      hintText: 'Search Related Product',
                      suffixIcon: Icon(Icons.search_rounded,color: primaryColor,)
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: productStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        print("Error: ${snapshot.error}");
                        return Text('Error occurred');
                      }

                      var data = snapshot.data!.docs;

                      return
                        ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if(selectedProduct.contains(data[index]['productId'])){
                                        showUploadMessage(
                                            context,
                                            'Already Added');
                                    }else{
                                      selectedProduct.add(
                                        data[index]["productId"],
                                      );
                                    }
                                  });
                                  widget.set();
                                  setState(() {

                                  });
                                },
                                child: Container(
                                  width: w,
                                  decoration: BoxDecoration(color: Colors.white),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: h * 0.02,
                                      left: w * 0.001,
                                      bottom: h * 0.01,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: w * 0.70,
                                                child: Text(
                                                  (data[index]["name"]),
                                                  style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                      fontSize: h * 0.012,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: h * 0.01,
                                thickness: h * 0.0015,
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
