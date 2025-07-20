import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tts_voice_timer/utils/size_util.dart';

class ListDialog extends StatefulWidget {
  const ListDialog({super.key});

  @override
  State<ListDialog> createState() => _ListDialogState();
}

class _ListDialogState extends State<ListDialog> {

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
                  color: Colors.grey.shade50,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        elevation: 2.0,
                        child: ListTile(
                            leading: Icon(Icons.timer, color: Colors.orange),
                            title: Text('타이머 ${index + 1}'),
                            subtitle: Text('${index * 5 + 5}분'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    // Handle edit button press
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
                    },
                  ),
                ),
              ),
              Container(
                color: Colors.grey.shade50,
                height: SizeUtil().sh06,
                child: Align(
                  alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // context.read<TimerController>().modifyCountdownDetailSetup("e", 0, 0, 0);
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
                ),

              )
            ]
            ,),
        )
    );
  }
}
