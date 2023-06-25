import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../database/content.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE content(id INT PRIMARY KEY, course_id INT, content_order INT, content_heading TEXT, content_data TEXT, content_type TEXT)',
        );
      },
    );
  }

  Future<void> saveMap(Map<int, List<Content>> map) async {
    final Database db = await instance.database;
    final Batch batch = db.batch();

    map.forEach((id, contents) {
      for (Content content in contents) {
        batch.insert(
          'content',
          {
            'id': id,
            'course_id': content.courseId,
            'content_order': content.contentOrder,
            'content_heading': content.contentHeading,
            'content_data': content.contentData,
            'content_type': content.contentType,
          },
        );
      }
    });

    await batch.commit();
  }

// Need to check again this function
  Future<Map<int, List<Content>>> loadMap() async {
    final Database db = await instance.database;
    final List<Map<int, dynamic>> results =
        (await db.query('content')).cast<Map<int, dynamic>>();

    final Map<int, List<Content>> map = {};

    for (Map<int, dynamic> row in results) {
      final int id = row['id'];
      final int courseId = row['course_id'];
      final int contentOrder = row['content_order'];
      final String contentHeading = row['content_heading'];
      final String contentData = row['content_data'];
      final String contentType = row['content_type'];

      final content = Content(
          id: id,
          courseId: courseId,
          contentOrder: contentOrder,
          contentHeading: contentHeading,
          contentData: contentData,
          contentType: contentType);

      if (map.containsKey(id)) {
        map[id]!.add(content);
      } else {
        map[id] = [content];
      }
    }

    return map;
  }
}
