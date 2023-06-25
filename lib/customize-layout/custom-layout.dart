import 'package:flutter/material.dart';
import '../courses-screens/course-article.dart';

class CustomCoursesItem extends StatefulWidget {
  final int id;
  final String imagePath;
  final String title;
  final String description;
  final String iconText;
  final Color backgroundColor;

  CustomCoursesItem({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.iconText,
    required this.backgroundColor,
  });

  @override
  _CustomCoursesItemState createState() => _CustomCoursesItemState();
}

class _CustomCoursesItemState extends State<CustomCoursesItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CourseArticle(
                      courseId: widget.id,
                      courseName: widget.title,
                      courseImageBG: widget.imagePath,
                    )));
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        height: 300,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: widget.backgroundColor,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 6.0),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Image.asset(
                    widget.imagePath.isNotEmpty
                        ? widget.imagePath
                        : 'assets/studybg.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        widget.description,
                        maxLines: 2,
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.star,
                              size: 12,
                              color: Colors.amber,
                            ),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            widget.iconText,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCoursesItem2 extends StatefulWidget {
  final int id;
  final String imagePath;
  final String title;
  final String description;
  final Color backgroundColor;

  CustomCoursesItem2({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.backgroundColor,
  });

  @override
  _CustomCoursesItem2State createState() => _CustomCoursesItem2State();
}

class _CustomCoursesItem2State extends State<CustomCoursesItem2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: widget.backgroundColor //backgroundColor,
          ),
      child: Padding(
        padding: EdgeInsets.only(top: 6.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(top: 16.0),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      widget.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CourseArticle(
                                          courseId: widget.id,
                                          courseName: widget.title,
                                          courseImageBG: widget.imagePath,
                                        )));
                          },
                          child: Text('Start'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
