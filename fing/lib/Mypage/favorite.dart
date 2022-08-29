import 'dart:io';

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
              fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body:favorite_festival_list()
    );
  }
}


class favorite_festival_list extends StatelessWidget {
  const favorite_festival_list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: ListView.builder(
        itemCount: favoritelist.length,
        itemBuilder: (BuildContext context, int index) {
          return FestivalItem(item: favoritelist[index]);
        },
      ),
    );
  }
}

final favoritelist= [
  FestivalModel(
    2,
    "images/waterbomb1.png",
    "2022 워터밤 대구",
    "2022.07.23~2022.07.23",
    "대구광역시 대구스타디움",
    12,
  )
];