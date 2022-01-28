import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: Column(
            children: [
              Text('Welcome to',
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 32,
                          //color: Color(0xff41a58d),
                          fontWeight: FontWeight.w400))),
              SizedBox(
                height: 8,
              ),
              Text('TechAssist: A Mobile',
                  style: GoogleFonts.tinos(
                      textStyle: TextStyle(
                          letterSpacing: 1.3,
                          fontSize: 20,
                          //color: Color(0xff41a58d),
                          fontWeight: FontWeight.w500))),
              SizedBox(
                height: 8,
              ),
              Text('Application that provide',
                  style: GoogleFonts.tinos(
                      textStyle: TextStyle(
                          letterSpacing: 1.3,
                          fontSize: 20,
                          //color: Color(0xff41a58d),
                          fontWeight: FontWeight.w500))),
              SizedBox(
                height: 8,
              ),
              Text('services',
                  style: GoogleFonts.tinos(
                      textStyle: TextStyle(
                          letterSpacing: 1.3,
                          fontSize: 20,
                          //color: Color(0xff41a58d),
                          fontWeight: FontWeight.w500))),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Center(
          child: Image.asset(
            "assets/images/home_bg.png",
            scale: 1.0,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Features',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 16,
                              //color: Color(0xff41a58d),
                              fontWeight: FontWeight.w400))),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text('✔ You can find a skilled worker using',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 12,
                              //color: Color(0xff41a58d),
                              fontWeight: FontWeight.w600))),
                  Text('TechAssist.',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 12,
                              //color: Color(0xff41a58d),
                              fontWeight: FontWeight.w600))),
                  Text('✔ TechAssist will give job opportunities',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 12,
                              //color: Color(0xff41a58d),
                              fontWeight: FontWeight.w600))),
                  Text('to worker.',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 12,
                              //color: Color(0xff41a58d),
                              fontWeight: FontWeight.w600))),
                  Text('✔ You can pay manual transaction using',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 12,
                              //color: Color(0xff41a58d),
                              fontWeight: FontWeight.w600))),
                  Text('E-Wallet such as (GCASH or PAYMAYA)',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 12,
                              //color: Color(0xff41a58d),
                              fontWeight: FontWeight.w600))),
                  //   Text('CREDIT)',
                  //       style: GoogleFonts.roboto(
                  //           textStyle: TextStyle(
                  //               fontSize: 12,
                  //               //color: Color(0xff41a58d),
                  //               fontWeight: FontWeight.w600))),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
