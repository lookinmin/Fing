import 'package:flutter/material.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(AddressMap());
}

const String kakaoMapKey = '096bea75f9d0374f3c939bff68e78cd3'; //자바스크립트 key

class District {
  String name;
  String num;
  District(this.name, this.num);
}

class AddressMap extends StatefulWidget {
  const AddressMap({Key? key}) : super(key: key);
  @override
  State<AddressMap> createState() => _AddressMapState();
}

class _AddressMapState extends State<AddressMap> {
  int cnt = 0;
  double initLng = 127.459223;
  double initLat = 36.6283933;

  List _items = [];
  List district = [];

  var gangwon;
  var gyeongi1;
  var gyeongi2;
  var gyungnam1;
  var gyungnam2;
  var gyungnam3;
  var gyungnam4;
  var gyungbuk1;
  var gyungbuk2;
  var kwangju;
  var daegu;
  var daejeon;
  var busan1;
  var busan2;
  var busan3;
  var seoul;
  var sejong;
  var ulsan;
  var incheon1;
  var incheon2;
  var incheon3;
  var incheon4;
  var jeonnam1;
  var jeonnam2;
  var jeonnam3;
  var jeonnam4;
  var jeonnam5;
  var jeonnam6;
  var jeonnam7;
  var jeonnam8;
  var jeonnam9;
  var jeonbuk;
  var jeju;
  var chungnam1;
  var chungnam2;
  var chungbuk;

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('json/district.json');
    final data = await json.decode(response);
    setState(() {
      // _items = data["features"];
      // coordsParse(_items);
      coordsParse(data["features"]);
    });
  }

  void coordsParse(List items) {
    for (int i = 0; i < items.length; i++) {
      district.add(District(items[i]["properties"]["CTP_KOR_NM"],
          items[i]["properties"]["CTPRVN_CD"]));
    }

    gangwon = items[0]["geometry"]["coordinates"][0];
    gyeongi1 = items[1]["geometry"]["coordinates"][0];
    gyeongi2 = items[1]["geometry"]["coordinates"][1];
    gyungnam1 = items[2]["geometry"]["coordinates"][2];
    gyungnam2 = items[2]["geometry"]["coordinates"][3];
    gyungnam3 = items[2]["geometry"]["coordinates"][5];
    gyungnam4 = items[2]["geometry"]["coordinates"][6];
    gyungbuk1 = items[3]["geometry"]["coordinates"][0];
    gyungbuk2 = items[3]["geometry"]["coordinates"][1];
    kwangju = items[4]["geometry"]["coordinates"][0];
    daegu = items[5]["geometry"]["coordinates"][0];
    daejeon = items[6]["geometry"]["coordinates"][0];
    busan1 = items[7]["geometry"]["coordinates"][0];
    busan2 = items[7]["geometry"]["coordinates"][1];
    busan3 = items[7]["geometry"]["coordinates"][2];
    seoul = items[8]["geometry"]["coordinates"][0];
    sejong = items[9]["geometry"]["coordinates"][0];
    ulsan = items[10]["geometry"]["coordinates"][0];
    incheon1 = items[11]["geometry"]["coordinates"][0];
    incheon2 = items[11]["geometry"]["coordinates"][1];
    incheon3 = items[11]["geometry"]["coordinates"][5];
    incheon4 = items[11]["geometry"]["coordinates"][7];
    jeonnam1 = items[12]["geometry"]["coordinates"][8];
    jeonnam2 = items[12]["geometry"]["coordinates"][16];
    jeonnam3 = items[12]["geometry"]["coordinates"][21];
    jeonnam4 = items[12]["geometry"]["coordinates"][23];
    jeonnam5 = items[12]["geometry"]["coordinates"][27];
    jeonnam6 = items[12]["geometry"]["coordinates"][31];
    jeonnam7 = items[12]["geometry"]["coordinates"][32];
    jeonnam8 = items[12]["geometry"]["coordinates"][34];
    jeonnam9 = items[12]["geometry"]["coordinates"][35];
    jeonbuk = items[13]["geometry"]["coordinates"][1];
    jeju = items[14]["geometry"]["coordinates"][0];
    chungnam1 = items[15]["geometry"]["coordinates"][0];
    chungnam2 = items[15]["geometry"]["coordinates"][1];
    chungbuk = items[16]["geometry"]["coordinates"][0];
  }

  @override
  Widget build(BuildContext context) {
    if (cnt == 0) {
      readJson();
      cnt++;
    }
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Flexible(flex: 2, fit: FlexFit.tight, child: NowAddressText()),
        gangwon.isEmpty
            ? Expanded(
                flex: 10,
                child: KakaoMapView(
                  width: size.width,
                  height: 400,
                  kakaoMapKey: kakaoMapKey,
                  lat: initLat,
                  lng: initLng,
                  showMapTypeControl: true,
                  showZoomControl: true,
                  draggableMarker: true,
                  zoomLevel: 13,
                ))
            : Expanded(
                flex: 10,
                child: KakaoMapView(
                  width: size.width,
                  height: 400,
                  kakaoMapKey: kakaoMapKey,
                  lat: initLat,
                  lng: initLng,
                  showMapTypeControl: true,
                  showZoomControl: true,
                  draggableMarker: true,
                  zoomLevel: 13,
                  onTapMarker: (message) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(message.message)));
                  },
                  customScript: seperateRegion,
                ))
      ],
    );
  }

