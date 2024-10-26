import '../error/exceptions/network_exception.dart';
import '../error/exceptions/server_exception.dart';
import '../error/failures/failure.dart';
import '../error/failures/network_failure.dart';
import '../error/failures/server_failure.dart';

sealed class RadioResult {}

class Success<T> extends RadioResult {
  final T? data;

  Success(this.data);
}

class Error extends RadioResult {
  final Failure failure;

  Error(this.failure);
}

class Loading extends RadioResult {}

extension FutureExt on Future {
  Future<RadioResult> asResult() async {
    try {
      return Success(await this);
    } on Exception catch (e) {
      switch (e) {
        case NetworkException():
          return Error(
            NetworkFailure(e.message),
          );
        case ServerException():
          return Error(
            ServerFailure(e.message),
          );
        case Exception():
          return Error(
            const ServerFailure(),
          );
      }
    }
  }
}
