import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:kakao_flutter_sdk_navi/kakao_flutter_sdk_navi.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fing/Firebase/fing_db.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {Key? key,
      required this.firstimage,
      required this.title,
      required this.addr1,
      required this.contentid})
      : super(key: key);
  final firstimage;
  final title;
  final addr1;

  final contentid;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class favorite_Model {
  Uri? favorite_image;
  String? title;
  String? address;

  favorite_Model({this.favorite_image, this.title, this.address});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['favorite_image'] = favorite_image;
    map['title'] = title;
    map['address'] = address;
    return map;
  }
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  late TabController _TabController;
  // ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _TabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final regionText = widget.addr1.toString();
    final region1 = regionText.split(" ")[0];
    final region2 = regionText.split(" ")[1];
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
                  Container(
                    width: size.width * 0.75,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  FavoriteButton(
                    isFavorite: true,
                    valueChanged: (_isFavorite) async {
                      print("Is Favorite : $_isFavorite");
                      //로그인하면 자동으로 생김 최종 때 무조건 주석 풀어야함
                      //String curuser = fing_db_user[0].name;
                      //좋아요
                      if (_isFavorite == true) {
                        //최종때 밑에꺼 없애줘
                        String curuser = "wjdtpdus828@naver.com";
                        await FirebaseFirestore.instance
                            .collection('User')
                            .doc(curuser)
                            .collection("MyFavorite")
                            .doc(widget.title)
                            .set({
                          "favorite_image": widget.firstimage,
                          "title": widget.title,
                          "address": widget.addr1
                        }, SetOptions(merge: true));
                      }
                      //안좋아요
                      else {
                        //최종때 밑에꺼 없애줘
                        String curuser = "wjdtpdus828@naver.com";
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
          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          width: size.width * 0.25,
                          child: Text(
                            ' 이용요금',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 112, 112, 112)),
                          ),
                        ),
                        Container(
                          width: size.width * 0.6,
                          child: Text(
                            '일부 프로그램 유료',
                            style: TextStyle(fontSize: 16, color: Colors.black),
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
                              width: size.width * 0.25,
                              child: Text(
                                ' 개요',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 112, 112, 112)),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: size.width * 0.6,
                          child: Text(
                            '2020·2021 문화관광축제 선정, 정조대왕의 효심과 부국강병의 꿈을 바탕으로 축성된 수원화성에서 매년 펼쳐지는 역사 깊은 문화관광축제 ‘수원화성문화제’이다. 2022년 <제59회 수원화성문화제>는 <세계유산축전 수원화성>과 함께하여 더욱 뜻깊고 다채로운 프로그램으로 시민 곁에 다가간다. 수원화성의 이야기들을 보고, 듣고, 체험할 수 있으며, 역사적 정취가 깃든 장소에서 다양한 문화예술 콘텐츠를 함께 즐길 수 있다.',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
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
                          width: size.width * 0.25,
                          child: Text(
                            ' 주소',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 112, 112, 112)),
                          ),
                        ),
                        Container(
                          width: size.width * 0.6,
                          child: Text(
                            widget.addr1,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
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
                          width: size.width * 0.25,
                          child: Text(
                            ' 행사 장소',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 112, 112, 112)),
                          ),
                        ),
                        Container(
                          width: size.width * 0.6,
                          child: Text(
                            '화성행궁 및 행궁광장 등',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
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
                          width: size.width * 0.25,
                          child: Text(
                            ' 행사 시작일',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 112, 112, 112)),
                          ),
                        ),
                        Container(
                          width: size.width * 0.6,
                          child: Text(
                            '2022.10.07',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
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
                          width: size.width * 0.25,
                          child: Text(
                            ' 행사 종료일',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 112, 112, 112)),
                          ),
                        ),
                        Container(
                          width: size.width * 0.6,
                          child: Text(
                            '2022.10.09',
                            style: TextStyle(fontSize: 16, color: Colors.black),
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
                      Tab(text: '맛집', icon: Icon(Icons.restaurant_rounded)),
                      Tab(text: '전통시장', icon: Icon(Icons.storefront_rounded)),
                    ]),
              ),
              Align(
                alignment: Alignment.topRight,
                child: DropDown(),
              ),
            ],
          ),
        )),
        SliverFillRemaining(
          fillOverscroll: true,
          hasScrollBody: true,
          child: Container(
            height: double.infinity,
            margin: EdgeInsets.only(left: 16.0, right: 16.0),
            child: TabBarView(
              controller: _TabController,
              children: <Widget>[
                PlaceList(type: 1),
                PlaceList(type: 2),
                MarketList(reg1: region1, reg2: region2)
              ],
            ),
          ),
          // )
        ),
      ],
    ));
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

