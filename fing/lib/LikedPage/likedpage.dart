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
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Image.asset(
                  widget.item.imageUrl,
                  width: 120,
                ),
              ),
              Flexible(
                flex: 4,
                child: Container(
                    width: 400,
                    //color: Colors.green,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            widget.item.title,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            widget.item.desc1,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            widget.item.desc2,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    )),
              ),
              Expanded(
                child: Container(
                  // height: 30,
                  //color: Colors.red,
                  child: FavoriteButton(
                    //플러터 패키지 쓴 favorite_button임
                    isFavorite: true,
                    valueChanged: (_isFavorite) {
                      print("Is Favorite : $_isFavorite");
                    },
                  ),
                  // child: ElevatedButton(
                  //   onPressed: () {},
                  //   child: Icon(Icons.delete_forever,
                  //       color: Color.fromRGBO(255, 126, 0, 1)),
                  //   style: ElevatedButton.styleFrom(
                  //     padding: EdgeInsets.zero,
                  //     //alignment: Alignment.center,
                  //     //minimumSize: Size(70, 30),
                  //     primary: Colors.white,
                  //     onPrimary: Colors.black,
                  //     side: BorderSide(
                  //         color: Color.fromRGBO(255, 126, 0, 1)),
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(30.0)),
                  //   ),
                  // ),
                ),
              ),
               
                
            ],
            ),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          Divider(
            thickness: 1,
            color: Color.fromARGB(102, 192, 190, 190),
          ),
        ],
      ),
    );
  }
}

class ListModel {
  const ListModel(this.imageUrl, this.title, this.desc1, this.desc2);
  final String imageUrl;
  final String title;
  final String desc1;
  final String desc2;
}

const likeditem = [
  ListModel("assets/images/waterbombDaegu.png", "WATERBOMB(대구)",
      "기간 : 2022.07.23", "위치 : 대구스타디움"),
  ListModel("assets/images/jazzfestival.png", "자라섬 재즈 페스티벌",
      "기간 : 2022.10.01~10.03", "위치 : 가평군 가평읍 달전리 자라섬"),
];
