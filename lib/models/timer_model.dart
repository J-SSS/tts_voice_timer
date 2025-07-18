
/// mft_timer 테이블을 맵핑하기 위한 Model
class TimerModel {
  final int timerId; /// 타이머 고유아이디
  final int groupId; /// 폴더 고유아이디
  final String timerName; /// 타이머 이름

  int setupHour = 0; /// 설정시간(시)
  int setupMin = 0; /// 설정시간(분)
  int setupSec = 0; /// 설정시간(초)

  bool startCountdownYn = false; /// 시작 카운트다운 여부
  bool intervalCountdownYn = false; /// 간격 카운트다운 여부
  bool endCountdownYn = false; /// 종료 카운트다운 여부

  int startCountdownValue = 0; /// 시작 카운트다운 시간
  int intervalCountdownValue = 0; /// 간격 카운트다운 타입(경과시간 : 0 / 남은시간 : 1)
  int endCountdownValue = 0; /// 종료 카운트다운 시간

  int startCountdownInterval = 0; /// 시작 카운트다운 간격
  int intervalCountdownInterval = 0; /// 간격 카운트다운 간격
  int endCountdownInterval = 0; /// 종료 카운트다운 간격

  int startCountdownType = 0; /// 시작 카운트다운 타입 (음성 : 0 / 신호 : 1 / 진동 : 2)
  int intervalCountdownType = 0; /// 간격 카운트다운 타입 (음성 : 0 / 신호 : 1 / 진동 : 2)
  int endCountdownType = 0; /// 종료 카운트다운 타입 (음성 : 0 / 신호 : 1 / 진동 : 2)


  // TimerModel.fromSharedPreferences(Map<String, dynamic> recentTimer){ // SharedPreferences 사용하는 경우
  //   _recentTimer = recentTimer;
  //   // return TimerModel();
  // }

  /// 객체를 Map으로 변환
  Map<String, dynamic> toMap() {
    return {
      'timerId': timerId,
      'groupId': groupId,
      'timerName': timerName,
    };
  }


  TimerModel(
    {
    this.timerId = -1,
    this.groupId = 0,
    this.timerName = "New Timer",
    this.setupHour = 0, // new
    this.setupMin = 0, // new
    this.setupSec = 0, // new
    this.startCountdownYn = true, // new
    this.intervalCountdownYn = true, // new
    this.endCountdownYn = true,
    this.startCountdownValue = 0,
    this.intervalCountdownValue = 0,
    this.endCountdownValue = 0,
    this.startCountdownInterval = 0,
    this.intervalCountdownInterval = 0,
    this.endCountdownInterval = 0,
    this.startCountdownType = 0,
    this.intervalCountdownType = 0,
    this.endCountdownType = 0,
    }
      );

  // TimerModel.dflt();

  /// 객체 복사용 copyWith
  TimerModel copyWith({
    int? timerId,
    int? groupId,
    int? setupHour,
    int? setupMin,
    int? setupSec,
    bool? startCountdownYn,
    bool? intervalCountdownYn,
    bool? endCountdownYn,
    int? startCountdownValue,
    int? intervalCountdownValue,
    int? endCountdownValue,
    int? startCountdownInterval,
    int? intervalCountdownInterval,
    int? endCountdownInterval,
    int? startCountdownType,
    int? intervalCountdownType,
    int? endCountdownType,
  }) {
    return TimerModel(
      timerId : timerId ?? this.timerId,
      groupId : groupId ?? this.groupId,
      setupHour : setupHour ?? this.setupHour,
      setupMin : setupMin ?? this.setupMin,
      setupSec : setupSec ?? this.setupSec,
      startCountdownYn : startCountdownYn ?? this.startCountdownYn,
      intervalCountdownYn : intervalCountdownYn ?? this.intervalCountdownYn,
      endCountdownYn : endCountdownYn ?? this.endCountdownYn,
      startCountdownValue : startCountdownValue ?? this.startCountdownValue,
      intervalCountdownValue : intervalCountdownValue ?? this.intervalCountdownValue,
      endCountdownValue : endCountdownValue ?? this.endCountdownValue,
      startCountdownInterval : startCountdownInterval ?? this.startCountdownInterval,
      intervalCountdownInterval : intervalCountdownInterval ?? this.intervalCountdownInterval,
      endCountdownInterval : endCountdownInterval ?? this.endCountdownInterval,
      startCountdownType : startCountdownType ?? this.startCountdownType,
      intervalCountdownType : intervalCountdownType ?? this.intervalCountdownType,
      endCountdownType : endCountdownType ?? this.endCountdownType,
    );
  }


  factory TimerModel.fromMap(Map<String, dynamic> timerData) {
    return TimerModel(
      timerId: timerData['timerId'],
      groupId: timerData['groupId'],
      timerName: timerData['timerName'] ?? 'Basic Timer',

    );
  }
}



