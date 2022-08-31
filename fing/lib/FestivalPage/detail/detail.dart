import 'package:flutter/material.dart';
import 'package:fing/FestivalPage/detail/detail_list.dart';
import 'package:fing/FestivalPage/festivalist.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List _posts = [
    "맛집 1", "맛집 2", "맛집 3", "맛집 4", "맛집 5", "맛집 6", "맛집 7", "맛집 8",
    "맛집 ", //카카오 api보고 변경
  ];
  @override
  Widget build(BuildContext context) {
    final setwidth = MediaQuery.of(context).size.width * 0.03;
    final bwidth = MediaQuery.of(context).size.width * 0.1;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FestivalList())),

          //   ),
          title: Expanded(
            child: Row(
              children: const [
                Icon(Icons.place_outlined),
                Text(
                  '현재 위치 : ',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  softWrap: false,
                ),
                Text(
                  '경기도 광명시 역세권 휴먼시아 4단지 ', //주소 받아와 변경
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  softWrap: false,
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0.3,
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              pinned: true,
              elevation: 0.0,
              expandedHeight: 300.0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.redAccent,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  '[서울 잠실] 싸이 흠뻑쇼', //축제 이름마다 변경
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                titlePadding: EdgeInsetsDirectional.only(
                  start: 32,
                  bottom: 16,
                ),
                background: Image(
                    image: AssetImage('images/festival_2.png')), //축제 사진맘다 변경
              ),
            ),
            SliverToBoxAdapter(
                child: Container(
              constraints: BoxConstraints(
                maxHeight: double.infinity,
              ),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(setwidth, 20, setwidth, 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            '[서울 잠실] 싸이 흠뻑쇼 "SUMMER SWAG 2022"', // 축제 이름마다 변경
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '2022 싸이 흠뻑쇼', // 축제 설명
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      )),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 0.7,
                    indent: setwidth,
                    endIndent: setwidth,
                  ),
                ],
              ),
            )),
            SliverToBoxAdapter(
                child: Container(
              constraints: BoxConstraints(
                maxHeight: double.infinity,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(setwidth, 30, setwidth, 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            '소개',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 23.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: setwidth,
                              ),
                              Icon(
                                Icons.calendar_month,
                                size: 15.0,
                                color: const Color(0xffff7e00),
                              ),
                              SizedBox(
                                width: setwidth,
                              ),
                              Text(
                                '축제기간',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              SizedBox(
                                width: bwidth,
                              ),
                              Text(
                                '2022.05.11~2022.05.15',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: setwidth,
                              ),
                              Icon(
                                Icons.calendar_view_day,
                                size: 15.0,
                                color: Colors.redAccent,
                              ),
                              SizedBox(
                                width: setwidth,
                              ),
                              Text(
                                '휴무일',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.13,
                              ),
                              Text(
                                '매주 뭘요일',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: setwidth,
                              ),
                              Icon(
                                Icons.timelapse,
                                size: 15.0,
                                color: const Color(0xffff7e00),
                              ),
                              SizedBox(
                                width: setwidth,
                              ),
                              Text(
                                '축제시간',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              SizedBox(
                                width: bwidth,
                              ),
                              Text(
                                '09:00 ~ 19:00',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: setwidth,
                              ),
                              Icon(
                                Icons.place_outlined,
                                size: 15.0,
                                color: const Color(0xffff7e00),
                              ),
                              SizedBox(
                                width: setwidth,
                              ),
                              Text(
                                '장소',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.17,
                              ),
                              Text(
                                '서울 잠실종합운동장 보조경기장',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                softWrap: false,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      )),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 0.7,
                    indent: setwidth,
                    endIndent: setwidth,
                  ),
                ],
              ),
            )),
            SliverToBoxAdapter(
                child: Container(
              constraints: BoxConstraints(
                maxHeight: double.infinity,
              ),
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _posts = [
                                "숙소 1",
                                "숙소 2",
                                "숙소 3",
                                "숙소 4",
                                "숙소 5",
                                "숙소 6",
                                "숙소 7",
                                "숙소 8",
                                "숙소 ",
                              ]; //변경 예정
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.home_outlined,
                                size: 20,
                                color: const Color(0xffff7e00),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '숙소',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _posts = [
                                "맛집 1",
                                "맛집 2",
                                "맛집 3",
                                "맛집 4",
                                "맛집 5",
                                "맛집 6",
                                "맛집 7",
                                "맛집 8",
                                "맛집 ",
                              ]; //변경 예정
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.table_bar_outlined,
                                size: 20,
                                color: const Color(0xffff7e00),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '맛집',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _posts = [
                                "전통시장 1",
                                "전통시장 2",
                                "전통시장 3",
                                "전통시장 4",
                                "전통시장 5",
                                "전통시장 6",
                                "전통시장 7",
                                "전통시장 8",
                                "전통시장 ",
                              ];
                            }); //변경 예정
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.local_grocery_store_outlined,
                                size: 20,
                                color: const Color(0xffff7e00),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '전통시장',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                        itemCount: _posts.length,
                        itemBuilder: ((context, index) {
                          return MyList(child: _posts[index]);
                        })),
                  )
                ],
              ),
            )),

            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (BuildContext context, int index) {
            //       return MyList(
            //         child: _posts[index],
            //       );
            //     },
            //     childCount: _posts.length,
            //   ),
            // ),
          ],
        ));
  }
}
