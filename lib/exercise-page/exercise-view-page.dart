import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

class ExerciseViewPage extends StatefulWidget {
  final int id;
  final String groupName;
  final String name;
  final String description;
  final String example;
  final String hint;
  final String constraint;
  final String solution;

  const ExerciseViewPage({
    required this.id,
    required this.groupName,
    required this.name,
    required this.description,
    required this.example,
    required this.hint,
    required this.constraint,
    required this.solution,
  });

  @override
  _ExerciseViewPageState createState() => _ExerciseViewPageState();
}

class _ExerciseViewPageState extends State<ExerciseViewPage> {
  bool isHintVisible = false;
  bool isSolutionVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        leading: Icon(Icons.keyboard_backspace_sharp),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              widget.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '#${this.widget.groupName}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.description,
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.example,
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Constraint',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.constraint,
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              height: 20,
            ),
            // hint + solution need to toggle to show
            InkWell(
              onTap: () {
                setState(() {
                  isHintVisible = true;
                });
              },
              child: Text(
                'Click to reveal hint',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 17,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            if (isHintVisible)
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  widget.hint,
                  style: TextStyle(fontSize: 17),
                ),
              ),
            InkWell(
              onTap: () {
                setState(() {
                  isSolutionVisible = true;
                });
              },
              child: Text(
                'Click to reveal solution',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 17,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            if (isSolutionVisible)
              Padding(
                padding: EdgeInsets.all(16.0),
                child: HighlightView(
                  widget.solution,
                  theme: githubTheme,
                  language: 'python',
                  padding: EdgeInsets.all(12.0),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
