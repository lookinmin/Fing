import 'package:fing/Firebase/fing_db.dart';
import 'package:flutter/material.dart';

import 'package:fing/mypage/recent.dart';
import 'package:fing/Mypage/favorite.dart';
import 'package:fing/Mypage/notice.dart';
import 'package:fing/Mypage/FAQ.dart';
import 'package:fing/Mypage/personal.dart';
import 'package:fing/Mypage/service.dart';
import 'package:kakao_flutter_sdk_talk/kakao_flutter_sdk_talk.dart';

void main() => runApp(MyPageMain());

class MyPageMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MyPage(),
        '/recent': (context) => recent(),
        '/favorite': (context) => favorite(),
        '/notice': ((context) => NoticePage()),
        '/faq': (context) => FaqPage(),
        '/service': (context) => ServicePage(),
        '/persoanl': (context) => PersonalPage(),
      },
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
    // String nickname = fing_db_user[0].name;
    // String email = fing_db_user[0].email;

    //print('nickname'+nickname);

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
                        "asdf",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Asdf"),
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
                      Navigator.pushNamed(context, '/recent');
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
                      Navigator.pushNamed(context, '/favorite');
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
                                  change_alram(_isNotificationOn);  //알람뽑는거요
                                }
                                )
                                )
                                ),
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
                    onTap: () {
                      Navigator.pushNamed(context, '/notice');
                    },
                  ),
                  ListTile(
                    //dense: true,
                    minLeadingWidth: 0,
                    leading: Icon(Icons.help_outline_outlined, size: 17),
                    title: Text('FAQ'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.pushNamed(context, '/faq');
                    },
                  ),
                  ListTile(
                    //dense: true,
                    minLeadingWidth: 0,
                    leading: Icon(Icons.question_answer_outlined, size: 17),
                    title: Text('1:1 카카오 문의'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () async{
                        Uri url = await TalkApi.instance.addChannelUrl('_jMfVxj');

                        try {
                            Channels relations = await TalkApi.instance.channels();
                            print('채널 관계 확인 성공'
                                    '\n${relations.channels}');
                        } catch (error) {
                            print('채널 관계 확인 실패 $error');
                        }
                    },
                  ),
                  ListTile(
                    //dense: true,
                    minLeadingWidth: 0,
                    leading: Icon(Icons.call_outlined, size: 17),
                    title: Text('상담원 연결'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 130,
                              color: Color(0xFF737373),
                              child: Column(children: [
                                Container(
                                    height: 55,
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.fromLTRB(
                                                30, 0, 0, 0),
                                            child: Icon(Icons.phone,
                                                color: Colors.grey[700],
                                                size: 30)),
                                        Container(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: Text("통화 010-0000-0000",
                                                style: TextStyle(
                                                    color: Colors.blue[600],
                                                    fontSize: 18)))
                                      ],
                                    )),
                                InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    height: 55,
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Center(
                                        child: Text('취소',
                                            style: TextStyle(
                                                color: Colors.blue[600],
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600))),
                                  ),
                                ),
                              ]),
                            );
                          });
                    },
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
                    onTap: () {
                      Navigator.pushNamed(context, '/service');
                    },
                  ),
                  ListTile(
                    dense: true,
                    minLeadingWidth: 0,
                    leading: Icon(Icons.privacy_tip_outlined, size: 17),
                    title: Text('개인정보 처리방침'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.pushNamed(context, '/personal');
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }

     void change_alram(bool value){
    setState(() {
      if(value){
        showPopup1(context,value);
      }

      else{
        showPopup1(context,value);
      }
    });
  }
  void showPopup1(context,value){
    showDialog(
      context: context, 
      builder: (context){
        if(value){
          return Dialog(
          child: Container( 
            width: MediaQuery.of(context).size.width*0.8,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Padding(
                padding: EdgeInsets.all(5),
                child: Text('알람이 설정되었습니다!',style: TextStyle(fontSize: 14,color:Colors.black,fontWeight: FontWeight.bold),)
              ),
              
            ],),
            )
            );
        }
        else{
            return Dialog(
          child: Container( 
            width: MediaQuery.of(context).size.width*0.8,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Padding(
                padding: EdgeInsets.all(5),
                child: Text('알람이 해제되었습니다!',style: TextStyle(fontSize: 14,color:Colors.black,fontWeight: FontWeight.bold),)
              ),
              
            ],),
            )
            );
        }
        
            });

  }
}

                  // ListTile(
                  //   //dense: true,
                  //   minLeadingWidth: 0,
                  //   leading: Icon(Icons.call_outlined, size: 17),
                  //   title: Text('상담원 연결'),
                  //   trailing: Icon(Icons.chevron_right),
                  //   onTap: () {
                  //     showModalBottomSheet<void>(
                  //         context: context,
                  //         builder: (BuildContext context) {
                  //           return Container(
                  //             height: 130,
                  //             color: Color(0xFF737373),
                  //             child: Column(children: [
                  //               Container(
                  //                 height: 55,
                  //                 padding: EdgeInsets.zero,
                  //                 margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     borderRadius: BorderRadius.all(
                  //                         Radius.circular(15))),
                  //                 child:Row(
                  //                   children: [
                  //                     Container(
                  //                       padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  //                       child:Icon(Icons.phone,color:Colors.grey[700],size:30)
                  //                     ),
                  //                     Container(
                  //                       padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  //                       child:Text("통화 ",style:TextStyle(color:Colors.blue[600],fontSize: 18)))
                  //                   ],
                  //                 )
                  //               ),
                  //               InkWell(
                  //                 onTap: () =>Navigator.pop(context),
                  //                 child: Container(
                  //                   height: 55,
                  //                   padding: EdgeInsets.zero,
                  //                   margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  //                   decoration: BoxDecoration(
                  //                       color: Colors.white,
                  //                       borderRadius: BorderRadius.all(
                  //                           Radius.circular(15))),
                  //                     child:Center(child: Text('취소',style:TextStyle(color:Colors.blue[600],fontSize:19,fontWeight:FontWeight.w600))),
                  //                 ),
                  //               ),
                  //             ]),
                  //           );
                  //         });
                  //   },
                  // ),
                  // ListTile(
                  //   //dense: true,
                  //   minLeadingWidth: 0,
                  //   leading: Icon(Icons.help_outline_outlined, size: 17),
                  //   title: Text('FAQ'),
                  //   trailing: Icon(Icons.chevron_right),
                  //   onTap: () {
                  //     Navigator.pushNamed(context, '/faq');
                  //   },
                  // ),
