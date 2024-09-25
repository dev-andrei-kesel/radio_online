abstract class UseCase<Type, Params> {
  Future<Type> call(
    int? limit,
    int? offset,
    Params? params,
  );
}
