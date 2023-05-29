import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';


import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:video_player/video_player.dart';



import '../globals/colors.dart';
import '../model/usermodel.dart';


var productId;

class Media extends StatefulWidget {
  var pId;

  Media({
    super.key,
    this.pId,
  });

  @override
  State<Media> createState() => _MediaState();
}

class _MediaState extends State<Media> {
  final picker = ImagePicker();

  final storage = FirebaseStorage.instance;

  File? _video;
  late VideoPlayerController _videoPlayerController;
  String? videoUrl;

  Future<void> _pickvideo() async {
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
    videoUrl = downloadURL;

    // Save the download URL to Firestore or wherever you need it.
    // ...

    // Initialize a VideoPlayerController with the selected video file.
    _videoPlayerController = VideoPlayerController.file(videoFile)
      ..initialize().then((_) {
        setState(() {
          _videoPlayerController.pause();
        });
      });
  }

  // late VideoPlayerController _videoPlayerController;
  // File? _video;
  // final picker = ImagePicker();
  // _pickvideo() async {
  //   final video = await picker.getVideo(source: ImageSource.gallery);
  //   _video = File(video!.path);
  //   _videoPlayerController = VideoPlayerController.file(_video!)
  //     ..initialize().then((_) {
  //       setState(() {});
  //       _videoPlayerController.pause();
  //     });
  // }

  String videourl = '';

  final picker1 = ImagePicker();

  // List<Asset> _images = [];
  // Future<void> _pickImages() async {
  //   List<Asset> resultList = [];
  //   try {
  //     resultList = await MultiImagePicker.pickImages(
  //       maxImages: 3,

  //       selectedAssets: _images,
  //       cupertinoOptions: CupertinoOptions(
  //         takePhotoIcon: "chat",
  //       ),
  //       materialOptions: MaterialOptions(
  //         actionBarColor: "#abcdef",
  //         actionBarTitle: "Pick 3 images",
  //         allViewTitle: "All Photos",
  //         useDetailsView: false,
  //         selectCircleStrokeColor: "#000000",
  //       ),
  //     );
  //   } on Exception catch (e) {
  //     print(e.toString());
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _images = resultList;
  //   });
  // }

  List<Asset> productImages = [];
  List<String> productUrls = [];
  List<String> downloadUrls = [];
  String? pdfurl;

  // getProductimages() async {
  //   final List<XFile>? pickedimages = await picker1.pickMultiImage();

  //   if (pickedimages != null) {
  //     pickedimages.forEach((e) async {
  //       productImages.add(File(e.path));
  //     });
  //     setState(() {});
  //   }
  //   for (int i = 0; i < productImages.length; i++) {
  //     String url = await uploadfiles(productImages[i]);
  //     downloadUrls.add(url);
  //   }
  // }

  // Future<String> uploadfiles(File file) async {
  //   final metaData = SettableMetadata(contentType: 'image/jpeg');
  //   final storageref = FirebaseStorage.instance.ref();
  //   Reference ref = storageref
  //       .child('pictures/${DateTime.now().microsecondsSinceEpoch}.jpg');
  //   final uploadTask = ref.putFile(file, metaData);

  //   final taskSnapshot = await uploadTask.whenComplete(() => null);
  //   String url = await taskSnapshot.ref.getDownloadURL();
  //   return url;
  // }

  void UploadPdf() async {
    File? file = await pickPDF();
    if (file != null) {
      await uploadPDFStorage(file);
    }
  }

  Future<File?> pickPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        File file = File(result.files.single.path!);
        return file;
      } else {
        print('User canceled the file picking');
        return null;
      }
    } catch (e) {
      print('Error picking PDF file: $e');
      return null;
    }
  }

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
        print('Image uploaded: $fileName');
      } on firebase_storage.FirebaseException catch (e) {
        print(e);
      }
    }
    return productUrls;
  }

  List<Asset> resultList = [];

  loadAssets() async {
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
      );
    } on Exception catch (e) {
      print(e);
    }

    setState(() {
      productImages = resultList;
    });
  }

  // }

//   Future<void> _pickPDF() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(

//       type: FileType.custom,
//       allowedExtensions: ['pdf'],

//     );
//     if (result != null) {
//       setState(() {
//         _pdfFile = File(result.files.single.path!);
//       });

