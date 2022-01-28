import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './client_signin_page.dart';
import './worker_signin_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg1.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: double.infinity,

                  // padding: EdgeInsets.symmetric(horizontal: 70),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('WELCOME',
                            style: GoogleFonts.corben(
                                textStyle: TextStyle(
                                    fontSize: 36,
                                    //color: Color(0xff41a58d),
                                    fontWeight: FontWeight.w700))),
                        Text('TO',
                            style: GoogleFonts.corben(
                                textStyle: TextStyle(
                                    fontSize: 36,
                                    //color: Color(0xff41a58d),
                                    fontWeight: FontWeight.w700))),
                        Image.asset(
                          "assets/images/logo.png",
                          scale: 1.5,
                        ),
                        SizedBox(height: 12),
                        Text('LOGIN AS',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 30,
                                    //color: Color(0xff41a58d),
                                    fontWeight: FontWeight.w700))),
                        SizedBox(height: 24),
                        Container(
                          width: 210,
                          height: 44,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ClientSignInPage()),
                                );
                              },
                              child: Text("CLIENTS",
                                  style: GoogleFonts.roboto(
                                      letterSpacing: 2,
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                    width: 1.0, color: Color(0xfffafafa)),
                                shape: StadiumBorder(),
                                primary: Color(0xfff5970a),
                              )),
                        ),
                        SizedBox(height: 32),
                        Container(
                          width: 210,
                          height: 44,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WorkerSignInPage()),
                                );
                              },
                              child: Text("WORKERS",
                                  style: GoogleFonts.roboto(
                                      letterSpacing: 2,
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    width: 1.0, color: Color(0xfffafafa)),
                                shape: StadiumBorder(),
                                primary: Color(0xfff5970a),
                              )),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        InkWell(
                            onTap: () => _launchInBrowser(
                                "https://drive.google.com/file/d/1c2Dc8CQo7oWqUOdMne-TqyFOCpkd42Ty/view"),
                            child: Text(
                              "TERMS AND AGREEMENT",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await _launchURL(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}
