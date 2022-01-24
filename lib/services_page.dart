import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tech_assist_flutter_next/screens/chat_page.dart';
import 'package:tech_assist_flutter_next/screens/chatting_page.dart';
import 'package:tech_assist_flutter_next/widgets/posts_cards.dart';
import 'package:uuid/uuid.dart';

class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _searchTextController = TextEditingController();

  TextEditingController _postTextController = TextEditingController();

  Future<QuerySnapshot>? futureSearchResults;
  QuerySnapshot? futureSearch;
  final FocusNode _node = FocusNode();
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _searchTextController.addListener(() {
      setState(() {});
    });
  }

  var uuid = const Uuid();

  final postsRef = FirebaseFirestore.instance.collection('posts');

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isSearching = false;

  int _current = 0;
  String message = '';

  List _carouselImages = [
    'assets/images/carousel1.png',
    'assets/images/carousel2.png',
    'assets/images/carousel3.jpg',
    'assets/images/carousel4.jpg',
  ];

  final CollectionReference _collectionUsers =
      FirebaseFirestore.instance.collection("users");

  controlSearching(String userName) async {
    setState(() {
      if (userName.isEmpty) {
        setState(() {
          isSearching = false;
        });
      }
    });
    Future<QuerySnapshot> querySnapshot = _collectionUsers
        .where("jobdescription", isGreaterThanOrEqualTo: userName)
        .get();

    setState(() {
      isSearching = true;
      futureSearchResults = querySnapshot;
    });
  }

  displayUserFoundScreen() {
    return FutureBuilder<QuerySnapshot>(
        future: futureSearchResults,
        builder: (context, dataSnapshot) {
          if (dataSnapshot.hasData) {
            final List<DocumentSnapshot> documents = dataSnapshot.data!.docs;
            final allData = documents.map((doc) => doc.data()).toList();

            print("QIWIWEIEIOWUEWIUOWEUO");
            return Scrollbar(
              thickness: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey

                      //color: Colors.red[500],
                      ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                // color: Colors.white,
                child: Column(
                    children: documents
                        .map((doc) => Card(
                              child: Column(children: [
                                ListTile(
                                  leading: ClipOval(
                                      child: Material(
                                          color: Colors.blue,
                                          child: doc["imageurl"] != ''
                                              ? Container(
                                                  width: 50,
                                                  child: Image.network(
                                                    doc["imageurl"],
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                )
                                              : Container(
                                                  height: 50,
                                                  width: 50,
                                                  //   padding: const EdgeInsets
                                                  //           .symmetric(
                                                  //       horizontal: 36,
                                                  //       vertical: 26),
                                                  child: Center(
                                                    child: Text(
                                                        doc['fullname'][
                                                            0], //userInfos[0].email[0] ?? '',
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ))),
                                  title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Name:"),
                                            Text(doc['fullname']),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Job Service:"),
                                            Text(doc['jobdescription']),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Contacts:"),
                                            Text(doc['phoneNumber']),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Experience:"),
                                            Text(doc['jobexperience'])
                                          ],
                                        ),
                                      ]),
                                ),
                                Container(
                                  width: 130,
                                  height: 32,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChattingPage(
                                                      receiverId: doc["id"],
                                                      receiverName:
                                                          doc["fullname"],
                                                    )));
                                      },
                                      child: Text("MESSAGE ME",
                                          style: GoogleFonts.roboto(
                                              letterSpacing: 2,
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700)),
                                      style: ElevatedButton.styleFrom(
                                        side: BorderSide(
                                            width: 1.0,
                                            color: Color(0xfffafafa)),
                                        shape: StadiumBorder(),
                                        primary: Color(0xfff5970a),
                                      )),
                                ),
                              ]),
                            ))
                        .toList()),
              ),
            );
          } else if (dataSnapshot.hasError) {
            return const Center(child: const Text("No Results found"));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
          // dataSnapshot.data..print(dataSnapshot.data);

          //   List<UserResult> searchResult = [];
        });
  }

//   sendUserToChatPage(BuildContext context) {

