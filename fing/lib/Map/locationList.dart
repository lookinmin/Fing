import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fing/FestivalPage/detail/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fing/API/locationbasedlist.dart';

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

class LocationList extends StatefulWidget {
  const LocationList({Key? key}) : super(key: key);
  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  double initLng = 127.459223;
  double initLat = 36.6283933;
  String location = "initLocation";

  List festList = [];

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

    getFestList(initLat, initLng);
  }

  void getFestList(double initLat, double initLng) async {
    print('getFestList');
    List list = await fetchLocationBasedList(
        arrange: "A",
        contentTypeId: "15",
        mapX: initLng.toString(),
        mapY: initLat.toString(),
        radius: "15000");

    print('list len: ${list.length}');

    for (int i = 0; i < list[0].response.body.items.item.length; i++) {
      setState(() {
        festList.add(FestInfo(
            list[0].response.body.items.item[i].mapx,
            list[0].response.body.items.item[i].mapy,
            list[0].response.body.items.item[i].title,
            list[0].response.body.items.item[i].addr1,
            list[0].response.body.items.item[i].contentid,
            list[0].response.body.items.item[i].firstimage));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return festList.isEmpty
        ? Center(
            child: Text('위치 정보를 받을 수 없습니다'),
          )
        : ListView.builder(
            itemCount: festList.length,
            itemBuilder: (BuildContext context, index) => InkWell(
                  onTap: () {
                    String curuser = "wjdtpdus828@naver.com";
                    FirebaseFirestore.instance
                        .collection('User')
                        .doc(curuser)
                        .collection("MyCurrent")
                        .doc(festList[index].title)
                        .set({
                      "firstimage": festList[index].firstimage,
                      "title": festList[index].title,
                      "addr1": festList[index].addr1,
                      "contentid": festList[index].contentid,
                      "mapx": festList[index].mapx,
                      "mapy": festList[index].mapy,
                      "timestamp": DateTime.now()
                    }, SetOptions(merge: true));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(
                                firstimage: festList[index].firstimage,
                                title: festList[index].title,
                                addr1: festList[index].addr1,
                                contentid: festList[index].contentid,
                                mapx: festList[index].mapx,
                                mapy: festList[index].mapy)));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                    height: 150,
                    child: Row(mainAxisSize: MainAxisSize.max, children: [
                      CachedNetworkImage(
                        width: 100,
                        imageUrl: festList[index].firstimage,
                        errorWidget: ((context, url, error) => Image(
                            image:
                                AssetImage('assets/images/DefaultImage.png'))),
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                festList[index].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              height: 1.0,
                              width: 150.0,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                festList[index].addr1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ));
  }

  // Future<void> festivalInfo(BuildContext context, String name, String address,
  //     String contentid, String firstimage, String mapX, String mapY) {
  //   return showModalBottomSheet<void>(
  //     context: context,
  //     backgroundColor: Colors.white,
  //     shape: RoundedRectangleBorder(
  //         side: BorderSide.none,
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(20), topRight: Radius.circular(20))),
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //           builder: (BuildContext context, setState) => InkWell(
  //               onTap: () {
  //                 String curuser = "wjdtpdus828@naver.com";
  //                 FirebaseFirestore.instance
  //                     .collection('User')
  //                     .doc(curuser)
  //                     .collection("MyCurrent")
  //                     .doc(name)
  //                     .set({
  //                   "firstimage": firstimage,
  //                   "title": name,
  //                   "addr1": address,
  //                   "contentid": contentid,
  //                   // "eventstartdate": widget.item.eventstartdate,
  //                   // "eventenddate": widget.item.eventenddate,
  //                   "mapx": mapX,
  //                   "mapy": mapY,
  //                   // "readcount": widget.item.readcount.toString(),
  //                   "timestamp": DateTime.now()
  //                 }, SetOptions(merge: true));
  //                 Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (context) => DetailPage(
  //                             firstimage: firstimage,
  //                             title: name,
  //                             addr1: address,
  //                             contentid: contentid,
  //                             mapx: mapX,
  //                             mapy: mapY)));
  //               },
  //               child: SizedBox(
  //                 height: MediaQuery.of(context).size.height * 0.25,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   mainAxisSize: MainAxisSize.max,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(vertical: 15.0),
  //                       child: Image.network(
  //                         width: MediaQuery.of(context).size.width * 0.4,
  //                         firstimage,
  //                         fit: BoxFit.contain,
  //                       ),
  //                     ),
  //                     Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Center(
  //                           child: Container(
  //                             width: 150,
  //                             padding: EdgeInsets.symmetric(horizontal: 10),
  //                             child: Text(
  //                               name,
  //                               style: TextStyle(
  //                                   fontWeight: FontWeight.w600, fontSize: 15),
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           width: 150,
  //                           child: Padding(
  //                             padding:
  //                                 const EdgeInsets.symmetric(vertical: 10.0),
  //                             child: Divider(
  //                               thickness: 1.5,
  //                             ),
  //                           ),
  //                         ),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Icon(
  //                               Icons.near_me_outlined,
  //                               size: 16,
  //                               color: Color.fromRGBO(255, 126, 0, 1),
  //                             ),
  //                             Container(
  //                               width: 150,
  //                               padding: EdgeInsets.only(left: 5),
  //                               child: Text(
  //                                 address,
  //                                 style: TextStyle(
  //                                     color: Colors.black,
  //                                     height: 1.4,
  //                                     fontSize: 14.0,
  //                                     fontFamily: 'NanumSquareRegular'),
  //                                 overflow: TextOverflow.ellipsis,
  //                                 // textAlign: TextAlign.center,
  //                               ),
  //                             ),
  //                           ],
  //                         )
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               )));
  //     },
  //   );
  // }

  // Container address() {
  //   return Container(
  //     width: 400,
  //     height: 100,
  //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
  //     decoration: BoxDecoration(border: Border.all(color: Colors.black)),
  //     child: Row(
  //       children: [
  //         Icon(
  //           Icons.location_on_outlined,
  //           size: 20,
  //           color: Color.fromRGBO(255, 126, 0, 1),
  //         ),
  //         SizedBox(
  //           width: 5,
  //         ),
  //         Expanded(
  //             child: Text(
  //           location,
  //           style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
  //           overflow: TextOverflow.ellipsis,
  //         ))
  //       ],
  //     ),
  //   );
  // }
}
