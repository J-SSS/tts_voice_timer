import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tts_voice_timer/models/timer_model.dart';

import 'group_model.dart';

/// tvt_group 및 tvt_timer 테이블을 맵핑하기 위한 Model
class PresetModel {
  final int presetId; /// 프리셋 고유아이디
  final int presetType; /// 프리셋 타입 (1: 타이머, 2: 스톱워치, 3: 인터벌, 4: 알람)
  final int sortOrder; /// 정렬 순서
  final String presetName; /// 프리셋 이름
  final String presetColor; /// 프리셋 컬러
  final String timerId; /// 프리셋 컬러
  final TimerModel? timerModel ; /// 타이머 Model

  /// Named Parameter 기본 생성자
  PresetModel(
      {
        this.presetId = -1,
        this.presetType = 0,
        this.sortOrder = 0,
        this.presetName = "00:05:00",
        this.presetColor = "red",
        this.timerId = "0",
        this.timerModel
      }
  );

  /// 객체 복사용 copyWith
  PresetModel copyWith({
    int? presetId,
    int? presetType,
    int? sortOrder,
    String? presetName,
    String? presetColor,
    String? timerId,
    TimerModel? timerModel,
  }) {
    return PresetModel(
      presetId : presetId ?? this.presetId,
      presetType : presetType ?? this.presetType,
      sortOrder : sortOrder ?? this.sortOrder,
      presetName : presetName ?? this.presetName,
      presetColor : presetColor ?? this.presetColor,
      timerId : timerId ?? this.timerId,
      timerModel : timerModel ?? this.timerModel,
    );
  }

  /// Map을 객체로 변환
  factory PresetModel.fromMap(Map<String, dynamic> presetDataList) {
    return PresetModel(
      presetId: presetDataList['presetId'],
      presetType: presetDataList['presetType'],
      sortOrder: presetDataList['sortOrder'],
      presetName: presetDataList['presetName'],
      presetColor: presetDataList['presetColor'],
      timerId: presetDataList['timerId'],
      timerModel: null, // DB에서 직접 join 해서 가져올 수 있는지 확인해보기
    );
  }

  /// 삭제예정
  factory PresetModel.fromMap2(List<Map<String, dynamic>> presetDataList, List<Map<String, dynamic>> timerDataList) {
    TimerModel timerModel = TimerModel.fromMap(timerDataList[0]);

    PresetModel presetModel = PresetModel(
      presetId: presetDataList[0]['presetId'],
      presetType: presetDataList[0]['presetType'],
      sortOrder: presetDataList[0]['sortOrder'],
      presetName: presetDataList[0]['presetName'],
      presetColor: presetDataList[0]['presetColor'],
      timerId: presetDataList[0]['timerId'],
      timerModel: timerModel,
    );

    return presetModel;
  }

  /// 객체를 Map으로 변환
  Map<String, dynamic> toMap() {
    return {
      'presetId': presetId,
      'presetType': presetType,
      'sortOrder': sortOrder,
      'presetName': presetName,
      'presetColor': presetColor,
      'timerId': timerId,
      'timerModel': timerModel,
    };
  }
}
