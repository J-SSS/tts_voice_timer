import 'package:flutter/material.dart';

class StartCountdownSettingScreen extends StatefulWidget {
  const StartCountdownSettingScreen({Key? key}) : super(key: key);

  @override
  State<StartCountdownSettingScreen> createState() =>
      _StartCountdownSettingScreenState();
}

class _StartCountdownSettingScreenState
    extends State<StartCountdownSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('시작 카운트다운 설정'),
      ),
      body: Center(
        child: const Text(
          '여기에 설정 UI를 추가하세요',
          style: TextStyle(fontSize: 16),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 플로팅 버튼 눌렀을 때 동작 구현
        },
        child: const Icon(Icons.save_outlined),
      ),
    );
  }
}
