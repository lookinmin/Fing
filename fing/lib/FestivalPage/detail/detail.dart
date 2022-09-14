import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:kakao_flutter_sdk_navi/kakao_flutter_sdk_navi.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fing/Firebase/fing_db.dart';
import 'package:fing/API/detailInfo.dart' as info;
import 'package:fing/API/detailIntro.dart' as intro;
import 'package:fing/API/locationbasedlist.dart' as local;
import 'package:cached_network_image/cached_network_image.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {Key? key,
      required this.firstimage,
      required this.title,
      required this.addr1,
      required this.contentid,
      required this.mapx,
      required this.mapy})
      : super(key: key);
  final firstimage;
  final title;
  final addr1;
  final contentid;
  final mapx;
  final mapy;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

// class favorite_Model {
//   Uri? favorite_image;
//   String? title;
//   String? address;

//   favorite_Model({this.favorite_image, this.title, this.address});

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['favorite_image'] = favorite_image;
//     map['title'] = title;
//     map['address'] = address;
//     return map;
//   }
// }

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  late TabController _TabController;
  // ScrollController _scrollController = new ScrollController();

  late Future<DetailFestival> futureDetailFestival;

  @override
  void initState() {
    super.initState();
    _TabController = new TabController(length: 3, vsync: this);
    futureDetailFestival = fetchDetailFestival(
      contentId: widget.contentid,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var mobileWidth = 700;
    bool isWeb = true;
    size.width > mobileWidth ? isWeb = true : isWeb = false;

    final regionText = widget.addr1.toString();
    final reg1 = regionText.split(" ")[0];
    final reg2 = regionText.split(" ")[1];
    bool heartcheck = false;

    // 임시 로그인
    String curuser = fing_db_user[0].email;

    // FireBase 에서 찜 목록 확인
    FirebaseFirestore.instance
        .collection('User')
        .doc(curuser)
        .collection('MyFavorite')
        .where("contentid", isEqualTo: widget.contentid.toString())
        .get()
        .then((res) => {
              if (res.docs.isNotEmpty)
                {
                  heartcheck = true,
                }
            });

    return FutureBuilder<DetailFestival>(
        future: futureDetailFestival,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('hasData');
            DetailFestival detailfestival_modal = snapshot.data!;

            return Scaffold(
                body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  elevation: 0.0,
                  expandedHeight: 300.0,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.redAccent,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      widget.title, //축제 이름마다 변경
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    titlePadding: EdgeInsetsDirectional.only(
                      start: 32,
                      bottom: 16,
                    ),
                    background: Image.network(widget.firstimage,
                        fit: BoxFit.contain), //축제 사진맘다 변경
                  ),
                ),
                SliverToBoxAdapter(
                    child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: isWeb ? size.width * 0.005 : 0,
                          ),
                          SizedBox(
                            width:
                                isWeb ? size.width * 0.35 : size.width * 0.75,
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          FavoriteButton(
                            isFavorite: heartcheck ? true : false,
                            valueChanged: (isFavorite) async {
                              print("Is Favorite : $isFavorite");
                              //로그인하면 자동으로 생김 최종 때 무조건 주석 풀어야함
                              //String curuser = fing_db_user[0].name;
                              //좋아요
                              if (isFavorite) {
                                //최종때 밑에꺼 없애줘
                                String curuser = fing_db_user[0].email;
                                ;
                                await FirebaseFirestore.instance
                                    .collection('User')
                                    .doc(curuser)
                                    .collection("MyFavorite")
                                    .doc(widget.title)
                                    .set({
                                  "firstimage": widget.firstimage,
                                  "title": widget.title,
                                  "addr1": widget.addr1,
                                  "contentid": widget.contentid,
                                  "eventstartdate":
                                      detailfestival_modal.eventstartdate,
                                  "eventenddate":
                                      detailfestival_modal.eventenddate,
                                  "mapx": widget.mapx,
                                  "mapy": widget.mapy,
                                  //string으로 바꿔서 보내기
                                }, SetOptions(merge: true));
                              }
                              //안좋아요
                              else {
                                //최종때 밑에꺼 없애줘
                                String curuser = fing_db_user[0].email;
                                ;
                                await FirebaseFirestore.instance
                                    .collection('User')
                                    .doc(curuser)
                                    .collection("MyFavorite")
                                    .doc(widget.title)
                                    .delete();
                              }
                            },
                            iconSize: 40,
                          ),
                          SizedBox(width: isWeb ? size.width * 0.005 : 0),
                        ],
                      ),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 0.7,
                      ),
                    ],
                  ),
                )),
                SliverToBoxAdapter(
                    child: Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              children: [
                                SizedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.play_arrow,
                                        size: 16.0,
                                        color: const Color(0xffff7e00),
                                      ),
                                      Container(
                                        width: isWeb
                                            ? size.width * 0.1
                                            : size.width * 0.27,
                                        child: Text(
                                          ' 이용요금',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 112, 112, 112)),
                                        ),
                                      ),
                                      Container(
                                        width: isWeb
                                            ? size.width * 0.2
                                            : size.width * 0.6,
                                        child: Text(
                                          detailfestival_modal.usetimefestival
                                              .toString()
                                              .replaceAll('<br>', ' '),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.play_arrow,
                                      size: 16.0,
                                      color: const Color(0xffff7e00),
                                    ),
                                    Container(
                                      width: isWeb
                                          ? size.width * 0.1
                                          : size.width * 0.27,
                                      child: Text(
                                        ' 개요',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                255, 112, 112, 112)),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: isWeb
                                      ? size.width * 0.3
                                      : size.width * 0.6,
                                  child: Text(
                                    detailfestival_modal.infotext
                                        .toString()
                                        .replaceAll('<br>', ' '),
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  size: 16.0,
                                  color: const Color(0xffff7e00),
                                ),
                                Container(
                                  width: isWeb
                                      ? size.width * 0.1
                                      : size.width * 0.27,
                                  child: Text(
                                    ' 주소',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 112, 112, 112)),
                                  ),
                                ),
                                Container(
                                  width: isWeb
                                      ? size.width * 0.2
                                      : size.width * 0.6,
                                  child: Text(
                                    widget.addr1,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  size: 16.0,
                                  color: const Color(0xffff7e00),
                                ),
                                Container(
                                  width: isWeb
                                      ? size.width * 0.1
                                      : size.width * 0.27,
                                  child: Text(
                                    ' 행사 장소',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 112, 112, 112)),
                                  ),
                                ),
                                Container(
                                  width: isWeb
                                      ? size.width * 0.2
                                      : size.width * 0.6,
                                  child: Text(
                                    detailfestival_modal.eventplace.toString(),
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  size: 16.0,
                                  color: const Color(0xffff7e00),
                                ),
                                Container(
                                  width: isWeb
                                      ? size.width * 0.1
                                      : size.width * 0.27,
                                  child: Text(
                                    ' 행사 시작일',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 112, 112, 112)),
                                  ),
                                ),
                                Container(
                                  width: isWeb
                                      ? size.width * 0.2
                                      : size.width * 0.6,
                                  child: Text(
                                    strToDate(
                                        detailfestival_modal.eventstartdate),
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  size: 16.0,
                                  color: const Color(0xffff7e00),
                                ),
                                Container(
                                  width: isWeb
                                      ? size.width * 0.1
                                      : size.width * 0.27,
                                  child: Text(
                                    ' 행사 종료일',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 112, 112, 112)),
                                  ),
                                ),
                                Container(
                                  width: isWeb
                                      ? size.width * 0.2
                                      : size.width * 0.6,
                                  child: Text(
                                    strToDate(
                                        detailfestival_modal.eventenddate),
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 0.7,
                      ),
                      Container(
                        child: TabBar(
                            controller: _TabController,
                            labelColor: Color(0xffff7e00),
                            unselectedLabelColor: Colors.black,
                            indicatorColor: Color(0xffff7e00),
                            tabs: [
                              Tab(text: '숙소', icon: Icon(Icons.hotel_rounded)),
                              Tab(
                                  text: '맛집',
                                  icon: Icon(Icons.restaurant_rounded)),
                              Tab(
                                  text: '전통시장',
                                  icon: Icon(Icons.storefront_rounded)),
                            ]),
                      ),
                    ],
                  ),
                )),
                SliverToBoxAdapter(
                  child: Container(
                    height: size.height * 0.6,
                    margin: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TabBarView(
                      controller: _TabController,
                      children: <Widget>[
                        PlaceList(
                            type: 1,
                            contentId: widget.contentid,
                            firstimage: widget.firstimage,
                            mapX: widget.mapx,
                            mapY: widget.mapy),
                        PlaceList(
                            type: 2,
                            contentId: widget.contentid,
                            firstimage: widget.firstimage,
                            mapX: widget.mapx,
                            mapY: widget.mapy),
                        MarketList(reg1: reg1, reg2: reg2)
                      ],
                    ),
                  ),
                  // )
                ),
              ],
            ));
          } else if (snapshot.hasError) {
            return Text('error ${snapshot.error}');
          }
          return Center(child: CupertinoActivityIndicator());
        });
  }
}

