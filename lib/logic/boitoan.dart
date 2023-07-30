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
//id app banner ca-app-pub-9808019056055820/7988861846
  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-9808019056055820/7988861846'
      : 'ca-app-pub-3940256099942544/6300978111';

//ID QC XenKe
//id google ca-app-pub-3940256099942544/1033173712    ca-app-pub-3940256099942544/4411468910
//id app ca-app-pub-9808019056055820/1860887099
  final String _adUnitIdxenke = Platform.isAndroid
      ? 'ca-app-pub-9808019056055820/1860887099'
      : 'ca-app-pub-3940256099942544/1033173712';

// khai báo idqc banner

  final TextEditingController name1Controller = TextEditingController();
  final TextEditingController name2Controller = TextEditingController();
  String result = '';
  bool _isFullNameValid = true;
  bool _isTextFieldEmpty = true;

  void _validateFullName(String value) {
    setState(() {
      _isFullNameValid = value.trim().isNotEmpty;
      _isTextFieldEmpty = !value.trim().isNotEmpty;
    });
  }

  void _showRequiredFieldDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8.0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.contentcolor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Uiii Lỗi Rồi!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      fontFamily: 'Tilt_Neon'),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Bạn phải nhập đủ họ và tên nha!',
                  style: TextStyle(fontFamily: 'Tilt_Neon'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Đóng'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
                  controller: name1Controller,
                  onChanged: _validateFullName,
                  textCapitalization: TextCapitalization.words,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: 'Tilt_Neon', fontSize: 22),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.contentcolor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Tên của bạn',
                    errorText: _isFullNameValid
                        ? null
                        : 'Họ và tên không được để trống',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  style: const TextStyle(fontSize: 22, fontFamily: 'Tilt_Neon'),
                  controller: name2Controller,
                  onChanged: _validateFullName,
                  textCapitalization: TextCapitalization.words,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.contentcolor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Tên người ấy',
                    errorText: _isFullNameValid
                        ? null
                        : 'Họ và tên không được để trống',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (_isTextFieldEmpty) {
                      _showRequiredFieldDialog();
                    } else {
                      _interstitialAd?.show();
                      _showResultScreen();
                    }
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
                    if (_isTextFieldEmpty) {
                      _showRequiredFieldDialog();
                    } else {
                      _interstitialAd?.show();
                      _showResultScreenwork();
                    }
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
                    if (_isTextFieldEmpty) {
                      _showRequiredFieldDialog();
                    } else {
                      _interstitialAd?.show();
                      _showResultScreenmarried();
                    }
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
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (ad) {},
                onAdImpression: (ad) {},
                onAdClicked: (ad) {});
            debugPrint('$ad loaded.');
            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  void _loadAd() async {
    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdOpened: (Ad ad) {},
        onAdClosed: (Ad ad) {},
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
