import 'package:fing/goods/goods.dart';
import 'package:flutter/material.dart';
import '../category/example.dart';

void main() => runApp(BottomMain());

class BottomMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: CategoryBtn(),
        ),
        Flexible(
          flex: 1,
          child: GoodsButton(),
        )
      ],
    );
  }
}

class CategoryBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 243, 243, 243),
          border: Border(
              bottom: BorderSide(
            color: Colors.grey,
            width: 2.0,
          ))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 222, 236, 255),
                      borderRadius: BorderRadius.circular(100)),
                  child: imgSet(1),
                ),
                Text(
                  "Music",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 105, 105, 105),
                      fontSize: 14),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 222, 236, 255),
                      borderRadius: BorderRadius.circular(100)),
                  child: imgSet(2),
                ),
                Text(
                  "Food",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 105, 105, 105),
                      fontSize: 14),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 222, 236, 255),
                      borderRadius: BorderRadius.circular(100)),
                  child: imgSet(3),
                ),
                Text(
                  "Natural",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 105, 105, 105),
                      fontSize: 14),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 222, 236, 255),
                      borderRadius: BorderRadius.circular(100)),
                  child: imgSet(4),
                ),
                Text(
                  "Region",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 105, 105, 105),
                      fontSize: 14),
                )
              ],
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 222, 236, 255),
                          borderRadius: BorderRadius.circular(100)),
                      child: imgSet(5)),
                  Text(
                    "Spring",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 105, 105, 105),
                        fontSize: 14),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 222, 236, 255),
                        borderRadius: BorderRadius.circular(100)),
                    child: imgSet(6),
                  ),
                  Text(
                    "Summer",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 105, 105, 105),
                        fontSize: 14),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 222, 236, 255),
                        borderRadius: BorderRadius.circular(100)),
                    child: imgSet(7),
                  ),
                  Text(
                    "Fall",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 105, 105, 105),
                        fontSize: 14),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 222, 236, 255),
                        borderRadius: BorderRadius.circular(100)),
                    child: imgSet(8),
                  ),
                  Text(
                    "Winter",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 105, 105, 105),
                        fontSize: 14),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget imgSet(int id) {
  switch (id) {
    case 1:
      return Image.asset('images/music.png');
    case 2:
      return Image.asset('images/food.png');
    case 3:
      return Image.asset('images/natural.png');
    case 4:
      return Image.asset('images/region.png');
    case 5:
      return Image.asset('images/spring.png');
    case 6:
      return Image.asset('images/summer.png');
    case 7:
      return Image.asset('images/fall.png');
    case 8:
      return Image.asset('images/winter.png');
    default:
      return Image.asset('images/mark.jpg');
  }
}

class GoodsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
              //화면전환
              context,
              MaterialPageRoute(builder: (context) => GoodsPage()));
        },
        // ignore: sort_child_properties_last
        child: SizedBox(
          width: 400,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart,
                  color: Color.fromRGBO(255, 126, 0, 1.0)),
              Container(
                padding: const EdgeInsets.all(5.0),
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(
                  "Fing MARKET",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color.fromRGBO(255, 126, 0, 1.0),
                      fontSize: 17),
                ),
              ),
            ],
          ),
        ),
        style: OutlinedButton.styleFrom(
            padding: EdgeInsets.all(10),
            elevation: 5,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            shadowColor: Colors.grey,
            side: BorderSide(color: Color.fromRGBO(255, 126, 0, 1.0)),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(80)))),
      ),
    );
  }
}
