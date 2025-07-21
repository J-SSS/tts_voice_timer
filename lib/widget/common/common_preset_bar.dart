import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:tts_voice_timer/models/preset_model.dart';
import 'package:tts_voice_timer/models/timer_model.dart';
import '../../../utils/size_util.dart';
import '../../provider/timer_controller.dart';
import '../../utils/common_values.dart';


class CommonPresetBar extends StatefulWidget {
  const CommonPresetBar({Key? key}) : super(key: key);

  @override
  State<CommonPresetBar> createState() => _MainToolbarState();
}

class _MainToolbarState extends State<CommonPresetBar> {

  @override
  Widget build(BuildContext context) {
    List<PresetModel> presetList = context.read<TimerController>().presetDataList;
    int presetListLength = presetList.length;

    print('이게왜리빌드');

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
        child: ListView.builder( // todo 스크롤 위치 기억할 수 있도록 수정하기
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemCount: presetListLength,
            itemBuilder: (context, index) {

            TimerModel? timerModel = presetList[index].timerModel;



          String? hour = timerModel?.setupHour.toString().padLeft(2, '0');
              String? min = timerModel?.setupMin.toString().padLeft(2, '0');
              String? sec = timerModel?.setupSec.toString().padLeft(2, '0');
              String timeText = presetList[index].presetTitle.isNotEmpty
                  ? presetList[index].presetTitle
                  : '$hour:$min:$sec';

            Color dotColor = commonColorList[int.parse(presetList[index].presetColor)];

              return Container( // todo ListView 부모요소의 사이즈를 바꿔줘야함
                // height: SizeUtil().sh01,
                // width: SizeUtil().sw20 * 2,
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 15),
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.read<TimerController>().assignCurrentPreset(presetList[index]);
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
        );
  }
}