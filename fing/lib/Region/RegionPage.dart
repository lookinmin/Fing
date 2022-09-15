import 'package:flutter/material.dart';
import '../API/areacode.dart';
import 'package:flutter/cupertino.dart';

import '../FestivalPage/festivalist.dart';

// void main() {
//   runApp(const RegionPageMain());
// }

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

  String regionName = "서울";
  String cityName = "강남구";
  String regionCode = "1";
  String cityCode = "1";

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
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //도
            futureBuilderRegion(screen),
            //도시
            futureBuilderCity(screen),
          ],
        ));
  }

  FutureBuilder<List<AreaCode>> futureBuilderRegion(Size screen) {
    return FutureBuilder<List<AreaCode>>(
      future: futureAreaCode,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Item> areacode_model =
              snapshot.data![0].response!.body!.items!.item!;
          return region(screen, areacode_model);
        } else if (snapshot.hasError) {
          return Text('error${snapshot.error}');
        }
        return Center(child: CupertinoActivityIndicator());
      },
    );
  }

  FutureBuilder<List<AreaCode>> futureBuilderCity(Size screen) {
    return FutureBuilder<List<AreaCode>>(
        future: fetchAreaCode(
          areaCode: code,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Item> areadetailcode_model =
                snapshot.data![0].response!.body!.items!.item!;
            return city(screen, areadetailcode_model);
          } else if (snapshot.hasError) {
            return Text('error${snapshot.error}');
          }
          return Center(child: CupertinoActivityIndicator());
        });
  }

  Container city(Size screen, List<Item> areadetailcode_model) {
    var size = MediaQuery.of(context).size;
    var mobileWidth = 700;
    bool isWeb = true;
    size.width > mobileWidth ? isWeb = true : isWeb = false;
    return Container(
      color: Colors.white,
      width: isWeb ? screen.width * 0.65 : screen.width * 0.35,
      padding:
          EdgeInsets.fromLTRB(screen.width * 0.05, 0, screen.width * 0.05, 0),
      child: ListView.builder(
        itemCount: areadetailcode_model.length,
        itemBuilder: (BuildContext context, index) => InkWell(
          onTap: () {
            setState(() {
              cityName = areadetailcode_model[index].name.toString();
              cityCode = areadetailcode_model[index].code.toString();
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FestivalPage(
                        type: '$regionName $cityName',
                        region: regionCode,
                        city: cityCode)));
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
  }

  Container region(Size screen, List<Item> areacodeModel) {
    var size = MediaQuery.of(context).size;
    var mobileWidth = 700;
    bool isWeb = true;
    size.width > mobileWidth ? isWeb = true : isWeb = false;
    return Container(
      color: Colors.grey[100],
      width: isWeb ? screen.width * 0.35 : screen.width * 0.15,
      padding:
          EdgeInsets.fromLTRB(screen.width * 0.03, 0, screen.width * 0.03, 0),
      child: ListView.builder(
        itemCount: areacodeModel.length,
        itemBuilder: (BuildContext context, index) => InkWell(
          onTap: () => {
            setState(() {
              if (code != areacodeModel[index].code) {
                code = areacodeModel[index].code.toString();
              }
              regionCode = areacodeModel[index].code.toString();
              regionName = areacodeModel[index].name.toString();
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
              child: Text(areacodeModel[index].name.toString(),
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
  }
}
