class DataBaseException implements Exception {
  final String message;

  DataBaseException(this.message);

  @override
  String toString() {
    return "DataBaseException: $message";
  }
}
