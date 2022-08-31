import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:kakao_flutter_sdk_navi/kakao_flutter_sdk_navi.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

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
                    valueChanged: (_isFavorite) {
                      print("Is Favorite : $_isFavorite");
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
          fillOverscroll: false,
          hasScrollBody: false,
          child: Container(
            height: size.height,
            margin: EdgeInsets.only(left: 16.0, right: 16.0),
            child: TabBarView(
              controller: _TabController,
              children: <Widget>[
                PlaceList(type: 1),
                PlaceList(type: 2),
                MarketList()
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

class MarketList extends StatelessWidget {
  const MarketList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: listitem.length,
          itemBuilder: (BuildContext context, int index) {
            return MarketItem(item: marketitem[index]);
          },
        ));
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
    return Container(
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

final marketitem = [
  MarketModel(
    "신림중앙시장",
    "서울특별시 관악구 조원로16길",
    "매일",
    "Y",
  ),
  MarketModel(
    "용인중앙시장",
    "경기도 용인시 처인구 금령로99번길 9",
    "매일, 5일+10일",
    "N",
  ),
  MarketModel(
    "월야5일시장",
    "전라남도 함평군 월야면 밀재로 1504-5",
    "매 5일, 0일",
    "Y",
  ),
];

Widget ChgIcon(String yn) {
  if (yn == "Y") {
    return (Icon(Icons.check_circle_outline_outlined,
        size: 17.0, color: Color.fromARGB(255, 0, 191, 25)));
  } else {
    return (Icon(Icons.cancel_outlined,
        size: 17.0, color: Color.fromARGB(255, 254, 57, 46)));
  }
}
