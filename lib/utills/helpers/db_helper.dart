import 'dart:developer';

import 'package:my_todo_app/headers.dart';

mixin Todos {
  Future<void> initDB();
  Future<int> insertMyTask({required String title});
  Future<List<TodoModel>> getMyTasks();
  Future<int> updateMyTasks({required int id, required String title});
  Future<int> deleteMyTasks({required int id});
  void searchMyTasks({required String title});
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
  Future<int> updateMyTasks({required int id, required String title}) async {
    await initDB();
    // String query = "UPDATE $tableName SET $tableTitle = ? WHERE $tableId = ?";
    // return await db!.rawUpdate(query, [title, id]);
    return await db!.update(
      tableName,
      {tableTitle: title},
      where: "$tableId = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<int> deleteMyTasks({required int id}) async {
    await initDB();
    // String query = "DELETE FROM $tableName WHERE $tableId = ?";
    // return await db!.rawDelete(query, [id]);
    return await db!.delete(
      tableName,
      where: "$tableId = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<List<TodoModel>> searchMyTasks({required String title}) async {
    await initDB();
    String query = "SELECT * FROM $tableName WHERE $tableTitle LIKE '%$title%'";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);
    return data.map((e) => TodoModel.fromMap(data: e)).toList();
  }
}
