// lib/src/database/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'chat_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE messages(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        message TEXT,
        isUser INTEGER,
        time TEXT,
        image TEXT
      )
    ''');
  }

  Future<void> insertMessage(Map<String, dynamic> message) async {
    Database db = await database;
    print('save message: $message');
    await db.insert('messages', {
      'message': message['message'],
      'isUser': message['isUser'] ? 1 : 0,
      'time': message['time'],
      'image': message['image'],
    });
  }

  Future<List<Map<String, dynamic>>> getMessages() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('messages', orderBy: 'id ASC');

    return List.generate(maps.length, (i) {
      return {
        'id': maps[i]['id'],
        'message': maps[i]['message'] ?? '',
        'isUser': maps[i]['isUser'] == 1,
        'time': maps[i]['time'] ?? '',
        'image': maps[i]['image']
      };
    });
  }

  Future<void> clearMessages() async {
    Database db = await database;
    await db.delete('messages');
  }
}
