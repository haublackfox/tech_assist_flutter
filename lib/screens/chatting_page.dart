import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_assist_flutter_next/widgets/haha.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage(
      {Key? key, required this.receiverId, required this.receiverName})
      : super(key: key);

  final String receiverId;
  final String receiverName;

  @override
  _ChattingPageState createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController msgCtrl = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final ScrollController listScrollCtrl = ScrollController();
  File? selectedImage;
//   final Reference storageRef = FirebaseStorage.instance.ref();
//   String? _userName = '';
  //late Future<String> _counter;
  String imageUrl = '';

  String chatId = "";
  String userId = "";
  var listMessage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _isClient = '';

  @override
  void initState() {
    super.initState();

    readLocal();
  }

  readLocal() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String userId = (prefs.getString('id') ?? "");

    String userId = _auth.currentUser!.uid;

    if (userId.hashCode <= widget.receiverId.hashCode) {
      chatId = '$userId-$widget.receiverId';
    } else {
      chatId = '$widget.receiverId-$userId';
    }

    User user = _auth.currentUser!;

    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    setState(() {
      _isClient = userDoc.get('isClient').toString();
    });

    print("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
    print(_isClient);
    print("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
  }

  Future<void> onSendMessage(String contentMsg, int type) async {
    String now = DateTime.now()
        .add(Duration(seconds: 3))
        .toUtc()
        .millisecondsSinceEpoch
        .toString();
    //type 0 text msg
    //type 1 imageFile
    print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
    print(DateTime.now());

    print(now);
    //   print(DateTime.now()
    //       .add(Duration(seconds: 1))
    //       .millisecondsSinceEpoch
    //       .toString());
    //   //   print(DateTime.now());
    print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");

    print("WAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    if (contentMsg != "") {
      User user = _auth.currentUser!;
      String now = DateTime.now()
          .add(Duration(seconds: 3))
          .toUtc()
          .millisecondsSinceEpoch
          .toString();

      print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
      print(DateTime.now());

      print(now);
      //   print(DateTime.now()
      //       .add(Duration(seconds: 1))
      //       .millisecondsSinceEpoch
      //       .toString());
      //   //   print(DateTime.now());
      print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
      print(now);

      //   print("USERRRRRRRRRRRRRRRR");
      //   print(user.uid);
      //   print("USERRRRRRRRRRRRRRRR DAMAGE");
      //   msgCtrl.clear();

      //   print("RECEVVVVVVVVVVV");
      //   print(widget.receiverId);
      //   print("RECEVVVVVVVVVVV");
      //   var docRef = FirebaseFirestore.instance
      //       .collection("messages")
      //       .doc(chatId)
      //       .collection(chatId)
      //       .doc(DateTime.now().millisecondsSinceEpoch.toString());

      var docRef = FirebaseFirestore.instance
          .collection("messages")
          .doc(user.uid)
          .collection(user.uid)
          .doc(now);

      var receiveRef = FirebaseFirestore.instance
          .collection("messages")
          .doc(widget.receiverId)
          .collection(widget.receiverId)
          .doc(now);

      final senderData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final rcvData = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.receiverId)
          .get();

      await FirebaseFirestore.instance
          .collection('messages')
          .doc(user.uid)
          .collection(user.uid)
          .doc(now)
          .set({
        "idFrom": user.uid,
        "idTo": widget.receiverId,
        "timestamp": now,
        "content": contentMsg,
        "type": type,
        "senders_name": senderData['fullname'],
        "senders_image": senderData['imageurl'],
        "receiver_name": rcvData['fullname'],
        "receiver_image": rcvData['imageurl'],
        'timePosted': DateFormat("MM/dd/yyyy").format(DateTime.now()) +
            " " +
            DateFormat("hh:mm:ss a").format(DateTime.now()), //DateTime.now(),
      });

      await FirebaseFirestore.instance
          .collection('messages')
          .doc(widget.receiverId)
          .collection(widget.receiverId)
          .doc(now)
          .set({
        "idFrom": user.uid,
        "idTo": widget.receiverId,
        "timestamp": now,
        "content": contentMsg,
        "type": type,
        "senders_name": senderData['fullname'],
        "senders_image": senderData['imageurl'],
        "receiver_name": rcvData['fullname'],
        "receiver_image": rcvData['imageurl'],
        'timePosted': DateFormat("MM/dd/yyyy").format(DateTime.now()) +
            " " +
            DateFormat("hh:mm:ss a").format(DateTime.now()), //DateTime.now(),
      });

      msgCtrl.clear();

      listScrollCtrl.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  getImageFromGallery() async {
    User user = _auth.currentUser!;
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    selectedImage = File(pickedImage!.path);

    if (selectedImage != null) {
      EasyLoading.show(status: 'loading...');
      final ref = FirebaseStorage.instance
          .ref()
          .child('shopImages')
          .child(user.uid + DateTime.now().toString() + '.jpg');
      await ref.putFile(selectedImage!);
      String url = await ref.getDownloadURL();

      var docRef = FirebaseFirestore.instance
          .collection("messages")
          .doc(user.uid)
          .collection(user.uid)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      var receiveRef = FirebaseFirestore.instance
          .collection("messages")
          .doc(widget.receiverId)
          .collection(widget.receiverId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      final senderData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final rcvData = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.receiverId)
          .get();
      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(docRef, {
          "idFrom": user.uid,
          "idTo": widget.receiverId,
          "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
          "content": url,
          "type": 1,
          "senders_name": senderData['fullname'],
          "senders_image": senderData['imageurl'],
          "receiver_name": rcvData['fullname'],
          "receiver_image": rcvData['imageurl'],
          'timePosted': DateFormat("MM/dd/yyyy").format(DateTime.now()) +
              " " +
              DateFormat("hh:mm:ss a").format(DateTime.now()), //DateTime.now(),
        });
      });

      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(receiveRef, {
          "idFrom": user.uid,
          "idTo": widget.receiverId,
          "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
          "content": url,
          "type": 1,
          "senders_name": senderData['fullname'],
          "senders_image": senderData['imageurl'],
          "receiver_name": rcvData['fullname'],
          "receiver_image": rcvData['imageurl'],
          'timePosted': DateFormat("MM/dd/yyyy").format(DateTime.now()) +
              " " +
              DateFormat("hh:mm:ss a").format(DateTime.now()), //DateTime.now(),
        });
      });
      EasyLoading.showSuccess('Great Success!');
    }

    setState(() {});
  }

  getImageFromCamera() async {
    User user = _auth.currentUser!;
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.camera);
    selectedImage = File(pickedImage!.path);

    if (selectedImage != null) {
      EasyLoading.show(status: 'loading...');
      final ref = FirebaseStorage.instance
          .ref()
          .child('shopImages')
          .child(user.uid + DateTime.now().toString() + '.jpg');
      await ref.putFile(selectedImage!);
      String url = await ref.getDownloadURL();

      var docRef = FirebaseFirestore.instance
          .collection("messages")
          .doc(user.uid)
          .collection(user.uid)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      var receiveRef = FirebaseFirestore.instance
          .collection("messages")
          .doc(widget.receiverId)
          .collection(widget.receiverId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      final senderData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final rcvData = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.receiverId)
          .get();
      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(docRef, {
          "idFrom": user.uid,
          "idTo": widget.receiverId,
          "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
          "content": url,
          "type": "1",
          "senders_name": senderData['fullname'],
          "senders_image": senderData['imageurl'],
          "receiver_name": rcvData['fullname'],
          "receiver_image": rcvData['imageurl'],
          'timePosted': DateFormat("MM/dd/yyyy").format(DateTime.now()) +
              " " +
              DateFormat("hh:mm:ss a").format(DateTime.now()), //DateTime.now(),
        });
      });

      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(receiveRef, {
          "idFrom": user.uid,
          "idTo": widget.receiverId,
          "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
          "content": url,
          "type": "1",
          "senders_name": senderData['fullname'],
          "senders_image": senderData['imageurl'],
          "receiver_name": rcvData['fullname'],
          "receiver_image": rcvData['imageurl'],
          'timePosted': DateFormat("MM/dd/yyyy").format(DateTime.now()) +
              " " +
              DateFormat("hh:mm:ss a").format(DateTime.now()), //DateTime.now(),
        });
      });

      EasyLoading.showSuccess('Great Success!');
    }

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
                  Navigator.pop(context);
                  await getImageFromCamera();
                  //   Navigator.pop(context);
                }),
            SimpleDialogOption(
                child: Text("Image from Gallery",
                    style: TextStyle(color: Colors.blue)),
                onPressed: () async {
                  Navigator.pop(context);
                  await getImageFromGallery();
                  //   Navigator.pop(context);
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

  Future uploadImageFile() async {
    //    showSnackBar(context, "Saving image please wait...", Colors.blue, 5000);
    // String postId =
    //     widget.user.uid + "_" + timestamp.toString().split(' ').join();
    // UploadTask uploadTask =
    //     storageRef.child("post_$postId.jpg").putFile(widget.image);
    // TaskSnapshot storageSnap = await uploadTask;
    // String downloadUrl = await storageSnap.ref.getDownloadURL();
    // createPostInFirestore(mediaUrl: downloadUrl);
    //   String file

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef =
        FirebaseStorage.instance.ref().child("Chat Images").child(fileName);

    UploadTask storageUploadTask = storageRef.putFile(selectedImage!);
    TaskSnapshot storageTaskSnapshot = await storageUploadTask;

    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        onSendMessage(imageUrl, 1);
      });
    });
    //.onError((error, stackTrace) => print(error));
  }

  Widget top() {
    return Container(
        //height: 450,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xfff9f2f2),
            border: Border.all(
              color: Color(0xffb6b3b3),
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //   SizedBox(
          //     height: 20,
          //   ),
          Text(
            "MESSAGE",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            decoration: BoxDecoration(
                color: Color(0xffd6d0d0),
                border: Border.all(
                  color: Color(0xffb6b3b3),
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                    child: Material(
                        color: Colors.blue,
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: Text(
                                widget.receiverName[
                                    0], //userInfos[0].email[0] ?? '',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                          ),
                        ))),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.receiverName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      width: 250,
                      //child: Flexible(
                      child: Text(
                        'Thank you for message me. Don’t hesitate \nto ask and leave inquiries below',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      //),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                  ],
                )
              ],
            ),
          )
        ]));
  }

  @override
  Widget build(BuildContext context) {
    createInput() {
      return Container(
          //padding: EdgeInsets.all(16),
          child: ListTile(
        leading: Wrap(
          spacing: 12, // space between two icons
          children: <Widget>[
            InkWell(
                onTap: () {
                  print("HAHAHAHAHAHA");
                  selectImage(context);
                },
                child: Icon(
                  FontAwesomeIcons.plus,
                  size: 30,
                )),
            _isClient == "false"
                ? Text("")
                : InkWell(
                    onTap: () {
                      print("TAAAAAAAAAAAAAAAAAAAP");
                      showPayment(context, widget.receiverId);
                    },
                    child: Icon(
                      FontAwesomeIcons.moneyBillWaveAlt,
                      size: 30,
                    ),
                  )
          ],
        ),
        title: Container(
          color: Color(0xffdfd1d1),
          height: 30,
          width: 250,
          child: TextField(
            style: TextStyle(
                fontSize: 14, height: 1.5, fontWeight: FontWeight.w700),
            controller: msgCtrl,
            cursorColor: Colors.greenAccent,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                hintText: "Enter Message here",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(0))),
            focusNode: focusNode,
          ),
        ),
        trailing: InkWell(
          onTap: () => onSendMessage(msgCtrl.text, 0),
          child: Icon(
            Icons.send,
            size: 30,
          ),
        ),
      )
          //    Row(
          //     children: [
          //       InkWell(
          //         onTap: () {
          //           print("HAHAHAHAHAHA");
          //           selectImage(context);
          //         },
          //         child: Icon(
          //           FontAwesomeIcons.plus,
          //           size: 30,
          //         ),
          //       ),
          // _isClient == "false"
          //     ? Container()
          //     : InkWell(
          //         onTap: () {
          //           print("TAAAAAAAAAAAAAAAAAAAP");
          //           showPayment(context, widget.receiverId);
          //         },
          //         child: Icon(
          //           FontAwesomeIcons.moneyBillWaveAlt,
          //           size: 30,
          //         ),
          //       ),
          //       SizedBox(
          //         width: 20,
          //       ),
          //       Container(
          //         color: Color(0xffdfd1d1),
          //         height: 30,
          //         width: 250,
          //         child: TextField(
          //           style: TextStyle(
          //               fontSize: 14, height: 1.5, fontWeight: FontWeight.w700),
          //           controller: msgCtrl,
          //           cursorColor: Colors.greenAccent,
          //           decoration: InputDecoration(
          //               contentPadding:
          //                   EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          //               hintText: "Enter Message here",
          //               border: OutlineInputBorder(
          //                   borderRadius: BorderRadius.circular(0))),
          //           focusNode: focusNode,
          //         ),
          //       ),
          //       SizedBox(
          //         width: 3,
          //       ),
          //       InkWell(
          //         onTap: () => onSendMessage(msgCtrl.text, 0),
          //         child: Icon(
          //           Icons.send,
          //           size: 30,
          //         ),
          //       ),
          //     ],
          //   ));
          );
    }

    //Receiver msgs -left

