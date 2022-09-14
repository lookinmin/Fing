import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fing/FestivalPage/detail/detail.dart';
import 'package:fing/Firebase/fing_db.dart';
import 'package:fing/Mypage/favorite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart'; //favorite_button package사용

// void main() {
//   runApp(const LikedPage());
// }

class FireModel {
  String? addr1;
  String? firstimage;
  String? title;
  String? contentid;
  String? eventstartdate;
  String? eventenddate;
  String? mapx;
  String? mapy;
  DocumentReference? reference;

  FireModel(
      this.addr1,
      this.firstimage,
      this.title,
      this.contentid,
      this.eventstartdate,
      this.eventenddate,
      this.mapx,
      this.mapy,
      this.reference);

  FireModel.fromJson(dynamic json, this.reference) {
    addr1 = json['addr1'];
    firstimage = json['firstimage'];
    title = json['title'];
    contentid = json['contentid'];
    eventstartdate = json['eventstartdate'];
    eventenddate = json['eventenddate'];
    mapx = json['mapx'];
    mapy = json['mapy'];
  }

  FireModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);
}

class LikedPage extends StatelessWidget {
  const LikedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '페스티벌 찜 목록',
          style: TextStyle(
            fontSize: 18.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false, //뒤로가기버튼없애기
        leading: null,
        backgroundColor: Colors.white,
        elevation: 1.0, // 그림자 제거
        toolbarHeight: 50.0,
      ),
      body: LikedList(),
    );
  }
}

class LikedList extends StatefulWidget {
  const LikedList({Key? key}) : super(key: key);

  @override
  State<LikedList> createState() => _LikedListState();
}

class _LikedListState extends State<LikedList> {
  late Future<List<FireModel>> favoritelist;
  String curuser = fing_db_user[0].email;

  @override
  void initState() {
    super.initState();
    print('likepage initstate');
    favoritelist = readData();
  }

  Future<List<FireModel>> readData() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance
            .collection("User")
            .doc(curuser)
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
          fireModel.mapx,
          fireModel.mapy,
          fireModel.reference));
    }

    return tmp;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.all(5),
        child: FutureBuilder<List<FireModel>>(
          future: favoritelist,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<FireModel> list = snapshot.data!;
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                    firstimage: list[index].firstimage,
                                    title: list[index].title,
                                    addr1: list[index].addr1,
                                    contentid: list[index].contentid,
                                    mapx: list[index].mapx,
                                    mapy: list[index].mapy)));
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                favoriteImg(size, list, index),
                                favoriteInfo(size, list, index),
                                FavoriteButton(
                                  isFavorite: true,
                                  iconDisabledColor: Colors.red,
                                  valueChanged: (isFavorite) async {
                                    if (!isFavorite) {
                                      // isFavorite = true;
                                      await FirebaseFirestore.instance
                                          .collection('User')
                                          .doc(curuser)
                                          .collection("MyFavorite")
                                          .doc(list[index].title.toString())
                                          .delete();

                                      setState(() {
                                        list.remove(list[index]);
                                        // change_zzim(
                                        //     isFavorite, list[index].title);
                                      });
                                    }
                                  },
                                  iconSize: 50,
                                )
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 15)),
                            Divider(
                              thickness: 1,
                              color: Color.fromARGB(102, 192, 190, 190),
                            ),
                          ],
                        ),
                      ),
                    );
                  }));
            } else if (snapshot.hasError) {
              return Text('error${snapshot.error}');
            }
            return Center(child: CupertinoActivityIndicator());
          },
        ));
  }

  SizedBox favoriteImg(var size, List<FireModel> list, int index) {
    return SizedBox(
      width: size.width * 0.23,
      height: size.height * 0.13,
        child: CachedNetworkImage(
          placeholder: (context, url) => CircularProgressIndicator(),
          imageUrl: list[index].firstimage.toString(),
          errorWidget: ((context, url, error) =>
              Image(image: AssetImage('assets/images/DefaultImage.png'))),
          fit: BoxFit.fill,
        )
        // child: Image.network(list[index].firstimage.toString(), fit: BoxFit.fill),
    );
  }

  Container favoriteInfo(var size, List<FireModel> list, int index) {
    return Container(
        width: size.width * 0.52,
        padding: EdgeInsets.only(left: 13, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                list[index].title.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: size.width * 0.6,
              padding: EdgeInsets.only(top: 20),
              child: Text(
                '${StringToDate(list[index].eventstartdate.toString())} ~ ${StringToDate(list[index].eventenddate.toString())}',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                list[index].addr1.toString(),
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ));
  }

  void showPopup(BuildContext context, bool value, String festival_name) {
    showDialog(
        context: context,
        builder: (context) {
          if (value) {
            return Dialog(
                child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$festival_name',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '을 찜목록에 추가하였습니다!',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ],
              ),
            ));
          } else {
            return Dialog(
                child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$festival_name',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '을 찜목록에서 제거하였습니다!',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ],
              ),
            ));
          }
        });
  }
}

String StringToDate(eventenddate) {
  var date = DateTime.parse(eventenddate).toString().split(' ');
  return date[0];
}
