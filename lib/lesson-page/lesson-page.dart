import 'package:flutter/material.dart';
import 'package:my_dsa_app/database/courses.dart';

import '../customize-layout/custom-layout.dart';
import '../main.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final courseProvider = CourseProvider();
  late Future<List<Course>> _coursesFuture;
  //late List<Course> courses;

  @override
  void initState() {
    super.initState();
    _coursesFuture = courseProvider.fetchCourses();
    //print(courses.length);
  }

  @override
  Widget build(BuildContext context) {
    return StaticDBVariables.courses.isNotEmpty
        ? ListView.builder(
            itemCount: StaticDBVariables.courses.length,
            itemBuilder: (context, index) {
              final course = StaticDBVariables.courses[index];
              return CustomCoursesItem2(
                id: course.id,
                imagePath: course.courseImage!, //'assets/studybg1.png',
                title: course.courseName, //'Data Structures',
                description: course.courseDescription,
                backgroundColor: Color(0xFF71BFFA),
              );
            },
          )
        : FutureBuilder<List<Course>>(
            future: _coursesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                StaticDBVariables.courses = snapshot.data ?? [];

                return ListView.builder(
                  itemCount: StaticDBVariables.courses.length,
                  itemBuilder: (context, index) {
                    final course = StaticDBVariables.courses[index];
                    return CustomCoursesItem2(
                      id: course.id,
                      imagePath: course.courseImage!, //'assets/studybg1.png',
                      title: course.courseName, //'Data Structures',
                      description: course.courseDescription,
                      backgroundColor: Color(0xFF71BFFA),
                    );
                  },
                );
              }
            },
          );
  }
}
