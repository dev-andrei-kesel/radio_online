import 'failure.dart';

class ServerFailure extends Failure {
  const ServerFailure([super.message, super.statusCode]);

  @override
  List<Object?> get props => [message, statusCode];
}
