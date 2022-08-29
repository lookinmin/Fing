// 전통시장표준데이터

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
      home: const TraditionalMarketWidget(),
    );
  }
}

// api 호출
Future<List<TraditionalMarket>> fetchTraditionalMarket() async {

  String Url = "http://api.data.go.kr/openapi/tn_pubr_public_trdit_mrkt_api";
  String queryParams = "?serviceKey=mNbd2x4ks2HlhJCaa9VeqYslDUC%2Bdnzj4IOybVIFeSRU5tZtINpW3B2FMpDs8Mc0%2FMxp24VxxqWpuveYOmV%2FDA%3D%3D";
  queryParams = "$queryParams&type=json";

  print('api 호출$Url$queryParams');

  final response = await http.get(
      Uri.parse(Url+queryParams)
  );

  if(response.statusCode == 200){
    Map<String,dynamic> fes = jsonDecode(response.body);
    var modelObject = TraditionalMarket.fromJson(fes);
    String totalNum = modelObject.response!.body!.totalCount!.toString();

    queryParams = "$queryParams&numOfRows=$totalNum";
    queryParams = "$queryParams&pageNo=1";
   
    print('총개수만큼 api 호출\n$Url$queryParams');
   
    final res = await http.get(Uri.parse(Url+queryParams));
    
    if (res.statusCode == 200){
      print('api 호출 성공');
      return (jsonDecode("[${utf8.decode(res.bodyBytes)}]") as List<dynamic>)
        .map((e) => TraditionalMarket.fromJson(e))
        .toList();
    }else{
      throw Exception("Failed to load data");
    }
  } else {
    throw Exception('Failed to load data');
  }
}

// widget example
class TraditionalMarketWidget extends StatefulWidget {
  const TraditionalMarketWidget({Key? key}) : super(key: key);

  @override
  State<TraditionalMarketWidget> createState() => _TraditionalMarketWidgetState();
}

class _TraditionalMarketWidgetState extends State<TraditionalMarketWidget> {
  late Future<List<TraditionalMarket>> futureTranditionalMarket;

  @override
  void initState(){
    super.initState();
    futureTranditionalMarket = fetchTraditionalMarket();
  }
  
  Widget build(BuildContext context) {
    return FutureBuilder<List<TraditionalMarket>>(
      future:futureTranditionalMarket,
      builder:(context,snapshot){
        if(snapshot.hasData){
          print('hasData');

          // traditional_market_model[index].변수명 
          List<Items> traditional_market_model = snapshot.data![0].response!.body!.items!;
          print(traditional_market_model.length);

          return Container(
            color:Colors.white,
            child:ListView.builder(
            itemCount:traditional_market_model.length,
            itemBuilder:(BuildContext context, index)=>Card(
              margin:const EdgeInsets.all(10),
              child:ListTile(
                contentPadding:const EdgeInsets.all(10),
                title:Text(traditional_market_model[index].mrktNm.toString()),
                subtitle:Text(traditional_market_model[index].mrktType.toString()),
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
class TraditionalMarket {
  Response? response;

  TraditionalMarket({this.response});

  TraditionalMarket.fromJson(Map<String, dynamic> json) {
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
  String? mrktNm;
  String? mrktType;
  String? rdnmadr;
  String? lnmadr;
  String? mrktEstblCycle;
  String? latitude;
  String? longitude;
  String? storNumber;
  String? trtmntPrdlst;
  String? useGcct;
  String? homepageUrl;
  String? pblicToiletYn;
  String? prkplceYn;
  String? estblYear;
  String? phoneNumber;
  String? referenceDate;
  String? insttCode;

  Items(
      {this.mrktNm,
      this.mrktType,
      this.rdnmadr,
      this.lnmadr,
      this.mrktEstblCycle,
      this.latitude,
      this.longitude,
      this.storNumber,
      this.trtmntPrdlst,
      this.useGcct,
      this.homepageUrl,
      this.pblicToiletYn,
      this.prkplceYn,
      this.estblYear,
      this.phoneNumber,
      this.referenceDate,
      this.insttCode});

  Items.fromJson(Map<String, dynamic> json) {
    mrktNm = json['mrktNm'];
    mrktType = json['mrktType'];
    rdnmadr = json['rdnmadr'];
    lnmadr = json['lnmadr'];
    mrktEstblCycle = json['mrktEstblCycle'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    storNumber = json['storNumber'];
    trtmntPrdlst = json['trtmntPrdlst'];
    useGcct = json['useGcct'];
    homepageUrl = json['homepageUrl'];
    pblicToiletYn = json['pblicToiletYn'];
    prkplceYn = json['prkplceYn'];
    estblYear = json['estblYear'];
    phoneNumber = json['phoneNumber'];
    referenceDate = json['referenceDate'];
    insttCode = json['insttCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mrktNm'] = this.mrktNm;
    data['mrktType'] = this.mrktType;
    data['rdnmadr'] = this.rdnmadr;
    data['lnmadr'] = this.lnmadr;
    data['mrktEstblCycle'] = this.mrktEstblCycle;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['storNumber'] = this.storNumber;
    data['trtmntPrdlst'] = this.trtmntPrdlst;
    data['useGcct'] = this.useGcct;
    data['homepageUrl'] = this.homepageUrl;
    data['pblicToiletYn'] = this.pblicToiletYn;
    data['prkplceYn'] = this.prkplceYn;
    data['estblYear'] = this.estblYear;
    data['phoneNumber'] = this.phoneNumber;
    data['referenceDate'] = this.referenceDate;
    data['insttCode'] = this.insttCode;
    return data;
  }
}
