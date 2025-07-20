import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'app_manager.dart';

/// DbManager
class DbManager {
  static const _dbName = 'myDatabase.db';
  static const _dbVersion = 1;
  static const _tablePreset = 'tvt_preset';
  static const _tableTimer = 'tvt_timer';
  static const _tableConfig = 'tvt_config';

  static final DbManager instance = DbManager._();
  DbManager._();

  Database? _db;

  // 데이터베이스 객체를 가져오는 Getter
  Future<Database> get database async {
    return _db ??= await init();
  }

  /// 데이터베이스 초기화
  Future<Database> init() async {
    AppManager.log("SQLite 초기화", type: "S");

    final dbPath = await getDatabasesPath(); // /data/user/0/com.mtt.my_time_timer/databases
    final path = join(dbPath, _dbName);

    Database db = await openDatabase(
      path,
      version: _dbVersion,
      onConfigure: (db) async {
      await db.execute('PRAGMA foreign_keys = ON'); // 외래 키 활성화
      },
      onCreate: _onCreate,
      // 앱을 배포한 후 테이블 스키마를 수정해야 할 때, onUpgrade 콜백을 활용해 마이그레이션 로직을 작성 가능
      // onUpgrade: (db, oldVersion, newVersion) async {
      //   // 마이그레이션 로직
      //   if (oldVersion < newVersion) {
      //     // 예: 테이블에 컬럼 추가
      //     await db.execute("ALTER TABLE $_tableName ADD COLUMN newColumn TEXT");
      //   }
      // },
    );
    _db = db;
    return db;// DB 열기 (없으면 생성)
  }

  // DB가 처음 생성될 때 테이블 생성 및 값 초기화
  Future _onCreate(Database db, int version) async {
    // tvt_config 테이블
    await db.execute('''
      CREATE TABLE $_tableConfig(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER NOT NULL
      )
    ''');

    // tvt_preset 테이블
    await db.execute('''
      CREATE TABLE $_tablePreset(
        presetId INTEGER PRIMARY KEY AUTOINCREMENT,
        presetType INTEGER,
        sortOrder INTEGER,
        presetName TEXT,
        presetColor TEXT,
        timerId TEXT
      )
    ''');
    // tvt_timer 테이블
    await db.execute('''
      CREATE TABLE $_tableTimer(
        timerId INTEGER PRIMARY KEY AUTOINCREMENT,
        presetId INTEGER NOT NULL,
        timerName TEXT,
        setupHour INTEGER,
        setupMin INTEGER,
        setupSec INTEGER,
        startCountdownYn BOOLEAN,
        intervalCountdownYn BOOLEAN,
        endCountdownYn BOOLEAN,
        startCountdownValue INTEGER,
        intervalCountdownValue INTEGER,
        endCountdownValue INTEGER,
        startCountdownInterval INTEGER,
        intervalCountdownInterval INTEGER,
        endCountdownInterval INTEGER,
        startCountdownType INTEGER,
        intervalCountdownType INTEGER,
        endCountdownType INTEGER,
        
        FOREIGN KEY (presetId) REFERENCES $_tablePreset (presetId) 
        ON DELETE CASCADE
        ON UPDATE CASCADE
      )
    ''');
    await insertDefaultData(db);
  }

  Future<void> insertDefaultData(Database db) async {
    // Database db = await instance.database;
    // db.insert(_tableConfig, {}); // tvt_config
    await db.insert(_tablePreset, {
      "presetId" : 0,
      "presetType" : 0,
      "sortOrder" : 0,
      "presetName" : "00:05:00",
      "presetColor" : "red",
      "timerId" : "0",
    }); // tvt_preset
    await db.insert(_tableTimer, {
      "timerId" : 0,
      "presetId" : 0,
      "timerName" : "00:05:00",
      "setupHour" : 0,
      "setupMin" : 5,
      "setupSec" : 0,
      "startCountdownYn" : true,
      "intervalCountdownYn" : true,
      "endCountdownYn" : true,
      "startCountdownValue" : 0,
      "intervalCountdownValue" : 0,
      "endCountdownValue" : 0,
      "startCountdownInterval" : 0,
      "intervalCountdownInterval" : 0,
      "endCountdownInterval" : 0,
      "startCountdownType" : 0,
      "intervalCountdownType" : 0,
      "endCountdownType" : 0,
    }); // tvt_timer
  }

