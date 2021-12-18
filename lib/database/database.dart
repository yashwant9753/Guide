// import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

void addItem(mail, var d, var _messagecomp) {
  CollectionReference users = FirebaseFirestore.instance.collection("${mail}");
  users.doc('$d').set({"Activities": _messagecomp});
}

void addreview(int star, String suggestion, mail) {
  CollectionReference users = FirebaseFirestore.instance.collection("Review");
  users.doc('$mail').set({"Suggestion": "$suggestion", "Star": star});
}

// Fetch Document Id(Date and time) as List<dynamic>
Future getUserDate(_mail) async {
  CollectionReference profileList =
      FirebaseFirestore.instance.collection('$_mail');
  List itemsList = [];

  try {
    await profileList.get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        itemsList.add(element.id);
      });
    });
    return itemsList;
  } catch (e) {
    print(e.toString());
    return null;
  }
}

// Fetch the user Activity in InvestorScreen
Future getUserActivity(_mail, String date) async {
  CollectionReference user = FirebaseFirestore.instance.collection('$_mail');
  List itemsList = [];
  var map;
  var map2;
  try {
    await user.doc(date).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        map = documentSnapshot.data();
        map2 = map["Activities"];
      }
    });
    return map2;
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future updateApp() async {
  CollectionReference profileList =
      FirebaseFirestore.instance.collection('Update');
  List itemsList = [];

  try {
    await profileList.get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        itemsList.add(element.data());
      });
    });
    // print(itemsList);
    return itemsList;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
