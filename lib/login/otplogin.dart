import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var h;
var w;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _phoneNumber;
  late String _verificationId;
  late String _smsCode;
  void _signInWithPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      // TODO: Handle sign-in result
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      print('Phone number verification failed: ${e.message}');
    };

    final PhoneCodeSent codeSent =
        (String verificationId, int? resendToken) async {
      print('Verification code sent to $_phoneNumber');
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91'+_phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      print('Failed to verify phone number: $e');
    }
  }
  // void _signInWithSmsCode() async {
  //   try {
  //     final PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: _verificationId,
  //       smsCode: _smsCode,
  //     );
  //
  //     final UserCredential userCredential =
  //     await _auth.signInWithCredential(credential);
  //     final User? user = userCredential.user;
  //     FirebaseFirestore.instance.collection("vendor").doc(user!.uid).set({
  //       "phone":_phoneNumber,
  //       "id":user.uid
  //     }).then((value) {Navigator.push(context, MaterialPageRoute(builder:(context)=>Profile_Details(userid: user.uid,)));});
  //     print("helooooooooooooooooooooooooo");
  //     print(user.uid);
  //     // TODO: Handle sign-in result
  //   } catch (e) {
  //     print('Failed to sign in with SMS code: $e');
  //   }
  // }


  @override



  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    var primaryColor = Color(0xff8C31FF);
    var Color2 = Color(0xff601AB9);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: h * 0.50,
                width: w * 1,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xff8C31FF),
                        Color(0xff601AB9),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(w * 0.05),
                        bottomLeft: Radius.circular(w * 0.05))),
              ),
              Container(
                height: h * 0.30,
                width: w * 0.60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/Group 452.png"),
                        fit: BoxFit.fill)),
              ),
              Positioned(
                top: h * 0.20,
                left: w * 0.40,
                child: Container(
                  height: h * 0.10,
                  width: w * 0.55,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/Component 37.png"))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 0.35),
                child: Center(
                  child: Container(
                    height: h * 0.60,
                    width: w * 0.90,
                    decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black,
                            blurRadius: w * 0.015,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(w * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: h * 0.03,
                          ),
                          Container(
                            height: h * 0.10,
                            width: w * 0.70,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(w * 0.02)),
                            child: Center(
                                child: Text(
                              "Welcome Back!",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h * 0.030,
                                      color: Color(0xffFFFFFF))),
                            )),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text("Login to Seller Account",
                              style: GoogleFonts.roboto(
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Divider(
                            thickness: h * 0.003,
                            color: Color(0xff530CAD),
                            endIndent: w * 0.07,
                            indent: w * 0.08,
                          ),
                          SizedBox(
                            height: h * 0.05,
                          ),
                          Text("Enter Your Mobile Number",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                  fontFamily: "verdana_regular")),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: w * 0.07, right: w * 0.07),
                            child: Row(
                              children: [
                                Container(
                                  height: h * 0.07,
                                  width: w * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(w * 0.02),
                                          bottomLeft:
                                              Radius.circular(w * 0.02)),
                                      border:
                                          Border.all(color: Color(0xff7C29E5))),
                                  child: Center(
                                      child: Text(
                                    "+91",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: h * 0.015),
                                  )),
                                ),
                                Container(
                                  height: h * 0.07,
                                  width: w * 0.58,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(w * 0.02),
                                        bottomRight: Radius.circular(w * 0.02)),
                                    border: Border.all(
                                      color: Color(0xff7C29E5),
                                    ),
                                  ),
                                  child: TextFormField(


                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: " Enter Phone Number",
                                        hintStyle: TextStyle(
                                            fontSize: h * 0.015,
                                            color: Colors.black),
                                        suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.green,
                                          ),
                                        )),
                                    onChanged: (value) {
                                      _phoneNumber = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: h * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              _signInWithPhoneNumber();


                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return Wrap(
                                      children: [
                                        Container(
                                          height: h * 0.380,
                                          width: w * 1,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Color(0xff8C31FF),
                                                  Color(0xff601AB9),
                                                ],
                                              ),
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(w * 0.02),
                                                  topLeft: Radius.circular(
                                                      w * 0.02))),
                                          child: Column(
                                            children: [
                                              Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(
                                                        Icons.cancel_outlined,
                                                        color: Colors.white,
                                                        size: h * 0.040,
                                                      ))),
                                              Text(
                                                "Enter Verification Code",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: h * 0.02),
                                                    color: Color(0xffFFFFFF)),
                                              ),
                                              SizedBox(
                                                height: h * 0.02,
                                              ),
                                              Text(
                                                "Automatically detecting a SMS Send to your",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: Color(0xffFFFFFF)),
                                              ),
                                              Text(
                                                "mobile number ***********2145 Change",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.03),
                                                    color: Color(0xffFFFFFF)),
                                              ),
                                              SizedBox(
                                                height: h * 0.02,
                                              ),
                                              OTPTextField(
                                                onChanged: (value) {
                                                  _smsCode = value;
                                                },
                                                length: 6,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    34,
                                                fieldWidth: 51,
                                                otpFieldStyle: OtpFieldStyle(
                                                  backgroundColor:
                                                      Color(0xffFFFFFF),
                                                ),
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black),
                                                textFieldAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                fieldStyle:
                                                    FieldStyle.underline,
                                                outlineBorderRadius: 5,
                                              ),
                                              SizedBox(
                                                height: h * 0.02,
                                              ),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                   // _signInWithSmsCode();

                                                   // await FirebaseFirestore.instance.collection("vendor").add({
                                                   //   "phone":_phoneNumber
                                                   // }).then((value) {
                                                   //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile_Details()));
                                                   // });


                                                  },


                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.white),
                                                  child: Text(
                                                    "SUBMIT",
                                                    style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: Color(
                                                                0xff7C29E5))),
                                                  )),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Dont Recieve OTP? ",
                                                    style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize: w * 0.03,
                                                            color: Color(
                                                                0xffFFFFFF))),
                                                  ),
                                                  TextButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                        "RESEND OTP",
                                                        style: GoogleFonts.roboto(
                                                            textStyle: TextStyle(
                                                                color: Color(
                                                                  0xffFFFFFF,
                                                                ),
                                                                fontSize: w * 0.03)),
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },

                            // {Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile_Details()));},

                            child: Container(
                              height: h * 0.07,
                              width: w * 0.70,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff7C29E5)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: Text(
                                "Get OTP",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Center(
                              child: Text(
                            "   By Continuing you agree to tharacart\n Terms and Conditions & Privacy Policy",
                            style:
                                TextStyle(fontSize: 9, fontFamily: "verdana"),
                          )),
                          // TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile_Details()));},
                          //     child: Text("go"))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ]),
            SizedBox(
              height: h * 0.02,
            ),
            Container(
              height: h * 0.03,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xff8C31FF),
                    Color(0xff601AB9),
                  ],
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: w * 0.06),
                    child: Text(
                      "App V.1.2",
                      style: TextStyle(fontSize: 9, color: Color(0xffFFFFFF)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
