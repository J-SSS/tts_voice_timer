import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:numberpicker/numberpicker.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tts_voice_timer/models/timer_model.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/common_values.dart';
import '../../../utils/size_util.dart';
import '../../provider/timer_controller.dart';
import '../../screen/start_countdown_setting_screen.dart';
import '../end_countdown_dialog.dart';


class TimerAlarmConsole extends StatefulWidget {
  const TimerAlarmConsole({Key? key}) : super(key: key);

  @override
  State<TimerAlarmConsole> createState() => _MainToolbarState();
}

class _MainToolbarState extends State<TimerAlarmConsole> {

  @override
  Widget build(BuildContext context) {
    TimerModel timerModel = context.select((TimerController T) => T.currentTimer);
    bool startCountdownYn = timerModel.startCountdownYn;
    bool intervalCountdownYn = timerModel.intervalCountdownYn;
    bool endCountdownYn = timerModel.endCountdownYn;





    return Stack(
      children: [
        BiteContainer( // 배경 박스
          biteRadius: SizeUtil().sh15 * 0.4,
          // biteRadius: 50,
          elevation: 5.0,
          // color: Colors.yellow.withOpacity(0.9),
          color: Colors.white,
          child: Container( // 완전한 네모 영역
              decoration: BoxDecoration(
                // color: Colors.green.withOpacity(0.6),
              ),
              width: SizeUtil().sw,
              // height: SizeUtil().sh10,
              height: SizeUtil().sh225 * 0.97,
              // padding: const EdgeInsets.all(16.0),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container( // 클리퍼 영역과 높이 안겹치는 부분
                    decoration: BoxDecoration(
                      // border: Border.symmetric(horizontal:  BorderSide(color: Colors.blue.withOpacity(0.5), width: 0.5)),
                      // color: Colors.red.withOpacity(0.1),
                    ),
                    // color: Colors.red.withOpacity(0.1),
                    height: SizeUtil().sh225 * 0.97 - SizeUtil().sh15 * 0.4 * 1.2,
                    width: 500,
                    // width: SizeUtil().sw - (SizeUtil().sh15 * 1.08), // 플로팅버튼 부분과 구분해주기 위함(SizeUtil().sw - SizeUtil().sh15 * 0.6 - SizeUtil().sh15 * 0.48)
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: !startCountdownYn ? Colors.grey.shade200 : Colors.white,
                          height: 35,
                          child: !startCountdownYn ?  Row(
                            children: [
                              Checkbox(
                                value: startCountdownYn,
                                onChanged: (bool? value) {
                                  context.read<TimerController>().modifyCheckbox('s', !startCountdownYn);
                                },
                              ),
                              Text("시작 카운트다운  :  사용 안함"),
                            ],) : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: startCountdownYn,
                                onChanged: (bool? value) {
                                  context.read<TimerController>().modifyCheckbox('s', !startCountdownYn);
                                },
                              ),
                              Text("시작 카운트다운    "),
                              TextButton(onPressed: (){ context.read<TimerController>().modifyCountdownTime("s");}, child: Text("10 초 전",style: TextStyle(decoration: TextDecoration.underline,decorationThickness: 0.5, ),), style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역도 축소
                              ),),
                              const Spacer(),
                              IconButton(onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => StartCountdownSettingScreen()), // 시작 카운트 설정 화면
                                );
                              }, icon: Icon(Icons.edit_notifications_outlined, size: 20)),
                            ],
                          ),
                        ),
                        Container(
                          color: !intervalCountdownYn ? Colors.grey.shade100 : Colors.white,
                          height: 35,
                          child: !intervalCountdownYn ?  Row(
                            children: [
                              Checkbox(
                                value: intervalCountdownYn,
                                onChanged: (bool? value) {
                                  context.read<TimerController>().modifyCheckbox('i', !intervalCountdownYn);
                                },
                              ),
                              Text("작동 중 알림  :  사용 안함"),
                            ],) : Row(
                            children: [
                              Checkbox(
                                value: intervalCountdownYn,
                                onChanged: (bool? value) {
                                  context.read<TimerController>().modifyCheckbox('i', !intervalCountdownYn);
                                },
                              ),
                              Text("작동 중 알림  :  "),
                              TextButton(onPressed: (){}, child: Text("지난 시간 ",style: TextStyle(decoration: TextDecoration.underline,decorationThickness: 0.5, ),),style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역도 축소
                              ),),
                              // Text("을"),
                              TextButton(onPressed: (){}, child: Text("01",style: TextStyle(decoration: TextDecoration.underline,decorationThickness: 0.5, ),),style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역도 축소
                              ),),
                              Text(" 초 간격"),
                              const Spacer(),
                              IconButton(onPressed: (){}, icon: Icon(Icons.edit_notifications_outlined, size: 20)),
                            ],
                          ),
                        ),
                        Container(
                          color: !endCountdownYn ? Colors.grey.shade200 : Colors.white,
                          height: 35,
                          child: !endCountdownYn ? Row(
                            children: [
                              Checkbox(
                                value: endCountdownYn,
                                onChanged: (bool? value) {
                                  context.read<TimerController>().modifyCheckbox('e', !endCountdownYn);
                                },
                              ),
                              Text("종료 카운트다운  :  사용 안함"),
                            ],) : Row(
                            children: [
                              Checkbox(
                                value: endCountdownYn,
                                onChanged: (bool? value) {
                                  context.read<TimerController>().modifyCheckbox('e', !endCountdownYn);
                                },
                              ),
                              Text("종료 카운트다운  :  "),
                              TextButton(onPressed: (){context.read<TimerController>().modifyCountdownTime("e");}, child: Text("10 초 전",style: TextStyle(decoration: TextDecoration.underline,decorationThickness: 0.5, ),),style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역도 축소
                              ),),
                              // TextButton(onPressed: (){_showNumberPickerDialog();}, child: Text("01",style: TextStyle(decoration: TextDecoration.underline,decorationThickness: 0.5, ),),style: OutlinedButton.styleFrom(
                              //   padding: EdgeInsets.zero,
                              //   minimumSize: Size.zero,
                              //   tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역도 축소
                              // ),),
                              const Spacer(),
                              IconButton(onPressed: (){
                                showDialog(
                                  context: context,
                                  builder: (context) => EndCountdownDialog(),
                                );
                                }, icon: Icon(Icons.edit_notifications_outlined, size: 20)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container( // 클리퍼 영역과 높이 겹치는 부분
                    decoration: BoxDecoration(
                      // border: Border.symmetric(horizontal:  BorderSide(color: Colors.red.withOpacity(0.5), width: 1.2)),
                      // border: Border.all(width: 1)
                    ),
                    width: SizeUtil().sw - (SizeUtil().sh15 * 1.08), // 플로팅버튼 부분과 구분해주기 위함(SizeUtil().sw - SizeUtil().sh15 * 0.6 - SizeUtil().sh15 * 0.48)
                    height: SizeUtil().sh15 * 0.4 * 1.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            MaterialCommunityIcons.content_save_edit_outline,
                            size: 25,
                            color: Colors.blueGrey.withOpacity(0.5),
                          ),
                          label:   Text("Save",
                              style: TextStyle(
                                  fontSize: SizeUtil().sh075 / 4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey),
                              textAlign: TextAlign.center),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            // 내부 여백 줄이기
                            minimumSize: Size(0, 0),
                            // 최소 크기 제한 해제
                            tapTargetSize:
                            MaterialTapTargetSize.shrinkWrap, // 터치 영역도 축소
                          ),
                        ),
                        SizedBox(width: 30,),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            MaterialCommunityIcons.rotate_left,
                            size: 25,
                            color: Colors.grey,
                          ),
                          label:   Text('초기화',
                              style: TextStyle(
                                  fontSize: SizeUtil().sh075 / 4,
                                  // fontSize: SizeUtil().sh075 / 3,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey),
                              textAlign: TextAlign.center),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            // 내부 여백 줄이기
                            minimumSize: Size(0, 0),
                            // 최소 크기 제한 해제
                            tapTargetSize:
                            MaterialTapTargetSize.shrinkWrap, // 터치 영역도 축소
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )


          ),
        ),
      ],
    );
  }

  void _showNumberPickerDialog2() {
    int tempSelected = 1;
    int _selectedNumber = 1;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('종료 카운트다운'),
          content: NumberPicker(
            value: tempSelected,
            minValue: 0,
            maxValue: 100,
            onChanged: (value) {
              setState(() {
                tempSelected = value;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 그냥 닫기
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedNumber = tempSelected;
                });
                Navigator.of(context).pop(); // 값 적용하고 닫기
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void _showNumberPickerDialog() {
    int tempSelected = 1;
    int _selectedNumber = 1;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('숫자 선택'),
          content: NumberPicker(
            value: tempSelected,
            minValue: 0,
            maxValue: 100,
            onChanged: (value) {
              setState(() {
                tempSelected = value;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 그냥 닫기
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedNumber = tempSelected;
                });
                Navigator.of(context).pop(); // 값 적용하고 닫기
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}


/// 사각형에서 오른쪽 하단에 있는 원형 영역을 빼는 클리퍼
class BiteClipper extends CustomClipper<Path> {
  final double biteRadius;

  BiteClipper({this.biteRadius = 30.0});

  @override
  Path getClip(Size size) {
    final rectPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)); // 기본 사각형 Path
    final biteCenter = Offset(size.width - biteRadius - biteRadius/2, size.height); // 원 중심점
    final bitePath = Path()..addOval(Rect.fromCircle(center: biteCenter, radius: biteRadius * 1.2)); // addOval은 인자를 받아 원형 Path를 만든다

    return Path.combine(PathOperation.difference, rectPath, bitePath); // Path1에서 Path2를 뺀 Path 반환
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true; // todo false로 바꿔주기
}

/// 한 입 베어먹은 모양의 박스 (그림자 포함)
class BiteContainer extends StatelessWidget {
  final Widget child;
  final double biteRadius;
  final double elevation;
  final Color color;

  const BiteContainer({
    Key? key,
    required this.child,
    this.biteRadius = 30.0,
    this.elevation = 4.0,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // PhysicalShape를 사용하면 CustomClipper로 잘린 모양에 그림자(elevation)를 줄 수 있습니다.
    return PhysicalShape(
      clipper: BiteClipper(biteRadius: biteRadius),
      elevation: elevation,
      color: color,
      child: child,
      shadowColor: Colors.blueGrey,
    );
  }
}