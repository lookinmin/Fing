import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FestivalPage extends StatefulWidget {
  const FestivalPage({Key? key}) : super(key: key);

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
          'Music',
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
      body: FestivalList(),
    );
  }
}

//페스티벌 리스트뷰 -> 페스티벌 갯수만큼 아이템들을 리스트뷰로 생성
class FestivalList extends StatelessWidget {
  const FestivalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: ListView.builder(
        itemCount: festivalitem.length,
        itemBuilder: (BuildContext context, int index) {
          return FestivalItem(item: festivalitem[index]);
        },
      ),
    );
  }
}

//페스티벌 리스트뷰 아이템 -> 리스트뷰 아이템 하나
class FestivalItem extends StatefulWidget {
  const FestivalItem({Key? key, required this.item}) : super(key: key);
  final item;

  @override
  State<FestivalItem> createState() => _FestivalItemState();
}

class _FestivalItemState extends State<FestivalItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => 페스티벌상세())), #페스티벌상세페이지로 연결
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.grey,
                      child: Image.asset(widget.item.img1, fit: BoxFit.fill)),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                      color: Colors.pink[500],
                      // color: Color.fromRGBO(255, 126, 0, 30.0),
                      // color: Color.fromARGB(225, 255, 0, 85),
                      // color: Color.fromARGB(224, 45, 64, 209),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text("D-22",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(widget.item.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                widget.item.date,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.item.location,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                Container(
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.pink[400],
                      size: 17,
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                        child: Text(widget.item.likenum.toString(),
                            style: TextStyle(fontSize: 15))),
                  ]),
                )
              ],
            )),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            Divider(
              thickness: 1,
              color: Color.fromARGB(102, 192, 190, 190),
            ),
          ],
        ),
      ),
    );
  }
}

class FestivalModel {
  const FestivalModel(
      this.img1, this.title, this.date, this.location, this.likenum);
  final String img1;
  // final String img2;
  final String title;
  final String date;
  final String location;
  final int likenum;
}

final festivalitem = [
  FestivalModel(
    "images/waterbomb1.png",
    // "images/waterbombDaegu.png",
    "2022 워터밤 대구",
    "2022.07.23~2022.07.23",
    "대구광역시 대구스타디움",
    12,
  ),
  FestivalModel(
    "images/waterbomb2.png",
    // "images/jazzfestival.png",
    "자라섬 재즈 페스티벌",
    "2022.10.01~2022.10.03",
    "가평군 가평읍 달전리 자라섬",
    7,
  ),
  FestivalModel(
    "images/jazzfestival.png",
    // "images/jazzfestival.png",
    "치악산 복숭아축제",
    "2022.08.20~2022.08.21",
    "강원도 원주시",
    3,
  ),
  FestivalModel(
    "images/waterbombDaegu.png",
    // "images/jazzfestival.png",
    "피란수도 부산 문화재 야행",
    "2022.08.19~2022.08.20",
    "부산광역시 임시수도기념거리",
    7,
  ),
];
