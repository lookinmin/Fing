import 'package:flutter/material.dart';

class NearFestival extends StatefulWidget {
  const NearFestival({Key? key}) : super(key: key);

  @override
  State<NearFestival> createState() => _NearFestivalState();
}

//내주변 Page -> appbar와 listview로 구성
class _NearFestivalState extends State<NearFestival> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '내주변 페스티벌',
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
      body: NearFestivalList(),
    );
  }
}

//주변 페스티벌 리스트뷰 -> 페스티벌 갯수만큼 아이템들을 리스트뷰로 생성
class NearFestivalList extends StatelessWidget {
  const NearFestivalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: ListView.builder(
        itemCount: festivalitem.length,
        itemBuilder: (BuildContext context, int index) {
          return NearFestivalItem(item: festivalitem[index]);
        },
      ),
    );
  }
}

class NearFestivalItem extends StatefulWidget {
  const NearFestivalItem({Key? key, required this.item}) : super(key: key);
  final item;

  @override
  State<NearFestivalItem> createState() => _NearFestivalItemState();
}

class _NearFestivalItemState extends State<NearFestivalItem> {
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
                    margin: EdgeInsets.only(left: 5),
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                        color: Colors.pink[500],
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 49, 48, 48)
                                  .withOpacity(0.4),
                              spreadRadius: 1, //퍼지는거리
                              blurRadius: 5, //흐림정도
                              offset: Offset(2, 4)) //그림자위치
                        ]),
                    child: Text("D-${widget.item.dday.toString()}",
                        style: TextStyle(
                            letterSpacing: 0.7,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(widget.item.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
      this.dday, this.img1, this.title, this.date, this.location, this.likenum);
  final int dday;
  final String img1;
  final String title;
  final String date;
  final String location;
  final int likenum;
}

final festivalitem = [
  FestivalModel(
    2,
    "images/waterbomb1.png",
    "2022 워터밤 대구",
    "2022.07.23~2022.07.23",
    "대구광역시 대구스타디움",
    12,
  ),
  FestivalModel(
    12,
    "images/waterbomb2.png",
    "자라섬 재즈 페스티벌",
    "2022.10.01~2022.10.03",
    "가평군 가평읍 달전리 자라섬",
    7,
  ),
  FestivalModel(
    8,
    "images/jazzfestival.png",
    "치악산 복숭아축제",
    "2022.08.20~2022.08.21",
    "강원도 원주시",
    3,
  ),
  FestivalModel(
    23,
    "images/waterbombDaegu.png",
    "피란수도 부산 문화재 야행",
    "2022.08.19~2022.08.20",
    "부산광역시 임시수도기념거리",
    7,
  ),
];
