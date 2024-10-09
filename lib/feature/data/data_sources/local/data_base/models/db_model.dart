abstract class DbModel<T> {
  final T id;

  DbModel({required this.id});

  static void fromJson(Map<String, dynamic> map) {}

  Map<String, dynamic> toJson() => Map.fromIterable([]);
}
