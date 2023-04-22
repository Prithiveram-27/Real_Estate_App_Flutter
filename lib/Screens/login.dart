// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields, unused_field, constant_identifier_names, use_build_context_synchronously, sort_child_properties_last, non_constant_identifier_names, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_services_app/Widgets/header_Widget.dart';
import 'package:home_services_app/Screens/home.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../constants.dart';

enum MobileVerificationState { Mobile_SHOW_state, Otp_SHOW_state }

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  MobileVerificationState currentState =
      MobileVerificationState.Mobile_SHOW_state;

  var phoneNumberController = TextEditingController();
  var otpController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  double _headerHeight = 250;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = "";
  String currentText = "";
  String phoneNumber = "";
  bool showLoading = false;

  void SignInwithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      if (authCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
        ),
      );
    }
  }

  void verifyOTP() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpController.text);
    SignInwithPhoneAuthCredential(phoneAuthCredential);
  }

  void verifyPhoneNumber() async {
    setState(() {
      showLoading = true;
    });
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        setState(() {
          showLoading = false;
        });
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: otpController.text);
        SignInwithPhoneAuthCredential(phoneAuthCredential);
      },
      verificationFailed: (FirebaseAuthException e) async {
        setState(() {
          showLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message.toString()),
          ),
        );
      },
      codeSent: (String verificationId, int? resendToken) async {
        setState(() {
          showLoading = false;
          currentState = MobileVerificationState.Otp_SHOW_state;
          this.verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  getMobileFormWidget(context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IntlPhoneField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                phoneNumber = phone.completeNumber;
              },
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ]);
  }

  getOtpFormWidget(context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: PinCodeTextField(
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Constants.secondaryColor,
                activeColor: Constants.primaryColor,
                inactiveColor: Constants.primaryColor),
            animationDuration: const Duration(milliseconds: 300),
            //backgroundColor: Constants.secondaryColor,
            enableActiveFill: false,
            controller: otpController,
            onCompleted: (v) {
              debugPrint("Completed");
            },
            onChanged: (value) {
              debugPrint(value);
              setState(() {
                currentText = value;
              });
            },
            beforeTextPaste: (text) {
              return true;
            },
            appContext: context,
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Constants.secondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          height: _headerHeight,
          child: HeaderWidget(_headerHeight, true, Icons.person),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  "Login With Mobile Number",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                margin: EdgeInsets.only(left: 10),
              ),
            ),
          ],
        ),
        showLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : currentState == MobileVerificationState.Mobile_SHOW_state
                ? getMobileFormWidget(context)
                : getOtpFormWidget(context),
        Spacer(),
        TextButton(
          style: TextButton.styleFrom(
            fixedSize: Size(width - 40, 50),
            backgroundColor: Colors.grey[800],
          ),
          onPressed: () {
            currentState == MobileVerificationState.Mobile_SHOW_state
                ? verifyPhoneNumber()
                : verifyOTP();
          },
          child: Text(
            currentState == MobileVerificationState.Mobile_SHOW_state
                ? "Get OTP"
                : "Verify",
            style: TextStyle(
              color: Constants.secondaryColor,
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ]),
    );
  }
}
