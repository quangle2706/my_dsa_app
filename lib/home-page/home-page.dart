import 'package:flutter/material.dart';
import 'package:my_dsa_app/customize-layout/custom-button.dart';
import 'package:my_dsa_app/customize-layout/custom-icon-button.dart';
import 'package:my_dsa_app/customize-layout/custom-layout.dart';
import 'package:my_dsa_app/customize-layout/custom-textfield.dart';

import '../database/courses.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final courseProvider = CourseProvider();
  late Future<List<Course>> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = courseProvider.fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                    hintText: 'Search', suffixIcon: Icons.search_outlined),
              ),
              SizedBox(
                width: 12.0,
              ),
              CustomIconButton(
                  iconData: Icons.filter_alt_outlined,
                  backgroundColor: Colors.blue,
                  iconColor: Colors.white,
                  width: 48,
                  height: 48,
                  borderRadius: 12.0),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Courses',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CustomButton(
                  icon: Icons.local_fire_department,
                  text: 'All Topic',
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: CustomButton(
                  icon: Icons.trending_up,
                  text: 'Popular',
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CustomButton(
                  icon: Icons.local_florist_rounded,
                  text: 'Newest',
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: CustomButton(
                  icon: Icons.bolt,
                  text: 'Advanced',
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: StaticDBVariables.courses.isEmpty
                ? FutureBuilder<List<Course>>(
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
                          scrollDirection: Axis.horizontal,
                          itemCount: StaticDBVariables.courses.length,
                          itemBuilder: (context, index) {
                            final course = StaticDBVariables.courses[index];
                            return CustomCoursesItem(
                              id: course.id,
                              imagePath:
                                  course.courseImage!, //'assets/studybg1.png',
                              title: course.courseName, //'Stack',
                              description: course.courseDescription,
                              iconText: course.courseTag, //'DS',
                              backgroundColor: Color(0xFF71BFFA),
                            );
                          },
                        );
                      }
                    },
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: StaticDBVariables.courses.length,
                    itemBuilder: (context, index) {
                      final course = StaticDBVariables.courses[index];
                      return CustomCoursesItem(
                        id: course.id,
                        imagePath: course.courseImage!, //'assets/studybg1.png',
                        title: course.courseName, //'Stack',
                        description: course.courseDescription,
                        iconText: course.courseTag, //'DS',
                        backgroundColor: Color(0xFF71BFFA),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