class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  final dropdownList = ['거리순', '조회순'];
  var selectedDropdown = '거리순';

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: selectedDropdown,
        items: dropdownList.map(
          (value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          },
        ).toList(),
        onChanged: (value) {
          setState(() {
            selectedDropdown = value.toString();
          });
        });
  }
}

// 탭 누르면 숙소,맛집 리스트뷰
class PlaceList extends StatefulWidget {
  const PlaceList(
      {Key? key,
      required this.type,
      required this.contentId,
      required this.firstimage,
      required this.mapX,
      required this.mapY})
      : super(key: key);
  final type;
  final contentId;
  final firstimage;
  final mapX;
  final mapY;

  @override
  State<PlaceList> createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  late Future<List<local.LocationBasedList>> futureHotel;
  late Future<List<local.LocationBasedList>> futureRestaurant;

  @override
  void initState() {
    super.initState();
    // 기본 정렬 E (거리순), 일단 10km (10000)
    if (widget.type == 1) {
      futureHotel = local.fetchLocationBasedList(
          arrange: "E",
          contentTypeId: "32",
          mapX: widget.mapX,
          mapY: widget.mapY,
          radius: "10000");
    } else {
      futureRestaurant = local.fetchLocationBasedList(
          arrange: "E",
          contentTypeId: "39",
          mapX: widget.mapX,
          mapY: widget.mapY,
          radius: "10000");
    }
  }

