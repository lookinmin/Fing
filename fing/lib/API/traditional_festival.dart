// 전통문화축제표준데이터

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
      home: const TraditionalFestivalWidget(),
    );
  }
}

// api 호출
Future<List<TraditionalFestival>> fetchTraditionalFestival() async {

  String Url = "http://api.data.go.kr/openapi/tn_pubr_public_cltur_fstvl_api";
  String queryParams = "?serviceKey=mNbd2x4ks2HlhJCaa9VeqYslDUC%2Bdnzj4IOybVIFeSRU5tZtINpW3B2FMpDs8Mc0%2FMxp24VxxqWpuveYOmV%2FDA%3D%3D";
  queryParams = "$queryParams&type=json";

  print('api 호출$Url$queryParams');

  final response = await http.get(
      Uri.parse(Url+queryParams)
  );

  if(response.statusCode == 200){
    Map<String,dynamic> fes = jsonDecode(response.body);
    var modelObject = TraditionalFestival.fromJson(fes);
    String totalNum = modelObject.response!.body!.totalCount!.toString();

    queryParams = "$queryParams&numOfRows=$totalNum";
    queryParams = "$queryParams&pageNo=1";
   
    print('총개수만큼 api 호출\n$Url$queryParams');
   
    final res = await http.get(Uri.parse(Url+queryParams));
    
    if (res.statusCode == 200){
      print('api 호출 성공');
      return (jsonDecode("[${utf8.decode(res.bodyBytes)}]") as List<dynamic>)
        .map((e) => TraditionalFestival.fromJson(e))
        .toList();
    }else{
      throw Exception("Failed to load data");
    }
  } else {
    throw Exception('Failed to load data');
  }
}

// widget example
class TraditionalFestivalWidget extends StatefulWidget {
  const TraditionalFestivalWidget({Key? key}) : super(key: key);

  @override
  State<TraditionalFestivalWidget> createState() => _TraditionalFestivalWidgetState();
}

class _TraditionalFestivalWidgetState extends State<TraditionalFestivalWidget> {
  late Future<List<TraditionalFestival>> futureTraditionalFestival;

  @override
  void initState(){
    super.initState();
    futureTraditionalFestival = fetchTraditionalFestival();
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<TraditionalFestival>>(
      future:futureTraditionalFestival,
      builder:(context,snapshot){
        if(snapshot.hasData){
          print('hasData');

          // tranditional_festival_model[index].변수명 으로 쓰면 됨
          List<Items> traditional_festival_model = snapshot.data![0].response!.body!.items!;
          print(traditional_festival_model.length);

          return Container(
            color:Colors.white,
            child:ListView.builder(
            itemCount:traditional_festival_model.length,
            itemBuilder:(BuildContext context, index)=>Card(
              margin:const EdgeInsets.all(10),
              child:ListTile(
                contentPadding:const EdgeInsets.all(10),
                title:Text(traditional_festival_model[index].fstvlNm.toString()),
                subtitle:Text(traditional_festival_model[index].fstvlStartDate.toString()),
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
class TraditionalFestival {
  Response? response;

  TraditionalFestival({this.response});

  TraditionalFestival.fromJson(Map<String, dynamic> json) {
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
  String? type;

  Header({this.resultCode, this.resultMsg, this.type});

  Header.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    resultMsg = json['resultMsg'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultCode'] = this.resultCode;
    data['resultMsg'] = this.resultMsg;
    data['type'] = this.type;
    return data;
  }
}

class Body {
  List<Items>? items;
  String? totalCount;
  String? numOfRows;
  String? pageNo;

  Body({this.items, this.totalCount, this.numOfRows, this.pageNo});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    numOfRows = json['numOfRows'];
    pageNo = json['pageNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    data['numOfRows'] = this.numOfRows;
    data['pageNo'] = this.pageNo;
    return data;
  }
}

class Items {
  String? fstvlNm;
  String? opar;
  String? fstvlStartDate;
  String? fstvlEndDate;
  String? fstvlCo;
  String? mnnst;
  String? auspcInstt;
  String? suprtInstt;
  String? phoneNumber;
  String? homepageUrl;
  String? relateInfo;
  String? rdnmadr;
  String? lnmadr;
  String? latitude;
  String? longitude;
  String? referenceDate;
  String? insttCode;

  Items(
      {this.fstvlNm,
      this.opar,
      this.fstvlStartDate,
      this.fstvlEndDate,
      this.fstvlCo,
      this.mnnst,
      this.auspcInstt,
      this.suprtInstt,
      this.phoneNumber,
      this.homepageUrl,
      this.relateInfo,
      this.rdnmadr,
      this.lnmadr,
      this.latitude,
      this.longitude,
      this.referenceDate,
      this.insttCode});

  Items.fromJson(Map<String, dynamic> json) {
    fstvlNm = json['fstvlNm'];
    opar = json['opar'];
    fstvlStartDate = json['fstvlStartDate'];
    fstvlEndDate = json['fstvlEndDate'];
    fstvlCo = json['fstvlCo'];
    mnnst = json['mnnst'];
    auspcInstt = json['auspcInstt'];
    suprtInstt = json['suprtInstt'];
    phoneNumber = json['phoneNumber'];
    homepageUrl = json['homepageUrl'];
    relateInfo = json['relateInfo'];
    rdnmadr = json['rdnmadr'];
    lnmadr = json['lnmadr'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    referenceDate = json['referenceDate'];
    insttCode = json['insttCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fstvlNm'] = this.fstvlNm;
    data['opar'] = this.opar;
    data['fstvlStartDate'] = this.fstvlStartDate;
    data['fstvlEndDate'] = this.fstvlEndDate;
    data['fstvlCo'] = this.fstvlCo;
    data['mnnst'] = this.mnnst;
    data['auspcInstt'] = this.auspcInstt;
    data['suprtInstt'] = this.suprtInstt;
    data['phoneNumber'] = this.phoneNumber;
    data['homepageUrl'] = this.homepageUrl;
    data['relateInfo'] = this.relateInfo;
    data['rdnmadr'] = this.rdnmadr;
    data['lnmadr'] = this.lnmadr;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['referenceDate'] = this.referenceDate;
    data['insttCode'] = this.insttCode;
    return data;
  }
}
