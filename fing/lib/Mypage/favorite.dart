import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fing/FestivalPage/detail/detail.dart';
import 'package:fing/login/login_SNS.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../FestivalPage/festivalist.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
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
        body: FavoriteFestivalList());
  }
}

class FavoriteFestivalList extends StatefulWidget {
  const FavoriteFestivalList({Key? key}) : super(key: key);

  @override
  State<FavoriteFestivalList> createState() => _FavoriteFestivalListState();
}

class _FavoriteFestivalListState extends State<FavoriteFestivalList> {
  late Future<List<FireModel>> favoritelist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String curuser = "wjdtpdus828@naver.com";

    favoritelist = readData();
  }

  Future<List<FireModel>> readData() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance
            .collection("User")
            .doc("wjdtpdus828@naver.com")
            .collection("MyFavorite");
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();

    List<FireModel> tmp = [];
    for (var doc in querySnapshot.docs) {
      FireModel fireModel = FireModel.fromQuerySnapshot(doc);
      tmp.add(FireModel(
          fireModel.addr1,
          fireModel.firstimage,
          fireModel.title,
          fireModel.contentid,
          fireModel.eventstartdate,
          fireModel.eventenddate,
          fireModel.readcount,
          fireModel.reference));
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
            List<FireModel> list = snapshot.data!;
            print(list[0].addr1);
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: ((context, index) => InkWell(
                      onTap: () {
                        //          Navigator.push(
                        // context,
                        // MaterialPageRoute(
                        //     builder: (context) =>DetailPage())
                        //     );
                      },
                      child: FestivalItem(item: list[index]),
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
  String? addr1;
  String? firstimage;
  String? title;
  String? contentid;
  String? eventstartdate;
  String? eventenddate;
  String? readcount;
  DocumentReference? reference;

  FireModel(this.addr1, this.firstimage, this.title, this.contentid,
      this.eventstartdate, this.eventenddate, this.readcount, this.reference);

  FireModel.fromJson(dynamic json, this.reference) {
    addr1 = json['addr1'];
    firstimage = json['firstimage'];
    title = json['title'];
    contentid = json['contentid'];
    eventstartdate = json['eventstartdate'];
    eventenddate = json['eventenddate'];
    readcount = json['readcount'];
  }

  FireModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);
}
