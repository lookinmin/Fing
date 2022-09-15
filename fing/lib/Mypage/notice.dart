import 'package:fing/Mypage/mypage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './notice_detail.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticeState();
}

class _NoticeState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyPage()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          '공지사항',
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
      body: NoticeList(),
    );
  }
}

class NoticeList extends StatelessWidget {
  const NoticeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: double.infinity),
      color: Colors.white,
      height: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ListView.builder(
        itemCount: Noticeitem.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NoticeDetail(data: Noticeitem[index])));
              },
              child: Container(
                  color: Colors.white,
                  constraints: BoxConstraints(maxWidth: double.infinity),
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: double.infinity),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    child: Text(
                                  ("[공지사항] " + Noticeitem[index].title),
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  softWrap: false,
                                )),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(Noticeitem[index].writer,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    Noticeitem[index].day,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      IconButton(
                        onPressed: null,
                        icon:
                            Icon(Icons.navigate_next, color: Colors.grey[800]),
                      )
                    ],
                  )));
        },
      ),
    );
  }
}

class NoticeModel {
  const NoticeModel(this.title, this.day, this.writer, this.desc);
  final String title;
  final String day;
  final String writer;
  final String desc;
}

const Noticeitem = [
  NoticeModel("정식출시 안내 (9/15 13:00)", "2022-09-03", "작성자 : Fing-관리자", '''
안녕하세요 Fing입니다.
9월 15일부터 Fing(Festival-ing)의 정식 서비스가 개시되었습니다.
많은 관심 부탁드리며 이용 시 에로사항은 'www.festival-ing.com'의 
1:1문의로 문의주시면 감사하겠습니다.
      '''),
  NoticeModel(
      "긴급점검 안내 (9/05 18:00 ~ 23:00)", "2022-09-03", "작성자 : Fing-관리자", '''
안녕하세요 Fing입니다.
치명적인 기술적 결함이 발견되어 9월 5일 18:00시 부터 23:00시까지 긴급정검이 있겠습니다.
서비스 이용에 불편을 드려 심심한 사과의 말씀드리며 더욱 발전하는 fing이 되겠습니다.
      '''),
  NoticeModel("정기점검 안내 (9/01 06:00 ~ 11:00)", "2022-08-30", "작성자 : Fing-관리자",
      "안녕하세요 Fing입니다.\n더욱 안정적인 서비스 제공을 위하여 9월 1일 06:00시 부터 11:00시까지 정기점검이 있겠습니다.\n서비스 이용에 불편을 드려 죄송합니다.\n"),
  NoticeModel("정기점검 안내 (8/25 06:00 ~ 11:00)", "2022-08-23", "작성자 : Fing-관리자",
      "안녕하세요 Fing입니다.\n더욱 안정적인 서비스 제공을 위한 8월 25일 06:00시 부터 11:00시까지 정기점검이 있겠습니다.\n서비스 이용에 불편을 드려 죄송합니다.\n"),
];
