import 'dart:io';
import 'dart:ui';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tech_assist_flutter_next/home_page.dart';
import 'package:tech_assist_flutter_next/home_screen.dart';
import 'package:tech_assist_flutter_next/screens/client_signin_page.dart';
import 'package:tech_assist_flutter_next/widgets/snackbar.dart';

class WorkerSignUpPage extends StatefulWidget {
  @override
  _WorkerSignUpPageState createState() => _WorkerSignUpPageState();
}

class _WorkerSignUpPageState extends State<WorkerSignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final usersRef = FirebaseFirestore.instance.collection('users');
  bool _obscureText = true;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController pswCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  String birthdate = '';
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController fullnameCtrl = TextEditingController();
  TextEditingController bdayCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController jobCtrl = TextEditingController();

  bool isMale = true;
  bool _value = false;
  int val = -1;
  int initialPage = 0;
  String validId = '1';
  String validId2 = '2';
  String validId3 = '3';
  String validId4 = '4';
  String validId5 = '5';
  File? selectedImage;
  File? selectedImage2;
  File? selectedImage3;
  File? selectedImage4;
  File? selectedImage5;
  bool _isLoading = false;
  String url = '';
  String url2 = '';
  String url3 = '';
  String url4 = '';
  String url5 = '';

