import 'package:fing/goods/goods.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'goods.dart';

class goods_echobag extends StatelessWidget {
  const goods_echobag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Fing Market',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 1.0,
            ),
          ),
          centerTitle: true,
          elevation: 1.0,
          toolbarHeight: 50.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: state());
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
    var screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width,
      height: screen.height,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
          height: screen.height * 0.3,
          width: screen.height * 0.3,
          child: Image.asset(
            'assets/images/echobag.png',
            fit: BoxFit.fill,
          ),
        ),
        Container(
          width: screen.width,
          padding:
              EdgeInsets.fromLTRB(screen.width * 0.1, 0, screen.width * 0.1, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fing Echobag',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(height:10),
              Text(
                'KRW 15,000',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Divider(
                thickness: 1,
              ),
                            SizedBox(height:10),
              Text(
                'Fing에서만 볼 수 있는 \n친환경적인 에코백',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: screen.width,
          padding:
              EdgeInsets.fromLTRB(screen.width * 0.1, 0, screen.width * 0.1, 0),
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
          ),
        ),
        Container(
          width: screen.width,
          padding:
              EdgeInsets.fromLTRB(screen.width * 0.1, 0, screen.width * 0.1, 0),
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
          width: screen.width,
          padding:
              EdgeInsets.fromLTRB(screen.width * 0.1, 0, screen.width * 0.1, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   style: ElevatedButton.styleFrom(
              //       minimumSize: Size(140, 50),
              //       primary: Color.fromRGBO(192, 192, 192, 1),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10.5),
              //       )),
              //   child: Text(
              //     "뒤로가기",
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
              ElevatedButton(
                onPressed: () {
                  print('hi');
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(screen.width*0.8, screen.height*0.08),
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
          ),
        ),
      ]),
    );
  }
}