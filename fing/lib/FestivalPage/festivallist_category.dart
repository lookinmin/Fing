import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fing/API/searchFestival.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fing/FestivalPage/detail/detail.dart';

import '../Firebase/fing_db.dart';

class FestivalModel {
  String firstimage;
  String title;
  String eventstartdate;
  String eventenddate;
  String addr1;
  String readcount;
  FestivalModel(this.firstimage, this.title, this.eventstartdate,
      this.eventenddate, this.addr1, this.readcount);
}

class FestivalPage extends StatefulWidget {
  const FestivalPage({Key? key, required this.type, required this.code})
      : super(key: key);
  final type;
  final code;

  @override
  State<FestivalPage> createState() => _FestivalState();
}

//Festival Page -> appbar와 listview로 구성
class _FestivalState extends State<FestivalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.type,
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        toolbarHeight: 50.0,
        elevation: 1.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
      ),
      body: FestivalList(code: widget.code),
    );
  }
}

//페스티벌 리스트뷰 -> 페스티벌 갯수만큼 아이템들을 리스트뷰로 생성
class FestivalList extends StatefulWidget {
  FestivalList({
    Key? key,
    required this.code,
  }) : super(key: key);
  final code;

  @override
  State<FestivalList> createState() => _FestivalListState();
}

class _FestivalListState extends State<FestivalList> {
  late Future<List<SearchFestival>> futureSearchFestival;

  @override
  void initState() {
    super.initState();
    futureSearchFestival = fetchSearchFestival(
        arrange: "B",
        areaCode: "",
        sigunguCode: "",
        eventStartDate: "20220901",
        eventEndDate: "");
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<SearchFestival>>(
        future: futureSearchFestival,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data![0].response == null) {
              return Center(
                child: Text('예정중인 페스티벌이 없습니다'),
              );
            }
            List<Item> searchfestival_model =
                snapshot.data![0].response!.body!.items!.item!;

            List<Item> category_festival_model = [];

            for (int i = 0; i < searchfestival_model.length; i++) {
              if (searchfestival_model[i].cat3 == widget.code) {
                category_festival_model.add(searchfestival_model[i]);
              }
            }

            if (category_festival_model.length == 0) {
              return Center(
                child: Text('예정중인 페스티벌이 없습니다'),
              );
            } else {
              return Container(
                margin: EdgeInsets.all(5),
                child: ListView.builder(
                  itemCount: category_festival_model.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FestivalItem(item: category_festival_model[index]);
                  },
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Text('error${snapshot.error}');
          }
          return Center(child: CupertinoActivityIndicator());
        });
  }
}

//페스티벌 리스트뷰 아이템 -> 리스트뷰 아이템 하나
class FestivalItem extends StatefulWidget {
  const FestivalItem({Key? key, required this.item}) : super(key: key);
  final item;

  @override
  State<FestivalItem> createState() => _FestivalItemState();
}

// class current_Model {
//   Uri? current_image;
//   String? current_title;
//   String? current_address;

//   current_Model({this.current_image, this.current_title, this.current_address});

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['current_image'] = current_image;
//     map['current_title'] = current_title;
//     map['current_address'] = current_address;
//     return map;
//   }
// }

class _FestivalItemState extends State<FestivalItem> {
  @override
  Widget build(BuildContext context) {
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
        //큐를 기반으로한 최근 본 축제
        bool flag = true;
        for (int i = 0; i < current_fast.length; i++) {
          if (widget.item.title.toString() == current_fast[i]) {
            flag = false;
            break;
          }
        }
        if (flag) {
          current_fast.add(widget.item.title.toString());
        }
        print(current_fast);
        String curuser = "wjdtpdus828@naver.com";
        FirebaseFirestore.instance
            .collection('User')
            .doc(curuser)
            .collection("MyCurrent")
            .doc(widget.item.title)
            .set({
          "firstimage": widget.item.firstimage,
          "title": widget.item.title,
          "addr1": widget.item.addr1,
          "contentid": widget.item.contentid,
          "mapx": widget.item.mapx,
          "mapy": widget.item.mapy,
          "eventstartdate": widget.item.eventstartdate,
          "eventenddate": widget.item.eventenddate,
          "timestamp": DateTime.now()
        }, SetOptions(merge: true));
        if (current_fast.length > 3) {
          print("hi");
          String curuser = "wjdtpdus828@naver.com";
          FirebaseFirestore.instance
              .collection('User')
              .doc(curuser)
              .collection("MyCurrent")
              .doc(current_fast[0].toString())
              .delete();
          current_fast.removeAt(0);
          print(current_fast);
        }
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                      height: 300,
                      width: double.infinity,
                      // color: Color.fromARGB(255, 227, 227, 227),
                      child: CachedNetworkImage(
                        imageUrl: widget.item.firstimage,
                        errorWidget: ((context, url, error) => Image(
                            image:
                                AssetImage('assets/images/DefaultImage.png'))),
                        fit: BoxFit.contain,
                      )),
                  dDay()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 15),
              child: Text(widget.item.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                '${strToDate(widget.item.eventstartdate)} ~ ${strToDate(widget.item.eventenddate)}',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
            location(),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            Divider(
              thickness: 1.5,
              color: Color.fromARGB(102, 192, 190, 190),
            ),
          ],
        ),
      ),
    );
  }

  Container dDay() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
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
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white)),
    );
  }

  Row location() {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, top: 2),
          width: size.width * 0.65,
          child: Text(
            widget.item.addr1,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Container(
          width: size.width * 0.3,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Icon(
                    Icons.visibility,
                    color: Color.fromRGBO(255, 126, 0, 1),
                    size: 17,
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(right: 10, top: 2),
                    child: Text(
                      widget.item.readcount.toString(),
                      style: TextStyle(fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                    )),
              ]),
        )
      ],
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
