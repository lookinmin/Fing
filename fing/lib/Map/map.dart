import 'package:flutter/material.dart';
// import 'package:flutter_kakao_map/flutter_kakao_map.dart';
// import 'package:flutter_kakao_map/kakao_maps_flutter_platform_interface.dart';
// import 'package:kakao_flutter_sdk/kakao_flutter_sdk_common.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';

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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        // Flexible(flex: 2, fit: FlexFit.tight, child: NowAddressText()),
        // Expanded(flex: 12, child: NowAddressMap())
        Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(255, 6, 17, 22))),
          child: KakaoMapView(
            width: size.width,
            height: 400,
            kakaoMapKey: kakaoMapKey,
            lat: 33.450701,
            lng: 126.570667,
            showMapTypeControl: true,
            showZoomControl: true,
            // markerImageURL:
            //     'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
            onTapMarker: (message) {
              //event callback when the marker is tapped
            },
          ),
        )
      ],
    );
  }
}

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

// class NowAddressText extends StatefulWidget {
//   const NowAddressText({Key? key}) : super(key: key);

//   @override
//   State<NowAddressText> createState() => _NowAddressTextState();
// }

// class _NowAddressTextState extends State<NowAddressText> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       padding: EdgeInsets.only(left: 5),
//       child: Row(
//         children: [
//           Container(
//             margin: EdgeInsets.only(right: 5),
//             child: Icon(
//               Icons.location_on_outlined,
//               size: 20,
//             ),
//           ),
//           Flexible(
//               flex: 5,
//               child: Text(
//                 '현재 위치  :  ',
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
//               )),
//           Flexible(
//               flex: 12,
//               child: Text('충청북도 청주시 서원구 충대로1',
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900)))
//         ],
//       ),
//     );
//   }
// }
