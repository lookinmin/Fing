import 'package:flutter/material.dart';
// import 'package:flutter_kakao_map/flutter_kakao_map.dart';
// import 'package:flutter_kakao_map/kakao_maps_flutter_platform_interface.dart';
// import 'package:kakao_flutter_sdk/kakao_flutter_sdk_common.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'dart:convert';
// import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter/services.dart';

void main() {
  AddressMap();
}

//자바스크립트 key
const String kakaoMapKey = 'f17b4d8f4539755e1bcee8e9e1584002';

class AddressMap extends StatefulWidget {
  const AddressMap({Key? key}) : super(key: key);

  @override
  State<AddressMap> createState() => _AddressMapState();
}

class _AddressMapState extends State<AddressMap> {
  double initLng = 127.459223;
  double initLat = 36.6283933;

  // final double _lat = 33.450701;
  // final double _lng = 126.570667;

  List _items = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('json/region.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["features"];
      print((_items[0]["geometry"]["coordinates"][0])); //좌표하나 출력 시
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        //NowAddressText()
        Flexible(flex: 2, fit: FlexFit.tight, child: NowAddressText()),
        ElevatedButton(
          child: const Text('Load Data'),
          onPressed: readJson,
        ),
        Expanded(
            flex: 10,
            child: KakaoMapView(
              width: size.width,
              height: 400,
              kakaoMapKey: kakaoMapKey,
              // lat: 37.54630155058717,
              // lng: 127.17826131172255,
              lat: 33.452344169439975,
              lng: 126.56878163224233,
              showMapTypeControl: true,
              showZoomControl: true,
              draggableMarker: true,
              polygon: district(),
              // polygon: kakaoFigure,
              zoomLevel: 13,
              onTapMarker: (message) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message.message)));
              },
              customScript: """


console.log("js console log");

var markers = [];
console.log("console.log2");
    function addMarker(position) {

      var marker = new kakao.maps.Marker({position: position});

      marker.setMap(map);

      markers.push(marker);
    }

    for(var i = 0 ; i < 3 ; i++){
      addMarker(new kakao.maps.LatLng(33.450701 + 0.0003 * i, 126.570667 + 0.0003 * i));

      kakao.maps.event.addListener(markers[i], 'click', (function(i) {
        return function(){
          onTapMarker.postMessage('marker ' + i + ' is tapped');
        };
      })(i));
    }

		  var zoomControl = new kakao.maps.ZoomControl();
      map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

      var mapTypeControl = new kakao.maps.MapTypeControl();
      map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

var polygonPath = [
    new kakao.maps.LatLng(33.45133510810506, 126.57159381623066),
    new kakao.maps.LatLng(33.44955812811862, 126.5713551811832),
    new kakao.maps.LatLng(33.449986291544086, 126.57263296172184),
    new kakao.maps.LatLng(33.450682513554554, 126.57321034054742),
    new kakao.maps.LatLng(33.451346760004206, 126.57235740081413) 
];

// 지도에 표시할 다각형을 생성합니다
var polygon = new kakao.maps.Polygon({
    path:polygonPath, // 그려질 다각형의 좌표 배열입니다
    strokeWeight: 3, // 선의 두께입니다
    strokeColor: '#39DE2A', // 선의 색깔입니다
    strokeOpacity: 0.8, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
    strokeStyle: 'solid', // 선의 스타일입니다
    fillColor: '#A2FF99', // 채우기 색깔입니다
    fillOpacity: 0.7 // 채우기 불투명도 입니다
});
polygon.setMap(map);
              """,
            ))
      ],
    );
  }
}