  /// tvt_preset에 새 그룹을 생성한다
  Future<int> insertPreset(Map<String, dynamic> data) async {
    Database db = await instance.database;
    return await db.insert(_tablePreset, data);
  }

  /// tvt_timer에 새 타이머를 생성한다 // todo 수정해야함
  Future<int> insertTimer(Map<String, dynamic> data) async {
    Database db = await instance.database;
    return await db.insert(_tableTimer, data);
  }

  /// tvt_preset에 새 그룹을 생성하기 위한 sortOrder 값을 반환한다
  Future<List<Map<String, dynamic>>> getSortOrderPreset() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT MAX(sortOrder) + 1 AS sortOrder FROM $_tablePreset');
  }


  /// tvt_preset에서 그룹을 삭제한다
  Future<int> deletePreset(int presetId) async {
    Database db = await instance.database;
    return await db.delete(
      _tablePreset,
      where: 'presetId = ?',
      whereArgs: [presetId],
    );
  }

  /// tvt_timer에서 presetId에 해당하는 타이머를 삭제한다
  Future<int> deleteTimerByPresetId(int presetId) async {
    Database db = await instance.database;
    return await db.delete(
      _tableTimer,
      where: 'presetId = ?',
      whereArgs: [presetId],
    );
  }

  /// tvt_preset에서 모든 그룹을 조회한다
  Future<List<Map<String, dynamic>>> getPresetData() async {
    Database db = await instance.database;
    return await db.query(_tablePreset);
  }
  /// tvt_timer에서 모든 타이머를 조회한다
  Future<List<Map<String, dynamic>>> getTimerData() async {
    Database db = await instance.database;
    return await db.query(_tableTimer);
  }

  /// Update
  Future<int> updateData(String tableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update(
      tableName,
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Delete
  Future<int> deleteData(String tableName, int id) async {
    Database db = await instance.database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// 모든 테이블 DROP 후 초기화
  Future<void> resetData() async {
    Database db = await instance.database;
    await db.execute('''DROP TABLE IF EXISTS $_tableConfig;'''); // tvt_config drop
    await db.execute('''DROP TABLE IF EXISTS $_tablePreset;'''); // tvt_preset drop
    await db.execute('''DROP TABLE IF EXISTS $_tableTimer;'''); // tvt_timer drop

    return await _onCreate(db, _dbVersion); // 테이블 재생성 및 값 초기화 todo 앱 재실행까지 가능한지 확인해보기
    // await db.close(); // 데이터베이스 닫기
    // await deleteDatabase(path); // 데이터베이스 삭제
  }
}

/**
 *  '''는 멀티라인 문자열
 *  execute은 DML (결과 반환 X)
 *  rawQuery는 SELECT 문 (결과 반환 O) > List<Map<String, dynamic>> 형태
 *
 * query: 테이블 조회 (편의 메서드)
 * final results = await db.query('users', where: 'age > ?', whereArgs: [20]);
 *
 * insert: 데이터 삽입
 * final id = await db.insert('users', {'name': 'Alice', 'age': 25});
 *
 * update: 데이터 수정
 * final rows = await db.update('users', {'age': 30}, where: 'name = ?', whereArgs: ['Alice']);
 *
 * delete: 데이터 삭제
 * final rows = await db.delete('users', where: 'age < ?', whereArgs: [18]);
 *
 * orderBy: 'salary DESC',
    limit: 2, // 상위 2개 가져오기
 *
 *
 * TEXT: ISO8601 형식의 문자열

예: '2025-01-14 15:30:00'
REAL: Julian Day 숫자 형식

예: 2459888.145833 (날짜와 시간을 나타내는 실수형 값)
INTEGER: Unix 타임스탬프 (초 단위 또는 밀리초 단위)

예: 1705257000 (UTC 기준 1970-01-01 00:00:00부터의 초)

date(): 날짜만 반환 (YYYY-MM-DD).
time(): 시간만 반환 (HH:MM:SS).
datetime(): 날짜와 시간 반환 (YYYY-MM-DD HH:MM:SS).
strftime(): 커스텀 형식으로 날짜/시간 반환.
julianday(): Julian Day 숫자 반환.
unixepoch(): Unix Epoch 시간 반환.
*/