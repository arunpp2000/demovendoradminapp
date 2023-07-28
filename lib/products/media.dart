import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:video_player/video_player.dart';

import '../../../globals/colors.dart';
import '../../../model/addProductModel.dart';
import '../../../model/usermodel.dart';
import '../login/splashscreen.dart';
import '../navbar/Navbar.dart';
import '../widgets/uploadmedia.dart';
import 'edit/videoViewer.dart';


class Media extends StatefulWidget {
   final AddProductModel? model;
  Media( {
    Key? key,this. model,
  });
  @override
  State<Media> createState() => _MediaState();
}

class _MediaState extends State<Media> {
  final picker = ImagePicker();

  final storage = FirebaseStorage.instance;
  bool selectall = false;
  File? _video;
  VideoPlayerController? _videoPlayerController;
  List  videoUrl=[];

  Future<void> _pickvideo() async {
    setState(() {
      isLoading=true;

    });

    final video = await picker.getVideo(source: ImageSource.gallery);
    final videoFile = File(video!.path);
    setState(() {
      _video = videoFile;
    });

    // Get a reference to the location where the video will be stored in Firebase storage.
    final videoRef = storage
        .ref()
        .child('videos/${DateTime.now().millisecondsSinceEpoch}.mp4');

    // Upload the video to Firebase storage.
    final uploadTask = videoRef.putFile(videoFile);
    final snapshot = await uploadTask.whenComplete(() {});

    // Get the download URL of the uploaded video.
    final downloadURL = await snapshot.ref.getDownloadURL();
    videoUrl.add(downloadURL);

    // Save the download URL to Firestore or wherever you need it.
    // ...

    // Initialize a VideoPlayerController with the selected video file.
    _videoPlayerController = VideoPlayerController.file(videoFile)
      ..initialize().then((_) {
        setState(() {
          _videoPlayerController?.pause();
        });
      });
    setState(() {
      isLoading=false;
    });
  }

  String videourl = '';
  bool isLoading=false;

  final picker1 = ImagePicker();

  List<Asset> productImages = [];
  List<String> productUrls = [];
  List<String> downloadUrls = [];
  String? pdfurl;

  Future<void> uploadPDFStorage(File file) async {
    try {
      // Get reference to the Firebase Storage bucket
      final FirebaseStorage storage = FirebaseStorage.instance;
      final Reference ref = storage.ref().child('pdfs').child('my_pdf.pdf');

      // Upload file to Firebase Storage
      final UploadTask uploadTask = ref.putFile(file);
      final TaskSnapshot downloadUrl = await uploadTask;
      final String url = await downloadUrl.ref.getDownloadURL();
      pdfurl = url;

      print('PDF uploaded to Firebase Storage with URL: $pdfurl');
    } catch (e) {
      print('Error uploading PDF to Firebase Storage: $e');
    }
  }

  uploadproductImages(List<Asset> images) async {
    for (int i = 0; i < images.length; i++) {
      String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref().child(fileName);

      final byteData = await images[i].getByteData();
      final imageData = byteData.buffer.asUint8List();

      try {
        await ref.putData(imageData);
        String url = await ref.getDownloadURL();
        productUrls.add(url);

      } on firebase_storage.FirebaseException catch (e) {
        print(e);
      }
    }
    return productUrls;

  }

  List productImage = [];
  List productImageUrls = [];

  getGallaryimages() async {
    final List<XFile>? pickedimage = await picker.pickMultiImage();

    if (pickedimage != null) {
      pickedimage.forEach((e) async {
        productImage.add(File(e.path));
      });
      setState(() {});
    }
    productImageUrls=[];
    for (int i = 0; i < productImage.length; i++) {
      String url = await uploadfiles(productImage[i]);
      productImageUrls.add(url);
    }
    setState(() {

    });
  }

