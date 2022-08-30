import 'package:flutter/material.dart';
import '../API/areacode.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const RegionPageMain());
}

class RegionPageMain extends StatelessWidget {
  const RegionPageMain({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FING",
      initialRoute: '/',
      routes: {
        '/': (context) => RegionPage(),
      },
    );
  }
}

class RegionPage extends StatefulWidget {
  const RegionPage({Key? key}) : super(key: key);

  @override
  State<RegionPage> createState() => _RegionPageState();
}

class _RegionPageState extends State<RegionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '지역',
          style: TextStyle(
            fontSize: 18.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false, //뒤로가기버튼없애기
        leading: null,
        backgroundColor: Colors.white,
        elevation: 1.0, // 그림자 제거
        toolbarHeight: 50.0,
      ),
      body: Region(),
    );
  }
}

class Region extends StatefulWidget {
  const Region({Key? key}) : super(key: key);

  @override
  State<Region> createState() => _RegionState();
}

class _RegionState extends State<Region> {
  late Future<List<AreaCode>> futureAreaCode;
  late Future<List<AreaCode>> futureAreaDeatilCode;
  var code = "1";

  @override
  void initState() {
    super.initState();
    futureAreaCode = fetchAreaCode(
      areaCode: "",
    );
    futureAreaDeatilCode = fetchAreaCode(
      areaCode: code,
    );
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<List<AreaCode>>(
              future: futureAreaCode,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print('hasData');

                  List<Item> areacode_model =
                      snapshot.data![0].response!.body!.items!.item!;
                  print(areacode_model.length);

                  return Container(
                    color: Colors.grey[100],
                    width: screen.width * 0.35,
                    padding: EdgeInsets.fromLTRB(
                        screen.width * 0.03, 0, screen.width * 0.03, 0),
                    child: ListView.builder(
                      itemCount: areacode_model.length,
                      itemBuilder: (BuildContext context, index) => InkWell(
                        onTap: () => {
                          setState(() {
                            if (code == areacode_model[index].code) {
                              print(areacode_model[index].name);
                            } else {
                              print(areacode_model[index].name);
                              code = areacode_model[index].code.toString();
                              print(areacode_model[index].code);
                            }
                          }),
                        },
                        child: Container(
                          width: double.infinity,
                          height: screen.height * 0.07,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ))),
                          child: Center(
                            child: Text(areacode_model[index].name.toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700]),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  print('error');
                  print(snapshot.error);
                  return Text('error${snapshot.error}');
                }
                return Center(child: CupertinoActivityIndicator());
              },
            ),
            // 세부 리스트
            FutureBuilder<List<AreaCode>>(
                future: fetchAreaCode(
                  areaCode: code,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print('hasData');

                    List<Item> areadetailcode_model =
                        snapshot.data![0].response!.body!.items!.item!;
                    print(areadetailcode_model.length);

                    return Container(
                      color: Colors.white,
                      width: screen.width * 0.65,
                      padding: EdgeInsets.fromLTRB(
                          screen.width * 0.05, 0, screen.width * 0.05, 0),
                      child: ListView.builder(
                        itemCount: areadetailcode_model.length,
                        itemBuilder: (BuildContext context, index) => InkWell(
                          // 세부지역의 페스티벌 띄우기
                          onTap: () => {
                            print(areadetailcode_model[index].code),
                          },
                          child: Container(
                              width: double.infinity,
                              height: screen.height * 0.07,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    areadetailcode_model[index].name.toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    print('error');
                    print(snapshot.error);
                    return Text('error${snapshot.error}');
                  }
                  return Center(child: CupertinoActivityIndicator());
                }),
          ],
        ));
  }
}
