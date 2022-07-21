import 'package:flutter/material.dart';

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
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddressSearch(),
      bottomNavigationBar: BottomAppBar(
        child: MyWidget(),
      ),
    ); // TODO: implement build
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var orange = Color.fromARGB(255, 255, 126, 0);
  var black = Color.fromARGB(255, 0, 0, 0);
  List<bool> isClick = [true, true, true, true, true];
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isClick[0] = !isClick[0];
                  });
                },
                icon: Icon(Icons.home_outlined),
                color: isClick[0] ? black : orange),
            Text('  홈  ', style: TextStyle(color: isClick[0] ? black : orange))
          ]),
          Column(children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isClick[1] = !isClick[1];
                  });
                },
                icon: Icon(Icons.place_outlined),
                color: isClick[1] ? black : orange),
            Text(' 지역 ', style: TextStyle(color: isClick[1] ? black : orange))
          ]),
          Column(children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isClick[2] = !isClick[2];
                  });
                },
                icon: Icon(Icons.map_outlined),
                color: isClick[2] ? black : orange),
            Text(' 내주변 ', style: TextStyle(color: isClick[2] ? black : orange))
          ]),
          Column(children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isClick[3] = !isClick[3];
                  });
                },
                icon: Icon(Icons.favorite_outline),
                color: isClick[3] ? black : orange),
            Text(
              '  찜  ',
              style: TextStyle(color: isClick[3] ? black : orange),
            )
          ]),
          Column(children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isClick[4] = !isClick[4];
                  });
                },
                icon: Icon(Icons.person_outline),
                color: isClick[4] ? black : orange),
            Text(
              '마이페이지',
              style: TextStyle(color: isClick[4] ? black : orange),
            )
          ]),
        ],
      ),
    );
  }
}

// class BottomMenu extends StatelessWidget {
//   const BottomMenu({Key? key}) : super(key: key);
//   var orange = const Color.fromARGB(
//     255,
//     255,
//     126,
//     0,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 70,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Column(
//             children: [
//               IconButton(onPressed: () {}, icon: Icon(Icons.home_outlined)),
//               Text('  홈  ')
//             ],
//           ),
//           Column(children: [
//             IconButton(onPressed: () {}, icon: Icon(Icons.place_outlined)),
//             Text(' 지역 ')
//           ]),
//           Column(children: [
//             IconButton(onPressed: () {}, icon: Icon(Icons.map_outlined)),
//             Text(' 내주변 ')
//           ]),
//           Column(children: [
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.favorite_outline),
//               color: Color.fromARGB(
//                 255,
//                 255,
//                 126,
//                 0,
//               ),
//             ),
//             Text(
//               '  찜  ',
//               style: TextStyle(color: black),
//             )
//           ]),
//           Column(children: [
//             IconButton(onPressed: () {}, icon: Icon(Icons.person_outline)),
//             Text('마이페이지')
//           ]),
//         ],
//       ),
//     );
//   }
// }

class AddressSearch extends StatelessWidget {
  const AddressSearch({Key? key}) : super(key: key);

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
          Expanded(flex: 1, child: logo()),
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

Widget logo() {
  return Image.asset(
    'images/mark.jpg',
  );
}
