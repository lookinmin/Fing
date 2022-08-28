import 'package:flutter/material.dart';
import 'package:fing/mypage/recent.dart';

void main() => runApp(MyPageMain());

class MyPageMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => MyPage(), '/recent': (context) => recent()},
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  var _isNotificationOn = true;
  @override
  Widget build(BuildContext context) {    
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '마이페이지',
            style: TextStyle(
              fontSize: 18.0,
              letterSpacing: 1.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: false,
          automaticallyImplyLeading: false, //뒤로가기버튼없애기
          leading: null,
          backgroundColor: Colors.white,
          elevation: 1.0, // 그림자 제거
          toolbarHeight: 50.0,
        ),
        body: Container(
          padding: EdgeInsets.all(3),
          child: ListView(
            padding: EdgeInsets.fromLTRB(15, 20, 10, 15),
            children: [
              Column(
                children: [
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: Colors.white,
                            width: 2,
                          )),
                      tileColor: Color.fromRGBO(255, 126, 0, 1.0),
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      leading: Icon(Icons.account_circle, size: 40),
                      title: Text(
                        "페스티벌좋아요님",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("s2eung1@naver.com"),
                    ),
                  ),
                  ListTile(
                    //contentPadding: EdgeInsets.only(top:10),
                    title: Text(
                      'MY Fing',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    //dense: true,
                    minLeadingWidth: 0,
                    leading: Icon(Icons.youtube_searched_for, size: 17),
                    title: Text('최근 본 페스티벌'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> 어쩌구()));
                    },
                  ),
                  ListTile(
                    //dense: true,
                    minLeadingWidth: 0,
                    leading: Icon(Icons.favorite_border_outlined, size: 17),
                    title: Text('찜한 페스티벌'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> 어쩌구()));
                    },
                  ),                  
                  ListTile(
                    //dense: true,
                    minLeadingWidth: 0,
                    leading: Icon(Icons.notifications_outlined, size: 17),
                    title: Text('알림설정'),
                    trailing: Container(
                        child: Switch(
                            activeColor: Color.fromRGBO(255, 126, 0, 1.0),
                            value: _isNotificationOn,
                            onChanged: (bool value) => setState(() {
                                  _isNotificationOn = value;
                                }))),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> 어쩌구()));
                    },
                  ),
                  Divider(
                    height: 50,
                    color: Colors.grey[500],
                    thickness: 1,
                    endIndent: 12,
                  ),
                ],
              ),
              Column(
                children: [
                  ListTile(
                      title: Text(
                    '고객 센터',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  ListTile(
                    //dense: true,
                    minLeadingWidth: 0,
                    leading: Icon(Icons.campaign_outlined, size: 17),
                    title: Text('공지사항'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    //dense: true,
                    minLeadingWidth: 0,
                    leading: Icon(Icons.help_outline_outlined, size: 17),
                    title: Text('FAQ'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    //dense: true,
                    minLeadingWidth: 0,
                    leading: Icon(Icons.question_answer_outlined, size: 17),
                    title: Text('1:1 카카오 문의'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    //dense: true,
                    minLeadingWidth: 0,
                    leading: Icon(Icons.call_outlined, size: 17),
                    title: Text('상담원 연결'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  Divider(
                    height: 50,
                    color: Colors.grey[500],
                    thickness: 1,
                    endIndent: 15.0,
                  ),
                ],
              ),
              Column(
                children: [
                  ListTile(
                      title: Text(
                    '이용 안내',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  ListTile(
                    dense: true,
                    minLeadingWidth: 0,
                    leading: Icon(Icons.verified_user_outlined, size: 17),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('앱 버전'),
                        Text('v1.0 (최신버전)',
                            style: TextStyle(color: Colors.grey))
                      ],
                    ),
                  ),
                  ListTile(
                    dense: true,
                    minLeadingWidth: 0,
                    leading: Icon(Icons.policy_outlined, size: 17),
                    title: Text('서비스 이용약관'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    dense: true,
                    minLeadingWidth: 0,
                    leading: Icon(Icons.privacy_tip_outlined, size: 17),
                    title: Text('개인정보 처리방침'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
