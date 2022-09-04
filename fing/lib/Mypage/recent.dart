import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../FestivalPage/festivalist.dart';
import 'favorite.dart';

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
    curuser = "wjdtpdus828@naver.com";

    recentList = readData();
  }

  Future<List<FireModel>> readData() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance
            .collection("User")
            .doc(curuser)
            .collection("MyCurrent");
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
      if (tmp.length > 3) {
        tmp.removeAt(0);
        FirebaseFirestore.instance
            .collection('User')
            .doc(curuser)
            .collection("MyCurrent")
            .doc(tmp[0].title.toString())
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
