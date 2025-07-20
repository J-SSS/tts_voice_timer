import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/timer_controller.dart';
import '../utils/size_util.dart';

class EndCountdownDialog extends StatefulWidget {
  @override
  _EndCountdownDialogState createState() => _EndCountdownDialogState();
}

class _EndCountdownDialogState extends State<EndCountdownDialog> {

  int? _selectedStartTime = 10;
  int? _selectedIntervalTime = 1;

  String? _selectedVoiceAlarmOption;

  // 시간 선택 옵션들 (초 단위)
  final List<int> _startTimeOptions = [3, 5, 10, 15, 20, 30, 45, 60];
  final List<int> _intervalTimeOptions = [1, 2, 3, 5, 10];
  final List<String> _voiceAlarmOptions = ["초", "초 전", "초 남았습니다", "직접 입력"];

  String _alarmType = 'v'; // v(voice) : 음성, s(sound) : 소리, n(none) : 진동

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      // elevation: 1.0,
      // surfaceTintColor: Colors.green, // 초록색 틴트
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Container( // dialog 실제 영역
            width: SizeUtil().sw80,
            height: SizeUtil().sh30,
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                  height: SizeUtil().sh06,
                  color: Colors.orange,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '종료 카운트 다운 설정',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      IconButton(
                        icon: Icon(Icons.close_rounded),
                        color: Colors.white,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ), // 헤더 부분
                Container( // 본문 영역
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                  height: SizeUtil().sh20 * 18/20,
                  color: Colors.white,
                  child: Container(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: SizeUtil().sh06,
                          child: Center(
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 70,height: 100,child: DropdownButton<int>(
                                  value: _selectedStartTime,
                                  hint: Text('$_selectedStartTime 초',),
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  items: _startTimeOptions.map((int time) {
                                    return DropdownMenuItem<int>(
                                      value: time,
                                      child: Text(
                                        '$time 초',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (int? val) {
                                    setState(() {
                                      _selectedStartTime = val;
                                    });
                                  },
                                ),
                                ),
                                Text(
                                  '전 부터 ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey),
                                ),
                                SizedBox(width: 70,height: 100,child: DropdownButton<int>(
                                  value: _selectedIntervalTime,
                                  hint: Text('$_selectedIntervalTime 초',),
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  items: _intervalTimeOptions.map((int time) {
                                    return DropdownMenuItem<int>(
                                      value: time,
                                      child: Text(
                                        '$time 초',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (int? val) {
                                    setState(() {
                                      _selectedIntervalTime = val;
                                    });
                                  },
                                ),
                                ),
                                Text(
                                  '간격 ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeUtil().sh06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                    fixedSize: Size(
                                        SizeUtil().sw80 / 3.3, SizeUtil().sh05),
                                    // 고정 너비 150, 고정 높이 50
                                    backgroundColor: _alarmType == 'v'
                                        ? Colors.orange
                                        : Colors.white,
                                    foregroundColor: _alarmType == 'v'
                                        ? Colors.white
                                        : Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0), // 둥근 정도
                                    ),
                                    side: BorderSide(
                                      color: _alarmType == 'v'
                                          ? Colors.orange
                                          : Colors.grey, // 테두리 색상
                                      width: 1.0, // 테두리 두께
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _alarmType = 'v'; // 음성
                                    });
                                  },
                                  child: Text("음 성",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    fixedSize: Size(
                                        SizeUtil().sw80 / 3.3, SizeUtil().sh05),
                                    backgroundColor: _alarmType == 's'
                                        ? Colors.orange
                                        : Colors.white,
                                    foregroundColor: _alarmType == 's'
                                        ? Colors.white
                                        : Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0), // 둥근 정도
                                    ),
                                    side: BorderSide(
                                      color: _alarmType == 's'
                                          ? Colors.orange
                                          : Colors.grey,
                                      width: 1.0, // 테두리 두께
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _alarmType = 's'; // 소리
                                    });
                                  },
                                  child: Text("소 리",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    fixedSize: Size(
                                        SizeUtil().sw80 / 3.3, SizeUtil().sh05),
                                    backgroundColor: _alarmType == 'n'
                                        ? Colors.orange
                                        : Colors.white,
                                    foregroundColor: _alarmType == 'n'
                                        ? Colors.white
                                        : Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0), // 둥근 정도
                                    ),
                                    side: BorderSide(
                                      color: _alarmType == 'n'
                                          ? Colors.orange
                                          : Colors.grey,
                                      width: 1.0, // 테두리 두께
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _alarmType = 'n'; // 진동
                                    });
                                  },
                                  child: Text("진 동",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                            ],
                          ),
                        ), // 알림 타입 선택 버튼 Row
                        if(_alarmType== 'v') ...[
                          SizedBox(height: SizeUtil().sh06,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    // color: Colors.grey.withOpacity(0.2),
                                    color: Colors.grey[200],
                                  width: SizeUtil().sw80 / 2,
                                  height: SizeUtil().sh05,
                                  child: DropdownButton<String>(
                                    // value: _selectedVoiceAlarmOption ?? _voiceAlarmOptions[0],
                                    value: _selectedVoiceAlarmOption,
                                    // dropdownColor: Colors.green.shade50,  // 드롭다운 목록 배경색
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                    icon: const Icon(Icons.arrow_drop_down),
                                    // items: _voiceAlarmOptions.map((String text) {
                                    //   return DropdownMenuItem<String>(
                                    //       value: text,
                                    //       child: Center(
                                    //         child: Text(
                                    //           '$text',
                                    //           style:
                                    //               const TextStyle(fontSize: 16),
                                    //         ),
                                    //       ));
                                    // }).toList(),
                                    items: _voiceAlarmOptions.asMap().entries.map((entry) {
                                      print('entry: $entry');
                                      print(_voiceAlarmOptions.length-1 == entry.key);
                                      // int index = entry.key;
                                      // String text = entry.value;
                                      // todo DropdownButton의 value는 DropdownMenuItem 의 값이어야함
                                      String text = _voiceAlarmOptions.length-1 == entry.key ? entry.value : "$_selectedStartTime " + entry.value;
                                      return DropdownMenuItem<String>(
                                        value: text,
                                        child: Center(
                                          child: Text(
                                            text,
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? val) {
                                      setState(() {
                                        _selectedVoiceAlarmOption = val;
                                      });
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.settings),
                                  color: Colors.blueGrey,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ] else if(_alarmType == 's') ...[
                          Text(
                            '소리 알림이 설정되었습니다.',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                          ),
                        ] else if(_alarmType == 'n') ...[
                          Text(
                            '진동 알림이 설정되었습니다.',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                  height: SizeUtil().sh06,
                  color: Colors.grey.withOpacity(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                        },
                        child: Text(
                          '초기화',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<TimerController>().modifyCountdownDetailSetup("e", 0, 0, 0);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          '적용',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

      ),
    );
  }
}
