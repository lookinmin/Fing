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
                lat: 33.450701,
                lng: 126.570667,
                showMapTypeControl: true,
                showZoomControl: true,
                draggableMarker: true,
                polygon: jeju(),
                zoomLevel: 9,
                onTapMarker: (message) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message.message)));
                }))
      ],
    );
  }

  KakaoFigure jeju() {
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
    return KakaoFigure(
      path: path.isEmpty
          ? [
              KakaoLatLng(lat: 33.45086654081833, lng: 126.56906858718982),
              KakaoLatLng(lat: 33.45010890948828, lng: 126.56898629127468),
              KakaoLatLng(lat: 33.44979857909499, lng: 126.57049357211622),
              KakaoLatLng(lat: 33.450137483918496, lng: 126.57202991943016),
              KakaoLatLng(lat: 33.450706188506054, lng: 126.57223147947938),
              KakaoLatLng(lat: 33.45164068091554, lng: 126.5713126693152)
            ]
          : path,
      polygonColor: Colors.red,
      polygonColorOpacity: 0.3,
      strokeColor: Colors.deepOrange,
      strokeWeight: 2,
      strokeColorOpacity: 0.9,
      strokeStyle: StrokeStyle.shortdashdot,
    );
  }
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
