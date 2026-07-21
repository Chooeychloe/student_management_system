class Student {
  final int? id;
  final String studentNumber;
  final String firstName;
  final String middleName;
  final String lastName;
  final String course;
  final int yearLevel;

  final String email;
  final String contactNumber;
  final String address;

  Student({
    this.id,
    required this.studentNumber,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.course,
    required this.yearLevel,
    required this.email,
    required this.contactNumber,
    required this.address,
  });

  /// Computed Property
  String get fullName {
    return [
      firstName,
      middleName,
      lastName,
    ].where((e) => e.trim().isNotEmpty).join(" ");
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentNumber': studentNumber,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'course': course,
      'yearLevel': yearLevel,
      'email': email,
      'contactNumber': contactNumber,
      'address': address,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      studentNumber: map['studentNumber'] ?? '',
      firstName: map['firstName'] ?? '',
      middleName: map['middleName'] ?? '',
      lastName: map['lastName'] ?? '',
      course: map['course'] ?? '',
      yearLevel: map['yearLevel'] ?? 1,
      email: map['email'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
      address: map['address'] ?? '',
    );
  }

  Student copyWith({
    int? id,
    String? studentNumber,
    String? firstName,
    String? middleName,
    String? lastName,
    String? course,
    int? yearLevel,
    String? email,
    String? contactNumber,
    String? address,
  }) {
    return Student(
      id: id ?? this.id,
      studentNumber: studentNumber ?? this.studentNumber,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      course: course ?? this.course,
      yearLevel: yearLevel ?? this.yearLevel,
      email: email ?? this.email,
      contactNumber: contactNumber ?? this.contactNumber,
      address: address ?? this.address,
    );
  }
}
