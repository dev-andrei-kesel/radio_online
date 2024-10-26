import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/db_model.dart';
import 'models/radio_item.dart';

class RadioDataBase {
  RadioDataBase._();

  static final RadioDataBase instance = RadioDataBase._();
  static late Database _db;
  static bool _isInitialized = false;

  /*
  /  здесь сохраняем фабрики
  */
  static final _factories = <Type, Function(Map<String, dynamic> map)>{
    RadioItem: (map) => RadioItem.fromJson(map),
  };

  /*
  /  инициализация
  */
  Future init() async {
    if (!_isInitialized) {
      var databasePath = await getDatabasesPath();

      var path = join(databasePath, "db_v1.0.0.db");

      _db = await openDatabase(path, version: 1, onCreate: _createDB);
      _isInitialized = true;
    }
  }

  /*
  /  создание базы данных
  */
  Future _createDB(Database db, int version) async {
    var dbInitScript = await rootBundle.loadString('assets/db/db_init.sql');

    dbInitScript.split(';').forEach(
      (element) async {
        if (element.isNotEmpty) {
          await db.execute(element);
        }
      },
    );
  }

  /*
  /  метод, который для указанного класса вернёт нужное название таблицы
  */
  String _dbName(Type type) {
    return "t_${(type).toString()}";
  }

  /*
  /  запись в базу
  */
  Future<void> insert<T extends DbModel>(T model) async => await _db.insert(
        _dbName(T), // Получаем имя рабочей таблицы
        model.toJson(), // Переводим наш объект в мапу для вставки
        conflictAlgorithm: ConflictAlgorithm.replace,
        // Что должно происходить при конфликте вставки
        nullColumnHack:
            null, // Что делать, если not null столбец приходит как null
      );

  /*
  /  запись в базу все элементов
  */
  Future<void> insertAll<T extends DbModel>(List<T> list) async {
    for (var e in list) {
      await _db.insert(
        _dbName(T), // Получаем имя рабочей таблицы
        e.toJson(), // Переводим наш объект в мапу для вставки
        conflictAlgorithm: ConflictAlgorithm.replace,
        // Что должно происходить при конфликте вставки
        nullColumnHack:
            null, // Что делать, если not null столбец приходит как null
      );
    }
  }

  /*
  /  чтение по id
  */
  Future<T?> get<T extends DbModel>(dynamic id) async {
    var res = await _db.query(
      _dbName(T),
      where: 'id = ? ',
      whereArgs: [id],
    );
    return res.isNotEmpty ? _factories[T]!(res.first) : null;
  }

  /*
  /  чтение с ограничением по количеству записей
  */
  Future<Iterable<T>> getTake<T extends DbModel>({
    int? take,
    int? skip,
  }) async {
    Iterable<Map<String, dynamic>> query = await _db.query(
      _dbName(T),
      offset: skip, // сколько строк нужно пропустить из конечной выборки
      limit: take, // количество возвращаемых строк
    );

    var resList = query.map((e) => _factories[T]!(e)).cast<T>();

    return resList;
  }

  /*
  /  чтение всех записей
  */
  Future<Iterable<T>> getAll<T extends DbModel>() async {
    Iterable<Map<String, dynamic>> query = await _db.query(_dbName(T));
    var resList = query.map((e) => _factories[T]!(e)).cast<T>();
    return resList;
  }

  /*
  /  обновление записи
  */
  Future<void> update<T extends DbModel>(T model) async => _db.update(
        _dbName(T),
        model.toJson(),
        where: 'id = ?', // без этого все строки таблицы будут обновлены
        whereArgs: [model.id],
      );

  /*
  /  удаление записи
  */
  Future<void> delete<T extends DbModel>(T model) async => _db.delete(
        _dbName(T),
        where: 'id = ?', // если не указывать, то удалятся все строки
        whereArgs: [model.id],
      );
}
