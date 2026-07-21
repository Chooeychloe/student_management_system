class ImportResult {
  int imported = 0;
  int duplicates = 0;
  int invalid = 0;

  final List<String> errors = [];

  bool get hasErrors => errors.isNotEmpty;

  void addError(String message) {
    errors.add(message);
  }
}
