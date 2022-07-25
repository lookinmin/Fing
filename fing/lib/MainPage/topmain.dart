import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(TopMain());

class TopMain extends StatelessWidget {
  TopMain({Key? key}) : super(key: key);
  final List<String> festivalImg = [
    'FestImg1',
    'FestImg2',
    'FestImg3',
    'FestImg4',
    'FestImg5'
  ];
  List<String> festivalList = [
    'festivalList1',
    'festivalList2',
    'festivalList3',
    'festivalList4',
    'festivalList5'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 6,
          child: FestivalCarousel(festivalImg: festivalImg),
        ),
        Expanded(flex: 2, child: FestivalRanking(festivalList: festivalList))
      ],
    );
  }
}

//메인 페이지 상단 Hot Festival 전체 Box
class FestivalRanking extends StatelessWidget {
  FestivalRanking({
    Key? key,
    required this.festivalList,
  }) : super(key: key);

  final List<String> festivalList;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Text(
              'Hot\nFestival',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 226, 36, 115)),
            )),
        FestivalRankingBox(festivalList: festivalList)
      ],
    );
  }
}

//Hot Festival 랭킹 carousel 포함한 박스
class FestivalRankingBox extends StatelessWidget {
  FestivalRankingBox({
    Key? key,
    required this.festivalList,
  }) : super(key: key);

  final List<String> festivalList;
  CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 8,
        child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 5), // changes position of shadow
                  )
                ]),
            child: FestivalRankCarousel(festivalList: festivalList)));
  }
}

class FestivalRankCarousel extends StatelessWidget {
  FestivalRankCarousel({
    Key? key,
    required this.festivalList,
  }) : super(key: key);
  final List<String> festivalList;
  CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            flex: 8,
            fit: FlexFit.tight,
            child: CarouselSlider(
              carouselController: controller,
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.vertical),
              items: festivalList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          i,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w600),
                        ));
                  },
                );
              }).toList(),
            )),
        Expanded(
            child: Column(
          children: [
            Flexible(
                flex: 1,
                child: IconButton(
                    iconSize: 20,
                    onPressed: () {},
                    // onPressed: () => controller.previousPage(
                    //     duration: Duration(milliseconds: 300),
                    //     curve: Curves.linear),
                    icon: Icon(
                      Icons.arrow_drop_up,
                    ))),
            Flexible(
                flex: 4,
                child: IconButton(
                    iconSize: 20,
                    onPressed: () {},
                    // onPressed: () => controller.nextPage(
                    //     duration: Duration(milliseconds: 300),
                    //     curve: Curves.linear),
                    icon: Icon(Icons.arrow_drop_down)))
          ],
        ))
      ],
    );
  }
}

//Hot Festival 랭킹 텍스트 carousel
class FestivalList extends StatelessWidget {
  FestivalList({
    Key? key,
    required this.festivalList,
    required this.controller,
  }) : super(key: key);

  final List<String> festivalList;
  final CarouselController controller;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: controller,
      options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 1000),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.vertical),
      items: festivalList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  i,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ));
          },
        );
      }).toList(),
    );
  }
}

//메인 페이지 상단 페스티벌 사진 carousel
class FestivalCarousel extends StatelessWidget {
  const FestivalCarousel({
    Key? key,
    required this.festivalImg,
  }) : super(key: key);

  final List<String> festivalImg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black))),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 250.0,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 1000),
          autoPlayCurve: Curves.fastOutSlowIn,
        ),
        items: festivalImg.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Center(
                    child: Text(
                      i,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ));
            },
          );
        }).toList(),
      ),
    );
  }
}