  Widget build(BuildContext context) {
    return
        // Column(
        //   children: [
        //     Align(
        //       alignment: Alignment.topRight,
        //       child: DropDown(),
        //     ),
        FutureBuilder<List<local.LocationBasedList>>(
            future: widget.type == 1 ? futureHotel : futureRestaurant,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if ((snapshot.data![0].response) == null) {
                  return widget.type == 1
                      ? Center(
                          child: Text('해당 페스티벌 근방 10km 이내에 숙소 정보가 존재하지 않습니다.'))
                      : Center(
                          child: Text("해당 페스티벌 근방 10km 이내에 맛집 정보가 존재하지 않습니다."));
                }
                List<local.Item> festivallocation_model =
                    snapshot.data![0].response!.body!.items!.item!;
                return Container(
                  margin: EdgeInsets.all(5),
                  child: ListView.builder(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: festivallocation_model.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListItem(item: festivallocation_model[index]);
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('error${snapshot.error}');
              }
              return Center(child: CupertinoActivityIndicator());
            });
    // ],
    // );
  }
}

class ListItem extends StatefulWidget {
  const ListItem({Key? key, required this.item}) : super(key: key);
  final item;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var mobileWidth = 700;
    bool isWeb = true;
    size.width > mobileWidth ? isWeb = true : isWeb = false;
    return InkWell(
      onTap: () async {
        bool result = await NaviApi.instance.isKakaoNaviInstalled();
        var title = widget.item.title;
        var lat = widget.item.mapy;
        var long = widget.item.mapx;
        if (result) {
          await NaviApi.instance.shareDestination(
              destination: Location(name: title, x: '$long', y: '$lat'),
              option: NaviOption(
                  coordType: CoordType.wgs84,
                  vehicleType: VehicleType.second,
                  rpOption: RpOption.recommended));
        } else {
          launchBrowserTab(Uri.parse(NaviApi.webNaviInstall));
        }
      },
      child: Container(
        // padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    padding: EdgeInsets.only(top: 10),
                    width: isWeb ? size.width * 0.1 : size.width * 0.22,
                    height: size.height * 0.15,
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      imageUrl: widget.item.firstimage,
                      errorWidget: ((context, url, error) => Image(
                          image: AssetImage('assets/images/DefaultImage.png'))),
                      fit: BoxFit.contain,
                    )),
                Container(
                  width: isWeb ? size.width * 0.2 : size.width * 0.6,
                  padding: EdgeInsets.only(left: 15, right: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            widget.item.title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(widget.item.addr1,
                              style: TextStyle(fontSize: 16))),
                    ],
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            Divider(
              thickness: 1,
              color: Color.fromARGB(102, 192, 190, 190),
            ),
          ],
        ),
      ),
    );
  }
}