class PlaceList extends StatelessWidget {
  const PlaceList({Key? key, required this.type}) : super(key: key);
  final type;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: listitem.length,
        itemBuilder: (BuildContext context, int index) {
          return ListItem(item: type == 1 ? listitem[index] : listitem2[index]);
        },
      ),
    );
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
    return InkWell(
      onTap: () async {
        bool result = await NaviApi.instance.isKakaoNaviInstalled();
        var title = "어디로 갈까";
        var lat = '36.6617';
        var long = '127.539913';
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
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    width: size.width * 0.2,
                    height: size.height * 0.1,
                    child: Image.asset(widget.item.img, fit: BoxFit.fill)),
                Container(
                  width: size.width * 0.6,
                  padding: EdgeInsets.only(left: 15, right: 10),
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
                          child: Text(widget.item.location,
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
    print(widget.reg1 + widget.reg2);
    return FutureBuilder<List>(
        future: futuremarket,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            print("들어왔어용");
            print(snapshot.data![0]);
            print(snapshot.data!.length);
            return Container(
                margin: EdgeInsets.all(5),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MarketItem(item: snapshot.data![index]);
                  },
                ));
          } else if (snapshot.hasError) {
            return Text('error');
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
    print("마켓아이템");
    print(widget.item);
    print(widget.item.mrktNm);
    print("dlkfjslkdjf");
    return InkWell(
      onTap: () async {
        bool result = await NaviApi.instance.isKakaoNaviInstalled();
        var title = "어디로 갈까";
        var lat = '36.6617';
        var long = '127.539913';
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
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.verified_rounded,
                    //Icons.workspace_premium_rounded,
                    size: 18.0,
                    color: const Color(0xffff7e00),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Container(
                    width: size.width * 0.6,
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
            Padding(
              padding: const EdgeInsets.all(3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.2,
                    child: Text(
                      ' 도로명주소',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 112, 112, 112)),
                    ),
                  ),
                  Container(
                    width: size.width * 0.6,
                    child: Text(
                      widget.item.rdnmadr,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.2,
                    child: Text(
                      ' 개설주기',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 112, 112, 112)),
                    ),
                  ),
                  Container(
                    width: size.width * 0.6,
                    child: Text(
                      widget.item.mrktEstblCycle,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.2,
                    child: Text(
                      ' 주차장여부',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 112, 112, 112)),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 3),
                      child: ChgIcon(widget.item.prkplceYn)),
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

//맛집, 숙소 같이 쓰는 모델
class ItemModel {
  const ItemModel(this.img, this.title, this.location);
  final String img;
  final String title;
  final String location;
}

//숙소 Item
final listitem = [
  ItemModel(
    "assets/images/waterbomb1.png",
    "2022 워터밤 대구",
    "대구광역시 대구스타디움",
  ),
  ItemModel(
    "assets/images/waterbomb1.png",
    "2022 워터밤 대구",
    "대구광역시 대구스타디움",
  ),
  ItemModel(
    "assets/images/waterbomb1.png",
    "2022 워터밤 대구",
    "대구광역시 대구스타디움",
  ),
];

//맛집 Item
final listitem2 = [
  ItemModel(
    "assets/images/waterbomb1.png",
    "202222 워터밤 대구",
    "대구광역시 대구스타디움",
  ),
  ItemModel(
    "assets/images/waterbomb1.png",
    "2022222 워터밤 대구",
    "대구광역시 대구스타디움",
  ),
  ItemModel(
    "assets/images/waterbomb1.png",
    "2022222 워터밤 대구",
    "대구광역시 대구스타디움",
  ),
  ItemModel(
    "assets/images/waterbomb1.png",
    "2022222 워터밤 대구",
    "대구광역시 대구스타디움",
  ),
];

//전통시장모델
class MarketModel {
  const MarketModel(
      this.mrktNm, this.rdnmadr, this.mrktEstblCycle, this.prkplceYn);
  final String mrktNm; //시장이름
  final String rdnmadr; //소재지도로명주소
  final String mrktEstblCycle; //시장개설주기
  final String prkplceYn; //주차장보유여부y,n
}

List marketitem = [];

Widget ChgIcon(String yn) {
  print(yn);
  if (yn == "Y") {
    return (Icon(Icons.check_circle_outline_outlined,
        size: 17.0, color: Color.fromARGB(255, 0, 191, 25)));
  } else {
    return (Icon(Icons.cancel_outlined,
        size: 17.0, color: Color.fromARGB(255, 254, 57, 46)));
  }
}

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
                "${value.docs[i].data()['prkplceYn']}"))
          },
      });
  for (int j = 0; j < 48; j++) {
    print("응애 ${marketitem[j].mrktNm}");
  }
  return marketitem;
}
