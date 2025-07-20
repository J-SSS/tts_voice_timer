import '../models/preset_model.dart';

import '../manager/db_manager.dart';

/// TimerRepository
class TimerRepository {
  final DbManager dbManager = DbManager.instance;
  // final PrefsManager prefsManager = PrefsManager.instance;

  TimerRepository();

  /// SharedPreferences에서 최근 사용 타이머 정보를 불러온다
  // TimerModel getRecentFromPrefs()  {
  //   Map<String, dynamic> recentTimer = prefsManager.getRecentTimer();
  //   print(recentTimer);
  //   return TimerModel.fromMap(recentTimer);
  // }

  /// tvt_group 및 tvt_timer 테이블의 모든 데이터를 PresetModel로 반환한다
  Future<PresetModel?> getPresetFromDb() async {
    final presetData =  await dbManager.getPresetData();
    final timerData =  await dbManager.getTimerData();
    return PresetModel.fromMap(presetData,timerData);
  }

  /// tvt_group에 새 그룹을 생성한다
  Future<void> insertGroup(Map<String, dynamic> data) async {
    await dbManager.insertPreset(data);
  }

  /// tvt_timer에 새 타이머를 생성한다
  Future<void> insertTimer(Map<String, dynamic> data) async {
    await dbManager.insertTimer(data);
  }

  /// tvt_timer의 타이머를 업데이트한다 todo 수정해야함
  Future<void> updateTimer(Map<String, dynamic> data) async {
    await dbManager.insertPreset(data);
  }

  /// tvt_preset에 새 그룹을 생성하기 위한 sortOrder 값을 반환한다
  Future<List<Map<String, dynamic>>> getSortOrderPreset() async {
    return await dbManager.getSortOrderPreset();
  }

  /// tvt_preset에서 그룹을 삭제한다
  Future<void> deletePreset(int presetId) async {
    await dbManager.deletePreset(presetId);
  }

  /// tvt_timer에서 presetId에 해당하는 타이머를 삭제한다
  Future<void> deleteTimerByPresetId(int presetId) async {
    await dbManager.deleteTimerByPresetId(presetId);
  }
}