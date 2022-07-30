import 'package:flutter/material.dart';
import 'package:flutter_kakao_map/flutter_kakao_map.dart';
import 'package:flutter_kakao_map/kakao_maps_flutter_platform_interface.dart';
// import 'package:kakao_flutter_sdk/kakao_flutter_sdk_common.dart';

void main() {
  AddressMap();
}

class AddressMap extends StatefulWidget {
  const AddressMap({Key? key}) : super(key: key);

  @override
  State<AddressMap> createState() => _AddressMapState();
}

class _AddressMapState extends State<AddressMap> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(flex: 2, fit: FlexFit.tight, child: NowAddressText()),
        Expanded(flex: 12, child: NowAddressMap())
      ],
    );
  }
}

class NowAddressMap extends StatefulWidget {
  NowAddressMap({Key? key}) : super(key: key);

  @override
  State<NowAddressMap> createState() => _NowAddressMapState();
}

class _NowAddressMapState extends State<NowAddressMap> {
  late KakaoMapController mapController;
  MapPoint _init = MapPoint(37.508, 127.06);
  CameraPosition _initPosition =
      CameraPosition(target: MapPoint(37.508, 127.06), zoom: 5);

  void onMapCreated(KakaoMapController controller) async {
    final MapPoint visibleRegion = await controller.getMapCenterPoint();
    setState(() {
      mapController = controller;
      _init = visibleRegion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: KakaoMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: _initPosition,
      ),
    );
  }
}

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
