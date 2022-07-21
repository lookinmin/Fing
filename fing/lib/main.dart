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
        child: BottomMenu(),
      ),
    ); // TODO: implement build
  }
}

class BottomMenu extends StatelessWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(children: [Icon(Icons.home), Text('홈')]),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(children: [Icon(Icons.map_outlined), Text('지도')]),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(children: [Icon(Icons.assignment), Text('게시판')]),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(children: [Icon(Icons.person), Text('내 정보')]))
        ],
      ),
    );
    ;
  }
}

class AddressSearch extends StatelessWidget {
  const AddressSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 20),
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
          Text(
            '검색할 주소를 입력하세요',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),
          ),
          Icon(
            Icons.search,
            color: Color.fromRGBO(248, 180, 0, 1.0),
          )
        ],
      ),
    );
  }
}
