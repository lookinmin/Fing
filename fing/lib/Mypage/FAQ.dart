import 'package:flutter/material.dart';
import 'FAQ_detail.dart';

void main() {
  runApp(const FaqPage());
}

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
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
      body: Column(
        children: [
          Container(child:Category()),
          Expanded(child: Faqlist()),
        ],
      ),
    );
  }
}


class Faqlist extends StatelessWidget {
  const Faqlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.white,
      width:double.infinity,
      height:double.infinity,
      margin:EdgeInsets.fromLTRB(10, 0, 10, 0),
      child:ListView.builder(
        itemCount:faqlist.length,
        itemBuilder:(BuildContext context, int index){
          return InkWell(
            onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> FaqDetail(data:faqlist[index])));
              // Navigator.of(context,rootNavigator:true).push(
              //   MaterialPageRoute(builder:(context)=>FaqDetail(data:faqlist[index])),
              // );
            },
            child:Container(
              color:Colors.white,
              width:double.infinity,
              margin:EdgeInsets.fromLTRB(10, 5, 0, 15),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Container(child:Text("["+faqlist[index].category+"]"+" "+faqlist[index].title),
                  )),
                  IconButton(
                    onPressed: null, 
                    icon: Icon(Icons.navigate_next,color:Colors.grey[800]),
                    )
                ],
              )
            )
          );
        }
      )
    );
  }
}

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categorylist.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: TextButton(
              onPressed: () {
                print(categorylist[index]);
              },
              child: Text(
                categorylist[index],
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

const categorylist = ["전체", "가입 및 로그인", "검색", "마이페이지", "장소상세", "즐겨찾기", "초기화면"];

class FAQModel{
  const FAQModel(this.category,this.title,this.desc);
  
  final category;
  final title;
  final desc;
}

const faqlist=[
  FAQModel("가입 및 로그인", "다음아이디로 로그인은 불가능한가요?","Fing은 카카오로그인을 기본으로 하며, 다른 아이디 로그인은 제공하고 있지 않습니다."),
  FAQModel("가입 및 로그인", "카카오 로그인은 왜 필요한가요?","카카오 로그인을 기본으로 제공하고 있고, 이를 통해 어플리케이션의 모든 데이터가 계정 정보에 저장되기 때문에 카카오 로그인은 꼭 필요합니다."),
  FAQModel("마이페이지", "내가 좋아요 한 페스티벌은 어디서 확인할 수 있나요?","마이페이지의 찜한 페스티벌 메뉴에서 확인할 수 있습니다."),
  FAQModel("마이페이지", "프로필 편집은 불가능한가요?","본 서비스는 카카오 로그인을 기반으로 계정 정보가 저장되기 때문에 아이디 변경, 비밀번호 변경 등 다른 프로필 변경은 불가능합니다."),
  FAQModel("즐겨찾기", "좋아요 한 페스티벌은 어디서 확인할 수 있나요?","마이페이지의 찜한 페스티벌 메뉴에서 확인할 수 있습니다."),
  FAQModel("즐겨찾기", "즐겨찾기는 몇 개 까지 저장할 수 있나요?", "즐겨찾기는 총 10,000개 까지 저장 가능합니다."),
 
  FAQModel("즐겨찾기", "즐겨찾기는 몇 개 까지 저장할 수 있나요?", "즐겨찾기는 총 10,000개 까지 저장 가능합니다."),
  FAQModel("가입 및 로그인", "다음아이디로 로그인은 불가능한가요?","Fing은 카카오로그인을 기본으로 하며, 다른 아이디 로그인은 제공하고 있지 않습니다."),
  FAQModel("가입 및 로그인", "카카오 로그인은 왜 필요한가요?","카카오 로그인을 기본으로 제공하고 있고, 이를 통해 어플리케이션의 모든 데이터가 계정 정보에 저장되기 때문에 카카오 로그인은 꼭 필요합니다."),
  FAQModel("마이페이지", "내가 좋아요 한 페스티벌은 어디서 확인할 수 있나요?","마이페이지의 찜한 페스티벌 메뉴에서 확인할 수 있습니다."),
  FAQModel("마이페이지", "프로필 편집은 불가능한가요?","본 서비스는 카카오 로그인을 기반으로 계정 정보가 저장되기 때문에 아이디 변경, 비밀번호 변경 등 다른 프로필 변경은 불가능합니다."),
  FAQModel("즐겨찾기", "좋아요 한 페스티벌은 어디서 확인할 수 있나요?","마이페이지의 찜한 페스티벌 메뉴에서 확인할 수 있습니다."),
  FAQModel("즐겨찾기", "즐겨찾기는 몇 개 까지 저장할 수 있나요?", "즐겨찾기는 총 10,000개 까지 저장 가능합니다."),
  FAQModel("즐겨찾기", "즐겨찾기는 몇 개 까지 저장할 수 있나요?", "즐겨찾기는 총 10,000개 까지 저장 가능합니다."),
  FAQModel("즐겨찾기", "즐겨찾기는 몇 개 까지 저장할 수 있나요?", "즐겨찾기는 총 10,000개 까지 저장 가능합니다."),
  FAQModel("가입 및 로그인", "다음아이디로 로그인은 불가능한가요?","Fing은 카카오로그인을 기본으로 하며, 다른 아이디 로그인은 제공하고 있지 않습니다."),
  FAQModel("가입 및 로그인", "카카오 로그인은 왜 필요한가요?","카카오 로그인을 기본으로 제공하고 있고, 이를 통해 어플리케이션의 모든 데이터가 계정 정보에 저장되기 때문에 카카오 로그인은 꼭 필요합니다."),
  FAQModel("마이페이지", "내가 좋아요 한 페스티벌은 어디서 확인할 수 있나요?","마이페이지의 찜한 페스티벌 메뉴에서 확인할 수 있습니다."),
  FAQModel("마이페이지", "프로필 편집은 불가능한가요?","본 서비스는 카카오 로그인을 기반으로 계정 정보가 저장되기 때문에 아이디 변경, 비밀번호 변경 등 다른 프로필 변경은 불가능합니다."),
  FAQModel("즐겨찾기", "좋아요 한 페스티벌은 어디서 확인할 수 있나요?","마이페이지의 찜한 페스티벌 메뉴에서 확인할 수 있습니다."),
  FAQModel("즐겨찾기", "즐겨찾기는 몇 개 까지 저장할 수 있나요?", "즐겨찾기는 총 10,000개 까지 저장 가능합니다."),
  FAQModel("즐겨찾기", "즐겨찾기는 몇 개 까지 저장할 수 있나요?", "즐겨찾기는 총 10,000개 까지 저장 가능합니다."),

];
