import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../FestivalPage/festivalist.dart';

class recent extends StatefulWidget {
  const recent({Key? key}) : super(key: key);

  @override
  State<recent> createState() => _recentState();
}

class _recentState extends State<recent> {
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
        body: recent_festival_list());
  }
}

class recent_festival_list extends StatelessWidget {
  const recent_festival_list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: ListView.builder(
        itemCount: recentlist.length,
        itemBuilder: (BuildContext context, int index) {
          return FestivalItem(item: recentlist[index]);
        },
      ),
    );
  }
}

final recentlist = [
  FestivalModel("assets/images/jazzfestival.png", "2022 워터밤 대구", "2022.08.20",
      "2022.08.21", "강원도 원주시", "3")
];
