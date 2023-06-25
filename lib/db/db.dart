import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as p;
import '../objectBox.g.dart';

Future<Database> getDatabase() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, 'app.db');
  final db = await openDatabase(path, version: 1, onOpen: (db) {},
      onCreate: (Database db, int version) async {
    await db.execute('''
          CREATE TABLE maps (
            "name TEXT, 
            
            "state TEXT, 
            "country TEXT, 
            
            "lat TEXT,
            "lon TEXT,     
          )
      ''');
  });
  return db;
}

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store =
        await openStore(directory: p.join(docsDir.path, "app.db"));
    return ObjectBox._create(store);
  }
}
