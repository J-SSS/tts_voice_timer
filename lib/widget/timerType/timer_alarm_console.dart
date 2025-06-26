import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/common_values.dart';
import '../../../utils/size_util.dart';


class TimerAlarmConsole extends StatefulWidget {
  const TimerAlarmConsole({Key? key}) : super(key: key);

  @override
  State<TimerAlarmConsole> createState() => _MainToolbarState();
}

class _MainToolbarState extends State<TimerAlarmConsole> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BiteContainer( // 배경 박스
          biteRadius: SizeUtil().sh15 * 0.4,
          // biteRadius: 50,
          elevation: 5.0,
          // color: Colors.yellow.withOpacity(0.9),
          color: Colors.white60.withOpacity(0.9),
          child: Container( // 완전한 네모 영역
              decoration: BoxDecoration(
                // color: Colors.green.withOpacity(0.6),
              ),
              width: SizeUtil().sw,
              // height: SizeUtil().sh10,
              height: SizeUtil().sh25 * 0.97,
              // padding: const EdgeInsets.all(16.0),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container( // 클리퍼 영역과 높이 안겹치는 부분
                    decoration: BoxDecoration(
                      border: Border.symmetric(horizontal:  BorderSide(color: Colors.blue.withOpacity(0.5), width: 0.5)),
                      // color: Colors.red.withOpacity(0.1),
                    ),
                    // color: Colors.red.withOpacity(0.1),
                    height: SizeUtil().sh25 * 0.97 - SizeUtil().sh15 * 0.4 * 1.2,
                    width: 500,
                    // width: SizeUtil().sw - (SizeUtil().sh15 * 1.08), // 플로팅버튼 부분과 구분해주기 위함(SizeUtil().sw - SizeUtil().sh15 * 0.6 - SizeUtil().sh15 * 0.48)
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Text("시작 카운트"),
                        // Text("간격 카운트"),
                        // Text("종료 카운트"),
                      ],
                    ),
                  ),
                  Container( // 클리퍼 영역과 높이 겹치는 부분
                    decoration: BoxDecoration(
                      // border: Border.symmetric(horizontal:  BorderSide(color: Colors.red.withOpacity(0.5), width: 1.2)),
                      border: Border.all(width: 1)
                    ),
                    width: SizeUtil().sw - (SizeUtil().sh15 * 1.08), // 플로팅버튼 부분과 구분해주기 위함(SizeUtil().sw - SizeUtil().sh15 * 0.6 - SizeUtil().sh15 * 0.48)
                    height: SizeUtil().sh15 * 0.4 * 1.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
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