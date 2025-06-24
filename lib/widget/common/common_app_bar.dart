import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../utils/app_utils.dart';
import '../../utils/common_values.dart';
import '../../utils/size_util.dart';


class CommonAppBar extends StatefulWidget {
  const CommonAppBar({Key? key}) : super(key: key);

  @override
  State<CommonAppBar> createState() => _MainToolbarState();
}

class _MainToolbarState extends State<CommonAppBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
          width: SizeUtil().sw,
          height: SizeUtil().sh075,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.timelapse,size: 20),
                label: Text('타이머'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // 내부 여백 줄이기
                  // minimumSize: Size(0, 0), // 최소 크기 제한 해제
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역도 축소
                ),
              ),
              // SizedBox(height: 16),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.timer,size: 20),
                label: Text('스톱워치'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // 내부 여백 줄이기
                  // minimumSize: Size(0, 0), // 최소 크기 제한 해제
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역도 축소
                ),
              ),
              // SizedBox(height: 10),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(MaterialCommunityIcons.repeat,size: 20),//format_paint,
                label: Text('인터벌'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // 내부 여백 줄이기
                  // minimumSize: Size(0, 0), // 최소 크기 제한 해제
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역도 축소
                ),
              ),
              // SizedBox(height: 15),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(MaterialCommunityIcons.alarm,size: 20,),//format_paint,
                label: Text('알람'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // 내부 여백 줄이기
                  // minimumSize: Size(0, 0), // 최소 크기 제한 해제
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역도 축소
                ),
              ),

              // ElevatedButton.icon(
              //   onPressed: () {},
              //   icon: Icon(Icons.thumb_up),
              //   label: Text('타이머'),
              // ),
              // SizedBox(height: 16),
              // OutlinedButton.icon(
              //   onPressed: () {},
              //   icon: Icon(Icons.send),
              //   label: Text('스톱워치'),
              // ),
              // SizedBox(height: 16),
              // TextButton.icon(
              //   onPressed: () {},
              //   icon: Icon(Icons.info),
              //   label: Text('인터벌'),
              // ),

              // Text("(타이머) / (스톱워치) / (인터벌)",
              //     style: TextStyle(
              //         fontSize: SizeUtil().sh10 / 4,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.blueGrey),
              //     textAlign: TextAlign.center),
            ],
          )
      );
  }
}