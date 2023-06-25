import 'package:flutter/material.dart';
import 'package:my_dsa_app/database/content.dart';
import 'package:my_dsa_app/main.dart';

class CourseArticle extends StatefulWidget {
  final int courseId;
  final String courseName;
  final String courseImageBG;

  const CourseArticle({
    super.key,
    required this.courseId,
    required this.courseName,
    required this.courseImageBG,
  });

  @override
  _CourseArticleState createState() => _CourseArticleState();
}

class _CourseArticleState extends State<CourseArticle> {
  final contentProvider = ContentProvider();
  late Future<List<Content>> _contentFuture;
  late List<Content> contents = [];

  @override
  void initState() {
    super.initState();
    if (!StaticDBVariables.coursesContent.containsKey(widget.courseId))
      _contentFuture = contentProvider.fetchContents(widget.courseId);
    else
      contents = StaticDBVariables.coursesContent[widget.courseId]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
        leading: Icon(Icons.keyboard_backspace_sharp),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFFF4F5F9),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: contents.isEmpty
                  ? FutureBuilder<List<Content>>(
                      future: _contentFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          contents = snapshot.data ?? [];
                          // Add to a static variable
                          StaticDBVariables.coursesContent[widget.courseId] =
                              contents;
                          return ListView.builder(
                            itemCount: contents.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0)
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      widget.courseName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    Image.asset(
                                      widget
                                          .courseImageBG, //'assets/priorityqueue-topic.png',
                                      fit: BoxFit.fitWidth,
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                  ],
                                );
                              final content = contents[index - 1];
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (content.contentHeading.isNotEmpty)
                                      Text(
                                        content.contentHeading,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    if (content.contentHeading.isNotEmpty)
                                      SizedBox(
                                        height: 10,
                                      ),
                                    if (content.contentType == 'text')
                                      Text(
                                        content.contentData,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    if (content.contentType == 'image')
                                      Image.asset(
                                        content.contentData,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    if (content.contentType == 'list')
                                      for (String listData
                                          in content.contentData.split('\n'))
                                        if (listData.isNotEmpty)
                                          ListTile(
                                            leading: Icon(
                                              Icons.circle,
                                              size: 8,
                                            ),
                                            title: Text(listData),
                                          ),
                                    if (content.contentData.isNotEmpty)
                                      SizedBox(
                                        height: 12,
                                      ),
                                  ]);
                            },
                          );
                        }
                      },
                    )
                  : ListView.builder(
                      itemCount: contents.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0)
                          return Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                widget.courseName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Image.asset(
                                widget
                                    .courseImageBG, //'assets/priorityqueue-topic.png',
                                fit: BoxFit.fitWidth,
                              ),
                              SizedBox(
                                height: 24,
                              ),
                            ],
                          );
                        final content = contents[index - 1];
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (content.contentHeading.isNotEmpty)
                                Text(
                                  content.contentHeading,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (content.contentHeading.isNotEmpty)
                                SizedBox(
                                  height: 10,
                                ),
                              if (content.contentType == 'text')
                                Text(
                                  content.contentData,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              if (content.contentType == 'image')
                                Image.asset(
                                  content.contentData,
                                  fit: BoxFit.fitWidth,
                                ),
                              if (content.contentType == 'list')
                                for (String listData
                                    in content.contentData.split('\n'))
                                  if (listData.isNotEmpty)
                                    ListTile(
                                      leading: Icon(
                                        Icons.circle,
                                        size: 8,
                                      ),
                                      title: Text(listData),
                                    ),
                              if (content.contentData.isNotEmpty)
                                SizedBox(
                                  height: 12,
                                ),
                            ]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