//else{
//return

//NEED
//  Container(
//      margin: EdgeInsets.only(bottom: 10.0),
//      child: Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: [Row(children: [],),isLastMsgLeft(index) ? Container(child: Text(DateFormat("dd MMMM, yyyy - hh:mm:aa").format(DateTime.fromMillisecondsSinceEpoch(int.parse(docs["timestamp"]))), style: const TextStyle(color: Colors.grey, fontSize: 12.0 ),),margin: EdgeInsets.only(left: 50.0, top: 50.0, bottom: 5.0),): Container() ]));
//NEED

//}

    bool isLastMsgLeft(int index) {
      if ((index > 0 &&
              listMessage != null &&
              listMessage[index - 1]["idFrom"] == userId) ||
          index == 0) {
        return true;
      } else {
        return false;
      }
    }

    bool isLastMsgRight(int index) {
      if ((index > 0 &&
              listMessage != null &&
              listMessage[index - 1]["idFrom"] != userId) ||
          index == 0) {
        return true;
      } else {
        return false;
      }
    }

    Widget createItem(int index, DocumentSnapshot document) {
      User user = _auth.currentUser!;
      //My messages - Right Side
      print("BAAAAAAAAAAAT<AM");
      print(document.data());
      print(user.uid);
      print("BAAAAAAAAAAAT<AM");
      if (document["idFrom"] == user.uid) {
        print("TRUEEEEEEEEEEEEEEE");
        return Row(
          mainAxisAlignment: document["idFrom"] == user.uid
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: <Widget>[
            document["type"] == 0 && document["idTo"] == widget.receiverId
                //Text

                ? Container(
                    child: Text(
                      "Sent: " + document["content"],
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ), // Text
                    padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    width: 200.0,
                    decoration: BoxDecoration(
                        color: Color(0xffffbe7d),
                        borderRadius: BorderRadius.circular(8.0)),
                    margin: EdgeInsets.only(
                        bottom: isLastMsgRight(index) ? 20.0 : 10.0,
                        right: 10.0),
                  )
                //: Container()

                // Image Msg
                : document["type"] == 1 && document["idTo"] == widget.receiverId
                    ? Container(
                        margin: EdgeInsets.all(12),
                        child: FlatButton(
                          child: Container(
                            width: 200,
                            child: Material(
                              child: Image.network(document["content"]),
                              //   CachedNetworkImage(
                              //     imageUrl: document["content"],
                              //     progressIndicatorBuilder:
                              //         (context, url, downloadProgress) =>
                              //             CircularProgressIndicator(
                              //                 value: downloadProgress.progress),
                              //     errorWidget: (context, url, error) =>
                              //         Icon(Icons.error),
                              //   ),

                              //    CachedNetworkImage(
                              //     placeholder: (context, url) => Container(
                              //       child: CircularProgressIndicator(
                              //         valueColor: AlwaysStoppedAnimation<Color>(
                              //             Colors.lightBlueAccent),
                              //       ), //CircularProgressIndicator
                              //       width: 200.0,
                              //       height: 200.0,
                              //       padding: EdgeInsets.all(70.0),
                              //       decoration: BoxDecoration(
                              //         color: Colors.grey,
                              //         borderRadius:
                              //             BorderRadius.all(Radius.circular(8.0)),
                              //       ), //BoxDecoration
                              //     ), //Container
                              //     // errorWidget: (context, url, error) => Material(
                              //     //   child: Image.asset(
                              //     //       "images/img_not_available.jpg",
                              //     //       width: 200.0,
                              //     //       height: 200.0,
                              //     //       fit: BoxFit.cover),
                              //     //   borderRadius:
                              //     //       BorderRadius.all(Radius.circular(8.0)),
                              //     //   clipBehavior: Clip.hardEdge,
                              //     // ), //Material
                              //     imageUrl: document["content"],
                              //     width: 200.0,
                              //     height: 200.0,
                              //     fit: BoxFit.cover,
                              //   ), //ChacheNetwork Image
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              clipBehavior: Clip.hardEdge,
                            ),
                          ), //Material
                          // onPressed: () {

                          //   print(document["content"]);
                          // }

                          onPressed: () {
                            // ImageViewer.showImageSlider(
                            //   images: [document["content"]],
                            //   startingPosition: 1,
                            // );
                            final imageProvider =
                                Image.network(document["content"]).image;
                            showImageViewer(context, imageProvider,
                                onViewerDismissed: () {
                              print("dismissed");
                            });
                          },
                          // {
                          // 	Navigator.push(context, MaterialPageRoute(
                          // 		builder: (context) => FullPhoto(url: document["content"]);
                          // 	)); //MaterialPageRoute
                          // },
                        ), //FlatButton
                        //margin: EdgeInsets.only(bottom isLastMsgRight(index) ? 20.0 : 10.0, right: 10.0),
                      ) //Container
                    //Sticker .gif Msg

                    : Container()

            // Container(
            //     // child: Image.asset(
            //     // 	"images/${document['container']}.gif",
            //     // 	width: 100.0,
            //     // 	height: 100.0,
            //     // 	fit: BoxFit.cover,
            //     // ),//Image.asset
            //     // margin: EdgeInsets.only(bottom isLastMsgRight(index) ? 20.0 : 10.0, right: 10.0),
            //     ), //container
          ], //<Widget>[]
        ); //Row
      }
      //Receiver Messages - Left Side
      else {
        return Container(
            child: Column(children: <Widget>[
          Row(children: <Widget>[
            document["type"] == 0 && document["idFrom"] == widget.receiverId
                //Text
                ? Container(
                    child: Text(
                      "Received: " + document["content"],
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400),
                    ), // Text
                    padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    width: 200.0,
                    decoration: BoxDecoration(
                        color: Color(0xff9dd4e5),
                        borderRadius: BorderRadius.circular(8.0)),
                    margin: EdgeInsets.only(left: 10.0, bottom: 10),
                  )
                : document["type"] == 1 &&
                        document["idFrom"] == widget.receiverId
                    ? Container(
                        margin: EdgeInsets.all(12),
                        child: FlatButton(
                          child: Container(
                            //  height: 400,
                            width: 200,
                            child: Material(
                              child: Image.network(document["content"]),
                              //   CachedNetworkImage(
                              //     imageUrl: document["content"],
                              //     progressIndicatorBuilder:
                              //         (context, url, downloadProgress) =>
                              //             CircularProgressIndicator(
                              //                 value: downloadProgress.progress),
                              //     errorWidget: (context, url, error) =>
                              //         Icon(Icons.error),
                              //   ),

                              //    CachedNetworkImage(
                              //     placeholder: (context, url) => Container(
                              //       child: CircularProgressIndicator(
                              //         valueColor: AlwaysStoppedAnimation<Color>(
                              //             Colors.lightBlueAccent),
                              //       ), //CircularProgressIndicator
                              //       width: 200.0,
                              //       height: 200.0,
                              //       padding: EdgeInsets.all(70.0),
                              //       decoration: BoxDecoration(
                              //         color: Colors.grey,
                              //         borderRadius:
                              //             BorderRadius.all(Radius.circular(8.0)),
                              //       ), //BoxDecoration
                              //     ), //Container
                              //     // errorWidget: (context, url, error) => Material(
                              //     //   child: Image.asset(
                              //     //       "images/img_not_available.jpg",
                              //     //       width: 200.0,
                              //     //       height: 200.0,
                              //     //       fit: BoxFit.cover),
                              //     //   borderRadius:
                              //     //       BorderRadius.all(Radius.circular(8.0)),
                              //     //   clipBehavior: Clip.hardEdge,
                              //     // ), //Material
                              //     imageUrl: document["content"],
                              //     width: 200.0,
                              //     height: 200.0,
                              //     fit: BoxFit.cover,
                              //   ), //ChacheNetwork Image
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              clipBehavior: Clip.hardEdge,
                            ),
                          ), //Material
                          // onPressed: () {
                          //   print(document["content"]);
                          // }
                          onPressed: () {
                            // ImageViewer.showImageSlider(
                            //   images: [document["content"]],
                            //   startingPosition: 1,
                            // );
                            final imageProvider =
                                Image.network(document["content"]).image;
                            showImageViewer(context, imageProvider,
                                onViewerDismissed: () {
                              print("dismissed");
                            });
                          },
                          // {
                          // 	Navigator.push(context, MaterialPageRoute(
                          // 		builder: (context) => FullPhoto(url: document["content"]);
                          // 	)); //MaterialPageRoute
                          // },
                        ), //FlatButton
                        //margin: EdgeInsets.only(bottom isLastMsgRight(index) ? 20.0 : 10.0, right: 10.0),
                      ) //Contai
                    : document["type"] == 2 &&
                            (document["idFrom"] == widget.receiverId) &&
                            document["idTo"] == user.uid

                        // &&
                        //         (document["idFrom"] == user.uid &&
                        //             document["idTo"] == widget.receiverId)
                        ? Container(
                            child: Text(
                              "TechAssist: " + document["content"],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ), // Text
                            padding:
                                EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                            width: 200.0,
                            decoration: BoxDecoration(
                                color: Color(0xff5fef77),
                                borderRadius: BorderRadius.circular(8.0)),
                            margin: EdgeInsets.only(left: 10.0, bottom: 10),
                          )
                        : Container()
          ])
        ]));
      }
    }

    Widget createListMessages() {
      User user = _auth.currentUser!;
      return Scrollbar(
        isAlwaysShown: true,
        child: Container(
          height: 460,
          child: chatId == ""
              ? const Center(
                  child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                ))
              : StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("messages")
                      .doc(user.uid)
                      .collection(user.uid)
                      .orderBy("timestamp", descending: true)
                      .limit(20)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: Center(
                              child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.lightBlueAccent),
                      )));
                    } else {
                      listMessage = snapshot.data!.docs;
                      return ListView.builder(
                        itemBuilder: (context, index) =>
                            createItem(index, snapshot.data!.docs[index]),
                        itemCount: snapshot.data!.docs.length,
                        reverse: true,
                        controller: listScrollCtrl,
                      );
                    }
                  }),
        ),
      );
    }

    return
        // MaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   home:

        Scaffold(
            //   bottomSheet: createInput(),
            //resizeToAvoidBottomInset: false,
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('payment')
                    .snapshots(),
                builder: (ctx,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        streamSnapshots) {
                  if (streamSnapshots.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final documents = streamSnapshots.data!.docs;

                  print("YYYYYYYYYYYYYYY");
                  documents.forEach((doc) {
                    print(doc);
                  });
                  print(documents.last.data());
                  print("YYYYYYYYYYYYYYY");
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //  WillPopScope(
                          //   child:
                          //  Stack(
                          //   children: [
                          //  Column(
                          ////  children: [

                          top(),
                          createListMessages(),
                          //  Spacer(),
                          createInput()
                          // ],
                          //  ),
                          // ],
                          //),
                          //   onWillPop: null)
                          //msgScreen()
                        ],
                      ),
                    ),
                  );
                }));
    // );
  }
}