List tmp = [
  [127.40150573442256, 36.48679951624792],
  [127.40237162713332, 36.486049226720844],
  [127.40583116302797, 36.45493887822377],
  [127.40629396019843, 36.454913086274914],
  [127.43213116720865, 36.45662159419439],
  [127.43378989155006, 36.45653731526793],
  [127.46155957004515, 36.45509361223148],
  [127.4617928230305, 36.455337148641355],
  [127.47987139318172, 36.477063983032316],
  [127.48061100717518, 36.47720999255097],
  [127.48423168252953, 36.475797777779924],
  [127.48427610887815, 36.4756241273186],
  [127.4960880025384, 36.454788546508105],
  [127.49646645707624, 36.45490693805522],
  [127.5035961999129, 36.454045572323665],
  [127.5037888450623, 36.45370091965119],
  [127.49376705635758, 36.42524291590289],
  [127.49391176970472, 36.42506434044689],
  [127.53743516505264, 36.420317939994945],
  [127.53778279146553, 36.42012291038361],
  [127.54228073457993, 36.41927919632655],
  [127.54185998818646, 36.41585756869269],
  [127.5470727467962, 36.40845961594542],
  [127.54707951164634, 36.408454519716564],
  [127.55816517314781, 36.399675947569705],
  [127.55878010175535, 36.399856150629894],
  [127.55919218532583, 36.39914654004481],
  [127.55967899075192, 36.39821888953578],
  [127.55508024348465, 36.39518678315378],
  [127.55494637061842, 36.39514713936509],
  [127.52480467423321, 36.38380225513675],
  [127.5193690338617, 36.35035287645941],
  [127.50134180998748, 36.34006990064799],
  [127.49257720191125, 36.23795395068193],
  [127.44871641082584, 36.19672289194393],
  [127.40799929928723, 36.212892945867274],
  [127.39025797769695, 36.2622709500042],
  [127.35950194982368, 36.262586342451286],
  [127.36419718015068, 36.21890129271374],
  [127.32394583489626, 36.203158372814976],
  [127.31564105913714, 36.22081536998303],
  [127.2831547927397, 36.23529359092193],
  [127.28650666227946, 36.26495018611541],
  [127.28624581898431, 36.264895312282356],
  [127.25877186484053, 36.2760505815688],
  [127.25975274393714, 36.32724953025797],
  [127.27912600112028, 36.3448265782094],
  [127.28212428234082, 36.414603964631645],
  [127.29426961581308, 36.421915039124464],
  [127.29425168764308, 36.42219502183513],
  [127.3263167270464, 36.422208976417835],
  [127.35579857644919, 36.450273038129],
  [127.38008138312885, 36.499215976257155],
  [127.38033654837668, 36.49953929874922],
  [127.38096688868224, 36.499660645040414],
  [127.38230967353526, 36.49992444824916],
  [127.38385497104343, 36.500230690026456],
  [127.38538373894964, 36.499444883432616],
  [127.38626339999793, 36.498985556577466],
  [127.39575988535204, 36.49195602619904],
  [127.39614094465608, 36.491708392279],
  [127.40150573442256, 36.48679951624792]
];

var kakaoFigure = KakaoFigure(
  path: [
    KakaoLatLng(lat: 33.45086654081833, lng: 126.56906858718982),
    KakaoLatLng(lat: 33.45010890948828, lng: 126.56898629127468),
    KakaoLatLng(lat: 33.44979857909499, lng: 126.57049357211622),
    KakaoLatLng(lat: 33.450137483918496, lng: 126.57202991943016),
    KakaoLatLng(lat: 33.450706188506054, lng: 126.57223147947938),
    KakaoLatLng(lat: 33.45164068091554, lng: 126.5713126693152)
  ],
  polygonColor: Colors.red,
  polygonColorOpacity: 0.3,
  strokeColor: Colors.deepOrange,
  strokeWeight: 2.5,
  strokeColorOpacity: 0.9,
  strokeStyle: StrokeStyle.shortdashdot,
);

