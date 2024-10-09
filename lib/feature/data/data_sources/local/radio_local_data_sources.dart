import 'data_base/models/db_model.dart';
import 'data_base/radio_data_base.dart';

abstract class RadioLocalDataSources {
  Future<void> insert<T extends DbModel>(T model);

  Future<void> insertAll<T extends DbModel>(List<T> list);

  Future<T?> get<T extends DbModel>(dynamic id);

  Future<Iterable<T>> getTake<T extends DbModel>({
    int? take,
    int? skip,
  });

  Future<Iterable<T>> getAll<T extends DbModel>();

  Future<void> update<T extends DbModel>(T model);

  Future<void> delete<T extends DbModel>(T model);
}

class RadioLocalDataSourceImpl implements RadioLocalDataSources {
  final RadioDataBase dataBase;

  RadioLocalDataSourceImpl({required this.dataBase});

  @override
  Future<void> delete<T extends DbModel>(T model) async {
    await dataBase.init();
    dataBase.delete<T>(model);
  }

  @override
  Future<T?> get<T extends DbModel>(id) async {
    await dataBase.init();
    return dataBase.get<T>(id);
  }

  @override
  Future<Iterable<T>> getAll<T extends DbModel>() async {
    await dataBase.init();
    return dataBase.getAll<T>();
  }

  @override
  Future<Iterable<T>> getTake<T extends DbModel>({int? take, int? skip}) async {
    await dataBase.init();
    return dataBase.getTake<T>(take: take, skip: skip);
  }

  @override
  Future<void> insert<T extends DbModel>(T model) async {
    await dataBase.init();
    dataBase.insert<T>(model);
  }

  @override
  Future<void> insertAll<T extends DbModel>(List<T> list) async {
    await dataBase.init();
    dataBase.insertAll<T>(list);
  }

  @override
  Future<void> update<T extends DbModel>(T model) async {
    await dataBase.init();
    dataBase.update<T>(model);
  }
}
