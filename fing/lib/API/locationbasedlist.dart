// 위치기반 관광정보조회

// import packages
import 'dart:convert'; //json으로 바꿔주기 위해 필요한 패키지
import 'dart:async';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http; // api 호출 위해 필요한 패키지

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LocationBasedListWidget(),
    );
  }
}

// api 호출
Future<List<LocationBasedList>> fetchLocationBasedList({required String arrange, required String contentTypeId, required String mapX, required String mapY,required String radius}) async {

  String Url = "https://apis.data.go.kr/B551011/KorService/locationBasedList";
  String queryParams = "?serviceKey=mNbd2x4ks2HlhJCaa9VeqYslDUC%2Bdnzj4IOybVIFeSRU5tZtINpW3B2FMpDs8Mc0%2FMxp24VxxqWpuveYOmV%2FDA%3D%3D";
  queryParams += "&_type=json&MobileOS=ETC&MobileApp=Fing";
  queryParams ="$queryParams&arrange=$arrange&contentTypeId=$contentTypeId&mapX=$mapX&mapY=$mapY&radius=$radius";

  print('api 호출$Url$queryParams');

  final response = await http.get(
      Uri.parse(Url+queryParams)
  );

  if(response.statusCode == 200){
    Map<String,dynamic> fes = jsonDecode(response.body);
    var modelObject = LocationBasedList.fromJson(fes);
    String totalNum = modelObject.response!.body!.totalCount!.toString();

    queryParams = "$queryParams&numOfRows=$totalNum";
    queryParams = "$queryParams&pageNo=1";
   
    print('총개수만큼 api 호출\n$Url$queryParams');
   
    final res = await http.get(Uri.parse(Url+queryParams));
    
    if (res.statusCode == 200){
      print('api 호출 성공');
      return (jsonDecode("[${utf8.decode(res.bodyBytes)}]") as List<dynamic>)
        .map((e) => LocationBasedList.fromJson(e))
        .toList();
    }else{
      throw Exception("Failed to load data");
    }
  } else {
    throw Exception('Failed to load data');
  }
}

// widget example
class LocationBasedListWidget extends StatefulWidget {
  const LocationBasedListWidget({Key? key}) : super(key: key);

  @override
  State<LocationBasedListWidget> createState() => _LocationBasedListWidgetState();
}

class _LocationBasedListWidgetState extends State<LocationBasedListWidget> {
  late Future<List<LocationBasedList>> futureLocationBasedList;
  
  @override
  void initState(){
    super.initState();
    // 여기 적혀 있는 변수들 다 넣어야됨
    futureLocationBasedList = fetchLocationBasedList(
      arrange:"A",
      contentTypeId:"12",
      mapX : "128.6922646449",
      mapY:"35.9910080699",
      radius:"10000");
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<LocationBasedList>>(
      future:futureLocationBasedList,
      builder:(context,snapshot){
        if(snapshot.hasData){
          print('hasData');

          // tranditional_festival_model[index].변수명 으로 쓰면 됨
          List<Item> locationbasedlist_model = snapshot.data![0].response!.body!.items!.item!;
          print(locationbasedlist_model.length);

          return Container(
            color:Colors.white,
            child:ListView.builder(
            itemCount:locationbasedlist_model.length,
            itemBuilder:(BuildContext context, index)=>Card(
              margin:const EdgeInsets.all(10),
              child:ListTile(
                contentPadding:const EdgeInsets.all(10),
                title:Text(locationbasedlist_model[index].title.toString()),
                subtitle:Text(locationbasedlist_model[index].addr1.toString()),
              )
            )
          ));
        }else if(snapshot.hasError){
          print('error');
          print(snapshot.error);
          return Text('error${snapshot.error}');
        }
        return Center(child: CupertinoActivityIndicator());
      }
      );
  }
}

// json to dart
class LocationBasedList {
  Response? response;

  LocationBasedList({this.response});

