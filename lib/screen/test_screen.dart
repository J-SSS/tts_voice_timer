import 'package:flutter/material.dart';
// import 'package:flutter_beep/flutter_beep.dart';
// import 'package:neo_beep/neo_beep.dart' ;



class SoundTestApp extends StatelessWidget {
  const SoundTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beep Sound Tester',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SoundTestPage(),
    );
  }
}

class SoundTestPage extends StatelessWidget {
  const SoundTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final tests = <_SoundTestItem>[
    //   _SoundTestItem(
    //     label: 'Beep (success)',
    //     action: () => FlutterBeep.beep(),
    //   ),
    //   _SoundTestItem(
    //     label: 'Beep (failure)',
    //     action: () => FlutterBeep.beep(false),
    //   ),
    //   _SoundTestItem(
    //     label: 'Android: CDMA Alert',
    //     action: () => FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_ABBR_ALERT),
    //   ),
    //   _SoundTestItem(
    //     label: 'Android: BEEP',
    //     action: () => FlutterBeep.playSysSound(AndroidSoundIDs.TONE_PROP_BEEP),
    //   ),
    //   _SoundTestItem(
    //     label: 'Android: DTMF 0',
    //     action: () => FlutterBeep.playSysSound(AndroidSoundIDs.TONE_DTMF_0),
    //   ),
    //   _SoundTestItem(
    //     label: 'iOS: Busy',
    //     action: () => FlutterBeep.playSysSound(iOSSoundIDs.AudioToneBusy),
    //   ),
    //   // _SoundTestItem(
    //   //   label: 'iOS: Ringtone',
    //   //   action: () => FlutterBeep.playSysSound(iOSSoundIDs.ReceivedMessage),
    //   // ),
    // ];

    return Scaffold(
      appBar: AppBar(title: const Text('Beep Sound Tester')),
      // body: ListView.builder(
      //   padding: const EdgeInsets.all(16),
      //   itemCount: tests.length,
      //   itemBuilder: (context, index) {
      //     final item = tests[index];
      //     return Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 8),
      //       child: ElevatedButton(
      //         onPressed: item.action,
      //         child: Text(item.label),
      //       ),
      //     );
      //   },
      // ),


      // body: Column(
      //   children: <Widget>[
      //     ElevatedButton(
      //       child: Text("Beep Success"),
      //       onPressed: () => NeoBeep.beep(),
      //     ),
      //     ElevatedButton(
      //       child: Text("Beep Fail"),
      //       onPressed: () => NeoBeep.beep(false),
      //     ),
      //     ElevatedButton(
      //       child: Text("Beep Android Custom"),
      //       onPressed: () =>
      //           NeoBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_ABBR_ALERT),
      //     ),
      //     ElevatedButton(
      //       child: Text("Beep something"),
      //       onPressed: () => NeoBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_CALL_SIGNAL_ISDN_PAT7),
      //     ),
      //     ElevatedButton(
      //       child: Text("TONE_CDMA_ANSWER"),
      //       onPressed: () => NeoBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_ANSWER),
      //     ),
      //     ElevatedButton(
      //       child: Text(""),
      //       onPressed: () => NeoBeep.playSysSound(26),
      //     ),

          // 25






        // ],
      // ),
    );
  }
}



// extension AndroidSoundIDsExtension on AndroidSoundIDs {
// static Map<String, int> get values => {
// 'TONE_CDMA_ABBR_ALERT': TONE_CDMA_ABBR_ALERT,
// 'TONE_CDMA_ABBR_INTERCEPT': TONE_CDMA_ABBR_INTERCEPT,
// // Add all other sound IDs here...
// };
// }

class _SoundTestItem {
  final String label;
  final VoidCallback action;
  const _SoundTestItem({required this.label, required this.action});
}
