import 'package:flutter/material.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../FestivalPage/detail/detail.dart';

const String kakaoMapKey = 'fcc2a9ef6a954ca6baa99fd67031b63f'; //자바스크립트 key

class FestInfo {
  String mapx;
  String mapy;
  String title;
  String addr1;
  String contentid = "contentid";
  String firstimage = 'assets/images/WaterbombDaegu.png';
  FestInfo(this.mapx, this.mapy, this.title, this.addr1);
}

class MyLocation extends StatefulWidget {
  const MyLocation({Key? key}) : super(key: key);

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  WebViewController? _mapController;
  double initLng = 127.459223;
  double initLat = 36.6283933;
  String location = " ";

  List festList = [
    FestInfo('36.6183933', '127.469223', "목포세계마당페스티벌 ", '목포 원도심 수문로 일대'),
    FestInfo('36.6383933', '127.259223', "festival2", "페스티벌 일정에 관한 내용"),
    FestInfo('36.6483933', '127.419223', "festival3", "페스티벌 일정에 관한 내용"),
    FestInfo('36.7283933', '127.440223', "festival4", "페스티벌 일정에 관한 내용"),
    FestInfo('36.6883933', '127.420223', "festival5", "페스티벌 일정에 관한 내용"),
    FestInfo('36.6283933', '127.473223', "festival6", "페스티벌 일정에 관한 내용"),
  ];

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      initLat = position.latitude;
      initLng = position.longitude;
    });

    List<Placemark> placemarks =
        await placemarkFromCoordinates(initLat, initLng);
    setState(() {
      location = placemarks[0].street.toString();
    });

    myLocationMaker();
  }

  void myLocationMaker() {
    _mapController?.runJavascript('''
        marker.setMap(null);
        var imageSrc = 'https://cdn-icons-png.flaticon.com/512/684/684908.png';                            
        var imageSize = new kakao.maps.Size(28, 30);                
        var imageOption = {offset: new kakao.maps.Point(17, 36)}; 

        addMarker(new kakao.maps.LatLng($initLat , $initLng));

        function addMarker(position) {
            let testMarker = new kakao.maps.Marker({position: position,
              image: new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)});

            testMarker.setMap(map);
        }
        var moveLatLon = new kakao.maps.LatLng($initLat, $initLng);
    
        map.setCenter(moveLatLon);
''');
  }

  void markFestivals() {
    _mapController?.runJavascript('''
        class FestList {
          constructor(mapx, mapy, title, addr1) {
            this.mapx = mapx;
            this.mapy = mapy;
            this.title = title;
            this.addr1 = addr1;
          }
        }
        var festPin = []
    ''');
    for (var item in festList) {
      _mapController?.runJavascript('''
          festPin.push(new FestList(`${item.mapx}`, `${item.mapy}`, `${item.title}`, `${item.addr1}`))
      ''');
    }
    _mapController?.runJavascript(''' 
            var imageSrc = 'https://cdn-icons-png.flaticon.com/512/149/149059.png';                             
            var imageSize = new kakao.maps.Size(28, 30);                
            var imageOption = {offset: new kakao.maps.Point(17, 36)};    
      
            var markers = [];
            function addMarker(position, name, info) {
              let testMarker = new kakao.maps.Marker({position: position,
              image: new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)});

              testMarker.setMap(map); 
              markers.push(testMarker);
              kakao.maps.event.addListener(testMarker, 'click', function (mouseEvent) {
                                           onTapMarker.postMessage(name+'-'+info);
              });
             }

            let len = festPin.length;
            for(let i=0;i<festPin.length;i++){
              addMarker(new kakao.maps.LatLng(festPin[i].mapx, festPin[i].mapy), festPin[i].title, festPin[i].addr1);
            }
    ''');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition().then((value) => markFestivals());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      address(),
      Expanded(
        flex: 10,
        child: KakaoMapView(
          mapController: (controller) {
            _mapController = controller;
          },
          width: size.width,
          height: 400,
          kakaoMapKey: kakaoMapKey,
          showMapTypeControl: true,
          showZoomControl: true,
          draggableMarker: true,
          zoomLevel: 7,
          lat: initLat,
          lng: initLng,
          onTapMarker: (message) {
            var fest = message.message.split('-');
            String name = fest[0];
            String address = fest[1];
            festivalInfo(context, name, address).then((value) {
              setState(() {});
            });
            MaterialPageRoute(builder: (context) => DetailPage());
          },
          zoomChanged: (p0) {
            //level 9에서부터 marker 지우기
            int level = int.parse(p0.message);
            print(level);
            if (level >= 9) {
              _mapController?.runJavascript('''
                for (var i = 0; i < markers.length; i++) {
                    markers[i].setMap(null);
                }      
              ''');
            } else {
              _mapController?.runJavascript('''
                for (var i = 0; i < markers.length; i++) {
                    markers[i].setMap(map);
                }    
              ''');
            }
          },
        ),
      )
    ]);
  }

  Future<void> festivalInfo(BuildContext context, String name, String address) {
    return showModalBottomSheet<void>(
      //디자인 수정 -> api 보는거 보고
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, setState) => InkWell(
                onTap: (() => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DetailPage()))),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/WaterbombDaegu.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    thickness: 1.5,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.near_me_outlined,
                                        size: 16,
                                        color: Color.fromRGBO(255, 126, 0, 1),
                                      ),
                                      SizedBox(width: 5),
                                      RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                        strutStyle: StrutStyle(fontSize: 16.0),
                                        text: TextSpan(
                                            text: address,
                                            style: TextStyle(
                                                color: Colors.black,
                                                height: 1.4,
                                                fontSize: 14.0,
                                                fontFamily:
                                                    'NanumSquareRegular')),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                )));
      },
    );
  }

  Container address() {
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
                '현위치: ',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              )),
          Flexible(
              flex: 12,
              child: Text(location,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)))
        ],
      ),
    );
  }
}
