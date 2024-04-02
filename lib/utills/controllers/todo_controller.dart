import 'package:flutter/material.dart';
import 'package:my_todo_app/utills/helpers/db_helper.dart';

import '../models/todo_model.dart';

class TodoController extends ChangeNotifier {
  List<TodoModel> myTask = [];

  TodoController() {
    getMyTasks();
  }

  Future<void> insertMyTask({required String title}) async {
    await DBHelper.dbHelper.insertMyTask(title: title);
    notifyListeners();
  }

  Future<void> getMyTasks() async {
    myTask = await DBHelper.dbHelper.getMyTasks();
    notifyListeners();
  }
}
