import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart'; //favorite_button package사용

void main() {
  runApp(const LikedPage());
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

class LikedList extends StatelessWidget {
  const LikedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: ListView.builder(
        itemCount: likeditem.length,
        itemBuilder: (BuildContext context, int index) {
          return LikedItem(item: likeditem[index]);
        },
      ),
    );
  }
}

//찜한 페스티벌 아이템
class LikedItem extends StatefulWidget {
  const LikedItem({Key? key, required this.item}) : super(key: key);
  final item;

  @override
  State<LikedItem> createState() => _LikedItemState();
}

class _LikedItemState extends State<LikedItem> {
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
                  )
              ),
              // SizedBox(
              //   width: 20,
              // ),
              FavoriteButton(
                //플러터 패키지 쓴 favorite_button임
                isFavorite: true,
                valueChanged: (_isFavorite) {
                  print("Is Favorite : $_isFavorite");
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
  ListModel("assets/images/waterbombDaegu.png", "WATERBOMB(대구)",
      "20220723",
      "20220725", "대구광역시 대구스타디움"),
  ListModel("assets/images/jazzfestival.png", "자라섬 재즈 페스티벌페스티벌페스티벌", "20220823",
      "20220923", "가평군 가평읍 달전리 자라섬자라섬자라섬자라섬"),
];
