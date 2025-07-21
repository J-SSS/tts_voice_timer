import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tts_voice_timer/utils/common_values.dart';
import 'package:tts_voice_timer/utils/size_util.dart';

import '../models/preset_model.dart';
import '../models/timer_model.dart';
import '../provider/timer_controller.dart';

class ListDialog extends StatefulWidget {
  const ListDialog({super.key});

  @override
  State<ListDialog> createState() => _ListDialogState();
}

class _ListDialogState extends State<ListDialog> {
  final TextEditingController _textController = TextEditingController();
  String? selectedPresetColor;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose(); // TextEditingController 해제
  }

  @override
  Widget build(BuildContext context) {
    List<PresetModel> presetList = context.read<TimerController>().presetDataList;

    return Dialog(
        insetPadding: EdgeInsets.zero,
        // elevation: 1.0,
        // surfaceTintColor: Colors.green, // 초록색 틴트
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Container(
          width: SizeUtil().sw80,
          height: SizeUtil().sh45,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                color: Colors.orange,
                height: SizeUtil().sh06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '사전 설정 타이머',
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
              ),
              Expanded(
                child: Container(
                  // height: SizeUtil().sh30,
                  color: Colors.grey.shade50,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    itemCount: presetList.length + 1,
                    itemBuilder: (context, index) {

                      if(index == presetList.length) {
                        return Card(
                            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                            elevation: 1.5,
                            // child: TextField(
                            //   decoration: InputDecoration(
                            //     hintText: 'Enter text',
                            //   ),
                            // ),
                            child: ListTile(
                              // contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              title: Center(
                                  child:Icon(Icons.add_circle_outline_rounded, color: Colors.grey)
                              ),
                              onTap: () {

                              },
                            ),
                          );
                      } else {
                        TimerModel? timerModel = presetList[index].timerModel;

                        String? hour = timerModel?.setupHour.toString().padLeft(2, '0');
                        String? min = timerModel?.setupMin.toString().padLeft(2, '0');
                        String? sec = timerModel?.setupSec.toString().padLeft(2, '0');

                        String presetTitle = presetList[index].presetTitle.isNotEmpty
                            ? presetList[index].presetTitle
                            : '$hour:$min:$sec';
                        String presetSubName = '$hour:$min:$sec';


                        Color dotColor = commonColorList[int.parse(presetList[index].presetColor)];

                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                          elevation: 1.5,
                          child: ListTile(
                            // contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 10),
                            leading: Icon(Icons.timer, color: dotColor),
                            title: Text(presetTitle),
                            subtitle: Text(presetSubName),
                            trailing: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    _textController.text = presetList[index].presetTitle;
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setStateInner) {
                                            return AlertDialog(
                                              title: Text('타이틀 수정'),
                                              content: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  DropdownButton<String>(
                                                    underline: SizedBox.shrink(),
                                                    value: selectedPresetColor ?? presetList[index].presetColor,
                                                    items: List.generate(commonColorList.length, (index) {
                                                      return DropdownMenuItem<String>(
                                                        value: index.toString(),
                                                        child: Icon(Icons.circle, color: commonColorList[index]),
                                                      );
                                                    }),
                                                    onChanged: (value) {
                                                      setStateInner(() {
                                                        selectedPresetColor = value ?? "0";
                                                      });
                                                    },
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                      controller: _textController,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    selectedPresetColor = null;
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('취소'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    context.read<TimerController>().modifyPresetTitle(
                                                        {"presetId" : presetList[index].presetId,
                                                          "presetTitle" : _textController.text,
                                                          "presetColor" : selectedPresetColor ?? presetList[index].presetColor
                                                        }
                                                    );
                                                    _textController.text = ""; // Clear the text field
                                                    selectedPresetColor = null;
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('저장'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    // Handle delete button press
                                  },
                                ),
                              ],
                            ),
                            onTap: () {
                              // Handle timer selection
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Container(
                color: Colors.grey.shade300,
                height: SizeUtil().sh06,
                child: Align(
                  alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // context.read<TimerController>().modifyCountdownDetailSetup("e", 0, 0, 0);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        '확인',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      ),
                    )
                ),

              )
            ]
            ,),
        )
    );
  }
}
