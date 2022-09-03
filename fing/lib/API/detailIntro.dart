// 소개정보조회

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
      home: const DetailIntroWidget(),
    );
  }
}

// api 호출
Future<List<DetailIntro>> fetchDetailIntro(
    {required String contentId}) async {
  String Url = "https://apis.data.go.kr/B551011/KorService/detailIntro";
  String queryParams =
      "?serviceKey=mNbd2x4ks2HlhJCaa9VeqYslDUC%2Bdnzj4IOybVIFeSRU5tZtINpW3B2FMpDs8Mc0%2FMxp24VxxqWpuveYOmV%2FDA%3D%3D";
  queryParams += "&_type=json&MobileOS=ETC&MobileApp=Fing";
  queryParams +=
      "&contentTypeId=15&contentId=$contentId";

  print('api 호출$Url$queryParams');

  final response = await http.get(Uri.parse(Url + queryParams));

  if (response.statusCode == 200) {
    Map<String, dynamic> fes = jsonDecode(response.body);

    var modelObject = DetailIntro.fromJson(fes);
    String totalNum = modelObject.response!.body!.totalCount!.toString();
    print(totalNum);

    if (totalNum == "0") {
      print('tatalnum=0');
      return ([
        {'response': null}
      ] as List<dynamic>)
          .map((e) => DetailIntro.fromJson(e))
          .toList();
    } else {
      queryParams = "$queryParams&numOfRows=$totalNum";
      queryParams = "$queryParams&pageNo=1";

      print('총개수만큼 api 호출\n$Url$queryParams');

      final res = await http.get(Uri.parse(Url + queryParams));

      if (res.statusCode == 200) {
        print('api 호출 성공');
        return (jsonDecode("[${utf8.decode(res.bodyBytes)}]") as List<dynamic>)
            .map((e) => DetailIntro.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to load data");
      }
    }
  } else {
    throw Exception('Failed to load data');
  }
}

// widget example
class DetailIntroWidget extends StatefulWidget {
  const DetailIntroWidget({Key? key}) : super(key: key);

  @override
  State<DetailIntroWidget> createState() => _DetailIntroWidgetState();
}

class _DetailIntroWidgetState extends State<DetailIntroWidget> {
  late Future<List<DetailIntro>> futureDetailIntro;

  @override
  void initState() {
    super.initState();
    // 여기 적혀 있는 변수들 다 넣어야됨
    futureDetailIntro = fetchDetailIntro(
        contentId: "506545"
        );
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<DetailIntro>>(
        future: futureDetailIntro,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('hasData');
            if ((snapshot.data![0].response) == null) {
              return Center(child: Text('이거눈 데이터가 없어용 앙앙'));
            } else {
              List<Item> detailIntro_model =
                  snapshot.data![0].response!.body!.items!.item!;
              print(detailIntro_model.length);

              return Container(
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: detailIntro_model.length,
                      itemBuilder: (BuildContext context, index) => Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            title: Text(
                                detailIntro_model[index].eventstartdate.toString()),
                            subtitle: Text(
                                detailIntro_model[index].eventenddate.toString()),
                          ))));
            }
          } else if (snapshot.hasError) {
            print('error');
            print(snapshot.error);
            return Text('error${snapshot.error}');
          }
          return Center(child: CupertinoActivityIndicator());
        });
  }
}

class DetailIntro {
  Response? response;

  DetailIntro({this.response});

  DetailIntro.fromJson(Map<String, dynamic> json) {
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
        items = json['items'].toString().length != 0
        ? new Items.fromJson(json['items'])
        : null;
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
  String? contentid;
  String? contenttypeid;
  String? sponsor1;
  String? sponsor1tel;
  String? sponsor2;
  String? sponsor2tel;
  String? eventenddate;
  String? playtime;
  String? eventplace;
  String? eventhomepage;
  String? agelimit;
  String? bookingplace;
  String? placeinfo;
  String? subevent;
  String? program;
  String? eventstartdate;
  String? usetimefestival;
  String? discountinfofestival;
  String? spendtimefestival;
  String? festivalgrade;

  Item(
      {this.contentid,
      this.contenttypeid,
      this.sponsor1,
      this.sponsor1tel,
      this.sponsor2,
      this.sponsor2tel,
      this.eventenddate,
      this.playtime,
      this.eventplace,
      this.eventhomepage,
      this.agelimit,
      this.bookingplace,
      this.placeinfo,
      this.subevent,
      this.program,
      this.eventstartdate,
      this.usetimefestival,
      this.discountinfofestival,
      this.spendtimefestival,
      this.festivalgrade});

  Item.fromJson(Map<String, dynamic> json) {
    contentid = json['contentid'];
    contenttypeid = json['contenttypeid'];
    sponsor1 = json['sponsor1'];
    sponsor1tel = json['sponsor1tel'];
    sponsor2 = json['sponsor2'];
    sponsor2tel = json['sponsor2tel'];
    eventenddate = json['eventenddate'];
    playtime = json['playtime'];
    eventplace = json['eventplace'];
    eventhomepage = json['eventhomepage'];
    agelimit = json['agelimit'];
    bookingplace = json['bookingplace'];
    placeinfo = json['placeinfo'];
    subevent = json['subevent'];
    program = json['program'];
    eventstartdate = json['eventstartdate'];
    usetimefestival = json['usetimefestival'];
    discountinfofestival = json['discountinfofestival'];
    spendtimefestival = json['spendtimefestival'];
    festivalgrade = json['festivalgrade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentid'] = this.contentid;
    data['contenttypeid'] = this.contenttypeid;
    data['sponsor1'] = this.sponsor1;
    data['sponsor1tel'] = this.sponsor1tel;
    data['sponsor2'] = this.sponsor2;
    data['sponsor2tel'] = this.sponsor2tel;
    data['eventenddate'] = this.eventenddate;
    data['playtime'] = this.playtime;
    data['eventplace'] = this.eventplace;
    data['eventhomepage'] = this.eventhomepage;
    data['agelimit'] = this.agelimit;
    data['bookingplace'] = this.bookingplace;
    data['placeinfo'] = this.placeinfo;
    data['subevent'] = this.subevent;
    data['program'] = this.program;
    data['eventstartdate'] = this.eventstartdate;
    data['usetimefestival'] = this.usetimefestival;
    data['discountinfofestival'] = this.discountinfofestival;
    data['spendtimefestival'] = this.spendtimefestival;
    data['festivalgrade'] = this.festivalgrade;
    return data;
  }
}
