class AppValidators {
  static String? requiredField(String? value, String field) {
    if (value == null || value.trim().isEmpty) {
      return "$field is required.";
    }

    return null;
  }

  static String? studentNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Student Number is required.";
    }

    if (value.length < 5) {
      return "Invalid Student Number.";
    }

    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required.";
    }

    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if (!regex.hasMatch(value.trim())) {
      return "Enter a valid email.";
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Contact Number is required.";
    }

    final cleaned = value.replaceAll(RegExp(r'\D'), '');

    if (cleaned.length < 10 || cleaned.length > 13) {
      return "Invalid contact number.";
    }

    return null;
  }

  static String? address(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Address is required.";
    }

    if (value.trim().length < 5) {
      return "Address is too short.";
    }

    return null;
  }
}