// 전통시장리스트뷰
class MarketList extends StatefulWidget {
  MarketList({Key? key, required this.reg1, required this.reg2})
      : super(key: key);
  final reg1;
  final reg2;

  @override
  State<MarketList> createState() => _MarketListState();
}

class _MarketListState extends State<MarketList> {
  late Future<List> futuremarket;

  @override
  void initState() {
    super.initState();
    futuremarket = readdata(widget.reg1, widget.reg2);
  }

  Widget build(BuildContext context) {
    print("시장들어옴ㅁㅁ");
    print(widget.reg1 + widget.reg2);
    return FutureBuilder<List>(
        future: futuremarket,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            print("들어왔어용");
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text('해당 페스티벌 근방 10km 이내에 전통시장 정보가 존재하지 않습니다.'),
              );
            }
            print(snapshot.data![0]);
            print("시장갯수 ${snapshot.data!.length}");
            return Container(
                child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return MarketItem(item: snapshot.data![index]);
              },
            ));
          } else if (snapshot.hasError) {
            return Text('error응앵${snapshot.error}');
          }
          return Center();
        }));
  }
}

class MarketItem extends StatefulWidget {
  const MarketItem({Key? key, required this.item}) : super(key: key);
  final item;

  @override
  State<MarketItem> createState() => _MarketItemState();
}

class _MarketItemState extends State<MarketItem> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var mobileWidth = 700;
    bool isWeb = true;
    size.width > mobileWidth ? isWeb = true : isWeb = false;
    print("마켓아이템");
    print(widget.item);
    return InkWell(
      onTap: () async {
        bool result = await NaviApi.instance.isKakaoNaviInstalled();
        var title = "어디로 갈까";
        var lat = widget.item.mapy;
        var long = widget.item.mapx;
        if (result) {
          await NaviApi.instance.shareDestination(
              destination: Location(name: title, x: '$long', y: '$lat'),
              option: NaviOption(
                  coordType: CoordType.wgs84,
                  vehicleType: VehicleType.second,
                  rpOption: RpOption.recommended));
        } else {
          launchBrowserTab(Uri.parse(NaviApi.webNaviInstall));
        }
      },
      child: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.verified_rounded,
                    size: 18.0,
                    color: const Color(0xffff7e00),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Container(
                    width: isWeb ? size.width * 0.2 : size.width * 0.6,
                    child: Text(
                      widget.item.mrktNm,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: isWeb ? size.width * 0.1 : size.width * 0.35,
                    padding: EdgeInsets.only(top: 7, left: 10),
                    child: Text(
                      ' 도로명주소',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 112, 112, 112)),
                    ),
                  ),
                  Container(
                    width: isWeb ? size.width * 0.1 : size.width * 0.53,
                    padding: EdgeInsets.only(top: 7),
                    child: Container(
                      child: Text(
                        widget.item.rdnmadr,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // padding: const EdgeInsets.all(3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: isWeb ? size.width * 0.1 : size.width * 0.35,
                    padding: EdgeInsets.only(top: 7, left: 10),
                    child: Text(
                      ' 개설주기',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 112, 112, 112)),
                    ),
                  ),
                  Container(
                    width: isWeb ? size.width * 0.1 : size.width * 0.53,
                    padding: EdgeInsets.only(top: 7, right: 3),
                    child: Text(
                      widget.item.mrktEstblCycle,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: isWeb ? size.width * 0.1 : size.width * 0.35,
                    padding: EdgeInsets.only(top: 7, left: 10),
                    child: Text(
                      ' 주차장여부',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 112, 112, 112)),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 7, right: 3),
                      child: ChgIcon(widget.item.prkplcYn.toString())),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            Divider(
              thickness: 1,
              color: Color.fromARGB(102, 192, 190, 190),
            ),
          ],
        ),
      ),
    );
  }
}

