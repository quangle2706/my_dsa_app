import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_dsa_app/main.dart';

class Course {
  int id;
  String courseName;
  String courseImage;
  String courseDescription;
  String? courseAuthor;
  String? courseDateCreate;
  String courseTag;

  Course({
    required this.id,
    required this.courseName,
    required this.courseImage,
    required this.courseDescription,
    this.courseAuthor,
    this.courseDateCreate,
    required this.courseTag,
  });
}

class CourseProvider extends ChangeNotifier {
  List<Course> _courses = [];
  List<Course> get courses => _courses;

  Future<List<Course>> fetchCourses() async {
    // Fetch courses from Supabase
    try {
      final response = await supabase.from('Courses').select();
      List<dynamic> data = response;
      for (var item in data) {
        Course course = Course(
            id: item['id'],
            courseName: item['course_name'],
            courseDescription: item['course_description'],
            courseTag: item['course_tag'],
            courseAuthor: item['course_author'],
            courseDateCreate: (item['course_date_create']).toString(),
            courseImage: item['course_image']);
        _courses.add(course);
      }
    } catch (error) {
      // Handle error
    }

    notifyListeners();
    return _courses;
  }
}
