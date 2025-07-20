import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:tts_voice_timer/models/preset_model.dart';
import '../../../utils/size_util.dart';
import '../../provider/timer_controller.dart';


class CommonPresetBar extends StatefulWidget {
  const CommonPresetBar({Key? key}) : super(key: key);

  @override
  State<CommonPresetBar> createState() => _MainToolbarState();
}

class _MainToolbarState extends State<CommonPresetBar> {

  @override
  Widget build(BuildContext context) {
    PresetModel? presetModel = context.read<TimerController>().currentPreset;
    print(presetModel?.presetName);

    return Container(
        width: SizeUtil().sw,
        height: SizeUtil().sh10,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          // color: Colors.white.withOpacity(0.8),
          color: Colors.white,
          // color: Colors.red,
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
        child: Container(
          height: SizeUtil().sh10,
          child: ListView.builder( // todo 스크롤 위치 기억할 수 있도록 수정하기
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemCount: 8, // 예시로 8개의 타이머 표시
            itemBuilder: (context, index) {
              // 타이머 시간 계산 (5분씩 증가)
              int minutes = (index + 1) * 5;
              String hours = (minutes ~/ 60).toString().padLeft(2, '0');
              String mins = (minutes % 60).toString().padLeft(2, '0');
              String timeText = '${hours}:${mins}:00';

              // 색상 순환
              Color dotColor = index % 4 == 0
                  ? Colors.deepOrangeAccent
                  : index % 4 == 1
                      ? Colors.blue
                      : index % 4 == 2
                          ? Colors.green
                          : Colors.purple;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 3, vertical: 15),
                child: OutlinedButton.icon(
                  onPressed: () {
                    // 타이머 선택 처리
                  },
                  icon: Icon(MaterialCommunityIcons.circle,
                      size: 15, color: dotColor),
                  label: Text(timeText),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              );
            },
          ),
        ));
  }
}