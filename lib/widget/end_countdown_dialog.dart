import 'package:flutter/material.dart';

import '../utils/size_util.dart';

class EndCountdownDialog extends StatefulWidget {
  @override
  _EndCountdownDialogState createState() => _EndCountdownDialogState();
}

class _EndCountdownDialogState extends State<EndCountdownDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _heightAnimation = Tween<double>(
      begin: SizeUtil().sh25 * 1.5, // 초기 높이
      end: SizeUtil().sh50 * 1.5,   // 확장된 높이
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
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
      child: AnimatedBuilder(
        animation: _heightAnimation,
        builder: (context, child) {
          return Container( // dialog 실제 영역
            width: SizeUtil().sw80,
            height: _heightAnimation.value,
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                  height: 40,
                  color: Colors.orange,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '알림 상세 설정',
                        style: TextStyle(
                            fontSize: 15,
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
                ), // 헤더 부분
                Container( // 본문 영역
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                  height: 150,
                  color: Colors.white,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 30,
                        child: Text(
                          '00 초 전 부터 00 초 간격 ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(onPressed: (){}, child: Text("음성")),
                          TextButton(onPressed: (){}, child: Text("소리")),
                          TextButton(onPressed: (){}, child: Text("진동"))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ' 00 초 남았습니다',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_drop_down),
                            color: Colors.blueGrey,
                            onPressed: (){},
                          ),
                          IconButton(
                            icon: Icon(Icons.settings),
                            color: Colors.blueGrey,
                            onPressed: (){},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                  height: 50,
                  color: Colors.grey.withOpacity(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      ElevatedButton(
                        onPressed: _toggleExpansion,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_isExpanded ? '스크립트' : '스크립트'),
                            SizedBox(width: 5),
                            AnimatedRotation(
                              turns: _isExpanded ? 0.5 : 0,
                              duration: Duration(milliseconds: 300),
                              child: Icon(Icons.expand_more),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '저장',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),

                // 확장 버튼


                // 확장되는 콘텐츠
                if (_isExpanded) ...[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expanded Content',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('확장',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 15),

                          // 추가 위젯들 예시
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter something',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 15),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Action 1'),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Action 2'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
