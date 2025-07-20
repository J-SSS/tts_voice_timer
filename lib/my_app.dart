import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:tts_voice_timer/models/timer_model.dart';
import 'package:tts_voice_timer/provider/timer_controller.dart';
import 'package:tts_voice_timer/utils/size_util.dart';
import 'package:tts_voice_timer/widget/common/comon_bottom_bar.dart';
import 'package:tts_voice_timer/widget/timerType/timer_alarm_console.dart';
import 'package:tts_voice_timer/widget/timerType/timer_time_console.dart';
import 'package:tts_voice_timer/widget/common/common_preset_bar.dart';
import 'package:tts_voice_timer/widget/common/common_app_bar.dart';

import 'etc/adMobService.dart';
import 'etc/bottom_banner.dart';
// import 'dart:developer';


class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    // todo 프로바이더는 리빌드 안됨 > 초기화 메서드들 옮기기

    /*
    provider 문법 예시 복붙용
    read : context.read<TimerController>().setSetupTime = clickToTime;
    watch : context.watch<AppConfigController>().isOnTimerBottomViewYn
    select : TimerModel timerModel = context.select((CreateTimerController T) => T.timerModel);
    */

    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (context) => TimerViewModel(), lazy: false,), // shared preference & sqlite // todo 얘는 프로바이더 안써도될거같음
        ChangeNotifierProvider(create: (context) => TimerController(), lazy: false), // isolate timer
        // ChangeNotifierProvider(create: (context) => AppConfigController()),
      ],
      child: MaterialApp(
        title: 'My Time Timer',
          theme: ThemeData(
            fontFamily: 'Pretendard',
            dividerColor: Colors.transparent,
            // expansionTileTheme: ExpansionTileThemeData(
            //   // tilePadding : EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            //   // childrenPadding : EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            //   backgroundColor: Colors.grey[200],
            //   textColor: Colors.blue,
            // ),
          ),
        home:  const MyAppMain()),
    );
  }
}

class MyAppMain extends StatelessWidget {
  const MyAppMain({super.key});

