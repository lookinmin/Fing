import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fing/login/login_SNS.dart';
import 'package:flutter/material.dart';
import '../FestivalPage/festivalist.dart';

class favorite extends StatefulWidget {
  const favorite({Key? key}) : super(key: key);

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '찜한 페스티벌',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: favorite_festival_list());
  }
}

class favorite_festival_list extends StatefulWidget {
  const favorite_festival_list({Key? key}) : super(key: key);

  @override
  State<favorite_festival_list> createState() => _favorite_festival_listState();
}

class _favorite_festival_listState extends State<favorite_festival_list> {
  List favoritelist = <FireModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String curuser = "wjdtpdus828@naver.com";

    readData();
  }

  Future<List<FireModel>> readData() async {
    print('readData start');
    CollectionReference<Map<String, dynamic>> _collectionReference =
        FirebaseFirestore.instance
            .collection("User")
            .doc("wjdtpdus828@naver.com")
            .collection("MyFavorite");
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _collectionReference.get();

    List<FireModel> favoritelist = [];
    for (var doc in querySnapshot.docs) {
      FireModel fireModel = FireModel.fromQuerySnapshot(doc);
      favoritelist.add(FireModel(fireModel.address, fireModel.favorite_image,
          fireModel.title, fireModel.reference));
      // favoritelist.add(fireModel);
    }

    for (var item in favoritelist) {
      print('${item.title}, ${item.address}, ${item.reference}');
    }

    return favoritelist;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: ListView.builder(
        itemCount: favoritelist.length,
        itemBuilder: (BuildContext context, int index) {
          return Text('Content Number ${favoritelist[index].address}');
        },
      ),
    );
  }
}

class FireModel {
  String? address;
  String? favorite_image;
  String? title;
  DocumentReference? reference;

  FireModel(this.address, this.favorite_image, this.title, this.reference);

  FireModel.fromJson(dynamic json, this.reference) {
    address = json['address'];
    favorite_image = json['favorite_image'];
    title = json['title'];
  }

  FireModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);
}
