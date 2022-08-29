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
        title: Text(
          '공지사항',
          style: TextStyle(
              fontSize: 18.0, 
              fontWeight: FontWeight.bold, 
              color: Colors.black,
              letterSpacing:1.0,
              ),
        ),
        centerTitle:true,
        elevation:1.0,
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
      color:Colors.white,
      width:double.infinity,
      height:double.infinity,
      margin:EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ListView.builder(
        itemCount: Noticeitem.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> NoticeDetail(data:Noticeitem[index])));
            },
            child:Container(
              color:Colors.white,
              width:double.infinity,
              margin:EdgeInsets.fromLTRB(10, 10, 0, 10),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Container(
                        //   width:double.infinity,
                        //   height:50,
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         child:Container(
                        //           child:Text(("[공지사항] "+Noticeitem[index].title))),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          width:300,
                          child:Text(("[공지사항] "+Noticeitem[index].title),
                          overflow:TextOverflow.ellipsis)
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:5),
                          child: Text(Noticeitem[index].writer,style:TextStyle(color:Colors.grey,fontSize: 13)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:5),
                          child: Text(Noticeitem[index].day,style:TextStyle(color:Colors.grey,fontSize: 13)),
                        ),
                      ]
                    ),
                  ),
                  IconButton(
                    onPressed: null, 
                    icon: Icon(Icons.navigate_next,color:Colors.grey[800]),
                    )
                ],
              )
            )
          );
        },
      ),
    );
  }
}

// class _NoticeItemState extends State<NoticeItem> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap:(){
//         // Navigator.push(context, MaterialPageRoute(builder: (context)=> FaqDetail(data:faqlist[index])));
//       },
//       child: Container(
//         margin:EdgeInsets.fromLTRB(10, 5, 0, 15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               color: Colors.white,
//               child: Stack(
//                 children: [
//                   Column(
//                     children: [
//                       Container(
//                           height: 60,
//                           width: double.infinity,
//                           // color: Colors.white,
//                           decoration: BoxDecoration(
//                             border: Border(bottom: BorderSide(
//                               width: 0.3,
//                               color: Colors.black
//                             )),
//                           ),
//                           margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(widget.item.title.toString(),
//                                 style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                               ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
//                                 alignment: Alignment.bottomLeft,
//                                 child: Column(
//                                   children: [
//                                     Text(widget.item.writer, style: TextStyle(fontSize: 10))
//                                   ],
//                                 ),
//                                 ),
//                               Container(
//                                 margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
//                                 alignment: Alignment.bottomLeft,
//                                 child: Column(
//                                   children: [
//                                     Text(widget.item.day, style: TextStyle(
//                                       fontSize: 10
//                                     ),)
//                                   ],
//                                 ),
//                               )
                              
//                             ],
//                           )
                        
//                       ),
//                     ],
//                   ),
//                 ]
//               )
//             ),
          
//           ]
//         )
//       ));
//     }
// }


class NoticeModel {
  const NoticeModel(this.title, this.day, this.writer,this.desc);
  final String title;
  final String day;
  final String writer;
  final String desc;
}

