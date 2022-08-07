import 'package:flutter/material.dart';
import 'package:fing/mypage/recent.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) => MyPage(),
        '/recent':(context) => recent()
      },
    );
  }
}

class MyPage extends StatefulWidget {

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.book,
            color: Colors.orange,
            size: 25.0,
          ),
          title: const Text(
            '닉네임',
            style: TextStyle(
              fontSize: 20.0,
              letterSpacing: 1.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          elevation: 1.0,
          toolbarHeight: 100.0,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: ListView(
            padding: EdgeInsets.all(8),
            children: <Widget>[
              Column(
                children: [
                  ListTile(
                    title: Text(
                      '나의 Fing',
                      style: TextStyle(fontWeight: FontWeight.bold, ),
                    ),
                    tileColor: Colors.grey[300],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  ListTile(
                    leading: Icon(Icons.watch),
                    title: Text('최근 본 페스티벌'),
                    trailing: Icon(Icons.add),
                    onTap: () {
                      Navigator.pushNamed(context, '/recent');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.light),
                    title: Text('찜한 페스티벌'),
                    onTap: () {},
                    trailing: Icon(Icons.add),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('다녀온 페스티벌'),
                    onTap: () {},
                    trailing: Icon(Icons.add),
                  ),
                  Divider(
                height: 60.0,
                color: Colors.grey[500],
                thickness: 0.5,
                endIndent: 15.0,
              ),
                ],
              ),


              Column(
                children: [
                  ListTile(
                    title: Text(
                      '고객 센터',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.question_mark),
                    title: Text('질문하기'),
                    trailing: Icon(Icons.add),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.message),
                    title: Text('1:1 카카오문의'),
                    onTap: () {},
                    trailing: Icon(Icons.add),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('상담원 연결'),
                    onTap: () {},
                    trailing: Icon(Icons.add),
                  ),
                  Divider(
                height: 60.0,
                color: Colors.grey[500],
                thickness: 0.5,
                endIndent: 15.0,
              ),
                ],
              ),

              ListTile(
                leading: Icon(Icons.home),
                title: Text('설정'),
                onTap: () {},
                trailing: Icon(Icons.add),
              ),
            ],
          ),
        ));
  }
}