  LocationBasedList.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  Header? header;
  Body? body;

  Response({this.header, this.body});

  Response.fromJson(Map<String, dynamic> json) {
    header =
        json['header'] != null ? new Header.fromJson(json['header']) : null;
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header!.toJson();
    }
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    return data;
  }
}

class Header {
  String? resultCode;
  String? resultMsg;

  Header({this.resultCode, this.resultMsg});

  Header.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    resultMsg = json['resultMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultCode'] = this.resultCode;
    data['resultMsg'] = this.resultMsg;
    return data;
  }
}

class Body {
  Items? items;
  int? numOfRows;
  int? pageNo;
  int? totalCount;

  Body({this.items, this.numOfRows, this.pageNo, this.totalCount});

  Body.fromJson(Map<String, dynamic> json) {
    items = json['items'] != null ? new Items.fromJson(json['items']) : null;
    numOfRows = json['numOfRows'];
    pageNo = json['pageNo'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.toJson();
    }
    data['numOfRows'] = this.numOfRows;
    data['pageNo'] = this.pageNo;
    data['totalCount'] = this.totalCount;
    return data;
  }
}

class Items {
  List<Item>? item;

  Items({this.item});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['item'] != null) {
      item = <Item>[];
      json['item'].forEach((v) {
        item!.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.item != null) {
      data['item'] = this.item!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  String? addr1;
  String? addr2;
  String? areacode;
  String? booktour;
  String? cat1;
  String? cat2;
  String? cat3;
  String? contentid;
  String? contenttypeid;
  String? createdtime;
  String? dist;
  String? firstimage;
  String? firstimage2;
  String? mapx;
  String? mapy;
  String? mlevel;
  String? modifiedtime;
  int? readcount;
  String? sigungucode;
  String? tel;
  String? title;

  Item(
      {this.addr1,
      this.addr2,
      this.areacode,
      this.booktour,
      this.cat1,
      this.cat2,
      this.cat3,
      this.contentid,
      this.contenttypeid,
      this.createdtime,
      this.dist,
      this.firstimage,
      this.firstimage2,
      this.mapx,
      this.mapy,
      this.mlevel,
      this.modifiedtime,
      this.readcount,
      this.sigungucode,
      this.tel,
      this.title});

  Item.fromJson(Map<String, dynamic> json) {
    addr1 = json['addr1'];
    addr2 = json['addr2'];
    areacode = json['areacode'];
    booktour = json['booktour'];
    cat1 = json['cat1'];
    cat2 = json['cat2'];
    cat3 = json['cat3'];
    contentid = json['contentid'];
    contenttypeid = json['contenttypeid'];
    createdtime = json['createdtime'];
    dist = json['dist'];
    firstimage = json['firstimage'];
    firstimage2 = json['firstimage2'];
    mapx = json['mapx'];
    mapy = json['mapy'];
    mlevel = json['mlevel'];
    modifiedtime = json['modifiedtime'];
    readcount = json['readcount'];
    sigungucode = json['sigungucode'];
    tel = json['tel'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addr1'] = this.addr1;
    data['addr2'] = this.addr2;
    data['areacode'] = this.areacode;
    data['booktour'] = this.booktour;
    data['cat1'] = this.cat1;
    data['cat2'] = this.cat2;
    data['cat3'] = this.cat3;
    data['contentid'] = this.contentid;
    data['contenttypeid'] = this.contenttypeid;
    data['createdtime'] = this.createdtime;
    data['dist'] = this.dist;
    data['firstimage'] = this.firstimage;
    data['firstimage2'] = this.firstimage2;
    data['mapx'] = this.mapx;
    data['mapy'] = this.mapy;
    data['mlevel'] = this.mlevel;
    data['modifiedtime'] = this.modifiedtime;
    data['readcount'] = this.readcount;
    data['sigungucode'] = this.sigungucode;
    data['tel'] = this.tel;
    data['title'] = this.title;
    return data;
  }
}