//전통시장모델
class MarketModel {
  const MarketModel(
      this.mrktNm, this.rdnmadr, this.mrktEstblCycle, this.prkplcYn);
  final String mrktNm; //시장이름
  final String rdnmadr; //소재지도로명주소
  final String mrktEstblCycle; //시장개설주기
  final String prkplcYn; //주차장보유여부y,n
}

Widget ChgIcon(yn) {
  print(yn);
  if (yn == "Y") {
    return (Icon(Icons.check_circle_outline_outlined,
        size: 17.0, color: Color.fromARGB(255, 0, 191, 25)));
  } else {
    return (Icon(Icons.cancel_outlined,
        size: 17.0, color: Color.fromARGB(255, 254, 57, 46)));
  }
}

// 전통시장 Firebase
Future<List> readdata(String reg1, String reg2) async {
  if (reg1.contains("서울")) {
    reg1 = "서울";
  }
  if (reg1.contains("대구")) {
    reg1 = "대구";
  }
  if (reg1.contains("광주")) {
    reg1 = "광주";
  }
  if (reg1.contains("대전")) {
    reg1 = "대전";
  }
  if (reg1.contains("인천")) {
    reg1 = "인천";
  }
  if (reg1.contains("울산")) {
    reg1 = "울산";
  }
  if (reg1.contains("부산")) {
    reg1 = "부산";
  }
  if (reg1.contains("세종")) {
    reg1 = "세종특별자치시";
    reg2 = "세종특별자치시";
  }
  if (reg1.contains("제주")) {
    reg1 = "제주도";
  }

  List marketitem = [
    // {"mrktNm": "", "rdnmadr": "", "mrktEstblCycle": "", "prkplcYn": ""}
  ];

  final usercol = FirebaseFirestore.instance
      .collection("전통시장")
      .doc('$reg1')
      .collection('$reg2');

  await usercol.get().then((value) => {
        for (int i = 0; i < value.docs.length; i++)
          {
            marketitem.add(MarketModel(
                "${value.docs[i].data()['mrktNm']}",
                "${value.docs[i].data()['rdnmadr']}",
                "${value.docs[i].data()['mrktEstblCycle']}",
                "${value.docs[i].data()['prkplcYn']}"))
          },
      });
  return marketitem;
}

// API
Future<DetailFestival> fetchDetailFestival({required String contentId}) async {
  List introfestival = await intro.fetchDetailIntro(contentId: contentId);
  List infofestival = await info.fetchDetailInfo(contentId: contentId);

  return DetailFestival(
      infofestival[0].response.body.items.item[0].infotext,
      introfestival[0].response.body.items.item[0].eventstartdate,
      introfestival[0].response.body.items.item[0].eventenddate,
      introfestival[0].response.body.items.item[0].usetimefestival,
      introfestival[0].response.body.items.item[0].eventplace);
}

class DetailFestival {
  String? infotext;
  String? eventstartdate;
  String? eventenddate;
  String? usetimefestival;
  String? eventplace;

  DetailFestival(
      String this.infotext,
      String this.eventstartdate,
      String this.eventenddate,
      String this.usetimefestival,
      String this.eventplace);
}

// 날짜형식변환
String strToDate(eventenddate) {
  var date = DateTime.parse(eventenddate).toString().split(' ');
  return date[0];
}
