import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tts_voice_timer/models/timer_model.dart';
import 'package:tts_voice_timer/provider/timer_controller.dart';

class OnTimerScreen extends StatefulWidget {

  const OnTimerScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OnTimerScreen> createState() => _TimerPageState();
}

class _TimerPageState extends State<OnTimerScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // // 페이지 로드 시 기존 타이머 복원 또는 새 타이머 시작
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _initializeTimer();
    // });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // 앱이 다시 활성화되면 타이머 복원
      context.read<TimerController>().restoreTimer();
    }
  }

  void _initializeTimer(TimerModel timerModel) async {
    final timerProvider = context.read<TimerController>();

    // 먼저 기존 타이머 복원 시도
    await timerProvider.restoreTimer();

    // 복원된 타이머가 없으면 새로 시작
    if (!timerProvider.isRunning) {
      await timerProvider.startTimer(
        timerModel.setupHour,
        timerModel.setupMin,
        timerModel.setupSec,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // context.read<TimerController>().currentTimer;
    TimerModel timerModel = TimerModel();
    timerModel.setupHour = 0;
    timerModel.setupMin = 10;
    timerModel.setupHour = 0;

    // 페이지 로드 시 기존 타이머 복원 또는 새 타이머 시작
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeTimer(timerModel);
    });

    return Scaffold(
      body: Consumer<TimerController>(
        builder: (context, timerProvider, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade300,
                  Colors.purple.shade300,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 타이머 표시
                Container(
                  padding: EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Text(
                    timerProvider.formattedTime,
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: timerProvider.isRunning ? Colors.blue.shade700 : Colors.grey,
                      letterSpacing: 4,
                    ),
                  ),
                ),

                SizedBox(height: 60),

                // 컨트롤 버튼들
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 정지 버튼
                    ElevatedButton(
                      onPressed: timerProvider.isRunning
                          ? () => timerProvider.stopTimer()
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                      ),
                      child: Icon(Icons.stop, size: 30),
                    ),

                    // 일시정지/재시작 버튼
                    ElevatedButton(
                      onPressed: () {
                        if (timerProvider.isRunning) {
                          timerProvider.pauseTimer();
                        } else if (timerProvider.remainingTime.inSeconds > 0) {
                          timerProvider.startTimer(
                            timerProvider.remainingTime.inHours,
                            timerProvider.remainingTime.inMinutes.remainder(60),
                            timerProvider.remainingTime.inSeconds.remainder(60),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: timerProvider.isRunning ? Colors.orange : Colors.green,
                        foregroundColor: Colors.white,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                      ),
                      child: Icon(
                        timerProvider.isRunning ? Icons.pause : Icons.play_arrow,
                        size: 30,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40),

                // 상태 텍스트
                Text(
                  timerProvider.isRunning ? '타이머 실행 중' : '타이머 정지됨',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//
// class OnTimerScreen extends StatefulWidget {
//   const OnTimerScreen({super.key});
//
//   @override
//   State<OnTimerScreen> createState() => _OnTimerScreenState();
// }
//
// class _OnTimerScreenState extends State<OnTimerScreen> {
//   // bool isVisible = false;
//
//   @override
//   Widget build(BuildContext context) {
//
//     print('빌드');
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // print('온타이머'); // jdi : 본 위젯에 대한 콜백함수임
//       // context.read<TimerController>().runTimer();
//     });
//     // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive); // 상태 표시줄과 네비게이션 바 숨기기 (스와이프로 일시적으로 표시 가능)
//     // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack); // 숨김 // GestureDetector에 덮혀있어서 수정해야함
//     // SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
//     //   print(systemOverlaysAreVisible);
//     //   print('숨김중 터치');
//     //   Future.delayed(Duration(seconds: 2), () {
//     //     print('숨김중 터2치');
//     //     // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
//     //   });
//     // });
//     // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // 복원
//     // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // 화면전환가능
//     // SystemUiMode.immersive: 상태 표시줄과 네비게이션 바 숨기기 (스와이프로 일시적으로 표시 가능).
//     // SystemUiMode.leanBack: 간단한 숨김 모드.
//     // SystemUiMode.edgeToEdge: 상태 표시줄과 네비게이션 바 복원.\
//
//     return Scaffold(
//       body: SafeArea(
//         child: GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: () {
//             // isVisible = false;
//             // context.read<AppConfigController>().setOnTimerBottomView = true;
//             AppManager.log("온타이머 화면 터치", type: "G");
//             // utils.showOverlayBottomBar(context);
//             // setState(() {
//             //   !isVisible;
//             //   });
//           },
//           child: Container(
//             color: Colors.redAccent.withOpacity(0.05),
//             child: Stack(
//                 children: [
//                   Positioned(
//                     bottom: 0,// todo 수정필요
//                     child: OnTimerBottomBar(),
//                   ),
//                 ],
//               ),
//           )
//         ),
//       ),
//     );
//   }
// }
//
//
// class OnTimerBottomBar extends StatefulWidget {
//
//   // const OnTimerBottomBar({Key? key}) : super(key: key);
//   const OnTimerBottomBar({super.key});
//
//   void testFunc(){
//     print('키!');
//   }
//
//   @override
//   State<StatefulWidget> createState() => _onTimerBottomBarState();
// }
//
// class _onTimerBottomBarState extends State<OnTimerBottomBar> with WidgetsBindingObserver {
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     print(state);
//     switch (state) {
//       case AppLifecycleState.resumed:
//         print("앱이 표시되고 사용자 입력에 응답합니다");
//         break;
//       case AppLifecycleState.inactive:
//         print("앱이 비활성화 상태이고 사용자의 입력을 받지 않습니다");
//         break;
//       case AppLifecycleState.detached:
//         print("모든 뷰가 제거되고 플러터 엔진만 동작 중이며 앱이 종료되기 직전에 실행됩니다");
//         break;
//       case AppLifecycleState.paused:
//         print("앱이 현재 사용자에게 보이지 않고, 사용자의 입력을 받지 않으며, 백그라운드에서 동작 중입니다");
//         break;
//       default :;
//     }
//   }
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addObserver(this);
//   }
//   @override
//   void dispose() {
//     super.dispose();
//
//     WidgetsBinding.instance.removeObserver(this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size safeSize = SizeUtil().safeSize;
//     return Visibility(
//       // visible: context.watch<AppConfigController>().isOnTimerBottomViewYn,
//       // visible: true,
//       visible: true,
//       child: Container(
//         color: Colors.blueGrey.withOpacity(0.2),
//         width: safeSize.width,
//         height: safeSize.height * 0.2,
//         child: Stack(
//           children: <Widget>[
//
//           ],
//         ),
//       ),
//     );
//   }
// }