List<KakaoLatLng> jeju() {
  List coordinates = [
    [126.76810769405087, 33.5641592794216],
    [126.80811250530077, 33.55627895764881],
    [126.86073654031928, 33.52469704921349],
    [126.89281325620627, 33.52643714304505],
    [126.91310370824057, 33.503334977089686],
    [126.90168871448753, 33.48095034803912],
    [126.92437630387386, 33.45302162962542],
    [126.90554917633473, 33.39164571578218],
    [126.88014972201171, 33.38231096757103],
    [126.86817869146073, 33.35472313256807],
    [126.82909341898826, 33.306514278037525],
    [126.77572999969814, 33.307005033700115],
    [126.74335319543825, 33.278851795358314],
    [126.65307277375895, 33.270175945090955],
    [126.59928143623368, 33.23621090573838],
    [126.58901738387941, 33.24371564909495],
    [126.51977134812242, 33.240820434842114],
    [126.47090148793191, 33.22657848742092],
    [126.4099359336251, 33.24602771368301],
    [126.37017572943468, 33.23173079763588],
    [126.32680296262788, 33.241410210952026],
    [126.2697908923715, 33.19605392476859],
    [126.23541484105488, 33.235896226081785],
    [126.18352078770103, 33.259388011660334],
    [126.16164603240452, 33.292265061029646],
    [126.16411862524699, 33.3369143591478],
    [126.23418093173848, 33.389208508446195],
    [126.26290374315803, 33.41728391732652],
    [126.26334752626512, 33.4358175090436],
    [126.38550757278685, 33.48898413837508],
    [126.40833057042097, 33.48576086437714],
    [126.4540006929407, 33.49777855202679],
    [126.49490785068467, 33.52054046470463],
    [126.51135964980969, 33.51555085312057],
    [126.58622640244599, 33.525532579400924],
    [126.73025492918568, 33.5603612390647],
    [126.76810769405087, 33.5641592794216]
  ];

  List<KakaoLatLng> path = [];

  for (var items in coordinates) {
    path.add(KakaoLatLng(lat: items[1], lng: items[0]));
  }
  return (path.isEmpty
      ? [
          KakaoLatLng(lat: 33.45086654081833, lng: 126.56906858718982),
          KakaoLatLng(lat: 33.45010890948828, lng: 126.56898629127468),
          KakaoLatLng(lat: 33.44979857909499, lng: 126.57049357211622),
          KakaoLatLng(lat: 33.450137483918496, lng: 126.57202991943016),
          KakaoLatLng(lat: 33.450706188506054, lng: 126.57223147947938),
          KakaoLatLng(lat: 33.45164068091554, lng: 126.5713126693152)
        ]
      : path);
}

