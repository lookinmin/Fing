import 'package:flutter/material.dart';
import 'FAQ.dart';

class FaqDetail extends StatelessWidget {
  const FaqDetail({Key? key, required FAQModel this.data}) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "자주 묻는 질문",
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
              margin:EdgeInsets.only(bottom:5),
              child:Text("["+data.category+"]",style:TextStyle(color:Colors.grey,fontSize: 13)),
            ),
            // 제목
            Container(
              margin:EdgeInsets.only(bottom:5),
              child:Text(data.title,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
            ),
            Divider(thickness: 1),
            // 내용
            Container(
              margin:EdgeInsets.all(10),
              child:Text(data.desc,style:TextStyle(color:Colors.grey[600])),
            ),
          ],
        ),
      ),
    );
  }
}