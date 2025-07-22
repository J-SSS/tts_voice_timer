import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:tts_voice_timer/main.dart';
import 'package:tts_voice_timer/models/timer_model.dart';
import '../../../utils/size_util.dart';
import '../../models/preset_model.dart';
import '../../provider/timer_controller.dart';

class TimerTimeConsole extends StatefulWidget {
  const TimerTimeConsole({Key? key}) : super(key: key);

  @override
  State<TimerTimeConsole> createState() => _MainToolbarState();
}

class _MainToolbarState extends State<TimerTimeConsole> {
  double arrowIconSize = 25;

  @override
  Widget build(BuildContext context) {
    TimerModel timerModel = context.select((TimerController T) => T.currentTimer);

    String? frmtHour = timerModel?.setupHour.toString().padLeft(2, '0');
    String? frmtMin = timerModel?.setupMin.toString().padLeft(2, '0');
    String? frmtSec = timerModel?.setupSec.toString().padLeft(2, '0');

    return Container(
        width: SizeUtil().sw,
        height: SizeUtil().sh40,
        margin: EdgeInsets.fromLTRB(0, 10.sp, 0, 10.sp),
        padding: EdgeInsets.fromLTRB(0, 10.sp, 0, 10.sp),
        // alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // 균일한 간격으로 배치
              children: [
                TextButton(
                  onPressed: () {
                    context.read<TimerController>().modifySetupTime('h', 5);
                  },
                  child: Icon(
                    Icons.keyboard_double_arrow_up_rounded,
                    size: arrowIconSize,
                    color: Colors.blueGrey,
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    // minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<TimerController>().modifySetupTime('m', 5);
                  },
                  child: Icon(
                    Icons.keyboard_double_arrow_up_rounded,
                    size: arrowIconSize,
                    color: Colors.blueGrey,
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    // minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<TimerController>().modifySetupTime('s', 5);
                  },
                  child: Icon(
                    Icons.keyboard_double_arrow_up_rounded,
                    size: arrowIconSize,
                    color: Colors.blueGrey,
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    // minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // 균일한 간격으로 배치
              children: [
                OutlinedButton(
                  onPressed: () {
                    context.read<TimerController>().modifySetupTime('h', 1);
                  },
                  child: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: arrowIconSize,
                    color: Colors.blueGrey,
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    // minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    context.read<TimerController>().modifySetupTime('m', 1);
                  },
                  child: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: arrowIconSize,
                    color: Colors.blueGrey,
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    // minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    context.read<TimerController>().modifySetupTime('s', 1);
                  },
                  child: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: arrowIconSize,
                    color: Colors.blueGrey,
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    // minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Text(context.watch<TimerController>().currentTimer.setupTime.toString(),
                Text(frmtHour!,
                    style: TextStyle(
                        fontSize: 60.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                    textAlign: TextAlign.center),
                Text(":",
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                    textAlign: TextAlign.center),
                Text(frmtMin!,
                    style: TextStyle(
                        fontSize: 60.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                    textAlign: TextAlign.center),
                Text(":",
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                    textAlign: TextAlign.center),
                Text(frmtSec!,
                    style: TextStyle(
                        fontSize: 60.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                    textAlign: TextAlign.center),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // 균일한 간격으로 배치
              children: [
                OutlinedButton(
                  onPressed: () {
                    context.read<TimerController>().modifySetupTime('h', -1);
                  },
                  child: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: arrowIconSize,
                    color: Colors.blueGrey,
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    // minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    context.read<TimerController>().modifySetupTime('m', -1);
                  },
                  child: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: arrowIconSize,
                    color: Colors.blueGrey,
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    // minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    context.read<TimerController>().modifySetupTime('s', -1);
                  },
                  child: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: arrowIconSize,
                    color: Colors.blueGrey,
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    // minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    context.read<TimerController>().modifySetupTime('h', -5);
                  },
                  child: Icon(
                    Icons.keyboard_double_arrow_down_rounded,
                    size: arrowIconSize,
                    color: Colors.blueGrey,
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    // minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<TimerController>().modifySetupTime('m', -5);
                  },
                  child: Icon(
                    Icons.keyboard_double_arrow_down_rounded,
                    size: arrowIconSize,
                    color: Colors.blueGrey,
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    // minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<TimerController>().modifySetupTime('s', -5);
                  },
                  child: Icon(
                    Icons.keyboard_double_arrow_down_rounded,
                    size: arrowIconSize,
                    color: Colors.blueGrey,
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    // minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
