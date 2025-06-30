import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BottomBanner extends StatefulWidget {
  const BottomBanner({super.key});

  @override
  State<BottomBanner> createState() => _BottomBannerState();
}

class _BottomBannerState extends State<BottomBanner> {
  BannerAd? _bannerAd;
  AnchoredAdaptiveBannerAdSize? _adSize;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  Future<void> _loadAd() async {
    if (_bannerAd != null) return;

    final AnchoredAdaptiveBannerAdSize? size =
    await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      setState(() {
        _isLoaded = false;
      });
      return;
    }

    _bannerAd = BannerAd(
      size: size,
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // 테스트 ID, 실제 배포 시 교체!
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isLoaded = true;
            _adSize = size;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          setState(() {
            _isLoaded = false;
          });
        },
      ),
      request: AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _adSize == null || _bannerAd == null) {
      return SizedBox(height: 0);
    }
    // print('광고가로');
    // print(_adSize);
    print('광고가로 : ' + _adSize!.width.toDouble().toString());
    print('광고세로 : ' + _adSize!.height.toDouble().toString());
    return Container(
      color: Colors.transparent,
      width: _adSize!.width.toDouble(),
      height: _adSize!.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}