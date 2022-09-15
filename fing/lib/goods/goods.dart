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
        '/': (context) => GoodsPage(),
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
  ProductModel("assets/images/echobag.png", "Fing Echobag", "KRW 15,000",
      goods_echobag()),
  ProductModel("assets/images/tumbler.png", "Fing Tumbler", "KRW 8,000",
      goods_tumbler()),
];

class GoodsPage extends StatelessWidget {
  const GoodsPage({Key? key}) : super(key: key);

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
      body: GoodsMenu(),
    );
  }
}

class GoodsMenu extends StatelessWidget {
  const GoodsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var mobileWidth = 500;
    var desktopWidth = 850;
    bool isWeb = true;
    bool isDesktop = true;
    size.width > mobileWidth ? isWeb = true : isWeb = false;
    size.width > desktopWidth ? isDesktop = true : isDesktop = false;
    return SizedBox(
      width: size.width,
      child: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: size.width,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: isWeb ? size.width * 0.25 : size.width * 0.5,
                        constraints:
                            BoxConstraints(maxHeight: size.height * 0.3),
                        padding: EdgeInsets.all(5),
                        child: Image.asset(
                          productList[index].imageUrl,
                        ),
                      ),
                      Container(
                        // constraints:
                        //     BoxConstraints(maxHeight: size.height * 0.3),
                        width: isWeb ? size.width * 0.25 : size.width * 0.5,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                productList[index].title,
                                style: TextStyle(
                                    fontSize: isDesktop? 18 : 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                productList[index].desc1,
                                style: TextStyle(
                                  fontSize:isDesktop? 18 : 16,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          //화면전환
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  productList[index]
                                                      .router1));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color.fromRGBO(255, 126, 0, 1),
                                      // 테두리 모서리
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.5),
                                      ),
                                    ),
                                    child: Text(
                                      "구매하기",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: isWeb ? 17 : 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
