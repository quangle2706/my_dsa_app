import 'package:flutter/material.dart';
import 'package:my_dsa_app/database/content.dart';
import 'package:my_dsa_app/database/courses.dart';
import 'package:my_dsa_app/exercise-page/exercise-page.dart';
import 'package:my_dsa_app/home-page/home-page.dart';
import 'package:my_dsa_app/lesson-page/lesson-page.dart';
import 'package:my_dsa_app/profile-page/profile-page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'database/exercise-groups.dart';

final supabase = Supabase.instance.client;

class StaticDBVariables {
// Static variable is only used for save data for not loading everytime
// users change tab views. Database still be loaded when they opens app again
  static List<Course> courses = [];
  static Map<int, List<Content>> coursesContent = {};

// Data for exercises page + view
  static List<Item> exercisesData = [];
}

class Item {
  Item(
      {required this.expandedValue,
      required this.headerValue,
      this.isExpanded = false});

  List<Exercise> expandedValue;
  String headerValue;
  bool isExpanded;
}

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://zubeepunyqmkjlewmytx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1YmVlcHVueXFta2psZXdteXR4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODczNzA0NDksImV4cCI6MjAwMjk0NjQ0OX0.r_q1kcpbVGH1Hhs7qo_iCieO8xbjsWYGLrGCezexolw',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MY DSA APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: MyMainPage(),
    );
  }
}

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 1;
  final List<Widget> _screens = [
    HomePage(),
    LessonPage(),
    ExercisePage(),
    ProfilePage(),
  ];

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarHeight: 100,
        titleSpacing: 0.0,
        title: Padding(
          padding: EdgeInsets.only(left: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello,',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  Text(
                    'Developer',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          SizedBox(
            height: 50.0,
            child: CircleAvatar(
              backgroundColor: Colors.lightBlue,
              foregroundColor: Colors.transparent,
              radius: 50,
              child: ClipOval(
                  child: Image.asset(
                'assets/pikachu.png',
                fit: BoxFit.cover,
              )),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFC3E1ED),
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Opacity(
            opacity: _animation.value,
            child: Transform.translate(
              offset: Offset(0.0, 50.0 * (1.0 - _animation.value)),
              child: _screens[_currentIndex], //_buildContent(),
            ),
          );
        },
      ),
      //_screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(color: Colors.black),
        unselectedItemColor: Colors.lightBlue,
        unselectedIconTheme: IconThemeData(color: Colors.lightBlue),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              //color: Colors.lightBlue,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_books_outlined,
              //color: Colors.lightBlue,
            ),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.smart_toy_outlined,
              //color: Colors.lightBlue,
            ),
            label: 'Exercises',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
              //color: Colors.lightBlue,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
