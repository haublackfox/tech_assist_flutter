import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_assist_flutter_next/utils/flutter_screen_scaler.dart';

import 'workers_posts_cards.dart';

class WorkersHomePage extends StatefulWidget {
  @override
  _WorkersHomePageState createState() => _WorkersHomePageState();
}

class _WorkersHomePageState extends State<WorkersHomePage> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler();
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
          height: 24,
        ),
        Text("  CLIENT'S POST",
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    letterSpacing: 1.3,
                    fontSize: 24,
                    //color: Color(0xff41a58d),
                    fontWeight: FontWeight.w500))),
        Container(child: WorkersPostsCard(), height: scaler.getHeight(13) //300,
            )
      ],
    );
  }
}
