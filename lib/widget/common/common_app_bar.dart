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
              Text("(타이머) / (스톱워치) / (인터벌)",
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