//도 구별
  String get seperateRegion {
    return '''

                  var gangwonPath = [];
                  for (let i = 0, len = ${gangwon.length}; i < len; i++) {
                      gangwonPath.push(new kakao.maps.LatLng($gangwon[i][1], $gangwon[i][0]))
                  }
                  var gangwonPolygon = new kakao.maps.Polygon({
                      path: gangwonPath, 
                      strokeWeight: 3, 
                      strokeColor: '#006400', 
                      strokeOpacity: 0.8, 
                      strokeStyle: 'solid', 
                      fillColor: '#CDECFA', 
                      fillOpacity: 0.7 
                  });
                  gangwonPolygon.setMap(map);

                  kakao.maps.event.addListener(gangwonPolygon, 'click', function (mouseEvent) {
                      console.log(`${district[0].name}, ${district[0].num}`);
                  });     

                    var content = `<span style="background-color: #FF7E00; color: white; padding: 2px;font-size: .1rem">${district[0].name}</span>`;
                  var position = new kakao.maps.LatLng(37.8603672, 128.3115261);
                  var customOverlay = new kakao.maps.CustomOverlay({
                      position: position,
                      content: content
                  });
                  customOverlay.setMap(map);
                  //강원---------------------------------------------------------------------------------------

                  var gyeongiPath1 = [];
                  var gyeongiPath2 = [];
                  for (let i = 0, len = ${gyeongi1.length}; i < len; i++) {
                      gyeongiPath1.push(new kakao.maps.LatLng($gyeongi1[i][1], $gyeongi1[i][0]))
                  }
                  for (let i = 0, len = ${gyeongi2.length}; i < len; i++) {
                      gyeongiPath2.push(new kakao.maps.LatLng($gyeongi2[i][1], $gyeongi2[i][0]))
                  }
                  var gyeongiPolygon = new kakao.maps.Polygon({
                      path: [gyeongiPath1, gyeongiPath2], 
                      strokeWeight: 3, 
                      strokeColor: '#006400', 
                      strokeOpacity: 0.8, 
                      strokeStyle: 'solid', 
                      fillColor: '#CDECFA', 
                      fillOpacity: 0.7 
                  });
                  gyeongiPolygon.setMap(map);

                  kakao.maps.event.addListener(gyeongiPolygon, 'click', function (mouseEvent) {
                      console.log(`${district[1].name}, ${district[1].num}`);
                  });

                  var content = `<span style="background-color: #FF7E00; color: white; padding: 2px;font-size: .1rem">${district[1].name}</span>`;
                  var position = new kakao.maps.LatLng(37.4363177, 127.550802);
                  var customOverlay = new kakao.maps.CustomOverlay({
                      position: position,
                      content: content
                  });
                  customOverlay.setMap(map);
              //경기---------------------------------------------------------------------------------------
                  
                  var gyungnamPath1 = [];
                  var gyungnamPath2 = [];
                  var gyungnamPath3 = [];
                  var gyungnamPath4 = [];
                  for (let i = 0, len = ${gyungnam1.length}; i < len; i++) {
                      gyungnamPath1.push(new kakao.maps.LatLng($gyungnam1[i][1], $gyungnam1[i][0]))
                  }
                  for (let i = 0, len = ${gyungnam2.length}; i < len; i++) {
                      gyungnamPath2.push(new kakao.maps.LatLng($gyungnam2[i][1], $gyungnam2[i][0]))
                  }
                  for (let i = 0, len = ${gyungnam3.length}; i < len; i++) {
                      gyungnamPath3.push(new kakao.maps.LatLng($gyungnam3[i][1], $gyungnam3[i][0]))
                  }
                  for (let i = 0, len = ${gyungnam4.length}; i < len; i++) {
                      gyungnamPath4.push(new kakao.maps.LatLng($gyungnam4[i][1], $gyungnam4[i][0]))
                  }
                  var gyungnamPolygon = new kakao.maps.Polygon({
                      path: [gyungnamPath1, gyungnamPath2, gyungnamPath3, gyungnamPath4], 
                      strokeWeight: 3, 
                      strokeColor: '#006400', 
                      strokeOpacity: 0.8, 
                      strokeStyle: 'solid', 
                      fillColor: '#CDECFA', 
                      fillOpacity: 0.7 
                  });
                  gyungnamPolygon.setMap(map);

                  kakao.maps.event.addListener(gyungnamPolygon, 'click', function (mouseEvent) {
                      console.log(`${district[2].name}, ${district[2].num}`);
                  });
                  var content = `<span style="background-color: #FF7E00; color: white; padding: 2px;font-size: .1rem">${district[2].name}</span>`;
                  var position = new kakao.maps.LatLng(35.4414209, 128.2417453);
                  var customOverlay = new kakao.maps.CustomOverlay({
                      position: position,
                      content: content
                  });
                  customOverlay.setMap(map);
              //경남---------------------------------------------------------------------------------------

                  var gyungbukPath1 = [];
                  var gyungbukPath2 = [];
                  for (let i = 0, len = ${gyungbuk1.length}; i < len; i++) {
                      gyungbukPath1.push(new kakao.maps.LatLng($gyungbuk1[i][1], $gyungbuk1[i][0]))
                  }
                  for (let i = 0, len = ${gyungbuk2.length}; i < len; i++) {
                      gyungbukPath2.push(new kakao.maps.LatLng($gyungbuk2[i][1], $gyungbuk2[i][0]))
                  }
                  var gyungbukPolygon = new kakao.maps.Polygon({
                      path: [gyungbukPath1, gyungbukPath2], 
                      strokeWeight: 3, 
                      strokeColor: '#006400', 
                      strokeOpacity: 0.8, 
                      strokeStyle: 'solid', 
                      fillColor: '#CDECFA', 
                      fillOpacity: 0.7 
                  });
                  gyungbukPolygon.setMap(map);

                  kakao.maps.event.addListener(gyungbukPolygon, 'click', function (mouseEvent) {
                      console.log(`${district[3].name}, ${district[3].num}`);
                  });
                  var content = `<span style="background-color: #FF7E00; color: white; padding: 2px;font-size: .1rem">${district[3].name}</span>`;
                  var position = new kakao.maps.LatLng(36.6308397, 128.962578);
                  var customOverlay = new kakao.maps.CustomOverlay({
                      position: position,
                      content: content
                  });
                  customOverlay.setMap(map);                
              //경북---------------------------------------------------------------------------------------

                  var kwangjuPath = [];
                  for (let i = 0, len = ${kwangju.length}; i < len; i++) {
                      kwangjuPath.push(new kakao.maps.LatLng($kwangju[i][1], $kwangju[i][0]))
                  }
                  var kwangjuPolygon = new kakao.maps.Polygon({
                      path: kwangjuPath, 
                      strokeWeight: 3, 
                      strokeColor: '#006400', 
                      strokeOpacity: 0.8, 
                      strokeStyle: 'solid', 
                      fillColor: '#CDECFA', 
                      fillOpacity: 0.7 
                  });
                  kwangjuPolygon.setMap(map);

                  kakao.maps.event.addListener(kwangjuPolygon, 'click', function (mouseEvent) {
                      console.log(`${district[4].name}, ${district[4].num}`);
                  });     
                  var content = `<span style="background-color: #FF7E00; color: white; padding: 2px;font-size: .1rem">${district[4].name}</span>`;
                  var position = new kakao.maps.LatLng(35.160032, 126.851338);
                  var customOverlay = new kakao.maps.CustomOverlay({
                      position: position,
                      content: content
                  });
                  customOverlay.setMap(map);                 
              //광주---------------------------------------------------------------------------------------

                  var daeguPath = [];
                  for (let i = 0, len = ${daegu.length}; i < len; i++) {
                      daeguPath.push(new kakao.maps.LatLng($daegu[i][1], $daegu[i][0]))
                  }
                  var daeguPolygon = new kakao.maps.Polygon({
                      path: daeguPath, 
                      strokeWeight: 3, 
                      strokeColor: '#006400', 
                      strokeOpacity: 0.8, 
                      strokeStyle: 'solid', 
                      fillColor: '#CDECFA', 
                      fillOpacity: 0.7 
                  });
                  daeguPolygon.setMap(map);

                  kakao.maps.event.addListener(daeguPolygon, 'click', function (mouseEvent) {
                      console.log(`${district[5].name}, ${district[5].num}`);
                  });  
                  var content = `<span style="background-color: #FF7E00; color: white; padding: 2px;font-size: .1rem">${district[5].name}</span>`;
                  var position = new kakao.maps.LatLng(35.87139, 128.601763);
                  var customOverlay = new kakao.maps.CustomOverlay({
                      position: position,
                      content: content
                  });
                  customOverlay.setMap(map);                     
              //대구---------------------------------------------------------------------------------------

                  var daejeonPath = [];
                  for (let i = 0, len = ${daejeon.length}; i < len; i++) {
                      daejeonPath.push(new kakao.maps.LatLng($daejeon[i][1], $daejeon[i][0]))
                  }
                  var daejeonPolygon = new kakao.maps.Polygon({
                      path: daejeonPath, 
                      strokeWeight: 3, 
                      strokeColor: '#006400', 
                      strokeOpacity: 0.8, 
                      strokeStyle: 'solid', 
                      fillColor: '#CDECFA', 
                      fillOpacity: 0.7 
                  });
                  daejeonPolygon.setMap(map);

                  kakao.maps.event.addListener(daejeonPolygon, 'click', function (mouseEvent) {
                      console.log(`${district[6].name}, ${district[6].num}`);
                  });     
                  var content = `<span style="background-color: #FF7E00; color: white; padding: 2px;font-size: .1rem">${district[6].name}</span>`;
                  var position = new kakao.maps.LatLng(36.3504396, 127.3849508);
                  var customOverlay = new kakao.maps.CustomOverlay({
                      position: position,
                      content: content
                  });
                  customOverlay.setMap(map);                  
              //대전---------------------------------------------------------------------------------------

                  var busanPath1 = [];
                  var busanPath2 = [];
                  var busanPath3 = [];
                  for (let i = 0, len = ${busan1.length}; i < len; i++) {
                      busanPath1.push(new kakao.maps.LatLng($busan1[i][1], $busan1[i][0]))
                  }
                  for (let i = 0, len = ${busan2.length}; i < len; i++) {
                      busanPath2.push(new kakao.maps.LatLng($busan2[i][1], $busan2[i][0]))
                  }
                  for (let i = 0, len = ${busan3.length}; i < len; i++) {
                      busanPath3.push(new kakao.maps.LatLng($busan3[i][1], $busan3[i][0]))
                  }
                  var busanPolygon = new kakao.maps.Polygon({
                      path: [busanPath1, busanPath2, busanPath3], 
                      strokeWeight: 3, 
                      strokeColor: '#006400', 
                      strokeOpacity: 0.8, 
                      strokeStyle: 'solid', 
                      fillColor: '#CDECFA', 
                      fillOpacity: 0.7 
                  });
                  busanPolygon.setMap(map);

                  kakao.maps.event.addListener(busanPolygon, 'click', function (mouseEvent) {
                      console.log(`${district[7].name}, ${district[7].num}`);
                  });
                    var content = `<span style="background-color: #FF7E00; color: white; padding: 2px;font-size: .1rem">${district[7].name}</span>`;

                    var position = new kakao.maps.LatLng(35.179816, 129.0750223
                    );

                    var customOverlay = new kakao.maps.CustomOverlay({
                        position: position,
                        content: content
                    });
                    customOverlay.setMap(map);
              //부산---------------------------------------------------------------------------------------
 
                  var seoulPath = [];
                  for (let i = 0, len = ${seoul.length}; i < len; i++) {
                      seoulPath.push(new kakao.maps.LatLng($seoul[i][1], $seoul[i][0]))
                  }
                  var seoulPolygon = new kakao.maps.Polygon({
                      path: seoulPath, 
                      strokeWeight: 3, 
                      strokeColor: '#006400', 
                      strokeOpacity: 0.8, 
                      strokeStyle: 'solid', 
                      fillColor: '#CDECFA', 
                      fillOpacity: 0.7 
                  });
                  seoulPolygon.setMap(map);

                  kakao.maps.event.addListener(seoulPolygon, 'click', function (mouseEvent) {
                      console.log(`${district[8].name}, ${district[8].num}`);
                  });   
                    var content = `<span style="background-color: #FF7E00; color: white; padding: 2px;font-size: .1rem">${district[8].name}</span>`;

                    var position = new kakao.maps.LatLng(37.5666103, 126.9783882
                    );

                    var customOverlay = new kakao.maps.CustomOverlay({
                        position: position,
                        content: content
                    });
                    customOverlay.setMap(map);  
              //서울---------------------------------------------------------------------------------------

                  var sejongPath = [];
                  for (let i = 0, len = ${sejong.length}; i < len; i++) {
                      sejongPath.push(new kakao.maps.LatLng($sejong[i][1], $sejong[i][0]))
                  }
                  var sejongPolygon = new kakao.maps.Polygon({
                      path: sejongPath, 
                      strokeWeight: 3, 
                      strokeColor: '#006400', 
                      strokeOpacity: 0.8, 
                      strokeStyle: 'solid', 
                      fillColor: '#CDECFA', 
                      fillOpacity: 0.7 
                  });
                  sejongPolygon.setMap(map);

                  kakao.maps.event.addListener(sejongPolygon, 'click', function (mouseEvent) {
                      console.log(`${district[9].name}, ${district[9].num}`);
                  }); 
                    var content = `<span style="background-color: #FF7E00; color: white; padding: 2px;font-size: .1rem">${district[9].name}</span>`;

                    var position = new kakao.maps.LatLng(36.4803512, 127.2894325
                    );

                    var customOverlay = new kakao.maps.CustomOverlay({
                        position: position,
                        content: content
                    });
                    customOverlay.setMap(map);

   
              //세종---------------------------------------------------------------------------------------

                  var ulsanPath = [];
                  for (let i = 0, len = ${ulsan.length}; i < len; i++) {
                      ulsanPath.push(new kakao.maps.LatLng($ulsan[i][1], $ulsan[i][0]))
                  }
                  var ulsanPolygon = new kakao.maps.Polygon({
                      path: ulsanPath, 
                      strokeWeight: 3, 
                      strokeColor: '#006400', 
                      strokeOpacity: 0.8, 
                      strokeStyle: 'solid', 
                      fillColor: '#CDECFA', 
                      fillOpacity: 0.7 
                  });
                  ulsanPolygon.setMap(map);

                  kakao.maps.event.addListener(ulsanPolygon, 'click', function (mouseEvent) {
                      console.log(`${district[10].name}, ${district[10].num}`);
                  });     
                    var content = `<span style="background-color: #FF7E00; color: white; padding: 2px;font-size: .1rem">${district[10].name}</span>`;

                    var position = new kakao.maps.LatLng(35.5394773, 129.3112994
                    );

                    var customOverlay = new kakao.maps.CustomOverlay({
                        position: position,
                        content: content
                    });
                    customOverlay.setMap(map);
              //울산---------------------------------------------------------------------------------------     

                  var incheonPath1 = [];
                  var incheonPath2 = [];
                  var incheonPath3 = [];
                  var incheonPath4 = [];
                  for (let i = 0, len = ${incheon1.length}; i < len; i++) {
                      incheonPath1.push(new kakao.maps.LatLng($incheon1[i][1], $incheon1[i][0]))
                  }
                  for (let i = 0, len = ${incheon2.length}; i < len; i++) {
                      incheonPath2.push(new kakao.maps.LatLng($incheon2[i][1], $incheon2[i][0]))
                  }
                  for (let i = 0, len = ${incheon3.length}; i < len; i++) {
                      incheonPath3.push(new kakao.maps.LatLng($incheon3[i][1], $incheon3[i][0]))
                  }
                  for (let i = 0, len = ${incheon4.length}; i < len; i++) {
                      incheonPath4.push(new kakao.maps.LatLng($incheon4[i][1], $incheon4[i][0]))
                  }
                  var incheonPolygon = new kakao.maps.Polygon({
                      path: [incheonPath1, incheonPath2, incheonPath3, incheonPath4], 
                      strokeWeight: 3, 
                      strokeColor: '#006400', 
                      strokeOpacity: 0.8, 
                      strokeStyle: 'solid', 
                      fillColor: '#CDECFA', 
                      fillOpacity: 0.7 
                  });
                  incheonPolygon.setMap(map);

                  kakao.maps.event.addListener(incheonPolygon, 'click', function (mouseEvent) {
                      console.log(`${district[11].name}, ${district[11].num}`);
                  });
                    var content = `<span style="background-color: #FF7E00; color: white; padding: 2px;font-size: .1rem">${district[11].name}</span>`;

                    var position = new kakao.maps.LatLng(37.4559418, 126.7051505
                    );

                    var customOverlay = new kakao.maps.CustomOverlay({
                        position: position,
                        content: content
                    });
                    customOverlay.setMap(map);
              //인천---------------------------------------------------------------------------------------

                  var jeonnamPath1 = [];
                  var jeonnamPath2 = [];
                  var jeonnamPath3 = [];
                  var jeonnamPath4 = [];
                  var jeonnamPath5 = [];
                  var jeonnamPath6 = [];
                  var jeonnamPath7 = [];
                  var jeonnamPath8 = [];
                  var jeonnamPath9 = [];
                  for (let i = 0, len = ${jeonnam1.length}; i < len; i++) {
                      jeonnamPath1.push(new kakao.maps.LatLng($jeonnam1[i][1], $jeonnam1[i][0]))
                  }
                  for (let i = 0, len = ${jeonnam2.length}; i < len; i++) {
                      jeonnamPath2.push(new kakao.maps.LatLng($jeonnam2[i][1], $jeonnam2[i][0]))
                  }
                  for (let i = 0, len = ${jeonnam3.length}; i < len; i++) {
                      jeonnamPath3.push(new kakao.maps.LatLng($jeonnam3[i][1], $jeonnam3[i][0]))
                  }
                  for (let i = 0, len = ${jeonnam4.length}; i < len; i++) {
                      jeonnamPath4.push(new kakao.maps.LatLng($jeonnam4[i][1], $jeonnam4[i][0]))
                  }
                  for (let i = 0, len = ${jeonnam5.length}; i < len; i++) {
                      jeonnamPath5.push(new kakao.maps.LatLng($jeonnam5[i][1], $jeonnam5[i][0]))
                  }
                  for (let i = 0, len = ${jeonnam6.length}; i < len; i++) {
                      jeonnamPath6.push(new kakao.maps.LatLng($jeonnam6[i][1], $jeonnam6[i][0]))
                  }
                  for (let i = 0, len = ${jeonnam7.length}; i < len; i++) {
                      jeonnamPath7.push(new kakao.maps.LatLng($jeonnam7[i][1], $jeonnam7[i][0]))
                  }
                  for (let i = 0, len = ${jeonnam8.length}; i < len; i++) {
                      jeonnamPath8.push(new kakao.maps.LatLng($jeonnam8[i][1], $jeonnam8[i][0]))
                  }
                  for (let i = 0, len = ${jeonnam9.length}; i < len; i++) {
                      jeonnamPath9.push(new kakao.maps.LatLng($jeonnam9[i][1], $jeonnam9[i][0]))
                  }
                  var jeonnamPolygon = new kakao.maps.Polygon({
                      path: [jeonnamPath1, jeonnamPath2, jeonnamPath3,
                          jeonnamPath4, jeonnamPath5, jeonnamPath6
                          , jeonnamPath7, jeonnamPath8, jeonnamPath9], 
                      strokeWeight: 3, 
                      strokeColor: '#006400', 
                      strokeOpacity: 0.8, 
                      strokeStyle: 'solid', 
                      fillColor: '#CDECFA', 
                      fillOpacity: 0.7 
                  });
                  jeonnamPolygon.setMap(map);

                  kakao.maps.event.addListener(jeonnamPolygon, 'click', function (mouseEvent) {
                      console.log(`${district[12].name}, ${district[12].num}`);
                  });
                    var content = `<span style="background-color: #FF7E00; color: white; padding: 2px;font-size: .1rem">${district[12].name}</span>`;

                    var position = new kakao.maps.LatLng(34.9007274, 126.9571667
                    );

                    var customOverlay = new kakao.maps.CustomOverlay({
                        position: position,
                        content: content
                    });
                    customOverlay.setMap(map);
              //전남---------------------------------------------------------------------------------------

                  var jeonbukPath = [];
                  for (let i = 0, len = ${jeonbuk.length}; i < len; i++) {
                      jeonbukPath.push(new kakao.maps.LatLng($jeonbuk[i][1], $jeonbuk[i][0]))
                  }
                  var jeonbukPolygon = new kakao.maps.Polygon({
                      path: jeonbukPath, 
                      strokeWeight: 3, 
                      strokeColor: '#006400', 
                      strokeOpacity: 0.8, 
                      strokeStyle: 'solid', 
                      fillColor: '#CDECFA', 
                      fillOpacity: 0.7 
                  });
                  jeonbukPolygon.setMap(map);

                  kakao.maps.event.addListener(jeonbukPolygon, 'click', function (mouseEvent) {
                      console.log(`${district[13].name}, ${district[13].num}`);
                  });
                    var content = `<span style="background-color: #FF7E00; color: white; padding: 2px;font-size: .1rem">${district[13].name}</span>`;

                    var position = new kakao.maps.LatLng(35.6910153, 127.2368291
                    );

                    var customOverlay = new kakao.maps.CustomOverlay({
                        position: position,
                        content: content
                    });
                    customOverlay.setMap(map);
              //전북---------------------------------------------------------------------------------------

                  var jejuPath = [];
                  for (let i = 0, len = ${jeju.length}; i < len; i++) {
                      jejuPath.push(new kakao.maps.LatLng($jeju[i][1], $jeju[i][0]))
                  }
                  var jejuPolygon = new kakao.maps.Polygon({
                      path: jejuPath, 
                      strokeWeight: 3, 
                      strokeColor: '#006400', 
                      strokeOpacity: 0.8, 
                      strokeStyle: 'solid', 
                      fillColor: '#CDECFA', 
                      fillOpacity: 0.7 
                  });
                  jejuPolygon.setMap(map);

                  kakao.maps.event.addListener(jejuPolygon, 'click', function (mouseEvent) {
                      console.log(`${district[14].name}, ${district[14].num}`);
                  });      
                    var content = `<span style="background-color: #FF7E00; color: white; padding: 2px;font-size: .1rem">${district[14].name}</span>`;

                    var position = new kakao.maps.LatLng(33.4273366, 126.5758344
                    );

                    var customOverlay = new kakao.maps.CustomOverlay({
                        position: position,
                        content: content
                    });
                    customOverlay.setMap(map);              
              //제주---------------------------------------------------------------------------------------

                  var chungnamPath1 = [];
                  var chungnamPath2 = [];
                  for (let i = 0, len = ${chungnam1.length}; i < len; i++) {
                      chungnamPath1.push(new kakao.maps.LatLng($chungnam1[i][1], $chungnam1[i][0]))
                  }
                  for (let i = 0, len = ${chungnam2.length}; i < len; i++) {
                      chungnamPath2.push(new kakao.maps.LatLng($chungnam2[i][1], $chungnam2[i][0]))
                  }
                  var chungnamPolygon = new kakao.maps.Polygon({
                      path: [chungnamPath1, chungnamPath2], 
                      strokeWeight: 3, 
                      strokeColor: '#006400', 
                      strokeOpacity: 0.8, 
                      strokeStyle: 'solid', 
                      fillColor: '#CDECFA', 
                      fillOpacity: 0.7 
                  });
                  chungnamPolygon.setMap(map);

                  kakao.maps.event.addListener(chungnamPolygon, 'click', function (mouseEvent) {
                      console.log(`${district[15].name}, ${district[15].num}`);
                  });
                    var content = `<span style="background-color: #FF7E00; color: white; padding: 2px;font-size: .1rem">${district[15].name}</span>`;

                    var position = new kakao.maps.LatLng(36.6173379, 126.8453965);

                    var customOverlay = new kakao.maps.CustomOverlay({
                        position: position,
                        content: content
                    });
                    customOverlay.setMap(map);
              //충남---------------------------------------------------------------------------------------

                  var chungbukPath = [];
                  for (let i = 0, len = ${chungbuk.length}; i < len; i++) {
                      chungbukPath.push(new kakao.maps.LatLng($chungbuk[i][1], $chungbuk[i][0]))
                  }
                  var chungbukPolygon = new kakao.maps.Polygon({
                      path: chungbukPath, 
                      strokeWeight: 3, 
                      strokeColor: '#006400', 
                      strokeOpacity: 0.8, 
                      strokeStyle: 'solid', 
                      fillColor: '#CDECFA', 
                      fillOpacity: 0.7 
                  });

                  chungbukPolygon.setMap(map);

                  kakao.maps.event.addListener(chungbukPolygon, 'click', function (mouseEvent) {
                      console.log(`${district[16].name}, ${district[16].num}`);
                  });
                    var content = `<span style="background-color: #FF7E00; color: white; padding: 2px;font-size: .1rem">${district[16].name}</span>`;

                    var position = new kakao.maps.LatLng(36.7853718, 127.6551404);

                    var customOverlay = new kakao.maps.CustomOverlay({
                        position: position,
                        content: content
                    });
                    customOverlay.setMap(map);
              //충북---------------------------------------------------------------------------------------
''';
  }
}

// ----------------NowAddressText()----------------
class NowAddressText extends StatefulWidget {
  const NowAddressText({Key? key}) : super(key: key);

  @override
  State<NowAddressText> createState() => _NowAddressTextState();
}

class _NowAddressTextState extends State<NowAddressText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(left: 5),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Icon(
              Icons.location_on_outlined,
              size: 20,
            ),
          ),
          Flexible(
              flex: 5,
              child: Text(
                '현재 위치  :  ',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
              )),
          Flexible(
              flex: 12,
              child: Text('충청북도 청주시 서원구 충대로1',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900)))
        ],
      ),
    );
  }
}
