import 'package:flutter/material.dart';

void main() {
  runApp(const LikedPage());
}

class ListModel {
  const ListModel(this.imageUrl, this.title, this.desc1, this.desc2);
  final String imageUrl;
  final String title;
  final String desc1;
  final String desc2;
}

const likedList = [
  ListModel("images/waterbombDaegu.png", "WATERBOMB(대구)", "기간 : 2022.07.23",
      "위치 : 대구"),
  ListModel("images/jazzfestival.png", "자라섬 재즈 페스티벌", "기간 : 2022.10.01~10.03",
      "위치 : 경기 가평 자라섬"),
];

class LikedPage extends StatelessWidget {
  const LikedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15),
        // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "내 찜 목록",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
                // color: Colors.blue,
                margin: EdgeInsets.only(bottom: 10),
                child: ListView.separated(
                  itemCount: likedList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        margin: EdgeInsets.only(top: 20),
                        // color: Colors.yellow,
                        width: 400,
                        height: 150,
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Image.asset(
                              likedList[index].imageUrl,
                              width: 120,
                            ),
                            Expanded(
                              child: Container(
                                  // color: Colors.green,
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          likedList[index].title,
                                          style: TextStyle(
                                              fontSize: 18,
                                              //color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          likedList[index].desc1,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          likedList[index].desc2,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Icon(Icons.delete_forever,
                                  color: Color.fromRGBO(255, 126, 0, 1)),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black,
                                side: BorderSide(
                                    color: Color.fromRGBO(255, 126, 0, 1)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                              ),
                            ),
                          ],
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(thickness: 2);
                  },
                ))
          ],
        ));
  }
}
