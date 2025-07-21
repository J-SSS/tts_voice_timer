import 'package:flutter/material.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:my_time_timer/manager/db_manager.dart';
// import 'package:my_time_timer/manager/prefs_manager.dart';
import 'package:tts_voice_timer/my_app.dart';

import 'manager/db_manager.dart';

Future<void> main() async {
  // CustomBinding 사용법 찾아보기
  CustomWidgetsBinding();

  // Flutter 엔진과의 바인딩을 보장 > SharedPreferences, Firebase, MediaQuery 등의 의존성을 안전하게 사용할 수 있게 함
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize(); //광고 초기화


  // SharedPreferences 초기화
  // await PrefsManager.instance.init();

  // await DbManager.instance.resetData(); // SQLite 초기화
  await DbManager.instance.init(); // SQLite 초기화

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // 상태바를 완전 투명하게
      statusBarColor: Colors.white,
      // 아이콘 색상 (Light 면 흰색 아이콘, Dark 면 검정 아이콘)
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark, // iOS 상태바 텍스트 색
    ),
  );

  // 2️⃣ 윈도우에서 논리(dp) 크기 계산
  // final window = WidgetsBinding.instance.window;
  // final logicalSize = window.physicalSize / window.devicePixelRatio;
  // final widthDp  = logicalSize.width.truncate();
  // final heightDp = logicalSize.height.truncate();
  // final orientation = widthDp > heightDp
  //     ? Orientation.landscape
  //     : Orientation.portrait;
  //
  // // 3️⃣ await로 Adaptive Banner 사이즈 가져오기
  // final adSize = await AdSize.getAnchoredAdaptiveBannerAdSize(
  //   orientation,
  //   widthDp,
  // );
  //
  // print('광고사이즈');
  // print(adSize?.width);
  // print(adSize?.height);

  // todo SQLite 초기화 코드 추가

  // SystemChrome은 Flutter에서 디바이스의 시스템 UI(상태바, 내비게이션 바 등)를 제어하기 위해 제공되는 클래스
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp, // 세로로 고정
  // ]).then((_) {
  //   // runApp(DevicePreview( // todo 찾아보기
  //   //   // enabled: !kReleaseMode, // todo 찾아보기
  //   //   enabled: false,
  //   //   builder: (context) => ScreenUtilInit(
  //   //     designSize: const Size(360, 690), // 기준 화면 크기
  //   //     minTextAdapt: true,
  //   //     splitScreenMode: true,
  //   //     builder: (context, child) {
  //   //       // print('??');
  //   //       return MyApp(prefs: prefs);
  //   //     },
  //   //   ), // Wrap your app
  //   // ),);
  //
  //   runApp(DevicePreview( // todo 찾아보기
  //     // enabled: !kReleaseMode, // todo 찾아보기
  //     enabled: false,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),);
  // });
  runApp(MyApp());
}


class CustomWidgetsBinding extends WidgetsFlutterBinding {
  /*
  WidgetsFlutterBinding은 Flutter에서 위젯 시스템과 Flutter 엔진 간의 브리지 역할을 하는 클래스입니다.
  이 클래스는 위젯 트리 초기화, 앱 라이프사이클 관리, 플랫폼 이벤트 처리, 화면 렌더링 등과 같은 Flutter의 핵심적인 기능을 관리합니다.
  */
  @override
  void initInstances() {
    super.initInstances();
    // 커스텀 초기화 작업
    print('CustomWidgetsBinding initialized!');
  }

  @override
  void handleAppLifecycleStateChanged(AppLifecycleState state) {
    super.handleAppLifecycleStateChanged(state);
    // 앱 라이프사이클 이벤트를 감지하고 처리
    print('AppLifecycleState changed: $state');
  }
}
