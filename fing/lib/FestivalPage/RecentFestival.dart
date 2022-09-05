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
                width: size.width * 0.3,
                height: size.height * 0.15,
                padding: EdgeInsets.all(12),
                child: CachedNetworkImage(
                  imageUrl: widget.item.firstimage,
                  errorWidget: ((context, url, error) => Image(
                      image: AssetImage('assets/images/DefaultImage.png'))),
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, right: 10),
                width: size.width * 0.65,
                // padding: EdgeInsets.only(left: 13, right: 15),
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
}
