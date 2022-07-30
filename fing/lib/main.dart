import 'package:flutter/material.dart';
import 'Map/map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FING",
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(flex: 2, child: FestivalSearch()),
          Expanded(flex: 8, child: AddressMap())
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomMenu(),
      ),
    ); // TODO: implement build
  }
}

class BottomMenu extends StatefulWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  State<BottomMenu> createState() => _BottomMenu();
}

class _BottomMenu extends State<BottomMenu> {
  var orange = Color.fromARGB(255, 255, 126, 0);
  var black = Color.fromARGB(255, 0, 0, 0);
  List<bool> isClick = [true, true, true, true, true];
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: SizedBox(
        height: 60,
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     Column(children: [
        //       IconButton(
        //           onPressed: () {
        //             setState(() {
        //               isClick[1] = true;
        //               isClick[2] = true;
        //               isClick[3] = true;
        //               isClick[4] = true;
        //               isClick[0] = !isClick[0];
        //             });
        //           },
        //           icon: Icon(Icons.home_outlined),
        //           color: isClick[0] ? black : orange),
        //       Text('  홈  ',
        //           style: TextStyle(
        //               color: isClick[0] ? black : orange,
        //               fontSize: 11,
        //               fontWeight: FontWeight.w700))
        //     ]),
        //     Column(children: [
        //       IconButton(
        //           onPressed: () {
        //             setState(() {
        //               isClick[0] = true;
        //               isClick[2] = true;
        //               isClick[3] = true;
        //               isClick[4] = true;
        //               isClick[1] = !isClick[1];
        //             });
        //           },
        //           icon: Icon(Icons.place_outlined),
        //           color: isClick[1] ? black : orange),
        //       Text(' 지역 ',
        //           style: TextStyle(
        //               color: isClick[1] ? black : orange,
        //               fontSize: 11,
        //               fontWeight: FontWeight.w700))
        //     ]),
        //     Column(children: [
        //       IconButton(
        //           onPressed: () {
        //             setState(() {
        //               isClick[1] = true;
        //               isClick[0] = true;
        //               isClick[3] = true;
        //               isClick[4] = true;
        //               isClick[2] = !isClick[2];
        //             });
        //           },
        //           icon: Icon(Icons.map_outlined),
        //           color: isClick[2] ? black : orange),
        //       Text(' 내주변 ',
        //           style: TextStyle(
        //               color: isClick[2] ? black : orange,
        //               fontSize: 11,
        //               fontWeight: FontWeight.w700))
        //     ]),
        //     Column(children: [
        //       IconButton(
        //           onPressed: () {
        //             setState(() {
        //               isClick[1] = true;
        //               isClick[2] = true;
        //               isClick[0] = true;
        //               isClick[4] = true;
        //               isClick[3] = !isClick[3];
        //             });
        //           },
        //           icon: Icon(Icons.favorite_outline),
        //           color: isClick[3] ? black : orange),
        //       Text(
        //         '  찜  ',
        //         style: TextStyle(
        //             color: isClick[3] ? black : orange,
        //             fontSize: 11,
        //             fontWeight: FontWeight.w700),
        //       )
        //     ]),
        //     Column(children: [
        //       IconButton(
        //           onPressed: () {
        //             setState(() {
        //               isClick[1] = true;
        //               isClick[2] = true;
        //               isClick[3] = true;
        //               isClick[0] = true;
        //               isClick[4] = !isClick[4];
        //             });
        //           },
        //           icon: Icon(Icons.person_outline),
        //           color: isClick[4] ? black : orange),
        //       Text(
        //         '마이페이지',
        //         style: TextStyle(
        //             color: isClick[4] ? black : orange,
        //             fontSize: 11,
        //             fontWeight: FontWeight.w700),
        //       )
        //     ]),
        //   ],
        // ),
      ),
    );
  }
}

class FestivalSearch extends StatelessWidget {
  const FestivalSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey,
        width: 2.0,
      ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: Icon(Icons.abc)), //여기에 로고 들어감
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: Offset(0, 7), // changes position of shadow
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search Festival',
                      ),
                    ),
                  ),
                  Flexible(
                      child: Icon(
                    Icons.search,
                    color: Color.fromRGBO(255, 126, 0, 1.0),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Widget logo() {
//   return Image.asset(
//     'images/mark.jpg',
//   );
// }
