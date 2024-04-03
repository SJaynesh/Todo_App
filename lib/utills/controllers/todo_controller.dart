import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_todo_app/utills/helpers/db_helper.dart';

import '../models/todo_model.dart';

class TodoController extends ChangeNotifier {
  List<TodoModel> myTask = [];

  TodoController() {
    getMyTodos();
  }

  Future<void> insertMyTodos({required String title}) async {
    await DBHelper.dbHelper
        .insertMyTask(title: title)
        .then((value) => getMyTodos());
    notifyListeners();
  }

  Future<void> getMyTodos() async {
    myTask = await DBHelper.dbHelper.getMyTasks();
    notifyListeners();
  }

  Future<void> updateMyTodo({required int id, required String title}) async {
    await DBHelper.dbHelper
        .updateMyTasks(id: id, title: title)
        .then((value) => getMyTodos());
    notifyListeners();
  }

  Future<void> deleteMyTodo({required int id}) async {
    await DBHelper.dbHelper.deleteMyTasks(id: id).then((value) => getMyTodos());
    notifyListeners();
  }

  Future<void> searchMyTodo({required String title}) async {
    myTask = await DBHelper.dbHelper.searchMyTasks(title: title);
    notifyListeners();
  }
}
