import 'failure.dart';

class NetworkFailure extends Failure {
  const NetworkFailure([super.message, super.statusCode]);

  @override
  List<Object?> get props => [message, statusCode];
}
