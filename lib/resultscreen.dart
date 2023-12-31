import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'value/app_assets.dart';
import 'value/app_colors.dart';
import 'widget.dart';

class ResultScreen extends StatefulWidget {
  final String result;
  final String name1;
  final String name2;
  final int sum1;
  final int sum2;

  const ResultScreen({
    Key? key,
    required this.name1,
    required this.name2,
    required this.sum1,
    required this.sum2,
    required this.result,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool isLoading = true;
  int randomPercent = 0;
  // khai báo idqc banner
  BannerAd? _bannerAd;
  //id google ca-app-pub-3940256099942544/6300978111   ca-app-pub-3940256099942544/2934735716
  //id app banner1 ca-app-pub-9808019056055820/2182299457
  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-9808019056055820/2182299457'
      : 'ca-app-pub-3940256099942544/6300978111';
// khai báo idqc banner

  @override
  void initState() {
    super.initState();
    // Gọi phương thức _showResult() sau khi delay 2 giây
    _loadAd();
    randomPercent = randomPercentage();
    _showResult();
  }

  void _showResult() {
    // Delay 2 giây
    Future.delayed(const Duration(seconds: 4), () {
      // Cập nhật trạng thái isLoading và hiển thị widget.result
      setState(() {
        isLoading = false;
      });
    });
  }

  int randomPercentage() {
    // Tạo một số ngẫu nhiên từ 0 đến 19
    int randomNum = Random().nextInt(15);
    // Cộng thêm 80 để có giá trị từ 80 đến 99
    return 85 + randomNum;
  }

  @override
  Widget build(BuildContext context) {
    // đây là hàm random nè
    String randomPercentText = "$randomPercent%";
    // Tạo một giá trị ngẫu nhiên từ 80 đến 99
    // int randomPercent = randomPercentage();

    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      ),
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: widget.name1,
                        style: const TextStyle(
                            fontSize: 40,
                            fontFamily: 'Coiny',
                            color: AppColors.nameColor,
                            shadows: [
                              BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(3, 6),
                                  blurRadius: 15),
                            ])),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(AppAssets.love, height: 50, width: 50),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: widget.name2,
                        style: const TextStyle(
                            fontSize: 40,
                            fontFamily: 'Coiny',
                            color: AppColors.nameColor,
                            shadows: [
                              BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(3, 6),
                                  blurRadius: 15),
                            ])),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 70,
                      animation: true,
                      lineHeight: 50.0,
                      animationDuration: 2000,
                      percent: randomPercent / 100,
                      backgroundColor: AppColors.contentcolor,
                      barRadius: const Radius.circular(20),
                      center: Text(
                        randomPercentText,
                        style: const TextStyle(
                            fontSize: 30,
                            fontFamily: 'Tilt_Neon',
                            fontWeight: FontWeight.bold),
                      ),
                      // ignore: deprecated_member_use
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.red,
                    ),
                  ),
                  // Container(
                  //     padding: const EdgeInsets.all(20),
                  //     decoration: BoxDecoration(
                  //       color: AppColors.contentcolor,
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //     child: isLoading
                  //         ? const CircularProgressIndicator()
                  //         : Column(
                  //             children: [
                  //               RichText(3
                  //                   text: TextSpan(
                  //                       //random từ 85 tới 99
                  //                       text: randomInt(85, 99).toString(),
                  //                       style: const TextStyle(
                  //                           fontSize: 22,
                  //                           fontFamily: 'Braah_One',
                  //                           color: Colors.black)))
                  //             ],
                  //           )),
                  const SizedBox(height: 20),
                  Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.contentcolor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : Column(
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: widget.result,
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontFamily: 'Braah_One',
                                            color: Colors.black)))
                              ],
                            )),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
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
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    ).load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}
