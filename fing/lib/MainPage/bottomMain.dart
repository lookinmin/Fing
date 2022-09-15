import 'package:fing/goods/goods.dart';
import 'package:flutter/material.dart';
import 'package:fing/FestivalPage/festivallist_category.dart';

void main() => runApp(BottomMain());

class BottomMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: CategoryBtn(),
        ),
        // SizedBox(
        //   height: isWeb ? size.height * 0.2 : 0,
        // ),
        Flexible(
          flex: 1,
          child: GoodsButton(),
        ),
      ],
    );
  }
}

class CategoryBtn extends StatelessWidget {
  List type = <String>[
    '문화관광축제',
    '일반축제',
    '전통공연',
    '연극',
    '뮤지컬',
    '오페라',
    '전시회',
    '박람회',
    '컨벤션',
    '무용',
    '클래식 음악회',
    '콘서트',
    '영화',
    '스포츠',
    '기타',
    ""
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var mobileWidth = 500;
    bool isWeb = true;
    size.width > mobileWidth ? isWeb = true : isWeb = false;
    return Container(
      constraints: BoxConstraints(maxHeight: double.infinity),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      margin: EdgeInsets.fromLTRB(size.width * 0.05, 0, size.width * 0.05, 10),
      // decoration: BoxDecoration(
      //     // color: Color.fromARGB(255, 243, 243, 243),
      //     border: Border(
      //         top: BorderSide(color: Colors.grey, width: 1.0),
      //         bottom: BorderSide(
      //           color: Colors.grey,
      //           width: 1.0,
      //         ))),
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.02),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CatBtn(1, context, type[0]),
                    CatBtn(2, context, type[1]),
                    CatBtn(3, context, type[2]),
                    CatBtn(4, context, type[3])
                  ]),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CatBtn(5, context, type[4]),
                  CatBtn(6, context, type[5]),
                  CatBtn(7, context, type[6]),
                  CatBtn(8, context, type[7])
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CatBtn(9, context, type[8]),
                  CatBtn(10, context, type[9]),
                  CatBtn(11, context, type[10]),
                  CatBtn(12, context, type[11])
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CatBtn(13, context, type[12]),
                  CatBtn(14, context, type[13]),
                  CatBtn(15, context, type[14]),
                  CatBtn(16, context, type[15])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoodsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: OutlinedButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: false).push(
            MaterialPageRoute(
                builder: (context) => GoodsPage(),
                fullscreenDialog: true,
                maintainState: true),
          );
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

