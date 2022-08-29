import 'package:fing/MainPage/mainpage.dart';
import 'package:fing/Mypage/mypage.dart';
import 'package:flutter/material.dart';
import 'Map/map.dart';
import 'LikedPage/likedpage.dart';
import 'package:fing/login/intro_page.dart';
import 'Mypage/mypage.dart';
import 'NearFestivalPage/nearfestival.dart';

void main() {
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(flex: 2, child: FestivalSearch()),
          Text('임시')
          // Expanded(flex: 8, child: MainTopBottom())
        ],
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: BottomMenu(),
      // ),
    ); // TODO: implement build
  }
}

class _RootState extends State<Root> {
  int _currentIndex = 0;
  final _pages = [
    MainTopBottom(),
    AddressMap(),
    NearFestival(),
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
    return WillPopScope(
      onWillPop: () async {
        return !(await _navigatorKeyList[_currentIndex]
            .currentState!
            .maybePop());
      },
      child: Scaffold(
        body: Column(
          children: [
            Flexible(flex: 1, fit: FlexFit.tight, child: FestivalSearch()),
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
              _currentIndex = index;
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

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
      child: const Text('Setting'),
      // onPressed: () => Navigator.pushNamed(context, '/second'),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SearchList()));
      },
    ));
  }
}

class FestivalSearch extends StatelessWidget {
  const FestivalSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey,
        width: 2.0,
      ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: logo()), //여기에 로고 들어감
          Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                        child: Text(
                          '페스티벌을 검색하세요',
                          style: TextStyle(color: Colors.grey),
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
    'images/mark.jpg',
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
                    return option.contains(textEditingValue.text.toLowerCase());
                  }).toList();
                });
                return searchResult;
              },
              onSelected: (String selection) {
                debugPrint('You just selected $selection');
              },
            )),
        body: searchResult == null
            ? Container()
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: searchResult.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                      onTap: (() {}),
                      child: Container(
                        height: 50,
                        child: Text(searchResult[index]),
                      ));
                })));
  }
}

AppBar searchPageHeader() {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.grey),
    backgroundColor: Colors.white,
    title: TextFormField(
      decoration: InputDecoration(
          hintText: '페스티벌을 검색하세요',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          filled: true,
          prefixIcon: Icon(Icons.search, color: Colors.grey, size: 30),
          suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.grey,
              ),
              onPressed: null)),
      style: TextStyle(fontSize: 18, color: Colors.white),
      // 검색어 입력후 DB에서 일치하는 결과값 가져올것
      onFieldSubmitted: null,
    ),
  );
}

