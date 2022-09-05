import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fing/FestivalPage/detail/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fing/API/locationbasedlist.dart';

const String kakaoMapKey = 'fcc2a9ef6a954ca6baa99fd67031b63f'; //자바스크립트 key

class FestInfo {
  String mapx;
  String mapy;
  String title;
  String addr1;
  String contentid;
  String firstimage;
  FestInfo(this.mapx, this.mapy, this.title, this.addr1, this.contentid,
      this.firstimage);
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

  List festList = [];

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   return Future.error('Location services are disabled.');
    // }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Get.snackbar('', 'Location Permission Denied');
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

    List list = await fetchLocationBasedList(
        arrange: "A",
        contentTypeId: "15",
        mapX: initLng.toString(),
        mapY: initLat.toString(),
        radius: "200000");

    for (int i = 0; i < list[0].response.body.items.item.length; i++) {
      festList.add(FestInfo(
          list[0].response.body.items.item[i].mapx,
          list[0].response.body.items.item[i].mapy,
          list[0].response.body.items.item[i].title,
          list[0].response.body.items.item[i].addr1,
          list[0].response.body.items.item[i].contentid,
          list[0].response.body.items.item[i].firstimage));
    }

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
          constructor(mapx, mapy, title, addr1, contentid, firstimage) {
            this.mapx = mapx;
            this.mapy = mapy;
            this.title = title;
            this.addr1 = addr1;
            this.contentid = contentid;
            this.firstimage = firstimage;
          }
        }
        var festPin = []
    ''');
    for (var item in festList) {
      _mapController?.runJavascript('''
          festPin.push(new FestList(`${item.mapx}`, `${item.mapy}`, `${item.title}`, `${item.addr1}`, `${item.contentid}`, `${item.firstimage}`))
      ''');
    }
    _mapController?.runJavascript(''' 
            var imageSrc = 'https://cdn-icons-png.flaticon.com/512/149/149059.png';                             
            var imageSize = new kakao.maps.Size(28, 30);                
            var imageOption = {offset: new kakao.maps.Point(17, 36)};    
      
            var markers = [];
            function addMarker(position, title, addr1, contentid, firstimage) {
              let testMarker = new kakao.maps.Marker({position: position,
              image: new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)});

              testMarker.setMap(map); 
              markers.push(testMarker);
              kakao.maps.event.addListener(testMarker, 'click', function (mouseEvent) {
                                           onTapMarker.postMessage(title+'-'+addr1+'-'+contentid+'-'+firstimage+'-'+position.getLng()+'-'+position.getLat());
              });
             }


            for(let i=0;i<festPin.length;i++){
              addMarker(new kakao.maps.LatLng(festPin[i].mapy, festPin[i].mapx), festPin[i].title, festPin[i].addr1, festPin[i].contentid, festPin[i].firstimage);
            }
    ''');
  }

  @override
  void initState() {
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
            print(message.message);
            var fest = message.message.split('-');
            String name = fest[0];
            String address = fest[1];
            String contentid = fest[2];
            String firstimage = fest[3];
            String mapX = fest[4];
            String mapY = fest[5];
            festivalInfo(
                    context, name, address, contentid, firstimage, mapX, mapY)
                .then((value) {
              setState(() {});
            });
          },
          zoomChanged: (p0) {
            int level = int.parse(p0.message);
            if (level >= 9) {
              _mapController?.runJavascript('''
                for(let i=0;i<markers.length;i++){
                  markers[i].setMap(null);
                }      
              ''');
            } else {
              _mapController?.runJavascript('''
                for(let i=0;i<markers.length;i++){
                  markers[i].setMap(map);
                }      
              ''');
            }
          },
        ),
      )
    ]);
  }

  Future<void> festivalInfo(BuildContext context, String name, String address,
      String contentid, String firstimage, String mapX, String mapY) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, setState) => InkWell(
                onTap: () {
                  String curuser = "wjdtpdus828@naver.com";
                  FirebaseFirestore.instance
                      .collection('User')
                      .doc(curuser)
                      .collection("MyCurrent")
                      .doc(name)
                      .set({
                    "firstimage": firstimage,
                    "title": name,
                    "addr1": address,
                    "contentid": contentid,
                    // "eventstartdate": widget.item.eventstartdate,
                    // "eventenddate": widget.item.eventenddate,
                    "mapx": mapX,
                    "mapy": mapY,
                    // "readcount": widget.item.readcount.toString(),
                    "timestamp": DateTime.now()
                  }, SetOptions(merge: true));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPage(
                              firstimage: firstimage,
                              title: name,
                              addr1: address,
                              contentid: contentid,
                              mapx: mapX,
                              mapy: mapY)));
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Image.network(
                          width: MediaQuery.of(context).size.width * 0.4,
                          firstimage,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 150,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Divider(
                                thickness: 1.5,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.near_me_outlined,
                                size: 16,
                                color: Color.fromRGBO(255, 126, 0, 1),
                              ),
                              Container(
                                width: 150,
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  address,
                                  style: TextStyle(
                                      color: Colors.black,
                                      height: 1.4,
                                      fontSize: 14.0,
                                      fontFamily: 'NanumSquareRegular'),
                                  overflow: TextOverflow.ellipsis,
                                  // textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )));
      },
    );
  }

  Container address() {
    return Container(
      width: 400,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 20,
            color: Color.fromRGBO(255, 126, 0, 1),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
              child: Text(
            location,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ))
        ],
      ),
    );
  }
}
