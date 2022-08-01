import 'package:flutter/material.dart';
// import 'package:flutter_kakao_map/flutter_kakao_map.dart';
// import 'package:flutter_kakao_map/kakao_maps_flutter_platform_interface.dart';
// import 'package:kakao_flutter_sdk/kakao_flutter_sdk_common.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'dart:convert';
// import 'package:webview_flutter/webview_flutter.dart';

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

  // late WebViewController _mapController;
  // final double _lat = 33.450701;
  // final double _lng = 126.570667;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        //NowAddressText()
        Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
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
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w900),
                      )),
                  Flexible(
                      flex: 12,
                      child: Text('충청북도 청주시 서원구 충대로1',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w900)))
                ],
              ),
            )),
        //NowAddressText()
        Expanded(
            flex: 10,
            child: KakaoMapView(
              width: size.width,
              height: size.height, //예제 코드는 400
              kakaoMapKey: kakaoMapKey,
              lat: initLat,
              lng: initLng,
              showMapTypeControl: true,
              showZoomControl: true,
              // markerImageURL:
              //     'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
              // mapType: MapType.BICYCLE,
              // mapController: (controller) {
              //   _mapController = controller;
              // },
              onTapMarker: (message) {
                //event callback when the marker is tapped
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message.message)));
                // KakaoLatLng latLng =
                //     KakaoLatLng.fromJson(jsonDecode(message.message));
                // debugPrint('[idle] ${latLng.lat}, ${latLng.lng}');
              },
              cameraIdle: (message) {
                KakaoLatLng latLng =
                    KakaoLatLng.fromJson(jsonDecode(message.message));
                debugPrint('[idle] ${latLng.lat}, ${latLng.lng}');
              },
              boundaryUpdate: (message) {
                KakaoBoundary boundary =
                    KakaoBoundary.fromJson(jsonDecode(message.message));
                debugPrint(
                    'ne : ${boundary.neLat}, ${boundary.neLng}, sw : ${boundary.swLat}, ${boundary.swLng}');
              },
              customScript: '''
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
    
    // 클릭한 위도, 경도 정보를 가져옵니다 
    var latlng = mouseEvent.latLng;
    
    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
    message += '경도는 ' + latlng.getLng() + ' 입니다';
    
    var resultDiv = document.getElementById('result'); 
    resultDiv.innerHTML = message;
    
});
''',

              zoomLevel: 5,
              // customOverlayStyle: '''<style>
              //   .customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
              //   .customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
              //   .customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
              //   .customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
              //   .customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
              // </style>''',
              // customOverlay: '''
              //   var content = '<div class="customoverlay">' +
              //       '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
              //       '    <span class="title">New Marker</span>' +
              //       '  </a>' +
              //       '</div>';

              //   var position = new kakao.maps.LatLng(36.6283933, 127.459223);

              //   var customOverlay = new kakao.maps.CustomOverlay({
              //       map: map,
              //       position: position,
              //       content: content,
              //       yAnchor: 1
              //   });
              //   '''
            )),
        //   Container(
        //     decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        //     child: Flexible(
        //       flex: 3,
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: [
        //           InkWell(
        //             onTap: () {
        //               _mapController.runJavascript('''
        // addMarker(new kakao.maps.LatLng($_lat + 0.0003, $_lng + 0.0003));

        // function addMarker(position) {
        //     let testMarker = new kakao.maps.Marker({position: position});

        //     testMarker.setMap(map);
        // }
        //                   ''');
        //             },
        //             child: CircleAvatar(
        //               backgroundColor: Colors.amber,
        //               child: const Icon(
        //                 Icons.pin_drop,
        //                 color: Colors.white,
        //               ),
        //             ),
        //           ),
        //           InkWell(
        //             onTap: () async {
        //               await _mapController.reload();
        //               debugPrint('[refresh] done');
        //             },
        //             child: CircleAvatar(
        //               backgroundColor: Colors.green,
        //               child: const Icon(
        //                 Icons.refresh,
        //                 color: Colors.white,
        //               ),
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   )
      ],
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


//----------------NowAddressText()----------------
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
