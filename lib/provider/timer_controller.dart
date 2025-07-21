import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tts_voice_timer/models/preset_model.dart';
import 'package:tts_voice_timer/repository/timer_repository.dart';
import 'dart:isolate';


import '../models/timer_model.dart';
import '../manager/app_manager.dart';

class TimerController extends ChangeNotifier {
  // timer 변수
  int _setupTime = 34;
  int _remainTime = 34;
  String loopType = ''; // N : 반복 안함, O : 하나 반복, L : 목록 반복
  // ~timer 변수

  late TimerModel? _currentTimer;

  PresetModel? _presetModel;
  PresetModel? _currentPreset;
  List<PresetModel> _presetDataList = [];

  TimerController() {
    // AppManager.log('Isolate Timer Init');
    // isolateTimerInit(); // isolate 생성
  }

  get presetModel => _presetModel;
  get currentPreset => _currentPreset;
  get presetDataList => _presetDataList;


  Future<void> assignPresetModel() async {
    print('###### PresetModel 초기화 ######');
    final preset = await TimerRepository().getPresetFromDb();

    if (preset != null) {
      _presetModel = preset;
      _currentPreset = preset;
      // notifyListeners();
    } else {
      print('Failed to fetch PresetModel');
    }
  }

  Future<void> assignPresetDataList() async {
    print('###### PresetDataList 초기화 ######');
    final presetDataList = await TimerRepository().getPresetDataFromDb();
    if (presetDataList.length > 0) {
      _presetDataList = presetDataList;
    } else {
      print('Failed to fetch PresetModel');
    }
  }

  get currentTimer => _currentTimer;

  set setCurrentTimer(TimerModel timerModel){
    _currentTimer = timerModel;
    // notifyListeners();
  }
  // ~기타

  get setupTime => _setupTime;

  get remainTime => _remainTime;

  set setSetupTime(int setupTime) {
    if(this._setupTime != setupTime || this._remainTime != setupTime) {
      this._setupTime = setupTime;
      this._remainTime = setupTime;
      notifyListeners();
    }

  }



  assignCurrentPreset(PresetModel presetModel) {
    _currentPreset = presetModel;
    if(presetModel.timerModel != null){
      _currentTimer = presetModel.timerModel;
    }
    notifyListeners();
  }

  /** 설정 시간 수정
   * h : 시간 / m : 분 / s : 초
   * */
  modifySetupTime(String type, int val){
    if(type == 'h'){
      _currentTimer = _currentTimer?.copyWith(setupHour: _currentTimer!.setupHour + val > 99 ? 0 : _currentTimer!.setupHour + val < 0 ? 99 : _currentTimer!.setupHour + val);
    } else if(type == 'm'){
      _currentTimer = _currentTimer?.copyWith(setupMin: _currentTimer!.setupMin + val > 59 ? 0 : _currentTimer!.setupMin + val < 0 ? 59 : _currentTimer!.setupMin + val);
    } else if(type == 's'){
      _currentTimer = _currentTimer?.copyWith(setupSec: _currentTimer!.setupSec + val > 59 ? 0 : _currentTimer!.setupSec + val < 0 ? 59 : _currentTimer!.setupSec + val);
    }
    notifyListeners();
  }

  /** 알람 콘솔 영역 체크박스 수정
   * s : 시작 알림 / i : 간격 알림 / e : 종료 알림
   * */
  modifyCheckbox(String type, bool val){
    if(type == 's'){
      _currentTimer = _currentTimer!.copyWith(startCountdownYn : val);
    } else if(type == 'i'){
      _currentTimer = _currentTimer!.copyWith(intervalCountdownYn : val);
    } else if(type == 'e'){
      _currentTimer = _currentTimer!.copyWith(endCountdownYn : val);
    }
    notifyListeners();
  }

