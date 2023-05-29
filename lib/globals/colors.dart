import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';

import 'package:flutter/material.dart';

final primaryColor = Color(0xff8C31FF);
final primaryColor1=Color(0xff530CAD);
final gradient = LinearGradient(colors: [Color(0xff8C31FF), Color(0xff601AB9)]);

// void showUploadMessage(BuildContext context, String message,
//     {bool showLoading = false}) {
//   ScaffoldMessenger.of(context)
//     ..hideCurrentSnackBar()
//     ..showSnackBar(
//       SnackBar(
//         duration: showLoading
//             ? const Duration(minutes: 30)
//             : const Duration(seconds: 4),
//         backgroundColor: Color.fromARGB(255, 255, 253, 253),
//         content: Row(
//           children: [
//             if (showLoading)
//               Padding(
//                 padding: EdgeInsets.only(right: 12.0),
//                 child: CircularProgressIndicator(),
//               ),
//             Text(
//               message,
//               style: TextStyle(fontSize: 15, color: Colors.red),
//             ),
//           ],
//         ),
//       ),
//     );
// }