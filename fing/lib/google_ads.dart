import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const Map<String, String> UNIT_ID = kReleaseMode
    ? {
        'ios': '/6499/example/app-open', 
        'android': '/6499/example/app-open',
      }
    : {
        'ios': 'ca-app-pub-3940256099942544/2934735716',
        'android': 'ca-app-pub-3940256099942544/1033173712',
      };

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(GoogleAds());
}
class GoogleAds extends StatefulWidget {
  const GoogleAds({Key? key}) : super(key: key);

  @override
  State<GoogleAds> createState() => _GoogleAdsState();
}

class _GoogleAdsState extends State<GoogleAds> {


  @override
  Widget build(BuildContext context) {
     TargetPlatform os = Theme.of(context).platform;

  BannerAd banner = BannerAd(
    listener: BannerAdListener(
      onAdFailedToLoad: (Ad ad, LoadAdError error) {},
      onAdLoaded: (_) {},
    ),
    size: AdSize.banner,
    adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
    request: AdRequest(),
  )..load();

  return Container(
            height: 50.0,
            child: banner==null 
            ? Container(): 
            AdWidget(
              ad: banner,
            ),
          );
  }
}

