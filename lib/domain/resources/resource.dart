class ResourceException implements Exception {
  const ResourceException([this.message]);

  final String message;

  @override
  String toString() {
    return message.isNotEmpty ? message : super.toString();
  }
}
