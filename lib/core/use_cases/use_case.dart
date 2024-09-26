import 'package:radio_online/feature/data/models/radio_type.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(
    int? limit,
    int? offset,
    Params? params,
  );

  Future<List<RadioType>> get() {
    return Future.value(List.empty());
  }
}