  /** 카운트다운 시간 수정
   * s : 시작 알림 / e : 종료 알림
   * */
  modifyCountdownTime(String type){
    if(type == 's'){
      print('시작 카운트다운 클릭');
      // _currentTimer = _currentTimer.copyWith(startCountdownYn : val);
    } else if(type == 'e'){
      print('종료 카운트다운 클릭');
      // _currentTimer = _currentTimer.copyWith(endCountdownYn : val);
    }
  }

  /** 카운트다운 상세 설정
   * s : 시작 알림 / e : 종료 알림
   * */
  modifyCountdownDetailSetup(String type, int time, int interval, int alarmType){
    if(type == 's'){
      print('종료 카운트다운 상세설정');
      // _currentTimer = _currentTimer.copyWith(startCountdownYn : val);
    } else if(type == 'e'){
      print('종료 카운트다운 상세설정');
      _currentTimer = _currentTimer!.copyWith(endCountdownValue : time, endCountdownInterval : interval, endCountdownType : alarmType);
    }
  }




  //////////////////////// 타이머 작동 중 ////////////////////////

  static const String _timerStartKey = 'timer_start_time';
  static const String _timerDurationKey = 'timer_duration';
  static const String _isRunningKey = 'timer_is_running';

  Timer? _timer;
  Duration _remainingTime = Duration.zero;
  bool _isRunning = false;

  // Getters
  Duration get remainingTime => _remainingTime;
  bool get isRunning => _isRunning;

  String get formattedTime {
    int hours = _remainingTime.inHours;
    int minutes = _remainingTime.inMinutes.remainder(60);
    int seconds = _remainingTime.inSeconds.remainder(60);

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  // 타이머 시작
  Future<void> startTimer(int hours, int minutes, int seconds) async {
    final totalDuration = Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );

    if (totalDuration.inSeconds <= 0) return;

    final prefs = await SharedPreferences.getInstance();
    final startTime = DateTime.now().millisecondsSinceEpoch;

    await prefs.setInt(_timerStartKey, startTime);
    await prefs.setInt(_timerDurationKey, totalDuration.inMilliseconds);
    await prefs.setBool(_isRunningKey, true);

    _remainingTime = totalDuration;
    _isRunning = true;

    _startUITimer();
    notifyListeners();
  }

  // UI 타이머 시작
  void _startUITimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds > 0) {
        _remainingTime = _remainingTime - Duration(seconds: 1);
        notifyListeners();
      } else {
        _completeTimer();
      }
    });
  }

  // 타이머 완료
  void _completeTimer() {
    _timer?.cancel();
    _isRunning = false;
    _remainingTime = Duration.zero;
    _clearSavedTimer();
    notifyListeners();

    // 타이머 완료 알림 (필요시)
    print('타이머 완료!');
  }

  // 타이머 정지
  Future<void> stopTimer() async {
    _timer?.cancel();
    _isRunning = false;
    _remainingTime = Duration.zero;
    await _clearSavedTimer();
    notifyListeners();
  }

  // 일시정지
  Future<void> pauseTimer() async {
    _timer?.cancel();
    _isRunning = false;
    await _clearSavedTimer();
    notifyListeners();
  }

  // 저장된 타이머 복원
  Future<void> restoreTimer() async {
    final prefs = await SharedPreferences.getInstance();
    final isRunning = prefs.getBool(_isRunningKey) ?? false;

    if (!isRunning) return;

    final startTime = prefs.getInt(_timerStartKey);
    final totalDuration = prefs.getInt(_timerDurationKey);

    if (startTime == null || totalDuration == null) return;

    final elapsed = DateTime.now().millisecondsSinceEpoch - startTime;
    final remaining = totalDuration - elapsed;

    if (remaining > 0) {
      _remainingTime = Duration(milliseconds: remaining);
      _isRunning = true;
      _startUITimer();
    } else {
      _completeTimer();
    }

    notifyListeners();
  }

  // 저장된 타이머 정보 삭제
  Future<void> _clearSavedTimer() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_timerStartKey);
    await prefs.remove(_timerDurationKey);
    await prefs.setBool(_isRunningKey, false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  ////////////////////////////////////////////////////////////
}