  Future<void> _initMyApp(BuildContext context) async {
    SizeUtil().init(context);
    TimerModel timerModel = TimerModel();
    context.read<TimerController>().setCurrentTimer = timerModel;
    await context.read<TimerController>().assignPresetModel();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initMyApp(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          return _buildMainUI();
        }
      },
    );
  }

  Widget _buildMainUI() {
    BannerAd? _bannerAd; //추가
    _bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();


    //   /**
    //    * 현재 프레임이 끝난 후, 위젯 트리가 완전히 렌더링된 뒤 실행
    //    * UI와 충돌하는 것 방지(ex.이전 스크롤 위치로 이동..)
    //    */
    //   WidgetsBinding.instance.addPostFrameCallback((_) {}); // print('초기화');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            /* AppBar */
            SizedBox(
                height: SizeUtil().sh075,
                child: const CommonAppBar()
            ),
            Container(
                height: SizeUtil().sh40,
                alignment: Alignment.center,
                child: const TimerTimeConsole()
            ),
            Container(
              height: SizeUtil().sh10,
              width: SizeUtil().sw,
              alignment: Alignment.center,
              child: const CommonPresetBar(),
            ),
            Container(
              height: SizeUtil().sh225,
              alignment: Alignment.center,
              child: const TimerAlarmConsole(),
            ),
            Container(
              height: SizeUtil().sh10,
              alignment: Alignment.center,
              child: const CommonBottomBar(),
            ),
            Container(
                height: SizeUtil().sh10,
                color: Colors.white,
                child: BottomBanner()
            ),
          ],
        ),
      ),
    );
  }



  //
  // @override
  // Widget build(BuildContext context) {
  //   SizeUtil().init(context); // SizeUtil 초기화
  //   //
  //   // AppManager.log('메인 생성', type : 'S');

  //   // Size safeSize = SizeUtil().safeSize;
  //   // double mainLRPadding = (SizeUtil().sw * 0.075).roundToDouble(); // 가로 411 기준 약 31
  //   //
  //   // // print(MyAppBar(mainSize: safeSize).preferredSize.height); // AppBar 높이 확인
  //   //
  //   // // AppManager.log("SQLite 프리셋 초기화",type: "S");
  //   // context.read<TimerViewModel>().loadPresetFromDb();
  //   //
  //   // // SharedPreferences에서 최근 사용 타이머 셋팅
  //   // context.read<TimerController>().setCurrentTimer = TimerViewModel().loadRecentFromPrefs();
  //

  //   // // 비동기로 AdSize를 계산해서 반환
  //   // Future<AnchoredAdaptiveBannerAdSize?> _fetchAdSize() async {
  //   //   final window = WidgetsBinding.instance.window;
  //   //   final logicalSize = window.physicalSize / window.devicePixelRatio;
  //   //   final width = logicalSize.width.truncate();
  //   //   final orientation = logicalSize.width > logicalSize.height
  //   //       ? Orientation.landscape
  //   //       : Orientation.portrait;
  //   //
  //   //   return AdSize.getAnchoredAdaptiveBannerAdSize(orientation, width);
  //   // }
  //
  //   return Scaffold(
  //     resizeToAvoidBottomInset: false,
  //     // backgroundColor: scaffoldBackgroundColorLight,
  //     body: SafeArea(
  //         child: Column(
  //           children: [
  //             /* AppBar */
  //             SizedBox(
  //                 height: SizeUtil().sh075,
  //                 child: const CommonAppBar()
  //             ),
  //             // Container( // 임시
  //             //     height: SizeUtil().sh075,
  //             //     width: SizeUtil().sw,
  //             //     alignment: Alignment.center,
  //             //     child: const CommonTitleBar(),
  //                 // child: ConstrainedBox(
  //                 //     // constraints: BoxConstraints(maxWidth: SizeUtil().sw90),
  //                 //     constraints: null,
  //                 //     child: Text("WorkOut 60 min!" * 1, // todo AutoSizeText로 바꾸기
  //                 //         maxLines: 1, // 최대 한 줄로 제한
  //                 //         overflow: TextOverflow.ellipsis, // 넘치는 텍스트를 생략(...)
  //                 //         style: TextStyle(
  //                 //           // fontSize: SizeUtil().sh10 / 2,
  //                 //           fontWeight: FontWeight.bold,
  //                 //           color: Colors.black54,
  //                 //           shadows: [
  //                 //             Shadow(
  //                 //               offset: Offset(0, 3), // 그림자의 x, y 위치
  //                 //               blurRadius: 1.0, // 그림자 흐림 정도
  //                 //               color: Colors.grey.withOpacity(0.2), // 그림자 색상
  //                 //             ),
  //                 //           ],
  //                 //         )
  //                 //     )
  //                 // )
  //             // ),
  //             Container( // 임시
  //               height: SizeUtil().sh40,
  //               // color: Colors.green.withOpacity(0.15),
  //               alignment: Alignment.center,
  //               child: const TimerTimeConsole()
  //             ),
  //             Container( // 임시
  //               height: SizeUtil().sh10,
  //               width: SizeUtil().sw,
  //               alignment: Alignment.center,
  //               child: const CommonPresetBar(),)
  //             ,
  //             Container( // 임시
  //               // height: SizeUtil().sh35,
  //               height: SizeUtil().sh225,
  //               // color: Colors.green.withOpacity(0.15),
  //               alignment: Alignment.center,
  //               child: const TimerAlarmConsole(),
  //             ),
  //             Container( // 임시
  //               height: SizeUtil().sh10,
  //               // color: Colors.red.withOpacity(0.15),
  //               alignment: Alignment.center,
  //               child: const CommonBottomBar(),
  //             ),
  //             Container( // 임시
  //               height: SizeUtil().sh10,
  //               color: Colors.white,
  //               // alignment: Alignment.center,
  //               // child: AdWidget(ad: _bannerAd,)
  //               child: BottomBanner()
  //             ),
  //           ],
  //         ),
  //
  //     ),
  //   );
  // }
}