  Future<String> uploadfiles(File file) async {
    final metaData = SettableMetadata(contentType: 'image/jpeg');
    final storageref = FirebaseStorage.instance.ref();
    Reference ref = storageref
        .child('pictures/${DateTime.now().microsecondsSinceEpoch}.jpg');
    final uploadTask = ref.putFile(file, metaData);

    final taskSnapshot = await uploadTask.whenComplete(() => null);
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  TextEditingController youtubeUrl = TextEditingController();
  File? _pdfFile;
  bool check = false;
  bool image1 = false;
  bool image2 = false;
  bool image3 = false;
  bool video = false;
  List docId=[];
  Map checkmap = {};
  bool isChecked = false;
  @override
  void initState() {

    super.initState();
   // getId();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding:
          const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: w * 0.1,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          getGallaryimages();
                          //uploadproductImages();
                        },
                        child: Container(
                          height: h * 0.09,
                          width: w * 0.250,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: SvgPicture.asset(
                                "assets/uplodimage.svg",
                                height: h * 0.07,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      Text(
                        "Upload Image",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: primaryColor1,
                                fontSize: h * 0.015,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  SizedBox(
                    width: w * 0.2,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _pickvideo();
                        },
                        child: Container(
                          height: h * 0.09,
                          width: w * 0.250,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: SvgPicture.asset(
                                "assets/uplodvideo.svg",
                                height: h * 0.05,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      Text(
                        "Upload Video",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: primaryColor1,
                                fontSize: h * 0.015,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Images",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: primaryColor1,
                            fontSize: h * 0.015,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: w * 0.200,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/selsecfrommedia.svg"),
                      SizedBox(
                        width: w * 0.015,
                      ),
                      Text(
                        "Select From Media Library",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: primaryColor1,
                                fontSize: h * 0.015,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                height: h * 0.03,
                thickness: h * 0.002,
                color: Color(0xffB3B3B3),
              ),
              ListTile(
                leading:
                Checkbox(
                  activeColor: primaryColor,
                  value: selectall,
                  onChanged: (bool? value) {
                    if (selectall) {
                      for (var a in productImageUrls) {
                        checkmap.remove(a);
                      }
                      for (var a in videoUrl) {
                        checkmap.remove(a);
                      }
                    } else {
                      for (var a in productImageUrls) {
                        checkmap[a] = true;
                      }
                      for (var a in videoUrl) {
                        checkmap[a] = true;
                      }
                    }
                    setState(() {
                      selectall = value!;
                    });
                  },
                ),

                title: Text(
                  "Select All",
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: h * 0.015,
                          fontWeight: FontWeight.bold)),
                ),
                trailing: InkWell(
                  onTap: () {
    List keysToRemove = checkmap.keys.toList();
    for (var a in keysToRemove) {
      checkmap.remove(a);
      productImageUrls.remove(a);
      videoUrl.remove(a);

      productImage.clear();
    }
                    setState(() {

                    });
                  },
                  child: Container(
                    height: h * 0.04,
                    width: w * 0.200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xffFF0000)),
                    child: Center(
                        child: Text(
                          "Delete",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: h * 0.015,
                                  fontWeight: FontWeight.bold)),
                        )),
                  ),
                ),
              ),
              Divider(
                height: h * 0.03,
                thickness: h * 0.002,
                color: Color(0xffB3B3B3),
              ),

              productImageUrls.isEmpty?Stack(
                  clipBehavior: Clip.none,
                  children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [
                          Checkbox(
                            activeColor: primaryColor,
                            value:isChecked,
                            onChanged: (val) {


                              setState(() {});
                            },
                          ),
                          Container(
                            height: h * 0.15,
                            width: w * 0.350,
                            decoration:
                            BoxDecoration(color: Colors.grey.shade300),
                          ),
                        ],
                      ),
                      Container(
                        height: h * 0.04,
                        width: w * 0.200,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            "Replace",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: h * 0.015,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: w * 0.37,
                  bottom: h * 0.13,
                  child: Container(
                    width: w * 0.2,
                    height: h * 0.04,
                    child: const Icon(
                      Icons.clear,
                      color: Color.fromARGB(255, 254, 253, 255),
                      size: 25,
                    ),
                    decoration: const BoxDecoration(
                        color: Color(0xff8C31FF),
                        shape: BoxShape.circle),
                  ),
                )
              ]):
              Container(
                height: h * 0.35,
                width: w,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    itemCount: productImageUrls.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(clipBehavior: Clip.none,
                          children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    activeColor: primaryColor,
                                    value:
                                    checkmap.containsKey(productImageUrls[index]),
                                    onChanged: (val) {
                                      if (checkmap
                                          .containsKey(productImageUrls[index])) {
                                        checkmap.remove(productImageUrls[index]);
                                      } else {
                                        checkmap[productImageUrls[index]] = true;
                                      }

                                      setState(() {});
                                    },
                                  ),
                                  Container(
                                    height: h * 0.15,
                                    width: w * 0.350,
                                    decoration:
                                    BoxDecoration(color: Colors.grey.shade300),
                                    child: CachedNetworkImage(imageUrl: productImageUrls[index],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                  onTap: () {

                                    setState(() {
                                      productImageUrls.removeAt(index);

                                      productImage.removeAt(index);
                                      getGallaryimages();


                                    });
                                  },
                                  child: Container(
                                    height: h * 0.04,
                                    width: w * 0.200,
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Text(
                                        "Replace",
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: h * 0.015,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Positioned(
                          left: w * 0.40,
                          bottom: h * 0.13,
                          child: InkWell(
                            onTap: () {
                              productImageUrls.removeAt(index);

                              productImage.removeAt(index);
                              setState(() {});
                            },
                            child: Container(
                              width: w * 0.2,
                              height: h * 0.04,
                              child: const Icon(
                                Icons.clear,
                                color: Color.fromARGB(255, 254, 253, 255),
                                size: 25,
                              ),
                              decoration: const BoxDecoration(
                                  color: Color(0xff8C31FF),
                                  shape: BoxShape.circle),
                            ),
                          ),
                        )
                      ]);
                    }),
              ),


              SizedBox(
                height: h * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Videos",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: primaryColor1,
                                  fontSize: h * 0.015,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          width: w * 0.01,
                        ),
                        Text(
                          "(Upload a Video or Add URL)",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: primaryColor, fontSize: h * 0.011)),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        SvgPicture.asset("assets/selsecfrommedia.svg"),
                        SizedBox(
                          width: w * 0.015,
                        ),
                        Text(
                          "Select From Library",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: primaryColor1,
                                  fontSize: h * 0.015,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Divider(
                height: h * 0.03,
                thickness: h * 0.002,
                color: Color(0xffB3B3B3),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              videoUrl.isNotEmpty
                  ? Container(
                height: h * 0.35,
                width: w,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    itemCount: videoUrl.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Checkbox(
                                  activeColor: primaryColor,
                                  value:
                                  checkmap.containsKey(videoUrl[index]),
                                  onChanged: (val) {
                                    if (checkmap
                                        .containsKey(videoUrl[index])) {
                                      checkmap.remove(videoUrl[index]);
                                    } else {
                                      checkmap[videoUrl[index]] = true;
                                    }
                                    setState(() {});
                                  },
                                ),
                                Stack(
                                    clipBehavior: Clip.none, children: [
                                  //videoPlayerController==null?
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VideoViewer(
                                                      video:
                                                      videoUrl[index])));
                                    },
                                    child:  Container(
                                      height: h * 0.15,
                                      width: w * 0.35,
                                      decoration: BoxDecoration(
                                          color: Colors.black
                                        // image: DecorationImage(image: NetworkImage(widget.data?.imageId!),fit: BoxFit.contain)
                                      ),
                                      child: isLoading?Center(child: CircularProgressIndicator()):Center(
                                        child: Icon(
                                          Icons.play_circle_fill_outlined,
                                          size: 50,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: w * 0.23,
                                    bottom: h * 0.12,
                                    child: InkWell(
                                      onTap: () {
                                        videoUrl.removeAt(index);

                                        setState(() {});
                                      },
                                      child: Container(
                                        width: w * 0.2,
                                        height: h * 0.04,
                                        child: const Icon(
                                          Icons.clear,
                                          color: Color.fromARGB(
                                              255, 254, 253, 255),
                                          size: 25,
                                        ),
                                        decoration: const BoxDecoration(
                                            color: Color(0xff8C31FF),
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                  )
                                ]),

                              ],
                            ),
                            InkWell(
                              onTap: () {
                                videoUrl.removeAt(index);

                                _pickvideo();
                                setState(() {});
                              },
                              child: Container(
                                height: h * 0.04,
                                width: w * 0.200,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius:
                                    BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    "Replace",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: h * 0.015,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            )
                            // SizedBox(
                            //   width: w * 0.03,
                            // ),


                          ],
                        ),
                      );
                    }),
              )
                  : Row(
                children: [
                  Checkbox(
                    activeColor: primaryColor,
                    value: check,
                    onChanged: (bool? value) {},
                  ),
                  SizedBox(
                    width: w * 0.03,
                  ),
                  Stack(clipBehavior: Clip.none,
                      children: [
                        //videoPlayerController==null?
                        Container(
                          height: h * 0.15,
                          width: w * 0.35,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300
                            // image: DecorationImage(image: NetworkImage(widget.data?.imageId!),fit: BoxFit.contain)
                          ),
                        ),
                        Positioned(
                          left: w * 0.23,
                          bottom: h * 0.12,
                          child: Container(
                            width: w * 0.2,
                            height: h * 0.04,
                            child: const Icon(
                              Icons.clear,
                              color: Color.fromARGB(255, 254, 253, 255),
                              size: 25,
                            ),
                            decoration: const BoxDecoration(
                                color: Color(0xff8C31FF),
                                shape: BoxShape.circle),
                          ),
                        )
                      ]),
                  SizedBox(
                    width: w * 0.1,
                  ),
                  Container(
                    height: h * 0.04,
                    width: w * 0.200,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        "Replace",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: h * 0.015,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        "Recommended Video Resolution - 1920x1080 (16:9 Ratio)",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: primaryColor,
                              fontSize: h * 0.012,
                            )),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        "Upload Size Limit - 25 MB",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: primaryColor,
                              fontSize: h * 0.010,
                            )),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        "Recommended Video Length - 1 Minute",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: primaryColor,
                              fontSize: h * 0.010,
                            )),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        "Upload a video or Add url. Not Both at same time",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: primaryColor,
                              fontSize: h * 0.010,
                            )),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: h * 0.01,
              ),
              SizedBox(
                height: h * 0.02,
              ),
              InkWell(
                onTap: ()  async {
                  if(productImageUrls!=[]){
                    {
                      await showDialog(context: context,
                      builder: (context) {
                        return AlertDialog(
                            title: Text(
                                'Add Product?'),
                            content: Text(
                                'Do you want to Continue?'),
                            actions: [
                              TextButton(
                                  child: Text(
                                    'Cancel',style: TextStyle(color: Colors.black),),
                                  onPressed: () {
                                    Navigator.of(
                                        context)
                                        .pop();
                                  }),
                              TextButton(
                                  child: Text('Ok',style: TextStyle(color: Colors.black),),
                                  onPressed: () {
                                    var a = widget.model;
                                    a?.imageId=productImageUrls;
                                    a?.videoUrl=videoUrl;
                                    FirebaseFirestore.instance
                                        .collection("products")
                                        .add(a!.toJson()).then((value) {
                                      value.update({
                                        'productId':value.id,

                                      });
                                      showUploadMessage(
                                        context,
                                        'Product Added Successfully',

                                      );
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NavBar()));
                                    });

                                  }),

                            ]);
                      }
                      );
                    }
                  }
                  else{
                    productImageUrls == [] ?
                    showUploadMessage(context, 'Please upload images'):Container();
                  }


                  setState(() {

                  });
   },
                child: Container(
                  height: h * 0.06,
                  width: w * 0.800,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              SizedBox(
                height: h * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
