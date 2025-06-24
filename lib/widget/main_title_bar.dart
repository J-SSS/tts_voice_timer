import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../utils/app_utils.dart';
import '../../utils/common_values.dart';
import '../../utils/size_util.dart';


class MainTitlebar extends StatefulWidget {
  const MainTitlebar({Key? key}) : super(key: key);

  @override
  State<MainTitlebar> createState() => _MainToolbarState();
}

class _MainToolbarState extends State<MainTitlebar> {

  TimeOfDay? _selectedTime;
  String _selectedTimeText = "";


  @override
  Widget build(BuildContext context) {
    return Container(
          width: SizeUtil().sw,
          height: SizeUtil().sh05,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          // alignment: Alignment.topCenter,
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
            children: [
              Text("기본 타이머",
                  style: TextStyle(
                      fontSize: SizeUtil().sh10 / 4,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                  textAlign: TextAlign.center),
            // TextButton( /** 우 버튼 */
              //     onPressed: () {
              //     },
              //     style: ElevatedButton.styleFrom(
              //       shape: const CircleBorder(),
              //       // padding: EdgeInsets.all(10.0),
              //       // fixedSize: Size(55.0, 55.0),
              //     ),
              //     // child: Icon(MaterialCommunityIcons.chevron_right_circle,size: 35,),
              //     child: Icon(MaterialCommunityIcons.view_list,size: 35,),
              // ),
            ],
          )
      );
  }
}