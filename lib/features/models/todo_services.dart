import 'dart:developer';

import 'package:interview/features/models/todo_model.dart';
import 'package:interview/mock_server/mock_data.dart';
import 'package:interview/utility/local_storage/hive_utils.dart';
import 'package:interview/utility/network_utils/network_utils.dart';

class TodoServices {
  final mockData = MockData.data;

  final localStorage = LocalStorageUtils();
  final apiClient = NetworkUtils();

  Future<List<TodoModel>> fetchTodos() async {
    try {
      if (await apiClient.isNetworkAvailable()) {
       var res = await apiClient.request(endpoint: "/de6b2bd4-8500-4fcf-a8af-abc3102d6dff", method: HttpMethod.get);
       log("todo fetch res ${res?.data}");

        localStorage.saveAllData<TodoModel>(Map.from(mockData.map(
          (key, value) => MapEntry(key, TodoModel.fromJson(value)),
        )));
        return await localStorage.getAllData<TodoModel>();
      }
      return await localStorage.getAllData<TodoModel>();
    } catch (e) {
      log("todo fetch error : $e");
      rethrow;
    }
  }

  Future<List<TodoModel>> addTodo(TodoModel todo) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      mockData[todo.id] = (todo.toJson());
      return await fetchTodos();
    } catch (e) {
      log("todo fetch error : $e");
      rethrow;
    }
  }

  Future<List<TodoModel>> removeTodo(TodoModel todo) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      mockData.remove(
        todo.id,
      );
      await localStorage.deleteData<TodoModel>(todo.id);
      return await fetchTodos();
    } catch (e) {
      log("todo fetch error : $e");
      rethrow;
    }
  }

  Future<List<TodoModel>> updateTodoStatus(TodoModel todo) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      mockData[todo.id]?["status"] = todo.status;
      localStorage.saveData(todo.id, todo);
      return await fetchTodos();
    } catch (e) {
      log("todo fetch error : $e");
      rethrow;
    }
  }
}
