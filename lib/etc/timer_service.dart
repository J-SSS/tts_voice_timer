// class TimerService {
//   static const String _timerStartKey = 'timer_start_time';
//   static const String _timerDurationKey = 'timer_duration';
//   static const String _isRunningKey = 'timer_is_running';
//
//   // 타이머 시작
//   static Future<void> startTimer(Duration duration) async {
//     final prefs = await SharedPreferences.getInstance();
//     final startTime = DateTime.now().millisecondsSinceEpoch;
//
//     await prefs.setInt(_timerStartKey, startTime);
//     await prefs.setInt(_timerDurationKey, duration.inMilliseconds);
//     await prefs.setBool(_isRunningKey, true);
//   }
//
//   // 남은 시간 계산
//   static Future<Duration?> getRemainingTime() async {
//     final prefs = await SharedPreferences.getInstance();
//     final isRunning = prefs.getBool(_isRunningKey) ?? false;
//
//     if (!isRunning) return null;
//
//     final startTime = prefs.getInt(_timerStartKey);
//     final totalDuration = prefs.getInt(_timerDurationKey);
//
//     if (startTime == null || totalDuration == null) return null;
//
//     final elapsed = DateTime.now().millisecondsSinceEpoch - startTime;
//     final remaining = totalDuration - elapsed;
//
//     return remaining > 0 ? Duration(milliseconds: remaining) : Duration.zero;
//   }
//
//   // 타이머 종료
//   static Future<void> stopTimer() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_isRunningKey, false);
//   }
// }
//
// class TimerScreen extends StatefulWidget {
//   @override
//   _TimerScreenState createState() => _TimerScreenState();
// }
//
// class _TimerScreenState extends State<TimerScreen> with WidgetsBindingObserver {
//   Timer? _timer;
//   Duration _remainingTime = Duration.zero;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _restoreTimer();
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       _restoreTimer(); // 앱이 다시 활성화되면 타이머 복원
//     }
//   }
//
//   void _restoreTimer() async {
//     final remaining = await TimerService.getRemainingTime();
//     if (remaining != null) {
//       setState(() {
//         _remainingTime = remaining;
//       });
//       _startUITimer();
//     }
//   }
//
//   void _startUITimer() {
//     _timer?.cancel();
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (_remainingTime.inSeconds > 0) {
//           _remainingTime = _remainingTime - Duration(seconds: 1);
//         } else {
//           timer.cancel();
//           TimerService.stopTimer();
//           // 타이머 완료 처리
//         }
//       });
//     });
//   }
// }