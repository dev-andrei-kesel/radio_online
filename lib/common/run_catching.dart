import 'package:radio_online/common/string_resources.dart';

import '../core/error/exceptions/network_exception.dart';
import '../core/error/exceptions/server_exception.dart';

T runCatching<T>({required Function() run, required bool isConnected}) {
  if (isConnected) {
    try {
      return run();
    } on Exception {
      throw const ServerException();
    }
  } else {
    throw const NetworkException(StringResources.networkErrorMessage);
  }
}
