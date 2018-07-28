
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';

class NewsDbProvider {

  // import 'package:sqflite/sqflite.dart';
  Database db;

  init() async {

    // provide by path_provider package to get a path of folder on our mobile device
    // where we can save our data.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    
    // documentsDirectory.path/items.db
    final path = join(documentsDirectory.path, "items.db");

    db = await openDatabase( // top-level funciton 
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        // for sql without return values

        /// BLOB allows us to store a big set of data
        newDb.execute("""
          CREATE TABLE Items
            (
              id INTEGER PRIMARY_KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              kids BLOB, 
              dead INTEGER, 
              delete INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
        """);
      },
    );

  }

  addItem() {

  }

}