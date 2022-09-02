import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fing/FestivalPage/detail/detail.dart';
import 'package:fing/login/login_SNS.dart';
import 'package:flutter/cupertino.dart';
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
  late Future<List<FireModel>> favoritelist;

  late Future<List<FireModel>> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String curuser = "wjdtpdus828@naver.com";

    favoritelist = readData();
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

    List<FireModel> tmp = [];
    for (var doc in querySnapshot.docs) {
      FireModel fireModel = FireModel.fromQuerySnapshot(doc);
      tmp.add(FireModel(fireModel.address, fireModel.favorite_image,
          fireModel.title, fireModel.contentid, fireModel.reference));
    }
    return tmp;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: FutureBuilder<List<FireModel>>(
        future: favoritelist,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemBuilder: ((context, index) => InkWell(
                      onTap: () {
                        //          Navigator.push(
                        // context,
                        // MaterialPageRoute(
                        //     builder: (context) =>DetailPage())
                        //     );
                      },
                      child: Container(),
                    )));
          } else if (snapshot.hasError) {
            return Text('error${snapshot.error}');
          }
          return Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }
}

class FireModel {
  String? address;
  String? favorite_image;
  String? title;
  String? contentid;
  DocumentReference? reference;

  FireModel(this.address, this.favorite_image, this.title, this.contentid,
      this.reference);

  FireModel.fromJson(dynamic json, this.reference) {
    address = json['address'];
    favorite_image = json['favorite_image'];
    title = json['title'];
    contentid = json['contentid'];
  }

  FireModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);
}
