import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';

// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/common_values.dart';
import '../../../utils/size_util.dart';

class TimerTimeConsole extends StatefulWidget {
  const TimerTimeConsole({Key? key}) : super(key: key);

  @override
  State<TimerTimeConsole> createState() => _MainToolbarState();
}

class _MainToolbarState extends State<TimerTimeConsole> {
  TimeOfDay? _selectedTime;
  String _selectedTimeText = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeUtil().sw,
        height: SizeUtil().sh40,
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
        // alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: Colors.white54.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 1,
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
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.keyboard_double_arrow_up_rounded,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.keyboard_double_arrow_up_rounded,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.keyboard_double_arrow_up_rounded,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // 균일한 간격으로 배치
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("00",
                    style: TextStyle(
                        fontSize: SizeUtil().sh10 * 0.9,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                    textAlign: TextAlign.center),
                Text(":",
                    style: TextStyle(
                        fontSize: SizeUtil().sh05,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                    textAlign: TextAlign.center),
                Text("00",
                    style: TextStyle(
                        fontSize: SizeUtil().sh10 * 0.9,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                    textAlign: TextAlign.center),
                Text(":",
                    style: TextStyle(
                        fontSize: SizeUtil().sh05,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                    textAlign: TextAlign.center),
                Text("00",
                    style: TextStyle(
                        fontSize: SizeUtil().sh10 * 0.9,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                    textAlign: TextAlign.center),
                // Align(
                //   child: Text("00 : 00 : 00",
                //       style: TextStyle(
                //           fontSize: SizeUtil().sh10 * 0.8,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.blueGrey),
                //       textAlign: TextAlign.center),
                // ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // 균일한 간격으로 배치
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // 균일한 간격으로 배치
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.keyboard_double_arrow_down_rounded,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.keyboard_double_arrow_down_rounded,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.keyboard_double_arrow_down_rounded,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
