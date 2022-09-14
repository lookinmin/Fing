import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fing/FestivalPage/RecentFestival.dart';
import 'package:fing/Firebase/fing_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../FestivalPage/festivalist.dart';

class FireModel {
  String? addr1;
  String? firstimage;
  String? title;
  String? contentid;
  String? mapx;
  String? mapy;
  String? eventstartdate;
  String? eventenddate;
  Timestamp? timestamp;
  DocumentReference? reference;

  FireModel(
      this.addr1,
      this.firstimage,
      this.title,
      this.contentid,
      this.mapx,
      this.mapy,
      this.eventstartdate,
      this.eventenddate,
      this.timestamp,
      this.reference);

  FireModel.fromJson(dynamic json, this.reference) {
    addr1 = json['addr1'];
    firstimage = json['firstimage'];
    title = json['title'];
    contentid = json['contentid'];
    mapx = json['mapx'];
    mapy = json['mapy'];
    eventstartdate = json['eventstartdate'];
    eventenddate = json['eventenddate'];
    timestamp = json['timestamp'];
  }

  FireModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);
}

class Recent extends StatefulWidget {
  const Recent({Key? key}) : super(key: key);

  @override
  State<Recent> createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '최근 본 페스티벌',
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
        body: RecentFestivalList());
  }
}

class RecentFestivalList extends StatefulWidget {
  const RecentFestivalList({Key? key}) : super(key: key);

  @override
  State<RecentFestivalList> createState() => _RecentFestivalListState();
}

class _RecentFestivalListState extends State<RecentFestivalList> {
  late Future<List<FireModel>> recentList;
  late String curuser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    String email = fing_db_user[0].email;
    curuser = email;
    recentList = readData();
  }

  Future<List<FireModel>> readData() async {
    Query<Map<String, dynamic>> collectionReference = FirebaseFirestore.instance
        .collection("User")
        .doc(curuser)
        .collection("MyCurrent")
        .orderBy("timestamp", descending: true);
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
          fireModel.mapx,
          fireModel.mapy,
          fireModel.eventstartdate,
          fireModel.eventenddate,
          fireModel.timestamp,
          fireModel.reference));
      if (tmp.length > 10) {
        tmp.removeAt(tmp.length - 1);
        FirebaseFirestore.instance
            .collection('User')
            .doc(curuser)
            .collection("MyCurrent")
            .doc(tmp[tmp.length - 1].title.toString())
            .delete();
      }
    }
    return tmp;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: FutureBuilder<List<FireModel>>(
        future: recentList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<FireModel> list = snapshot.data!;
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
                      child: RecentFestivalItem(item: list[index]),
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
