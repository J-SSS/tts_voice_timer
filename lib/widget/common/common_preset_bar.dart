import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import '../../../utils/size_util.dart';


class CommonPresetBar extends StatefulWidget {
  const CommonPresetBar({Key? key}) : super(key: key);

  @override
  State<CommonPresetBar> createState() => _MainToolbarState();
}

class _MainToolbarState extends State<CommonPresetBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
          width: SizeUtil().sw,
          height: SizeUtil().sh10,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            // color: Colors.white.withOpacity(0.8),
            color: Colors.white,
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
              OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(MaterialCommunityIcons.circle,size: 20,color: Colors.deepOrangeAccent,),//format_paint,
                label: Text('00:05:00'),
                // style: OutlinedButton.styleFrom(
                //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // 내부 여백 줄이기
                //   // minimumSize: Size(0, 0), // 최소 크기 제한 해제
                //   tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역도 축소
                // ),
              ),
              SizedBox(width: 5,),
              OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(MaterialCommunityIcons.circle,size: 20,color: Colors.blue,),//format_paint,
                label: Text('00:10:00'),
                // style: OutlinedButton.styleFrom(
                //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // 내부 여백 줄이기
                //   // minimumSize: Size(0, 0), // 최소 크기 제한 해제
                //   tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역도 축소
                // ),
              ),
              SizedBox(width: 5,),
              OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(MaterialCommunityIcons.circle,size: 20,color: Colors.green,),//format_paint,
                label: Text('00:15:00'),
                // style: OutlinedButton.styleFrom(
                //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // 내부 여백 줄이기
                //   // minimumSize: Size(0, 0), // 최소 크기 제한 해제
                //   tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역도 축소
                // ),
              ),
            ],
          )
      );
  }
}