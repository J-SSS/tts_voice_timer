import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../utils/app_utils.dart';
import '../../utils/common_values.dart';
import '../../utils/size_util.dart';


class MainToolbar extends StatefulWidget {
  const MainToolbar({Key? key}) : super(key: key);

  @override
  State<MainToolbar> createState() => _MainToolbarState();
}

class _MainToolbarState extends State<MainToolbar> {

  TimeOfDay? _selectedTime;
  String _selectedTimeText = "";


  @override
  Widget build(BuildContext context) {
    return Container(
          width: SizeUtil().sw,
          height: SizeUtil().sh10 * 0.9,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          // alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: Colors.white,
            // color: Colors.red,
            borderRadius: BorderRadius.circular(50),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton( /** 좌 버튼 */
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    // padding: EdgeInsets.all(10.0),
                    // fixedSize: Size(55.0, 55.0),
                  ),
                // child: Icon(MaterialCommunityIcons.chevron_left_circle,size: 35,),
                child: Icon(MaterialCommunityIcons.chevron_left,size: 35,),
              ),

              Align(child: Text(_selectedTimeText,style: TextStyle(fontSize: SizeUtil().sh10/2.5, fontWeight: FontWeight.bold, color: Colors.blueGrey), textAlign: TextAlign.center),),

              TextButton( /** 우 버튼 */
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    // padding: EdgeInsets.all(10.0),
                    // fixedSize: Size(55.0, 55.0),
                  ),
                  // child: Icon(MaterialCommunityIcons.chevron_right_circle,size: 35,),
                  child: Icon(MaterialCommunityIcons.chevron_right,size: 35,),
              ),
            ],
          )
      );
  }
}