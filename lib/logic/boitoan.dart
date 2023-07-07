import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../resultscreen.dart';
import '../value/app_assets.dart';
import '../value/app_colors.dart';
import '../widget.dart';
import 'resultname.dart';
import 'resultnamemarried.dart';
import 'resultnamework.dart';
import 'singledigit.dart';
import 'sumofnumber.dart';

class BoiToan extends StatefulWidget {
  const BoiToan({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BoiToanState createState() => _BoiToanState();
}

class _BoiToanState extends State<BoiToan> {
// khai báo idqc banner
  BannerAd? _bannerAd;
// QC xen kẽ
  InterstitialAd? _interstitialAd;

// QC banner
//id google banner ca-app-pub-3940256099942544/6300978111
//id app banner ca-app-pub-9808019056055820~8645787293
  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

//ID QC XenKe
//id google ca-app-pub-3940256099942544/1033173712
//id app ca-app-pub-9808019056055820/1860887099
  final String _adUnitIdxenke = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

// khai báo idqc banner

  final TextEditingController name1Controller = TextEditingController();
  final TextEditingController name2Controller = TextEditingController();
  String result = '';

  @override
  void initState() {
    super.initState();
    _loadAd();
    loadAdxenke();
  }

  void _showResultScreen() {
    String name1 = name1Controller.text;
    String name2 = name2Controller.text;

    int sum1 = getSumOfNumber(name1);
    int sum2 = getSumOfNumber(name2);

    int totalSum = sum1 + sum2;
    int singleDigitSum = getSingleDigit(totalSum);

    result = getResultName(singleDigitSum);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          name1: name1,
          name2: name2,
          sum1: sum1,
          sum2: sum2,
          result: result,
        ),
      ),
    );
  }

  void _showResultScreenwork() {
    String name1 = name1Controller.text;
    String name2 = name2Controller.text;

    int sum1 = getSumOfNumber(name1);
    int sum2 = getSumOfNumber(name2);

    int totalSum = sum1 + sum2;
    int singleDigitSum = getSingleDigit(totalSum);

    result = getResultNameWork(singleDigitSum);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          name1: name1,
          name2: name2,
          sum1: sum1,
          sum2: sum2,
          result: result,
        ),
      ),
    );
  }

  void _showResultScreenmarried() {
    String name1 = name1Controller.text;
    String name2 = name2Controller.text;

    int sum1 = getSumOfNumber(name1);
    int sum2 = getSumOfNumber(name2);

    int totalSum = sum1 + sum2;
    int singleDigitSum = getSingleDigit(totalSum);

    result = getResultNameMarried(singleDigitSum);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          name1: name1,
          name2: name2,
          sum1: sum1,
          sum2: sum2,
          result: result,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        if (_bannerAd != null)
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            ),
          ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              verticalDirection: VerticalDirection.down,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  style: const TextStyle(fontSize: 22, fontFamily: 'Tilt_Neon'),
                  controller: name1Controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.contentcolor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Tên của bạn',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  style: const TextStyle(fontSize: 22, fontFamily: 'Tilt_Neon'),
                  controller: name2Controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.contentcolor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Tên người ấy',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _interstitialAd?.show();
                    _showResultScreen();
                  },
                  child: Card(
                    elevation: 3,
                    color: AppColors.contentcolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bói Tình Yêu',
                                      style: TextStyle(
                                          fontSize: 28, fontFamily: 'Merienda'),
                                    ),
                                    Text(
                                      'Tìm hiểu sự tương hợp trong tình yêu đôi lứa!',
                                      style: TextStyle(fontFamily: 'Tilt_Neon'),
                                    )
                                  ]),
                            ),
                            Image.asset(AppAssets.love, height: 80, width: 80)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _interstitialAd?.show();
                    _showResultScreenwork();
                  },
                  child: Card(
                    elevation: 3,
                    color: AppColors.contentcolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bói Sự Nghiệp',
                                      style: TextStyle(
                                          fontSize: 28, fontFamily: 'Merienda'),
                                    ),
                                    Text(
                                      'Tìm hiểu sự tương hợp trong tình yêu đôi lứa!',
                                      style: TextStyle(fontFamily: 'Tilt_Neon'),
                                    )
                                  ]),
                            ),
                            Image.asset(AppAssets.work, height: 80, width: 80)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _interstitialAd?.show();
                    _showResultScreenmarried();
                  },
                  child: Card(
                    color: const Color(0xfff8dae9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bói Hôn Nhân',
                                      style: TextStyle(
                                          fontSize: 28, fontFamily: 'Merienda'),
                                    ),
                                    Text(
                                      'Tìm hiểu sự tương hợp trong tình yêu đôi lứa!',
                                      style: TextStyle(fontFamily: 'Tilt_Neon'),
                                    )
                                  ]),
                            ),
                            Image.asset(AppAssets.married,
                                height: 80, width: 80)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: const Color(0xfff8dae9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tìm hiểu sự tương hợp trong tình yêu đôi lứa!',
                                    style: TextStyle(fontFamily: 'Tilt_Neon'),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 3),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  /// Loads an interstitial ad.
  void loadAdxenke() {
    InterstitialAd.load(
        adUnitId: _adUnitIdxenke,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                // onAdFailedToShowFullScreenContent: (ad, err) {
                //   // Dispose the ad here to free resources.
                //   ad.dispose();
                // },
                // Called when the ad dismissed full screen content.
                // onAdDismissedFullScreenContent: (ad) {
                //   // Dispose the ad here to free resources.
                //   ad.dispose();
                // },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  /// Loads and shows a banner ad.
  ///
  /// Dimensions of the ad are determined by the AdSize class.
  void _loadAd() async {
    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        // onAdFailedToLoad: (ad, err) {
        //   ad.dispose();
        // },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    ).load();
  }

  // @override
  // void dispose() {
  //   _bannerAd?.dispose();
  //   _interstitialAd?.dispose();
  //   super.dispose();
  // }
}
