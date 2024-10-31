import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:interview/features/models/todo_model.dart';
import 'package:interview/features/models/todo_services.dart';
import 'package:interview/utility/messenger/messenger.dart';

class TodoProvider extends ChangeNotifier {
  final _toodServices = TodoServices();
  List<TodoModel> todos = [];
  bool isLoading = false;
  String? error;

  Future<void> getTodos() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      todos = await _toodServices.fetchTodos();
    } catch (e) {
      log("Error in Todo Services: getTodos => $e");
      error = "Failed to load todos.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool isBusyOnUpdate = false;
  Future<void> updateTodoStatus(TodoModel todo) async {
    try {
      isBusyOnUpdate = true;
      notifyListeners();
      todos = await _toodServices.updateTodoStatus(todo);
      Messenger.alert(msg: "Updated todo status!", color: Colors.green);
    } catch (e) {
      log("Error in Todo Services: updateTodoStatus => $e");
      var errorMsg = "Failed to update todo status.";
      Messenger.alert(msg: errorMsg, color: Colors.red);
    } finally {
      isBusyOnUpdate = false;
      notifyListeners();
    }
  }

  bool isBusyOnAdd = false;
  Future<void> addTodo(TodoModel todo) async {
    try {
      isBusyOnAdd = true;
      notifyListeners();

      todos = await _toodServices.addTodo(todo);
      Messenger.alert(msg: "Added todo!", color: Colors.green);
    } catch (e) {
      log("Error in Todo Services: addTodo => $e");
      var errorMsg = "Failed to add todo.";
      Messenger.alert(msg: errorMsg, color: Colors.red);
    } finally {
      isBusyOnAdd = false;
      notifyListeners();
    }
  }

  bool isBusyOnRemove = false;
  Future<void> removeTodo(TodoModel todo) async {
    try {
      isBusyOnRemove = true;
      notifyListeners();

      todos = await _toodServices.removeTodo(todo);
      Messenger.alert(msg: "Removed todo!", color: Colors.green);
    } catch (e) {
      log("Error in Todo Services: removeTodo => $e");
      var errorMsg = "Failed to remove todo.";
      Messenger.alert(msg: errorMsg, color: Colors.red);
    } finally {
      isBusyOnRemove = false;
      notifyListeners();
    }
  }
}
