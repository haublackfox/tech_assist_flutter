import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_assist_flutter_next/widgets/snackbar.dart';

import '../home_screen.dart';
import 'client_signup_page.dart';

class ClientSignInPage extends StatefulWidget {
  @override
  _ClientSignInPageState createState() => _ClientSignInPageState();
}

class _ClientSignInPageState extends State<ClientSignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController pswCtrl = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  void _submitForm() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth
          .signInWithEmailAndPassword(
              email: emailCtrl.text, //_emailAddress.toLowerCase().trim(),
              password: pswCtrl.text)
          .then((value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              ));
    } catch (error) {
      showSnackBar(context, "Invalid email or password", Colors.red, 3000);
      //   showSnackBar(context, error.toString().split("]")[1], Colors.red, 3000);
      //   Fluttertoast.showToast(
      //       msg: error.toString().split("]")[1],
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.CENTER,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.red,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      //_globalMethods.authErrorHandle(error.message, context);
      print('error occured ${error.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildSignupBtn() {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ClientSignUpPage()),
          );
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t have an Account? ',
                style: TextStyle(
                  letterSpacing: 2,
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: 'Sign Up'.toUpperCase(),
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue[400],
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
            body: Stack(
          children: <Widget>[
            Image.asset(
              "assets/images/bg2.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: Container(
                width: double.infinity,

                // padding: EdgeInsets.symmetric(horizontal: 70),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        scale: 1.5,
                      ),
                      SizedBox(height: 12),
                      Text("CLIENT'S LOGIN",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: 30,
                                  //color: Color(0xff41a58d),
                                  fontWeight: FontWeight.w700))),
                      SizedBox(height: 36),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 80),
                        alignment: Alignment.center,
                        child: Container(
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: emailCtrl,
                            decoration: InputDecoration(
                                prefixIcon: Icon(FontAwesomeIcons.userAlt,
                                    color: Colors.black),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: '  Email'.toUpperCase(),
                                hintStyle: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                                contentPadding: EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      width: 1,
                                      style: BorderStyle.none,
                                    ))),
                            validator: (email) {
                              if (email == null || email.isEmpty) {
                                return 'The email must be provided.';
                              } else if (EmailValidator.validate(email) ==
                                  false) {
                                return 'A valid email must be provided.';
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 36),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 80),
                        alignment: Alignment.center,
                        child: Container(
                          // color: Colors.white,
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: _obscureText,
                            controller: pswCtrl,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ),
                              ),
                              prefixIcon: Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.black,
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                              hintText: '  Password'.toUpperCase(),
                              contentPadding: EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.none,
                                  )),
                            ),
                            validator: (password) {
                              if (password!.isEmpty) {
                                return 'The password must be provided.';
                              } else if (password.length < 6) {
                                return 'Password length requires 6 or more characters.';
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 80),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 110,
                            height: 36,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("BACK",
                                    style: GoogleFonts.roboto(
                                        letterSpacing: 2,
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700)),
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(
                                      width: 1.0, color: Color(0xfffafafa)),
                                  shape: StadiumBorder(),
                                  primary: Color(0xfff5970a),
                                )),
                          ),
                          SizedBox(width: 32),
                          Container(
                            width: 110,
                            height: 36,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _submitForm();
                                  }
                                },
                                child: Text("SIGN IN",
                                    style: GoogleFonts.roboto(
                                        letterSpacing: 2,
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700)),
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(
                                      width: 1.0, color: Color(0xfffafafa)),
                                  shape: StadiumBorder(),
                                  primary: Color(0xfff5970a),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: 36),
                      _buildSignupBtn()
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
