import 'package:flutter/material.dart';

import '../main.dart';

class Content {
  int id;
  int courseId;
  int contentOrder;
  String contentHeading;
  String contentData;
  String contentType;

  Content(
      {required this.id,
      required this.courseId,
      required this.contentOrder,
      required this.contentHeading,
      required this.contentData,
      required this.contentType});
}

class ContentProvider extends ChangeNotifier {
  final List<Content> _contents = [];
  List<Content> get contents => _contents;

  Future<List<Content>> fetchContents(int courseId) async {
    // Fetch courses from Supabase
    try {
      final response = await supabase
          .from('Content')
          .select()
          .eq('course_id', courseId)
          .order('content_order', ascending: true);
      List<dynamic> data = response;
      for (var item in data) {
        Content content = Content(
            id: item['id'],
            courseId: item['course_id'],
            contentOrder: item['content_order'],
            contentHeading: item['content_heading'] ?? '',
            contentData: item['content_data'] ?? '',
            contentType: item['content_type']);
        _contents.add(content);
      }
    } catch (error) {
      // Handle error
    }

    notifyListeners();
    return _contents;
  }
}