List<KakaoLatLng> daejeon() {
  List coordinates = [
    [127.40150573442256, 36.48679951624792],
    [127.40237162713332, 36.486049226720844],
    [127.40583116302797, 36.45493887822377],
    [127.40629396019843, 36.454913086274914],
    [127.43213116720865, 36.45662159419439],
    [127.43378989155006, 36.45653731526793],
    [127.46155957004515, 36.45509361223148],
    [127.4617928230305, 36.455337148641355],
    [127.47987139318172, 36.477063983032316],
    [127.48061100717518, 36.47720999255097],
    [127.48423168252953, 36.475797777779924],
    [127.48427610887815, 36.4756241273186],
    [127.4960880025384, 36.454788546508105],
    [127.49646645707624, 36.45490693805522],
    [127.5035961999129, 36.454045572323665],
    [127.5037888450623, 36.45370091965119],
    [127.49376705635758, 36.42524291590289],
    [127.49391176970472, 36.42506434044689],
    [127.53743516505264, 36.420317939994945],
    [127.53778279146553, 36.42012291038361],
    [127.54228073457993, 36.41927919632655],
    [127.54185998818646, 36.41585756869269],
    [127.5470727467962, 36.40845961594542],
    [127.54707951164634, 36.408454519716564],
    [127.55816517314781, 36.399675947569705],
    [127.55878010175535, 36.399856150629894],
    [127.55919218532583, 36.39914654004481],
    [127.55967899075192, 36.39821888953578],
    [127.55508024348465, 36.39518678315378],
    [127.55494637061842, 36.39514713936509],
    [127.52480467423321, 36.38380225513675],
    [127.5193690338617, 36.35035287645941],
    [127.50134180998748, 36.34006990064799],
    [127.49257720191125, 36.23795395068193],
    [127.44871641082584, 36.19672289194393],
    [127.40799929928723, 36.212892945867274],
    [127.39025797769695, 36.2622709500042],
    [127.35950194982368, 36.262586342451286],
    [127.36419718015068, 36.21890129271374],
    [127.32394583489626, 36.203158372814976],
    [127.31564105913714, 36.22081536998303],
    [127.2831547927397, 36.23529359092193],
    [127.28650666227946, 36.26495018611541],
    [127.28624581898431, 36.264895312282356],
    [127.25877186484053, 36.2760505815688],
    [127.25975274393714, 36.32724953025797],
    [127.27912600112028, 36.3448265782094],
    [127.28212428234082, 36.414603964631645],
    [127.29426961581308, 36.421915039124464],
    [127.29425168764308, 36.42219502183513],
    [127.3263167270464, 36.422208976417835],
    [127.35579857644919, 36.450273038129],
    [127.38008138312885, 36.499215976257155],
    [127.38033654837668, 36.49953929874922],
    [127.38096688868224, 36.499660645040414],
    [127.38230967353526, 36.49992444824916],
    [127.38385497104343, 36.500230690026456],
    [127.38538373894964, 36.499444883432616],
    [127.38626339999793, 36.498985556577466],
    [127.39575988535204, 36.49195602619904],
    [127.39614094465608, 36.491708392279],
    [127.40150573442256, 36.48679951624792]
  ];
  List<KakaoLatLng> path = [];

  for (var items in coordinates) {
    path.add(KakaoLatLng(lat: items[1], lng: items[0]));
  }

  return (path.isEmpty
      ? [
          KakaoLatLng(lat: 33.45086654081833, lng: 126.56906858718982),
          KakaoLatLng(lat: 33.45010890948828, lng: 126.56898629127468),
          KakaoLatLng(lat: 33.44979857909499, lng: 126.57049357211622),
          KakaoLatLng(lat: 33.450137483918496, lng: 126.57202991943016),
          KakaoLatLng(lat: 33.450706188506054, lng: 126.57223147947938),
          KakaoLatLng(lat: 33.45164068091554, lng: 126.5713126693152)
        ]
      : path);
}

KakaoFigure district() {
  var path = daejeon();
  path += jeju();
  return KakaoFigure(
    path: path,
    polygonColor: Colors.red,
    polygonColorOpacity: 0.3,
    strokeColor: Colors.deepOrange,
    strokeWeight: 2,
    strokeColorOpacity: 0.9,
    strokeStyle: StrokeStyle.shortdashdot,
  );
}
//----------------NowAddressMap()----------------
// class NowAddressMap extends StatefulWidget {
//   NowAddressMap({Key? key}) : super(key: key);

//   @override
//   State<NowAddressMap> createState() => _NowAddressMapState();
// }

// class _NowAddressMapState extends State<NowAddressMap> {
//   late KakaoMapController mapController;
//   MapPoint _init = MapPoint(37.508, 127.06);
//   CameraPosition _initPosition =
//       CameraPosition(target: MapPoint(37.508, 127.06), zoom: 5);

//   void onMapCreated(KakaoMapController controller) async {
//     final MapPoint visibleRegion = await controller.getMapCenterPoint();
//     setState(() {
//       mapController = controller;
//       _init = visibleRegion;
//     });
//   }

//   late double lat, lng;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(10),
//           child: KakaoMap(
//             onMapCreated: onMapCreated,
//             initialCameraPosition: _initPosition,
//           ),
//         ),
//         ElevatedButton(
//           child: Text('Location'),
//           onPressed: () => _locateMe(),
//         )
//       ],
//     );
//   }
// }

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
