import 'dart:io';
import 'dart:typed_data';

import 'package:fing/MainPage/mainpage.dart';
import 'package:fing/Mypage/mypage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'LikedPage/likedpage.dart';
import 'package:fing/login/intro_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'NearFestivalPage/nearfestival.dart';
import 'firebase_options.dart';
import 'Region/RegionPage.dart';
import 'Map/mylocation.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey: 'a0f1222696827f5577c696088787bc1f');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform
      //DefaultFirebaseOptions.currentPlatform,
      );
  HttpOverrides.global = new MyHttpOverrides();
  // WidgetsFlutterBinding.ensureInitialized();

  // ByteData data =
  //     await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FING",
      initialRoute: '/',
      debugShowMaterialGrid: false,
      routes: {
        '/': (context) => Intro(),
      },
    );
  }
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _currentIndex = 0;
  final _pages = [
    MainTopBottom(),
    RegionPageMain(),
    MyLocation(),
    LikedPage(),
    MyPageMain()
  ];

  late List<GlobalKey<NavigatorState>> _navigatorKeyList;

  static get data => null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatorKeyList =
        List.generate(_pages.length, (index) => GlobalKey<NavigatorState>());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
        // return !(await _navigatorKeyList[_currentIndex]
        //     .currentState!
        //     .maybePop());
      },
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: _currentIndex == 2 ? statusBarHeight : 0,
            ),
            (_currentIndex == 0
                ? Container(
                    margin: EdgeInsets.fromLTRB(0, statusBarHeight + 10, 0, 10),
                    height: size.height * 0.065,
                    constraints: BoxConstraints(minHeight: 50),
                    child: FestivalSearch())
                : Container()),
            Expanded(
              flex: 8,
              child: IndexedStack(
                index: _currentIndex,
                children: _pages.map((page) {
                  int index = _pages.indexOf(page);
                  return Navigator(
                    key: _navigatorKeyList[index],
                    onGenerateRoute: (_) {
                      return MaterialPageRoute(builder: (context) => page);
                    },
                  );
                }).toList(),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              if (index == 0) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Root()));
              } else {
                _currentIndex = index;
              }
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.place_outlined,
              ),
              label: '지역',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.map_outlined,
              ),
              label: '내주변',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline,
              ),
              label: '찜',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
              ),
              label: '마이페이지',
            ),
          ],
          unselectedItemColor: Colors.black,
          selectedItemColor: Color.fromRGBO(255, 126, 0, 1),
          unselectedLabelStyle: TextStyle(color: Colors.black),
          selectedLabelStyle: TextStyle(color: Color.fromRGBO(255, 126, 0, 1)),
        ),
      ),
    );
  }
}

class FestivalSearch extends StatelessWidget {
  const FestivalSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey,
        width: 2.0,
      ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Root()));
                  },
                  child: logo())), //여기에 로고 들어감
          Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 0,
                        blurRadius: 2,
                        offset: Offset(0, 7), // changes position of shadow
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchList()));
                        },
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            '페스티벌을 검색하세요',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )),
                    Icon(
                      Icons.search,
                      color: Color.fromRGBO(255, 126, 0, 1.0),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

Widget logo() {
  return Image.asset(
    'assets/images/FingLogo.png',
  );
}

class SearchList extends StatefulWidget {
  SearchList({Key? key}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  bool flag = true;
  static const List<String> festList = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  var searchResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.grey),
            backgroundColor: Colors.white,
            title: Autocomplete<String>(
              optionsMaxHeight: 0,
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                setState(() {
                  searchResult = festList.where((String option) {
                    return option.contains(textEditingValue.text);
                  }).toList();
                });
                return searchResult;
              },
              onSelected: (String selection) {
                debugPrint('You just selected $selection');
              },
            )),
        body: searchResult == null
            ? Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_outlined,
                        size: 25,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '페스티벌을 검색하세요',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      )
                    ]),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: searchResult.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                      onTap: (() {}),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        margin: EdgeInsets.fromLTRB(20, 5, 30, 5),
                        height: 50,
                        alignment: Alignment(-1.0, 0.0),
                        // decoration: BoxDecoration(
                        //     border: Border(
                        //   bottom: BorderSide(
                        //       color: Color.fromARGB(255, 129, 129, 129),
                        //       width: 1),
                        // )),
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                )),
                            Text(
                              searchResult[index],
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ));
                })));
  }
}
