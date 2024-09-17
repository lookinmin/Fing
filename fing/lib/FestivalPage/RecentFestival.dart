import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fing/API/searchFestival.dart';
import 'package:fing/Mypage/recent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fing/FestivalPage/detail/detail.dart';

import '../Firebase/fing_db.dart';

class RecentFestivalItem extends StatefulWidget {
  const RecentFestivalItem({Key? key, required this.item}) : super(key: key);

  final item;

  @override
  State<RecentFestivalItem> createState() => _RecentFestivalItemState();
}

class _RecentFestivalItemState extends State<RecentFestivalItem> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var mobileWidth = 700;
    bool isWeb = true;
    size.width > mobileWidth ? isWeb = true : isWeb = false;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      firstimage: widget.item.firstimage,
                      title: widget.item.title,
                      addr1: widget.item.addr1,
                      contentid: widget.item.contentid,
                      mapx: widget.item.mapx,
                      mapy: widget.item.mapy,
                    )));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  width: isWeb ? 140 : (size.width * 0.3),
                  height: size.height * 0.15,
                  padding: EdgeInsets.all(12),
                  child: Stack(
                    children: [
                      Container(
                        height: 300,
                        width: double.infinity,
                        color: Color.fromARGB(255, 227, 227, 227),
                        child: CachedNetworkImage(
                          imageUrl: widget.item.firstimage,
                          errorWidget: ((context, url, error) => Image(
                              image: AssetImage(
                                  'assets/images/DefaultImage.png'))),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      dDay()
                    ],
                  )),
              Container(
                padding: isWeb
                    ? EdgeInsets.only(left: 5)
                    : EdgeInsets.only(left: 5, right: 10),
                width: isWeb ? (size.width * 0.35) : (size.width * 0.65),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: Text(
                        widget.item.title,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 7.5),
                        child: Text(
                          widget.item.addr1,
                          style: TextStyle(
                              fontSize: 14, overflow: TextOverflow.ellipsis),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            '${strToDate(widget.item.eventstartdate)} ~ ${strToDate(widget.item.eventenddate)}',
                            style: TextStyle(fontSize: 14),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
          // Paddirng(padding: EdgeInsets.only(bottom: 15)),
          Divider(
            thickness: 1,
            color: Color.fromARGB(102, 192, 190, 190),
          ),
        ],
      ),
    );
  }

  Container dDay() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
      decoration: BoxDecoration(
          color: Colors.pink[500],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 49, 48, 48).withOpacity(0.4),
                spreadRadius: 1, //퍼지는거리
                blurRadius: 5, //흐림정도
                offset: Offset(2, 4)) //그림자위치
          ]),
      child: Text(getDDay(widget.item.eventstartdate),
          style: TextStyle(
              letterSpacing: 0.7,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white)),
    );
  }
}

String strToDate(eventenddate) {
  var date = DateTime.parse(eventenddate).toString().split(' ');
  return date[0];
}

String getDDay(eventstartdate) {
  int diff =
      DateTime.now().difference(DateTime.parse(eventstartdate)).inDays - 1;
  if (diff >= 0) {
    return "진행중";
  }
  return 'D$diff';
}
