import 'package:flutter/material.dart';
import 'notice.dart';

class NoticeDetail extends StatelessWidget {
  const NoticeDetail({Key? key, required NoticeModel this.data})
      : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "공지사항",
          style: TextStyle(
            fontSize: 18.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1.0,
        toolbarHeight: 50.0,
        // actions: [
        //   IconButton(
        //       onPressed: null, // 나중에 홈으로 연결시키기
        //       icon: Icon(Icons.home, color: Colors.black))
        // ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 카테고리
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                "[공지사항]",
                style: TextStyle(color: Colors.grey, fontSize: 13),
                overflow: TextOverflow.clip,
                maxLines: 1,
                softWrap: false,
              ),
            ),
            // 제목
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                data.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                overflow: TextOverflow.clip,
                maxLines: 2,
                
              ),
            ),
            // 날짜, 작성자
            Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data.writer,
                        style: TextStyle(color: Colors.grey, fontSize: 13)),
                    Text(data.day,
                        style: TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                )),
            Divider(thickness: 1),
            // 내용
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.all(10),
                child: Text(
                  data.desc,
                  style: TextStyle(color: Colors.grey[600]),
  
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
