
import 'package:fing/goods/goods.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'goods.dart';

void main() {
  runApp(const goods_echobag());
}

class goods_echobag extends StatelessWidget {
  const goods_echobag({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FING",
      initialRoute: '/',
      routes: {'/': (BuildContext context) => GoodsPage()},
    );
  }
}

class GoodsPage extends StatelessWidget {
  const GoodsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [Container(child: GoodsTop()), Container(child: state())],
      ),
    );
  }
}

class GoodsTop extends StatelessWidget {
  const GoodsTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.black))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Text(
              'Fing MARKET',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class state extends StatefulWidget {
  State createState() {
    return GoodsShow();
  }
}

class GoodsShow extends State<state> {
  int number = 0;
  int price = 15000;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
            height: 300,
            width: 300,
            child: Image.asset(
              'assets/images/echobag.png',
              fit: BoxFit.fill,
            )),
        Container(
          width: 300,
          child: Column(
            children: [
              Container(
                width: 300,
                height: 50,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  'Fing Echobag',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.black))),
                child: Text(
                  'KRW 15,000',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                width: 300,
                height: 100,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  'Fing에서만 볼 수 있는 \n친환경적인 에코백',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          number++;
                        });
                      },
                      child: Icon(Icons.add)),
                  Container(
                    child: Text(
                      '$number',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          if (number > 0) {
                            number--;
                          }
                        });
                      },
                      child: Icon(Icons.remove)),
                ],
              )),
              Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$number개 선택',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text((number * price).toString() + ' 원',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red))
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.push(context,
                          // MaterialPageRoute(builder: (context) => const GoodsPage()));
                          // 뒤로가기 만들어줘 제발
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(140, 50),
                            primary: Color.fromRGBO(192, 192, 192, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.5),
                            )),
                        child: Text(
                          "뒤로가기",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('hi');
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(140, 50),
                            primary: Color.fromRGBO(255, 126, 0, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.5),
                            )),
                        child: Text(
                          "구매하기",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        )
      ]),
    );
  }
}
