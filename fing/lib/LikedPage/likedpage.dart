import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fing/Mypage/favorite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart'; //favorite_button package사용

// void main() {
//   runApp(const LikedPage());
// }
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
  String curuser = "wjdtpdus828@naver.com";
  @override
  void initState() {
    super.initState();
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
          fireModel.readcount,
          fireModel.reference));
    }
    return tmp;
  }

  bool favoriteBtn = true;

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
                    var favoriteButton = FavoriteButton(
                      //플러터 패키지 쓴 favorite_button임
                      isFavorite: true,
                      valueChanged: (isFavorite) async {
                        print("Is Favorite : $isFavorite");
                        if (!isFavorite) {
                          // String curuser = "wjdtpdus828@naver.com";
                          await FirebaseFirestore.instance
                              .collection('User')
                              .doc(curuser)
                              .collection("MyFavorite")
                              .doc(list[index].title.toString())
                              .delete();

                          setState(() {
                            favoriteBtn = !favoriteBtn;
                            list.removeAt(index);
                          });
                        }
                      },
                      iconSize: 50,
                    );
                    return InkWell(
                      onTap: () {
                        //          Navigator.push(
                        // context,
                        // MaterialPageRoute(
                        //     builder: (context) =>DetailPage())
                        //     );
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
                                favoriteButton,
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
      child: Image.asset(list[index].firstimage.toString(), fit: BoxFit.fill),
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
}

//찜한 페스티벌 아이템
class LikedItem extends StatefulWidget {
  const LikedItem({Key? key, required this.item, required this.curuser})
      : super(key: key);
  final item;
  final curuser;

  @override
  State<LikedItem> createState() => _LikedItemState();
}

class _LikedItemState extends State<LikedItem> {
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: size.width * 0.23,
                height: size.height * 0.13,
                child: Image.asset(widget.item.firstimage, fit: BoxFit.fill),
              ),
              Container(
                  width: size.width * 0.52,
                  padding: EdgeInsets.only(left: 13, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          widget.item.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: size.width * 0.6,
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          '${StringToDate(widget.item.eventstartdate)} ~ ${StringToDate(widget.item.eventenddate)}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          widget.item.addr1,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  )),
              // SizedBox(
              //   width: 20,
              // ),
              FavoriteButton(
                //플러터 패키지 쓴 favorite_button임
                isFavorite: true,
                valueChanged: (isFavorite) async {
                  print("Is Favorite : $isFavorite");
                  if (isFavorite) {
                    // String curuser = "wjdtpdus828@naver.com";
                    await FirebaseFirestore.instance
                        .collection('User')
                        .doc(widget.curuser)
                        .collection("MyFavorite")
                        .doc(widget.item.title)
                        .delete();
                  }
                },
                iconSize: 50,
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 15)),
          Divider(
            thickness: 1,
            color: Color.fromARGB(102, 192, 190, 190),
          ),
        ],
      ),
    );
  }
}

String StringToDate(eventenddate) {
  var date = DateTime.parse(eventenddate).toString().split(' ');
  return date[0];
}

class ListModel {
  const ListModel(this.firstimage, this.title, this.eventstartdate,
      this.eventenddate, this.addr1);
  final String firstimage;
  final String title;
  final String eventstartdate;
  final String eventenddate;
  final String addr1;
}

const likeditem = [
  ListModel("assets/images/waterbombDaegu.png", "WATERBOMB(대구)", "20220723",
      "20220725", "대구광역시 대구스타디움"),
  ListModel("assets/images/jazzfestival.png", "자라섬 재즈 페스티벌페스티벌페스티벌", "20220823",
      "20220923", "가평군 가평읍 달전리 자라섬자라섬자라섬자라섬"),
];
