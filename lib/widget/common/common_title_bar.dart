import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/common_values.dart';
import '../../../utils/size_util.dart';


class CommonTitleBar extends StatefulWidget {
  const CommonTitleBar({Key? key}) : super(key: key);

  @override
  State<CommonTitleBar> createState() => _MainToolbarState();
}

class _MainToolbarState extends State<CommonTitleBar> {

  TimeOfDay? _selectedTime;
  String _selectedTimeText = "";


  @override
  Widget build(BuildContext context) {
    return Container(
          width: SizeUtil().sw,
          height: SizeUtil().sh05,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
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
          child : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(MaterialCommunityIcons.pencil,size: 18,color: Colors.grey,),//format_paint,
                // label:   Text("새 음성 타이머")
                label:   Text("새 음성 타이머",style: TextStyle(fontSize: 22),),
                // label:   Text("새 음성 타이머",
                //     style: TextStyle(
                //         fontSize: SizeUtil().sh075 / 3,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.blueGrey),
                //     textAlign: TextAlign.center),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2), // 내부 여백 줄이기
                  minimumSize: Size(0, 0), // 최소 크기 제한 해제
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역도 축소
                ),
              ),
            // TextButton(
            //       onPressed: () {
            //       },
            //       style: ElevatedButton.styleFrom(
            //         shape: const CircleBorder(),
            //         // padding: EdgeInsets.all(10.0),
            //         // fixedSize: Size(55.0, 55.0),
            //       ),
            //       // child: Icon(MaterialCommunityIcons.chevron_right_circle,size: 35,),
            //       child: Icon(MaterialCommunityIcons.view_list,size: 35,),
            //   ),
            ],
          )
      );
  }
}