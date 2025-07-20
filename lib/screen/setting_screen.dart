import 'package:flutter/material.dart';

import '../manager/db_manager.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<bool> switchValues = List.generate(10, (index) => false);
  final dbManager = DbManager.instance;
  // final prefsManager = PrefsManager.instance; // todo 수정필요
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('앱 설정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '타이머 작동 중 상단 바 숨김',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Switch(
                  value: false,
                  onChanged: (value) {
                    setState(() {
                      // switchValues[index] = value;
                    });
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '백그라운드에서도 실행',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Switch(
                  value: false,
                  onChanged: (value) {
                    setState(() {
                      // switchValues[index] = value;
                    });
                  },
                ),
              ],
            ),
            const Divider(),
            TextButton(onPressed: () async {

                await dbManager.resetData();
                // await prefsManager.resetData();

              print('DB 삭제 완료');

            }, child: Text('설정 초기화'))
          ]
        ),
      ),
    );
  }
}