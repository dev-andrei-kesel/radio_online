class ServerException implements Exception {
  final String? title;
  final String? message;

  const ServerException([this.title, this.message]);
}