//   late DateTime birthDate;
  @override
  Widget build(BuildContext context) {
    void _openDatePicker(BuildContext context) {
      BottomPicker.date(
        title: 'Set your Birthday',
        titleStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.blue,
        ),
        onChange: (index) {
          print(index);
        },
        onSubmit: (index) {
          print(index);
          setState(() {
            birthdate = DateFormat("M/d/y")
                .format(DateTime.parse(index.toString()))
                .toString();

            // bdayCtrl.value = bdayCtrl.value.copyWith(
            //   text: "DATE OF BIRTH " + birthdate,
            //   selection: TextSelection.collapsed(
            //     offset: bdayCtrl.value.selection.baseOffset + birthdate.length,
            //   ),
            // );
          });
        },
        bottomPickerTheme: BOTTOM_PICKER_THEME.plumPlate,
      ).show(context);
    }

    getImageFromGallery() async {
      final pickedImage =
          await ImagePicker().getImage(source: ImageSource.gallery);
      selectedImage = File(pickedImage!.path);

      setState(() {});
    }

    getImageFromCamera() async {
      final pickedImage =
          await ImagePicker().getImage(source: ImageSource.camera);
      selectedImage = File(pickedImage!.path);

      setState(() {});
    }

    getImageFromGallery2() async {
      final pickedImage =
          await ImagePicker().getImage(source: ImageSource.gallery);
      selectedImage2 = File(pickedImage!.path);

      setState(() {});
    }

    getImageFromCamera2() async {
      final pickedImage =
          await ImagePicker().getImage(source: ImageSource.camera);
      selectedImage2 = File(pickedImage!.path);

      setState(() {});
    }

    getImageFromGallery3() async {
      final pickedImage =
          await ImagePicker().getImage(source: ImageSource.gallery);
      selectedImage3 = File(pickedImage!.path);

      setState(() {});
    }

    getImageFromCamera3() async {
      final pickedImage =
          await ImagePicker().getImage(source: ImageSource.camera);
      selectedImage3 = File(pickedImage!.path);

      setState(() {});
    }

    getImageFromGallery4() async {
      final pickedImage =
          await ImagePicker().getImage(source: ImageSource.gallery);
      selectedImage4 = File(pickedImage!.path);

      setState(() {});
    }

    getImageFromCamera4() async {
      final pickedImage =
          await ImagePicker().getImage(source: ImageSource.camera);
      selectedImage4 = File(pickedImage!.path);

      setState(() {});
    }

    getImageFromGallery5() async {
      final pickedImage =
          await ImagePicker().getImage(source: ImageSource.gallery);
      selectedImage5 = File(pickedImage!.path);

      setState(() {});
    }

    getImageFromCamera5() async {
      final pickedImage =
          await ImagePicker().getImage(source: ImageSource.camera);
      selectedImage5 = File(pickedImage!.path);

      setState(() {});
    }

    selectImage(parentContext) {
      return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text("Choose image by:"),
            children: <Widget>[
              SimpleDialogOption(
                  child: Text(
                    "Photo with Camera",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () async {
                    await getImageFromCamera();
                    Navigator.pop(context);
                  }),
              SimpleDialogOption(
                  child: Text("Image from Gallery",
                      style: TextStyle(color: Colors.blue)),
                  onPressed: () async {
                    await getImageFromGallery();
                    Navigator.pop(context);
                  }),
              SimpleDialogOption(
                child: Text("Cancel", style: TextStyle(color: Colors.red)),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        },
      );
    }

    selectImage2(parentContext) {
      return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text("Choose image by:"),
            children: <Widget>[
              SimpleDialogOption(
                  child: Text(
                    "Photo with Camera",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () async {
                    await getImageFromCamera2();
                    Navigator.pop(context);
                  }),
              SimpleDialogOption(
                  child: Text("Image from Gallery",
                      style: TextStyle(color: Colors.blue)),
                  onPressed: () async {
                    await getImageFromGallery2();
                    Navigator.pop(context);
                  }),
              SimpleDialogOption(
                child: Text("Cancel", style: TextStyle(color: Colors.red)),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        },
      );
    }

    selectImage3(parentContext) {
      return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text("Choose image by:"),
            children: <Widget>[
              SimpleDialogOption(
                  child: Text(
                    "Photo with Camera",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () async {
                    await getImageFromCamera3();
                    Navigator.pop(context);
                  }),
              SimpleDialogOption(
                  child: Text("Image from Gallery",
                      style: TextStyle(color: Colors.blue)),
                  onPressed: () async {
                    await getImageFromGallery3();
                    Navigator.pop(context);
                  }),
              SimpleDialogOption(
                child: Text("Cancel", style: TextStyle(color: Colors.red)),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        },
      );
    }

    selectImage4(parentContext) {
      return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text("Choose image by:"),
            children: <Widget>[
              SimpleDialogOption(
                  child: Text(
                    "Photo with Camera",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () async {
                    await getImageFromCamera4();
                    Navigator.pop(context);
                  }),
              SimpleDialogOption(
                  child: Text("Image from Gallery",
                      style: TextStyle(color: Colors.blue)),
                  onPressed: () async {
                    await getImageFromGallery4();
                    Navigator.pop(context);
                  }),
              SimpleDialogOption(
                child: Text("Cancel", style: TextStyle(color: Colors.red)),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        },
      );
    }

    selectImage5(parentContext) {
      return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text("Choose image by:"),
            children: <Widget>[
              SimpleDialogOption(
                  child: Text(
                    "Photo with Camera",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () async {
                    await getImageFromCamera5();
                    Navigator.pop(context);
                  }),
              SimpleDialogOption(
                  child: Text("Image from Gallery",
                      style: TextStyle(color: Colors.blue)),
                  onPressed: () async {
                    await getImageFromGallery5();
                    Navigator.pop(context);
                  }),
              SimpleDialogOption(
                child: Text("Cancel", style: TextStyle(color: Colors.red)),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        },
      );
    }

    void _submitForm() async {
      setState(() {
        _isLoading = true;
      });

      try {
        await _auth.createUserWithEmailAndPassword(
            email: emailCtrl.text, //_emailAddress.toLowerCase().trim(),
            password: pswCtrl.text);

        final User user = _auth.currentUser!;
        final _uid = user.uid;
        user.reload();
        //user.updateProfile(displayName: )

        var date = DateTime.now().toString();
        var dateparse = DateTime.parse(date);
        var formattedDate =
            "${dateparse.day}-${dateparse.month}-${dateparse.year}";

        final ref = FirebaseStorage.instance
            .ref()
            .child('userDocs')
            .child(fullnameCtrl.text + validId + '.jpg');
        await ref.putFile(selectedImage!);
        url = await ref.getDownloadURL();

        final ref2 = FirebaseStorage.instance
            .ref()
            .child('userDocs')
            .child(fullnameCtrl.text + validId2 + '.jpg');
        await ref2.putFile(selectedImage2!);
        url2 = await ref2.getDownloadURL();

        final ref3 = FirebaseStorage.instance
            .ref()
            .child('userDocs')
            .child(fullnameCtrl.text + validId3 + '.jpg');
        await ref3.putFile(selectedImage3!);
        url3 = await ref3.getDownloadURL();

        final ref4 = FirebaseStorage.instance
            .ref()
            .child('userDocs')
            .child(fullnameCtrl.text + validId4 + '.jpg');
        await ref4.putFile(selectedImage4!);
        url4 = await ref4.getDownloadURL();

        final ref5 = FirebaseStorage.instance
            .ref()
            .child('userDocs')
            .child(fullnameCtrl.text + validId5 + '.jpg');
        await ref5.putFile(selectedImage5!);
        url5 = await ref5.getDownloadURL();

        DocumentSnapshot doc = await usersRef.doc(_uid).get();
        if (!doc.exists) {
          await FirebaseFirestore.instance.collection('users').doc(_uid).set({
            'id': _uid,
            'username': nameCtrl.text,
            'email': emailCtrl.text,
            'phoneNumber': phoneCtrl.text,
            'bday': birthdate,
            'address': addressCtrl.text,
            'gender': val.toString() == '2' ? 'Female' : 'Male',
            'fullname': fullnameCtrl.text,
            'validID': url,
            'validID2': url2,
            'validID3': url3,
            'validID4': url4,
            'validID5': url5,
            'joinedAt': formattedDate,
            //'createdAt': Timestamp.now(),
            'isClient': "false",
            'jobdescription': jobCtrl.text.toLowerCase(),
            'jobexperience': "",
            'imageurl': "",
            'status': "Not verified"
          });
        }

        // REUSE FOR SIGNING UP
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } catch (error) {
        //_globalMethods.authErrorHandle(error.message, context);
        print('error occured ${error.toString()}');

        showSnackBar(
            context,
            "Required Documents missing, please fill up the details properly",
            Colors.red,
            5000);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
    //_formKey.currentState!.save();

    // }
    //}

    Widget SignUpOne() {
      return Form(
        key: _formKey,
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg2.png"),
                  fit: BoxFit.cover)),
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
                Text("CREATE ACCOUNT",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 30,
                            //color: Color(0xff41a58d),
                            fontWeight: FontWeight.w700))),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  alignment: Alignment.center,
                  child: Container(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: nameCtrl,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            FontAwesomeIcons.userAlt,
                            color: Colors.black,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: '  Username'.toUpperCase(),
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
                      validator: (name) {
                        if (name == null || name.isEmpty) {
                          return 'The Username must be provided.';
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  alignment: Alignment.center,
                  child: Container(
                    // color: Colors.white,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailCtrl,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          FontAwesomeIcons.solidEnvelope,
                          color: Colors.black,
                        ),

                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                        hintText: '  Email'.toUpperCase(),
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 1,
                              style: BorderStyle.none,
                            )),
                        //   suffixIcon: IconButton(
                        //       icon: Icon(
                        //           //   _isObscure
                        //           //   ? Icons.visibility_off
                        //           //:
                        //           Icons.visibility),
                        //       onPressed: () {
                        //         // setState(() {
                        //         //   _isObscure = !_isObscure;
                        //         // });
                        //       })
                      ),
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'The email must be provided.';
                        } else if (EmailValidator.validate(email) == false) {
                          return 'A valid email must be provided.';
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  alignment: Alignment.center,
                  child: Container(
                    // color: Colors.white,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: _obscureText,
                      controller: pswCtrl,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.lock,
                          color: Colors.black,
                        ),
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
                        //   suffixIcon: IconButton(
                        //       icon: Icon(
                        //           //   _isObscure
                        //           //   ? Icons.visibility_off
                        //           //:
                        //           Icons.visibility),
                        //       onPressed: () {
                        //         // setState(() {
                        //         //   _isObscure = !_isObscure;
                        //         // });
                        //       })
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
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  alignment: Alignment.center,
                  child: Container(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: phoneCtrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            FontAwesomeIcons.phoneAlt,
                            color: Colors.black,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: '  PHONE NUMBER'.toUpperCase(),
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
                      validator: (phone) {
                        if (phone == null || phone.isEmpty) {
                          return 'The phone number must be provided.';
                        } else if (phone.length < 11) {
                          return 'The phone number must be valid.';
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => _openDatePicker(context),
                    child: Container(
                      child: TextFormField(
                        enabled: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        //controller: bdayCtrl,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: birthdate != ''
                                ? 'DATE OF BIRTH   $birthdate'
                                : 'DATE OF BIRTH             M/D/Y',
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
                        validator: (bday) {
                          print("DSFDFSDF" + (bday == null).toString());
                          if (bday == null) {
                            return 'The birthday must be provided.';
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  alignment: Alignment.center,
                  child: Container(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: addressCtrl,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            FontAwesomeIcons.locationArrow,
                            color: Colors.black,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: '  ADDRESS'.toUpperCase(),
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
                      validator: (addr) {
                        if (addr == null || addr.isEmpty) {
                          return 'The address must be provided.';
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          //color: Colors.red[500],
                          ),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("   GENDER"),
                              Radio(
                                value: 1,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    print("WWWWWWWWWWWWWWW" + value.toString());
                                    val = 1;
                                  });
                                },
                                activeColor: Colors.blue,
                              ),
                              Text("Male"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    print("WWWWWWWWWWWWWWW" + value.toString());
                                    val = 2;
                                  });
                                },
                                activeColor: Colors.blue,
                              ),
                              Text("Female"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              initialPage = 1;
                            } else {
                              print('the login form is not valid');
                            }
                            // print("SSSSSSSSSSSSSSSSSSS" +
                            //     isSecondPage.toString());
                            setState(() {});
                          },
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => BottomBarScreen()),
                          //   );

                          child: Text("NEXT",
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
              ],
            ),
          ),
        ),
      );
    }

    Widget SignUpTwo() {
      List<String> listItems = ["a", "b", "c", "d"];
      return Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg2.png"), fit: BoxFit.cover)),
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
              Text("CREATE ACCOUNT",
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 24,
                          //color: Color(0xff41a58d),
                          fontWeight: FontWeight.w700))),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 80),
                alignment: Alignment.center,
                child: Container(
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: fullnameCtrl,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Last Name, First Name, M.I',
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
                      // if (email == null || email.isEmpty) {
                      //   return 'The email must be provided.';
                      // } else if (EmailValidator.validate(email) ==
                      //     false) {
                      //   return 'A valid email must be provided.';
                      // }
                    },
                  ),
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 80),
                alignment: Alignment.center,
                child: InkWell(
                  //onTap: () => _openDatePicker(context),
                  child: Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              //color: Colors.red[500],
                              ),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: DropdownButton<String>(
                        underline: SizedBox(),
                        hint: Text(validId != ''
                            ? "   $validId"
                            : "   Select your Valid ID's"),
                        items: <String>[
                          'Driver’s License ',
                          'Passport',
                          'PhilHealth Card',
                          'Philippine Postal ID',
                          'PRC ID',
                          'SSS ID',
                          'UMID',
                          'Voter’s ID'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            validId = value!;
                          });
                          print(validId);
                        },
                      )),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  "Upload your file here".toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => selectImage(context),
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.white.withAlpha(80),
                            border: Border.all(
                                //color: Colors.red[500],
                                ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: selectedImage == null
                            ? Center(
                                child: Column(children: const [
                                SizedBox(
                                  height: 50,
                                ),
                                Icon(
                                  Icons.file_upload_rounded,
                                ),
                                Text(
                                  "CLICK TO UPLOAD",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ]))
                            : Image.file(
                                selectedImage!,
                                width: 80, //scaler.getWidth(80),
                                height: 40, //scaler.getHeight(35),
                                fit: BoxFit.fitHeight,
                              ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 8,
                    // ),
                    InkWell(
                      onTap: () => selectImage2(context),
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.white.withAlpha(80),
                            border: Border.all(
                                //color: Colors.red[500],
                                ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: selectedImage2 == null
                            ? Center(
                                child: Column(children: const [
                                SizedBox(
                                  height: 50,
                                ),
                                Icon(
                                  Icons.file_upload_rounded,
                                ),
                                Text(
                                  "CLICK TO UPLOAD",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ]))
                            : Image.file(
                                selectedImage2!,
                                width: 80, //scaler.getWidth(80),
                                height: 40, //scaler.getHeight(35),
                                fit: BoxFit.fitHeight,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  "Job Specialization".toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 80),
                alignment: Alignment.center,
                child: Container(
                  // color: Colors.white,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: jobCtrl,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        FontAwesomeIcons.solidEnvelope,
                        color: Colors.black,
                      ),

                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                      hintText: '  Carpenter, Electrician, Painter',
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            width: 1,
                            style: BorderStyle.none,
                          )),
                      //   suffixIcon: IconButton(
                      //       icon: Icon(
                      //           //   _isObscure
                      //           //   ? Icons.visibility_off
                      //           //:
                      //           Icons.visibility),
                      //       onPressed: () {
                      //         // setState(() {
                      //         //   _isObscure = !_isObscure;
                      //         // });
                      //       })
                    ),
                    validator: (job) {
                      if (job == null || job.isEmpty) {
                        return 'The job title must be provided.';
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 110,
                    height: 36,
                    child: ElevatedButton(
                        onPressed: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => BottomBarScreen()),
                          //   );
                          setState(() {
                            initialPage = 0;
                          });
                        },
                        child: Text("BACK",
                            style: GoogleFonts.roboto(
                                letterSpacing: 2,
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                        style: ElevatedButton.styleFrom(
                          side:
                              BorderSide(width: 1.0, color: Color(0xfffafafa)),
                          shape: StadiumBorder(),
                          primary: Color(0xfff5970a),
                        )),
                  ),
                  const SizedBox(width: 32),
                  Container(
                    width: 110,
                    height: 36,
                    child: ElevatedButton(
                        onPressed: () async {
                          // if (_formKey.currentState!.validate()) {
                          initialPage = 2;
                          //   } else {
                          //     print('the login form is not valid');
                          //   }
                          // print("SSSSSSSSSSSSSSSSSSS" +
                          //     isSecondPage.toString());
                          setState(() {});
                        },
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => BottomBarScreen()),
                        //   );

                        child: Text("NEXT",
                            style: GoogleFonts.roboto(
                                letterSpacing: 2,
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                        style: ElevatedButton.styleFrom(
                          side:
                              BorderSide(width: 1.0, color: Color(0xfffafafa)),
                          shape: StadiumBorder(),
                          primary: Color(0xfff5970a),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 36),
            ],
          ),
        ),
      );
    }

    Widget SignUpThree() {
      List<String> listItems = ["a", "b", "c", "d"];
      return Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg2.png"), fit: BoxFit.cover)),
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
              Text("CREATE ACCOUNT",
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 24,
                          //color: Color(0xff41a58d),
                          fontWeight: FontWeight.w700))),
              SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  "proof as a worker".toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(
                    //   width: 8,
                    // ),
                    InkWell(
                      onTap: () => selectImage3(context),
                      child: Container(
                        width: 150,
                        height: 75,
                        decoration: BoxDecoration(
                            color: Colors.white.withAlpha(80),
                            border: Border.all(
                                //color: Colors.red[500],
                                ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: selectedImage3 == null
                            ? Center(
                                child: Column(children: const [
                                SizedBox(
                                  height: 12,
                                ),
                                Icon(
                                  Icons.file_upload_rounded,
                                ),
                                Text(
                                  "CLICK TO UPLOAD",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ]))
                            : Image.file(
                                selectedImage3!,
                                width: 80, //scaler.getWidth(80),
                                height: 40, //scaler.getHeight(35),
                                fit: BoxFit.fitHeight,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  "provide clearance".toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(
                    //   width: 8,
                    // ),
                    InkWell(
                      onTap: () => selectImage4(context),
                      child: Container(
                        width: 150,
                        height: 75,
                        decoration: BoxDecoration(
                            color: Colors.white.withAlpha(80),
                            border: Border.all(
                                //color: Colors.red[500],
                                ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: selectedImage4 == null
                            ? Center(
                                child: Column(children: const [
                                SizedBox(
                                  height: 12,
                                ),
                                Icon(
                                  Icons.file_upload_rounded,
                                ),
                                Text(
                                  "CLICK TO UPLOAD",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ]))
                            : Image.file(
                                selectedImage4!,
                                width: 80, //scaler.getWidth(80),
                                height: 40, //scaler.getHeight(35),
                                fit: BoxFit.fitHeight,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  "provide a resume".toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(
                    //   width: 8,
                    // ),
                    InkWell(
                      onTap: () => selectImage5(context),
                      child: Container(
                        width: 150,
                        height: 75,
                        decoration: BoxDecoration(
                            color: Colors.white.withAlpha(80),
                            border: Border.all(
                                //color: Colors.red[500],
                                ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: selectedImage5 == null
                            ? Center(
                                child: Column(children: const [
                                SizedBox(
                                  height: 12,
                                ),
                                Icon(
                                  Icons.file_upload_rounded,
                                ),
                                Text(
                                  "CLICK TO UPLOAD",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ]))
                            : Image.file(
                                selectedImage5!,
                                width: 80, //scaler.getWidth(80),
                                height: 40, //scaler.getHeight(35),
                                fit: BoxFit.fitHeight,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 110,
                    height: 36,
                    child: ElevatedButton(
                        onPressed: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => BottomBarScreen()),
                          //   );
                          setState(() {
                            initialPage = 0;
                          });
                        },
                        child: Text("BACK",
                            style: GoogleFonts.roboto(
                                letterSpacing: 2,
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                        style: ElevatedButton.styleFrom(
                          side:
                              BorderSide(width: 1.0, color: Color(0xfffafafa)),
                          shape: StadiumBorder(),
                          primary: Color(0xfff5970a),
                        )),
                  ),
                  const SizedBox(width: 32),
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          width: 130,
                          height: 36,
                          child: ElevatedButton(
                              onPressed: _submitForm,
                              child: Text("REGISTER",
                                  style: GoogleFonts.roboto(
                                      letterSpacing: 2,
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    width: 1.0, color: Color(0xfffafafa)),
                                shape: const StadiumBorder(),
                                primary: const Color(0xfff5970a),
                              )),
                        ),
                ],
              ),
              SizedBox(height: 36),
            ],
          ),
        ),
      );
    }

    return SafeArea(
        child: Scaffold(
            body: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                // appBar: AppBar(
                //   backgroundColor: Colors.transparent,
                //   elevation: 0.0,
                // ),
                body: initialPage == 0
                    ? SignUpOne()
                    : initialPage == 1
                        ? SignUpTwo()
                        : initialPage == 2
                            ? SignUpThree()
                            : Container())));
  }
}
