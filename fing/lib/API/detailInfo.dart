// 반복정보조회

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
      home: const DetailInfoWidget(),
    );
  }
}

// api 호출
Future<List<DetailInfo>> fetchDetailInfo(
    {required String contentId}) async {
  String Url = "https://apis.data.go.kr/B551011/KorService/detailInfo";
  String queryParams =
      "?serviceKey=mNbd2x4ks2HlhJCaa9VeqYslDUC%2Bdnzj4IOybVIFeSRU5tZtINpW3B2FMpDs8Mc0%2FMxp24VxxqWpuveYOmV%2FDA%3D%3D";
  queryParams += "&_type=json&MobileOS=ETC&MobileApp=Fing";
  queryParams +=
      "&contentTypeId=15&contentId=$contentId";

  print('api 호출$Url$queryParams');

  final response = await http.get(Uri.parse(Url + queryParams));

  if (response.statusCode == 200) {
    Map<String, dynamic> fes = jsonDecode(response.body);

    var modelObject = DetailInfo.fromJson(fes);
    String totalNum = modelObject.response!.body!.totalCount!.toString();
    print(totalNum);

    if (totalNum == "0") {
      print('tatalnum=0');
      return ([
        {'response': null}
      ] as List<dynamic>)
          .map((e) => DetailInfo.fromJson(e))
          .toList();
    } else {
      queryParams = "$queryParams&numOfRows=$totalNum";
      queryParams = "$queryParams&pageNo=1";

      print('총개수만큼 api 호출\n$Url$queryParams');

      final res = await http.get(Uri.parse(Url + queryParams));

      if (res.statusCode == 200) {
        print('api 호출 성공');
        return (jsonDecode("[${utf8.decode(res.bodyBytes)}]") as List<dynamic>)
            .map((e) => DetailInfo.fromJson(e))
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
class DetailInfoWidget extends StatefulWidget {
  const DetailInfoWidget({Key? key}) : super(key: key);

  @override
  State<DetailInfoWidget> createState() => _DetailInfoWidgetState();
}

class _DetailInfoWidgetState extends State<DetailInfoWidget> {
  late Future<List<DetailInfo>> futureDetailInfo;

  @override
  void initState() {
    super.initState();
    // 여기 적혀 있는 변수들 다 넣어야됨
    futureDetailInfo = fetchDetailInfo(
        contentId: "506545"
        );
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<DetailInfo>>(
        future: futureDetailInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('hasData');
            if ((snapshot.data![0].response) == null) {
              return Center(child: Text('이거눈 데이터가 없어용 앙앙'));
            } else {
              List<Item> detailInfo_model =
                  snapshot.data![0].response!.body!.items!.item!;
              print(detailInfo_model.length);

              return Container(
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: detailInfo_model.length,
                      itemBuilder: (BuildContext context, index) => Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            title: Text(
                                detailInfo_model[index].infoname.toString()),
                            subtitle: Text(
                                detailInfo_model[index].infotext.toString()),
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

class DetailInfo {
  Response? response;

  DetailInfo({this.response});

  DetailInfo.fromJson(Map<String, dynamic> json) {
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
  String? serialnum;
  String? infoname;
  String? infotext;
  String? fldgubun;

  Item(
      {this.contentid,
      this.contenttypeid,
      this.serialnum,
      this.infoname,
      this.infotext,
      this.fldgubun});

  Item.fromJson(Map<String, dynamic> json) {
    contentid = json['contentid'];
    contenttypeid = json['contenttypeid'];
    serialnum = json['serialnum'];
    infoname = json['infoname'];
    infotext = json['infotext'];
    fldgubun = json['fldgubun'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentid'] = this.contentid;
    data['contenttypeid'] = this.contenttypeid;
    data['serialnum'] = this.serialnum;
    data['infoname'] = this.infoname;
    data['infotext'] = this.infotext;
    data['fldgubun'] = this.fldgubun;
    return data;
  }
}
