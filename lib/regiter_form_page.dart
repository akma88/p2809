import 'package:flutter/material.dart';
import 'package:p2809/model/student.dart';
import 'package:p2809/student_info_page.dart';

class RegisterFormPage extends StatefulWidget {
  RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _aboutController = TextEditingController();

  final _nameFocus = FocusNode();
  final _ageFocus = FocusNode();

  final List<String> _courses = [
    'Flutter Development',
    'Web Development',
    'UI/UX Design',
    'Cybersecurity',
  ];

  String? _selectedCourse;

  Student newStudent = Student();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _aboutController.dispose();

    _nameFocus.dispose();
    _ageFocus.dispose();

    super.dispose();
  }

  void _changeFocus(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Registration'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Icon(Icons.school, size: 70, color: Colors.teal),
            SizedBox(height: 10),
            Text(
              'Create Student Profile',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 25),

            TextFormField(
              controller: _nameController,
              focusNode: _nameFocus,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Full Name *',
                hintText: 'Enter your full name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _nameController.clear();
                  },
                ),
              ),
              onFieldSubmitted: (_) {
                _changeFocus(context, _nameFocus, _ageFocus);
              },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Name is required';
                }
                if (value.trim().length < 2) {
                  return 'Enter at least 2 characters';
                }
                return null;
              },
              onSaved: (value) {
                newStudent.name = value!.trim();
              },
            ),

            SizedBox(height: 15),

            TextFormField(
              controller: _ageController,
              focusNode: _ageFocus,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Age *',
                hintText: 'Enter your age',
                prefixIcon: Icon(Icons.cake),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onFieldSubmitted: (_) {
                _ageFocus.unfocus();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Age is required';
                }
                final age = int.tryParse(value);
                if (age == null || age < 1 || age > 100) {
                  return 'Enter a valid age';
                }
                return null;
              },
              onSaved: (value) {
                newStudent.age = value!;
              },
            ),

            SizedBox(height: 15),

            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email *',
                hintText: 'example@email.com',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
              onSaved: (value) {
                newStudent.email = value!;
              },
            ),

            SizedBox(height: 15),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Choose your course *',
                prefixIcon: Icon(Icons.menu_book),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              value: _selectedCourse,
              items: _courses.map((course) {
                return DropdownMenuItem<String>(
                  value: course,
                  child: Text(course),
                );
              }).toList(),
              onChanged: (course) {
                setState(() {
                  _selectedCourse = course;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a course';
                }
                return null;
              },
              onSaved: (value) {
                newStudent.course = value!;
              },
            ),

            SizedBox(height: 15),

            TextFormField(
              controller: _aboutController,
              maxLines: 3,
              maxLength: 150,
              decoration: InputDecoration(
                labelText: 'About Me',
                hintText: 'Tell us something about yourself',
                prefixIcon: const Icon(Icons.info_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onSaved: (value) {
                newStudent.about = value ?? '';
              },
            ),

            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: Icon(Icons.check),
              label: Text('Register'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: EdgeInsets.all(16),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _showDialog();
    } else {
      _showMessage('Please correct the form');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Registration successful!',
            style: TextStyle(color: Colors.teal),
          ),
          content: Text('Welcome, ${newStudent.name}!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return StudentInfoPage(student: newStudent);
                    },
                  ),
                );
              },
              child: Text('Continue', style: TextStyle(color: Colors.teal)),
            ),
          ],
        );
      },
    );
  }
}
