import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'goods_tumbler.dart';
import 'goods_echobag.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FING",
      routes: {
        '/goods_tumbler': (BuildContext context) => goods_tumbler(),
        '/goods_echobag': (BuildContext context) => goods_echobag()
      },
    );
  }
}

class ProductModel {
  const ProductModel(this.imageUrl, this.title, this.desc1, this.router1);
  final String imageUrl;
  final String title;
  final String desc1;
  final Widget router1;
}

const productList = [
  ProductModel(
      "images/echobag.png", "Fing Echobag", "KRW 15,000", goods_echobag()),
  ProductModel(
      "images/tumbler.png", "Fing Tumbler", "KRW 8,000", goods_tumbler()),
];

class GoodsPage extends StatelessWidget {
  const GoodsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [Container(child: GoodsTop()), Expanded(child: GoodsMenu())],
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

class GoodsMenu extends StatelessWidget {
  const GoodsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: productList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black))),
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      height: 200,
                      padding: EdgeInsets.fromLTRB(10, 10, 5, 0),
                      child: Row(
                        children: [
                          Image.asset(
                            productList[index].imageUrl,
                            width: 150,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
                                    child: Text(
                                      productList[index].title,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5, 20, 0, 30),
                                    child: Text(
                                      productList[index].desc1,
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(50, 20, 0, 0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          RaisedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  //화면전환
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          productList[index]
                                                              .router1));
                                            },

                                            color:
                                                Color.fromRGBO(255, 126, 0, 1),
                                            child: Text(
                                              "구매하기",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            // 테두리 모서리
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.5),
                                            ),
                                          )
                                        ]),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