//   }

  Widget serviceOne() {
    User user = _auth.currentUser!;
//     // _uid = user.uid;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 6),
          height: 120.0,
          width: double.infinity,
          child: Carousel(
            boxFit: BoxFit.fill,
            autoplay: true,
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(milliseconds: 1000),
            dotSize: 5.0,
            dotIncreasedColor: Colors.black,
            dotBgColor: Colors.black.withOpacity(0.2),
            dotPosition: DotPosition.bottomCenter,
            showIndicator: true,
            indicatorBgPadding: 5.0,
            images: [
              ExactAssetImage(_carouselImages[0]),
              ExactAssetImage(_carouselImages[1]),
              ExactAssetImage(_carouselImages[2]),
              ExactAssetImage(_carouselImages[3]),
            ],
          ),
        ),
        Container(
          height: 400,
          //   constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 130,
                  image: AssetImage("assets/images/bg5.png"),
                  fit: BoxFit.cover)),
          width: double.infinity,
          child: Container(
            color: Colors.grey.withAlpha(90),
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Text("TechAssist",
                    style: GoogleFonts.tinos(
                        letterSpacing: 2,
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text("At TechAssist you will find a",
                    style: GoogleFonts.tinos(
                        letterSpacing: 2,
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text("Service Worker who is good and",
                    style: GoogleFonts.tinos(
                        letterSpacing: 2,
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text("quality when it comes to service",
                    style: GoogleFonts.tinos(
                        letterSpacing: 2,
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 12,
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: 12,
                    left: 12,
                  ),
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey

                        //color: Colors.red[500],
                        ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffdfd1d1).withAlpha(150),
                          border: Border.all(

                              //color: Colors.red[500],
                              ),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        height: 30,
                        width: 260,
                        child: TextField(
                          autofocus: true,
                          controller: _postTextController,
                          style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              fontWeight: FontWeight.w700),
                          //controller: _controller,
                          cursorColor: Colors.greenAccent,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            hintText: "Post what you're looking for",
                          ),
                          onChanged: (value) {
                            setState(() {
                              message = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Container(
                        width: 90,
                        height: 32,
                        child: ElevatedButton(
                            onPressed: () async {
                              print(user.uid);
                              print("MMMMMMMMMMMMM");
                              final senderData = await FirebaseFirestore
                                  .instance
                                  .collection('users')
                                  .doc(user.uid)
                                  .get();

                              print("MMMMMMMMMMMMM");
                              print(senderData.data());
                              print("MMMMMMMMMMMMM");

                              print("MMMMMMMMMMMMM");
                              print(senderData['fullname']);
                              print("MMMMMMMMMMMMM");
                              final postId = uuid.v4();
                              //   DocumentSnapshot doc =
                              //       await postsRef.doc(user.uid).get();
                              //   if (!doc.exists) {
                              await FirebaseFirestore.instance
                                  .collection('posts')
                                  .doc(postId)
                                  .set({
                                'id': postId,
                                'poster_id': user.uid,
                                'name': senderData['fullname'],
                                'imageurl': senderData['imageurl'],
                                'msg': message,

                                'timePosted': DateFormat("MM/dd/yyyy")
                                        .format(DateTime.now()) +
                                    " " +
                                    DateFormat("hh:mm:ss a").format(
                                        DateTime.now()), //DateTime.now(),
                                "timestamp": DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                              });

                              _postTextController.clear();
                            },
                            child: Text("POST",
                                style: GoogleFonts.roboto(
                                    letterSpacing: 2,
                                    fontSize: 16,
                                    color: Colors.black,
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
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: PostsCard(),
                  height: 180,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: TextFormField(
            controller: _searchTextController,
            minLines: 1,
            focusNode: _node,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 0.0),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xff5d5f60),
              ),
              hintText: 'Search your needed Service Worker',
              filled: true,
              fillColor: Theme.of(context).cardColor,
              suffixIcon: IconButton(
                onPressed: _searchTextController.text.isEmpty
                    ? () {
                        setState(() {
                          isSearching = false;
                        });
                        _searchTextController.clear();
                        _node.unfocus();
                      }
                    : () {
                        setState(() {
                          isSearching = false;
                        });
                        _searchTextController.clear();
                        _node.unfocus();
                      },
                icon: Icon(Icons.close,
                    color: _searchTextController.text.isNotEmpty
                        ? Colors.red
                        : Colors.grey),
              ),
            ),
            onChanged: (value) {
              controlSearching(value);
              _searchTextController.text.toLowerCase();
              setState(() {
                //_searchList = productsData.searchQuery(value);
              });
            },
            onFieldSubmitted: controlSearching,
          ),
        ),
        futureSearchResults != null && isSearching
            ? displayUserFoundScreen()
            : serviceOne()
      ],
      // ),
    );
  }
}
