import 'dart:developer';

import 'package:my_todo_app/headers.dart';
import 'package:my_todo_app/utills/models/todo_model.dart';

mixin Todos {
  Future<void> initDB();
  Future<int> insertMyTask({required String title});
  Future<List<TodoModel>> getMyTasks();
  void updateMyTasks({required int id, required String title});
  void deleteMyTasks({required int id});
}

class DBHelper with Todos {
  DBHelper._();

  static DBHelper dbHelper = DBHelper._();

  Database? db;
  String tableName = "TODO";
  String tableId = "id";
  String tableTitle = "title";

  @override
  Future<void> initDB() async {
    String dbLocation = await getDatabasesPath();
    String path = join(dbLocation, "Todo.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        String query =
            "CREATE TABLE $tableName($tableId INTEGER PRIMARY KEY AUTOINCREMENT, $tableTitle TEXT NOT NULL);";
        await db.execute(query).then((value) {
          log("$tableName table Created Successfully 😎");
        }).onError((error, _) {
          log("ERROR : $error");
        });
      },
    );
  }

  @override
  Future<int> insertMyTask({required String title}) async {
    await initDB();

    // String query = "INSERT INTO $tableName ($tableTitle) VALUES(?)";
    // List args = [title];
    // return await db!.rawInsert(query, args);

    Map<String, dynamic> data = {
      tableTitle: title,
    };

    return await db!.insert(
      tableName,
      data,
    );
  }

  @override
  Future<List<TodoModel>> getMyTasks() async {
    await initDB();
    String query = "SELECT * FROM $tableName;";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);

    return data.map((e) => TodoModel.fromMap(data: e)).toList();
  }

  @override
  void updateMyTasks({required int id, required String title}) {}

  @override
  void deleteMyTasks({required int id}) {}
}
