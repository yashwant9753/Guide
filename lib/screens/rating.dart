import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guide/res/custom_colors.dart';
import 'package:guide/database/database.dart';

class RateApp extends StatefulWidget {
  const RateApp({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _RateAppState createState() => _RateAppState();
}

class _RateAppState extends State<RateApp> {
  final TextEditingController _suggestion = TextEditingController();

  bool star1 = false;
  bool star2 = false;
  bool star3 = false;
  bool star4 = false;
  bool star5 = false;
  int star = 0;
  late User _user;
  List reviewList = [];
  void submittReview() {
    reviewList.addAll([star1, star2, star3, star4, star5]);

    reviewList.forEach((element) {
      if (element) {
        star = star + 1;
      }
    });
    addreview(star, _suggestion.text, widget._user.email!);

    star = 0;
    reviewList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Scaffold(
          backgroundColor: CustomColors.buttonColor,
          appBar: AppBar(
            title: Text(
              "Rate this App",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  left: 8.0,
                  right: 8.0,
                  bottom: 30.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).backgroundColor),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                            ),
                            child: Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black, width: 0.4),
                                      borderRadius: BorderRadius.circular(8)),
                                  // color: Theme.of(context).backgroundColor,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: TextField(
                                      controller: _suggestion,
                                      maxLines: 5,
                                      decoration: InputDecoration.collapsed(
                                          hintText: "Any suggestion",
                                          hintStyle: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'PT_Sans',
                                          )),
                                    ),
                                  ),
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black, width: 0.4),
                                      borderRadius: BorderRadius.circular(10)),
                                  // color: Theme.of(context).backgroundColor,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(star1
                                              ? Icons.star
                                              : Icons.star_border),
                                          tooltip: 'Clear all Activity',
                                          onPressed: () {
                                            setState(() {
                                              star1 = star1 ? false : true;
                                              star2 = false;
                                              star3 = false;
                                              star4 = false;
                                              star5 = false;
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(star2
                                              ? Icons.star
                                              : Icons.star_border),
                                          tooltip: 'Clear all Activity',
                                          onPressed: () {
                                            setState(() {
                                              star1 = true;
                                              star2 = star2 ? false : true;
                                              star3 = false;
                                              star4 = false;
                                              star5 = false;
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(star3
                                              ? Icons.star
                                              : Icons.star_border),
                                          tooltip: 'Clear all Activity',
                                          onPressed: () {
                                            setState(() {
                                              star1 = true;
                                              star2 = true;
                                              star3 = star3 ? false : true;
                                              star4 = false;
                                              star5 = false;
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(star4
                                              ? Icons.star
                                              : Icons.star_border),
                                          tooltip: 'Clear all Activity',
                                          onPressed: () {
                                            setState(() {
                                              star1 = true;
                                              star2 = true;
                                              star3 = true;
                                              star4 = star4 ? false : true;
                                              star5 = false;
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(star5
                                              ? Icons.star
                                              : Icons.star_border),
                                          tooltip: 'Clear all Activity',
                                          onPressed: () {
                                            setState(() {
                                              star1 = true;
                                              star2 = true;
                                              star3 = true;
                                              star4 = true;
                                              star5 = star5 ? false : true;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      CustomColors.firebaseOrange,
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    submittReview();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: CustomColors.firebaseOrange,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Thanks for Rating this App")
                                      ],
                                    )));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 16.0, bottom: 16.0),
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.firebaseGrey,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ));
  }
}