Widget CatBtn(int id, BuildContext context, type) {
  var size = MediaQuery.of(context).size;
  var phoneWidth = 500;
  var mobileWidth = 700;
  bool isWeb = true;
  bool isPhone = true;
  size.width > phoneWidth ? isPhone = true : isPhone = false;
  size.width > mobileWidth ? isWeb = true : isWeb = false;
  switch (id) {
    case 1:
      return Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) =>
                      FestivalPage(type: type, code: 'A02070100')));
            },
            child: Container(
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              width: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              height: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 246, 255),
                  borderRadius: BorderRadius.circular(100)),
              child: imgSet(1),
            ),
          ),
          Text(
            "문화관광축제",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: isWeb ? 15 : 11),
          )
        ],
      );
    case 2:
      return Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) =>
                      FestivalPage(type: type, code: 'A02070200')));
            },
            child: Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              width: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              height: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 246, 255),
                  borderRadius: BorderRadius.circular(100)),
              child: imgSet(2),
            ),
          ),
          Text(
            "일반축제",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: isWeb ? 15 : 11),
          )
        ],
      );
    case 3:
      return Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) =>
                      FestivalPage(type: type, code: 'A02080100')));
            },
            child: Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              width: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              height: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 246, 255),
                  borderRadius: BorderRadius.circular(100)),
              child: imgSet(3),
            ),
          ),
          Text(
            "전통공연",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: isWeb ? 15 : 11),
          )
        ],
      );
    case 4:
      return Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) =>
                      FestivalPage(type: type, code: 'A02080200')));
            },
            child: Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              width: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              height: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 246, 255),
                  borderRadius: BorderRadius.circular(100)),
              child: imgSet(4),
            ),
          ),
          Text(
            "연극",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: isWeb ? 15 : 11),
          )
        ],
      );
    case 5:
      return Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) =>
                      FestivalPage(type: type, code: 'A02080300')));
            },
            child: Container(
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              width: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              height: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 246, 255),
                  borderRadius: BorderRadius.circular(100)),
              child: imgSet(5),
            ),
          ),
          Text(
            "뮤지컬",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: isWeb ? 15 : 11),
          )
        ],
      );
    case 6:
      return Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) =>
                      FestivalPage(type: type, code: 'A02080400')));
            },
            child: Container(
              padding: EdgeInsets.all(7),
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              width: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              height: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 246, 255),
                  borderRadius: BorderRadius.circular(100)),
              child: imgSet(6),
            ),
          ),
          Text(
            "오페라",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: isWeb ? 15 : 11),
          )
        ],
      );
    case 7:
      return Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) =>
                      FestivalPage(type: type, code: 'A02080500')));
            },
            child: Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              width: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              height: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 246, 255),
                  borderRadius: BorderRadius.circular(100)),
              child: imgSet(7),
            ),
          ),
          Text(
            "전시회",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: isWeb ? 15 : 11),
          )
        ],
      );
    case 8:
      return Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) =>
                      FestivalPage(type: type, code: 'A02080600')));
            },
            child: Container(
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              width: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              height: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 246, 255),
                  borderRadius: BorderRadius.circular(100)),
              child: imgSet(8),
            ),
          ),
          Text(
            "박람회",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: isWeb ? 15 : 11),
          )
        ],
      );
    case 9:
      return Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) =>
                      FestivalPage(type: type, code: 'A02080700')));
            },
            child: Container(
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              width: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              height: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 246, 255),
                  borderRadius: BorderRadius.circular(100)),
              child: imgSet(9),
            ),
          ),
          Text(
            "컨벤션",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: isWeb ? 15 : 11),
          )
        ],
      );
    case 10:
      return Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) =>
                      FestivalPage(type: type, code: 'A02080800')));
            },
            child: Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              width: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              height: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 246, 255),
                  borderRadius: BorderRadius.circular(100)),
              child: imgSet(10),
            ),
          ),
          Text(
            "무용",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: isWeb ? 15 : 11),
          )
        ],
      );
    case 11:
      return Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) =>
                      FestivalPage(type: type, code: 'A02080900')));
            },
            child: Container(
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              width: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              height: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 246, 255),
                  borderRadius: BorderRadius.circular(100)),
              child: imgSet(11),
            ),
          ),
          Text(
            "클래식 음악회",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: isWeb ? 15 : 11),
          )
        ],
      );
    case 12:
      return Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => FestivalPage(
                        type: type,
                        code: 'A02081000',
                      )));
            },
            child: Container(
              padding: EdgeInsets.all(7),
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              width: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              height: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 246, 255),
                  borderRadius: BorderRadius.circular(100)),
              child: imgSet(12),
            ),
          ),
          Text(
            "콘서트",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: isWeb ? 15 : 11),
          )
        ],
      );
    case 13:
      return Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) =>
                      FestivalPage(type: type, code: 'A02081100')));
            },
            child: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              width: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              height: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 246, 255),
                  borderRadius: BorderRadius.circular(100)),
              child: imgSet(13),
            ),
          ),
          Text(
            "영화",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: isWeb ? 15 : 11),
          )
        ],
      );
    case 14:
      return Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => FestivalPage(
                        type: type,
                        code: 'A02081200',
                      )));
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              padding: EdgeInsets.all(5),
              width: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              height: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 246, 255),
                  borderRadius: BorderRadius.circular(100)),
              child: imgSet(14),
            ),
          ),
          Text(
            "스포츠",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: isWeb ? 15 : 11),
          )
        ],
      );
    case 15:
      return Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) =>
                      FestivalPage(type: type, code: 'A02081300')));
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              width: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              height: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 246, 255),
                  borderRadius: BorderRadius.circular(100)),
              child: imgSet(15),
            ),
          ),
          Text(
            "기타",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: isWeb ? 15 : 11),
          )
        ],
      );
    case 16:
      return Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
            width: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
            height: isWeb ? size.width * 0.05 : (isPhone?size.width*0.1 :size.width * 0.13),
          ),
        ],
      );
    default:
      return Image.asset('assets/images/mark.jpg');
  }
}

Widget imgSet(int id) {
  switch (id) {
    case 1:
      return Image.asset('assets/images/garland.png');
    case 2:
      return Image.asset('assets/images/fireworks.png');
    case 3:
      return Image.asset('assets/images/buk.png');
    case 4:
      return Image.asset('assets/images/ticket.png');
    case 5:
      return Image.asset('assets/images/music.png');
    case 6:
      return Image.asset('assets/images/opera.png');
    case 7:
      return Image.asset('assets/images/exhibition.png');
    case 8:
      return Image.asset('assets/images/flyer.png');
    case 9:
      return Image.asset('assets/images/handshake.png');
    case 10:
      return Image.asset('assets/images/ballet.png');
    case 11:
      return Image.asset('assets/images/piano.png');
    case 12:
      return Image.asset('assets/images/spotlight.png');
    case 13:
      return Image.asset('assets/images/movie.png');
    case 14:
      return Image.asset('assets/images/sports.png');
    case 15:
      return Icon(
        Icons.more_horiz,
        size: 40,
      );
    default:
      return Image.asset('assets/images/mark.jpg');
  }
}
