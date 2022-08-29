import 'dart:io';

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
              fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body:recent_festival_list()
    );
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

final recentlist= [
  FestivalModel(
    2,
    "images/waterbomb1.png",
    "2022 워터밤 대구",
    "2022.07.23~2022.07.23",
    "대구광역시 대구스타디움",
    12,
  )
];