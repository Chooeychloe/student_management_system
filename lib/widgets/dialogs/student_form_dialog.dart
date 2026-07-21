import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../models/student.dart';
import '../../providers/student_provider.dart';
import '../../utils/validators.dart';
import '../common/app_dropdown.dart';
import '../common/app_text_field.dart';

class StudentFormDialog extends StatefulWidget {
  final Student? student;

  const StudentFormDialog({super.key, this.student});

  @override
  State<StudentFormDialog> createState() => _StudentFormDialogState();
}

class _StudentFormDialogState extends State<StudentFormDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController studentNumberController;
  late final TextEditingController firstNameController;
  late final TextEditingController middleNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController contactController;
  late final TextEditingController addressController;

  late String course;
  late int yearLevel;

  bool get isEdit => widget.student != null;

  @override
  void initState() {
    super.initState();

    studentNumberController = TextEditingController(
      text: widget.student?.studentNumber ?? '',
    );

    firstNameController = TextEditingController(
      text: widget.student?.firstName ?? '',
    );

    middleNameController = TextEditingController(
      text: widget.student?.middleName ?? '',
    );

    lastNameController = TextEditingController(
      text: widget.student?.lastName ?? '',
    );

    emailController = TextEditingController(text: widget.student?.email ?? '');

    contactController = TextEditingController(
      text: widget.student?.contactNumber ?? '',
    );

    addressController = TextEditingController(
      text: widget.student?.address ?? '',
    );

    course = widget.student?.course ?? AppConstants.courses.first;
    yearLevel = widget.student?.yearLevel ?? 1;
  }

  @override
  void dispose() {
    studentNumberController.dispose();
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    contactController.dispose();
    addressController.dispose();

    super.dispose();
  }

  Future<void> _saveStudent() async {
    if (!_formKey.currentState!.validate()) return;

    final student = Student(
      id: widget.student?.id,
      studentNumber: studentNumberController.text.trim(),
      firstName: firstNameController.text.trim(),
      middleName: middleNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      course: course,
      yearLevel: yearLevel,
      email: emailController.text.trim(),
      contactNumber: contactController.text.trim(),
      address: addressController.text.trim(),
    );

    final provider = context.read<StudentProvider>();

    if (isEdit) {
      await provider.updateStudent(student);
    } else {
      await provider.addStudent(student);
    }

    if (!mounted) return;

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isEdit
              ? "Student updated successfully."
              : "Student added successfully.",
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEdit ? "Edit Student" : "Add Student"),
      content: SizedBox(
        width: 750,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _sectionTitle("Personal Information"),

                AppTextField(
                  controller: studentNumberController,
                  label: "Student Number",
                  prefixIcon: Icons.badge_outlined,
                  validator: AppValidators.studentNumber,
                ),

                const SizedBox(height: 18),

                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: firstNameController,
                        label: "First Name",
                        prefixIcon: Icons.person_outline,
                        validator:
                            (value) => AppValidators.requiredField(
                              value,
                              "First Name",
                            ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: AppTextField(
                        controller: middleNameController,
                        label: "Middle Name",
                        prefixIcon: Icons.person_outline,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: AppTextField(
                        controller: lastNameController,
                        label: "Last Name",
                        prefixIcon: Icons.person_outline,
                        validator:
                            (value) =>
                                AppValidators.requiredField(value, "Last Name"),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                _sectionTitle("Academic Information"),

                Row(
                  children: [
                    Expanded(
                      child: AppDropdown<String>(
                        label: "Course",
                        value: course,
                        items: AppConstants.courses,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Select a course.";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            course = value!;
                          });
                        },
                      ),
                    ),

                    const SizedBox(width: 20),

                    Expanded(
                      child: AppDropdown<int>(
                        label: "Year Level",
                        value: yearLevel,
                        items: AppConstants.yearLevels,
                        validator: (value) {
                          if (value == null) {
                            return "Select a year level.";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            yearLevel = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                _sectionTitle("Contact Information"),

                AppTextField(
                  controller: emailController,
                  label: "Email Address",
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: AppValidators.email,
                ),

                const SizedBox(height: 18),

                AppTextField(
                  controller: contactController,
                  label: "Contact Number",
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                  validator: AppValidators.phone,
                ),

                const SizedBox(height: 18),

                AppTextField(
                  controller: addressController,
                  label: "Address",
                  maxLines: 3,
                  prefixIcon: Icons.home_outlined,
                  validator: AppValidators.address,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),

        FilledButton.icon(
          onPressed: _saveStudent,
          icon: Icon(isEdit ? Icons.edit : Icons.save),
          label: Text(isEdit ? "Update Student" : "Save Student"),
        ),
      ],
    );
  }
}