// Future<void> uploadPDF(File file) async {
//   try {
//     // Get reference to the Firebase Storage bucket
//     final FirebaseStorage storage = FirebaseStorage.instance;
//     final Reference ref = storage.ref().child('pdfs').child('my_pdf.pdf');

//     // Upload file to Firebase Storage
//     final UploadTask uploadTask = ref.putFile(file);
//     final TaskSnapshot downloadUrl = await uploadTask;
//     final String url = await downloadUrl.ref.getDownloadURL();

//     print('PDF uploaded to Firebase Storage with URL: $url');
//   } catch (e) {
//     print('Error uploading PDF to Firebase Storage: $e');
//   }
// }

//       // Do something with the PDF file

//       // Upload the file to your server or cloud storage
//     }
//   }

  TextEditingController youtubeUrl = TextEditingController();
  File? _pdfFile;
  bool check = false;
  bool image1 = false;
  bool image2 = false;
  bool image3 = false;
  bool video = false;
  @override
  Widget build(BuildContext context) {
    productId = widget.pId;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                        onTap: loadAssets,
                        child: Container(
                          height: h * 0.09,
                          width: w * 0.250,
                          decoration: BoxDecoration(color: primaryColor),
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
                        "Uplode Image",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: primaryColor,
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
                        onTap: () {},
                        child: Container(
                          height: h * 0.09,
                          width: w * 0.250,
                          decoration: BoxDecoration(color: primaryColor),
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
                                color: primaryColor,
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
                children: [
                  Text(
                    "Images",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: primaryColor,
                            fontSize: h * 0.015,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: w * 0.200,
                  ),
                  SvgPicture.asset("assets/selsecfrommedia.svg"),
                  SizedBox(
                    width: w * 0.015,
                  ),
                  Text(
                    "Select From Media Library",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: primaryColor,
                            fontSize: h * 0.015,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Divider(
                height: h * 0.03,
                thickness: h * 0.002,
                color: Color(0xffB3B3B3),
              ),
              ListTile(
                leading: Checkbox(
                  activeColor: primaryColor,
                  value: check,
                  onChanged: (bool? value) {
                    setState(() {
                      check = value!;

                      image1 = value!;
                      image2 = value;
                      image3 = value;
                      video = value;
                    });
                  },
                ),
                title: Text(
                  "Sellect All",
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: h * 0.015,
                          fontWeight: FontWeight.bold)),
                ),
                trailing: InkWell(
                  onTap: () {
                    productImages.clear();
                  },
                  child: Container(
                    height: h * 0.04,
                    width: w * 0.250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
              Row(
                children: [
                  Checkbox(
                    activeColor: primaryColor,
                    value: image1,
                    onChanged: (bool? value) {
                      setState(() {
                        image1 = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: w * 0.09,
                  ),
                  Stack(clipBehavior: Clip.none, children: [
                    productImages.length > 0
                        ? Container(
                      height: h * 0.15,
                      width: w * 0.350,
                      decoration:
                      BoxDecoration(color: Colors.grey.shade300),
                      child: AssetThumb(
                        asset: productImages[0],
                        width: 350,
                        height: 300,
                      ),
                    )
                        : Container(
                      height: h * 0.15,
                      width: w * 0.350,
                      decoration:
                      BoxDecoration(color: Colors.grey.shade300),
                    ),
                    Positioned(
                      left: w * 0.24,
                      bottom: h * 0.12,
                      child: InkWell(
                        onTap: () {
                          print(productImages);
                          productImages.removeAt(0);

                          // image = null;
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
                              color: Color(0xff8C31FF), shape: BoxShape.circle),
                        ),
                      ),
                    )
                  ]),
                  SizedBox(
                    width: w * 0.1,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: h * 0.05,
                      width: w * 0.200,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(15)),
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
                ],
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: primaryColor,
                    value: image2,
                    onChanged: (bool? value) {
                      setState(() {
                        image2 = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: w * 0.09,
                  ),
                  Stack(clipBehavior: Clip.none, children: [
                    productImages.length > 1
                        ? Container(
                      height: h * 0.15,
                      width: w * 0.350,
                      decoration:
                      BoxDecoration(color: Colors.grey.shade300),
                      child: AssetThumb(
                          asset: productImages[1],
                          width: 350,
                          height: 300),
                    )
                        : Container(
                        height: h * 0.15,
                        width: w * 0.350,
                        decoration:
                        BoxDecoration(color: Colors.grey.shade300)),
                    Positioned(
                      left: w * 0.24,
                      bottom: h * 0.12,
                      child: InkWell(
                        onTap: () {
                          productImages.removeAt(1);
                          // image = null;
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
                              color: Color(0xff8C31FF), shape: BoxShape.circle),
                        ),
                      ),
                    )
                  ]),
                  SizedBox(
                    width: w * 0.1,
                  ),
                  Container(
                    height: h * 0.05,
                    width: w * 0.200,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(15)),
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
              Row(
                children: [
                  Checkbox(
                    activeColor: primaryColor,
                    value: image3,
                    onChanged: (bool? value) {
                      setState(() {
                        image3 = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: w * 0.09,
                  ),
                  Stack(clipBehavior: Clip.none, children: [
                    productImages.length > 2
                        ? Container(
                      height: h * 0.15,
                      width: w * 0.350,
                      decoration:
                      BoxDecoration(color: Colors.grey.shade300),
                      child: AssetThumb(
                        asset: productImages[2],
                        width: 350,
                        height: 300,
                      ),
                    )
                        : Container(
                      height: h * 0.15,
                      width: w * 0.350,
                      decoration:
                      BoxDecoration(color: Colors.grey.shade300),
                    ),
                    Positioned(
                      left: w * 0.24,
                      bottom: h * 0.12,
                      child: InkWell(
                        onTap: () {
                          productImages.removeAt(2);
                          // image = null;
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
                              color: Color(0xff8C31FF), shape: BoxShape.circle),
                        ),
                      ),
                    )
                  ]),
                  SizedBox(
                    width: w * 0.1,
                  ),
                  Container(
                    height: h * 0.05,
                    width: w * 0.200,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(15)),
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
              SizedBox(
                height: h * 0.02,
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                children: [
                  Text(
                    "Videos",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: primaryColor,
                            fontSize: h * 0.014,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: w * 0.01,
                  ),
                  Text(
                    "(Upload a Video or Add URL)",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: primaryColor, fontSize: h * 0.010)),
                  ),
                  SizedBox(
                    width: w * 0.02,
                  ),
                  SvgPicture.asset("assets/selsecfrommedia.svg"),
                  SizedBox(
                    width: w * 0.015,
                  ),
                  InkWell(
                    onTap: () {
                      _pickvideo();
                    },
                    child: Text(
                      "Select From Library",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: primaryColor,
                              fontSize: h * 0.014,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              Divider(
                height: h * 0.03,
                thickness: h * 0.002,
                color: Color(0xffB3B3B3),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: primaryColor,
                    value: video,
                    onChanged: (bool? value) {
                      setState(() {
                        video = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: w * 0.09,
                  ),
                  Stack(clipBehavior: Clip.none, children: [
                    _video != null
                        ? _videoPlayerController.value.isInitialized
                        ? Container(
                      height: h * 0.2,
                      width: w * 0.4,
                      child: VideoPlayer(_videoPlayerController),
                    )
                        : Container(
                      height: h * 0.01,
                      width: w * 0.300,
                      decoration: BoxDecoration(color: Colors.blue),
                    )
                        : Container(
                      height: h * 0.2,
                      width: w * 0.4,
                      decoration:
                      BoxDecoration(color: Colors.grey.shade300),
                    ),

                    //      Container(
                    //   width: w * 0.5,
                    //   height: h * 0.5,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(color: primaryColor),
                    //     borderRadius: BorderRadius.all(
                    //       Radius.circular(20),
                    //     ),
                    //   ),
                    //   child: Center(child: Text('Upload Video',style: GoogleFonts.poppins(
                    //       color: primaryColor
                    //   ),)),
                    // )
                    //     : Container(
                    //     width: w * 0.5,
                    //     height: h * 0.5,
                    //     decoration: BoxDecoration(
                    //
                    //       border: Border.all(color:primaryColor),
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(20),
                    //       ),
                    //     ),
                    //     child:_controller==null?SizedBox(): VideoPlayer(_controller!)
                    //
                    //
                    //
                    // ),

                    // Container(
                    //   height: h * 0.15,
                    //   width: w * 0.350,
                    //   decoration: BoxDecoration(color: Colors.grey.shade300),
                    // ),
                    //     // :Container( height: h * 0.15,
                    //     // width: w * 0.350,
                    //     // decoration: BoxDecoration(color: Colors.grey.shade300),child: _controller==null?SizedBox(): VideoPlayer(_controller!),),
                    Positioned(
                      left: w * 0.28,
                      bottom: h * 0.17,
                      child: InkWell(
                        onTap: () {
                          // image = null;
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
                              color: Color(0xff8C31FF), shape: BoxShape.circle),
                        ),
                      ),
                    )
                  ]),
                  SizedBox(
                    width: w * 0.1,
                  ),
                  Container(
                    height: h * 0.05,
                    width: w * 0.200,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(15)),
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
              Center(
                child: Container(
                  height: h * 0.12,
                  width: w * 0.800,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
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
                ),
              ),
              SizedBox(
                height: h * 0.01,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text("YouTube URL(Optional)",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: primaryColor,
                            fontSize: h * 0.015,
                            fontWeight: FontWeight.bold))),
              ),
              TextFormField(
                controller: youtubeUrl,
                decoration: InputDecoration(
                  hintText: "Add your YouTube video URL here.https://",
                  hintStyle: TextStyle(
                      color: const Color(0xffB3B3B3), fontSize: h * 0.015),
                  enabledBorder: const UnderlineInputBorder(
                    //<-- SEE HERE
                    borderSide: BorderSide(width: 1, color: Colors.black54),
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                children: [
                  Text(
                    "PDF Description",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: primaryColor,
                            fontSize: h * 0.015,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: w * 0.02,
                  ),
                  Text(
                    "(Upload  Product Specifications)",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: primaryColor, fontSize: h * 0.010)),
                  )
                ],
              ),
              Divider(
                height: h * 0.03,
                thickness: h * 0.002,
                color: Color(0xffB3B3B3),
              ),
              Row(
                children: [
                  _pdfFile != null
                      ? Container(
                      height: h * 0.05,
                      width: w * 0.450,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Text(
                        "selecte PDF file",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: h * 0.008, color: Colors.black)),
                      ))
                      : Container(
                    width: w * 0.450,
                    child: Text(
                      "",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(fontSize: h * 0.007)),
                    ),
                  ),
                  SizedBox(
                    width: w * 0.210,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.check_circle_outline,
                        size: h * 0.04,
                        color: Colors.green,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.clear,
                        size: h * 0.04,
                        color: Colors.red,
                      ))
                ],
              ),
              Stack(children: [
                Container(
                    height: h * 0.05,
                    width: w * 0.700,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: primaryColor)),
                    child: Center(
                        child: Text(
                          "Select File",
                          style: TextStyle(color: primaryColor),
                        ))),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: UploadPdf,
                    child: Container(
                        height: h * 0.05,
                        width: w * 0.300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryColor,
                            border: Border.all(color: primaryColor)),
                        child: const Center(
                            child: Text(
                              "Upload",
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                ),
              ]),
              Row(
                children: [
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(
                    "Supported Document :  pdf",
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
                    "File Size Limit : 1 Mb",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: primaryColor,
                          fontSize: h * 0.010,
                        )),
                  )
                ],
              ),
              SizedBox(
                height: h * 0.02,
              ),
              InkWell(
                onTap: () async {
                  List<String> producturl =
                  await uploadproductImages(productImages);
                  print(widget.pId);
                  print("====================");
                  print(currentUser!.id);
                  print("currentUser.id====================");
                  print("pdf url===================");
                  print(pdfurl);
                  print("video url===========");
                  print(videoUrl);
                  print(producturl);
                  print(widget.pId);
                  FirebaseFirestore.instance
                      .collection("products")
                      .doc(widget.pId)
                      .update({

                    "media": {
                      "photos": producturl,
                      "pdf": pdfurl,
                      "video": videoUrl,
                      "youtubeUrl": youtubeUrl.text,
                    }
                  }).then((value) {
                    Navigator.pop(context);
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
                height: h * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}