const Noticeitem = [
  NoticeModel(
      "긴급점검 (23일 18:00 ~ 21:00)", "2022-08-23", "작성자 : Fing-관리자","안녕하세요 Fing입니다.\n\n더욱 안정적인 서비스 제공을 위한 긴급점검이 있겠습니다.\n\n서비스 이용에 불편을 드려 죄송합니다.\n"),
  NoticeModel(
      "정기점검 안내 (8/29 18:00 ~ 21:00)", "2022-08-29", "작성자 : Fing-관리자","안녕하세요 Fing입니다.\n\n더욱 안정적인 서비스 제공을 위한 정기점검이 있겠습니다.\n\n서비스 이용에 불편을 드려 죄송합니다.\n"),
  NoticeModel(
      "정기dddddddddddddddddddddddddd점검 안내 (8/29 18:00 ~ 21:00)", "2022-08-29", "작성자 : Fing-관리자","안녕하세요 Fing입니다.\n\n더욱 안정적인 서비스 제공을 위한 정기점검이 있겠습니다.\n\n서비스 이용에 불편을 드려 죄송합니다.\n"),
  NoticeModel(
      "정기점검 안내 (8/29 18:00 ~ 21:00)", "2022-08-29", "작성자 : Fing-관리자","안녕하세요 Fing입니다.\n\n더욱 안정적인 서비스 제공을 위한 정기점검이 있겠습니다.\n\n서비스 이용에 불편을 드려 죄송합니다.\n"),
  NoticeModel(
      "정기점검 안내 (8/29 18:00 ~ 21:00)", "2022-08-29", "작성자 : Fing-관리자","안녕하세요 Fing입니다.\n\n더욱 안정적인 서비스 제공을 위한 정기점검이 있겠습니다.\n\n서비스 이용에 불편을 드려 죄송합니다.\n"),
  NoticeModel(
      "정기점검 안내 (8/29 18:00 ~ 21:00)", "2022-08-29", "작성자 : Fing-관리자","안녕하세요 Fing입니다.\n\n더욱 안정적인 서비스 제공을 위한 정기점검이 있겠습니다.\n\n서비스 이용에 불편을 드려 죄송합니다.\n"),
  NoticeModel(
      "정기점검 안내 (8/29 18:00 ~ 21:00)", "2022-08-29", "작성자 : Fing-관리자","안녕하세요 Fing입니다.\n\n더욱 안정적인 서비스 제공을 위한 정기점검이 있겠습니다.\n\n서비스 이용에 불편을 드려 죄송합니다.\n"),
  NoticeModel(
      "정기점검 안내 (8/29 18:00 ~ 21:00)", "2022-08-29", "작성자 : Fing-관리자","안녕하세요 Fing입니다.\n\n더욱 안정적인 서비스 제공을 위한 정기점검이 있겠습니다.\n\n서비스 이용에 불편을 드려 죄송합니다.\n"),
  NoticeModel(
      "정기점검 안내 (8/29 18:00 ~ 21:00)", "2022-08-29", "작성자 : Fing-관리자","안녕하세요 Fing입니다.\n\n더욱 안정적인 서비스 제공을 위한 정기점검이 있겠습니다.\n\n서비스 이용에 불편을 드려 죄송합니다.\n"),
  NoticeModel(
      "정기점검 안내 (8/29 18:00 ~ 21:00)", "2022-08-29", "작성자 : Fing-관리자","안녕하세요 Fing입니다.\n\n더욱 안정적인 서비스 제공을 위한 정기점검이 있겠습니다.\n\n서비스 이용에 불편을 드려 죄송합니다.\n"),
  NoticeModel(
      "정기점검 안내 (8/29 18:00 ~ 21:00)", "2022-08-29", "작성자 : Fing-관리자","안녕하세요 Fing입니다.\n\n더욱 안정적인 서비스 제공을 위한 정기점검이 있겠습니다.\n\n서비스 이용에 불편을 드려 죄송합니다.\n"),
  NoticeModel(
      "정기점검 안내 (8/29 18:00 ~ 21:00)", "2022-08-29", "작성자 : Fing-관리자","안녕하세요 Fing입니다.\n\n더욱 안정적인 서비스 제공을 위한 정기점검이 있겠습니다.\n\n서비스 이용에 불편을 드려 죄송합니다.\n"),
  NoticeModel(
      "정기점검 안내 (8/29 18:00 ~ 21:00)", "2022-08-29", "작성자 : Fing-관리자","안녕하세요 Fing입니다.\n\n더욱 안정적인 서비스 제공을 위한 정기점검이 있겠습니다.\n\n서비스 이용에 불편을 드려 죄송합니다.\n"),
  NoticeModel(
      "정기점검 안내 (8/29 18:00 ~ 21:00)", "2022-08-29", "작성자 : Fing-관리자","안녕하세요 Fing입니다.\n\n더욱 안정적인 서비스 제공을 위한 정기점검이 있겠습니다.\n\n서비스 이용에 불편을 드려 죄송합니다.\n"),
  NoticeModel(
      "정기점검 안내 (8/29 18:00 ~ 21:00)", "2022-08-29", "작성자 : Fing-관리자","안녕하세요 Fing입니다.\n\n더욱 안정적인 서비스 제공을 위한 정기점검이 있겠습니다.\n\n서비스 이용에 불편을 드려 죄송합니다.\n"),
  NoticeModel(
      "정기점검 안내 (8/29 18:00 ~ 21:00)", "2022-08-29", "작성자 : Fing-관리자","안녕하세요 Fing입니다.\n\n더욱 안정적인 서비스 제공을 위한 정기점검이 있겠습니다.\n\n서비스 이용에 불편을 드려 죄송합니다.\n"),

];