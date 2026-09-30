import 'package:flutter/material.dart';
import 'package:p2809/model/student.dart';

class StudentInfoPage extends StatelessWidget {
  final Student student;

  StudentInfoPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Profile'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Color.fromARGB(255, 15, 159, 145),
                  child: Icon(Icons.person, size: 45, color: Colors.white),
                ),
                SizedBox(height: 15),
                Text(
                  student.name,
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                Divider(height: 30),
                ListTile(
                  leading: Icon(Icons.cake, color: Colors.teal),
                  title: Text('Age'),
                  subtitle: Text(student.age),
                ),
                ListTile(
                  leading: Icon(Icons.email, color: Colors.teal),
                  title: Text('Email'),
                  subtitle: Text(student.email),
                ),
                ListTile(
                  leading: Icon(Icons.school, color: Colors.teal),
                  title: Text('Course'),
                  subtitle: Text(student.course),
                ),
                ListTile(
                  leading: Icon(Icons.info, color: Colors.teal),
                  title: Text('About Me'),
                  subtitle: Text(
                    student.about.isEmpty ? 'Not specified' : student.about,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
