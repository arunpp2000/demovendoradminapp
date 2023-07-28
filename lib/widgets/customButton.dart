import 'package:flutter/material.dart';

import '../login/splashscreen.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  CustomButton({Key? key, required this.text, required this.onPressed,required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: w/2.7,
        height: h*0.07,
        child: ElevatedButton(

          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(

              primary: color,shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          ) ),

        ),
      ),
    );
  }
}
