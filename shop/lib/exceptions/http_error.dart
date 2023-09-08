class HttpError implements Exception {
  final String msg;
  final int statusCode;

  HttpError({
    required this.msg,
    required this.statusCode,
  });

  @override
  String toString() {
    return msg;
  }
}
