
import 'dart:convert';

import 'package:todo_app_offline/features/todo/models/todo.dart';
import 'package:todo_app_offline/features/todo/service/todo_service.dart';
import 'package:todo_app_offline/shared/services/local_storage.dart';

class TodoServiceImpl implements TodoService {
  static const String storageKey = "todos";

  final LocalStorage localStorage = LocalStorage();

  // mengambil semua data dari local storage
  Future<List<Todo>> _getTodos() async {
    final data = await localStorage.get(storageKey);

    if (data == null || data.isEmpty) {
      return [];
    }

    final List<dynamic> jsonList = jsonDecode(data);

    return jsonList.map((item) => Todo.fromJson(item)).toList();
  }

  // menyimpan seluruh data todo ke local starage.
  Future<void> _saveTodos(List<Todo> todos) async {
    final jsonString = jsonEncode(
      todos.map((todo) => todo.toJson()).toList(),
    );

    await localStorage.save(storageKey,jsonString);
  }


  @override
  Future<void> create(Todo todo) async {
    final todos = await _getTodos();

    todos.add(todo);

    await _saveTodos(todos);
  }

  @override
  Future<void> update(Todo todo) async {
    final todos = await _getTodos();

    final index = todos.indexWhere(
          (item) => item.id == todo.id,
    );

    if (index == -1) {
      throw Exception("Todo tidak ditemukan");
    }

    todos[index] = todo;

    await _saveTodos(todos);
  }

  @override
  Future<void> delete(String id) async {
    final todos = await _getTodos();

    todos.removeWhere(
          (item) => item.id == id,
    );

    await _saveTodos(todos);
  }

  @override
  Future<List<Todo>> getByFilter(String? status, String? search, int page) async {
    const int pageSize = 10;

    List<Todo> todos = await _getTodos();

    // filter berdasarkan status.
    if (status != null && status.isNotEmpty && status.toLowerCase() != "all") {
      todos = todos.where((item) {
        return item.status.toLowerCase() == status.toLowerCase();
      }).toList();
    }

    // filter berdasarkan title.
    if (search != null && search.isNotEmpty) {
      todos = todos.where((item) {
        return item.title.toLowerCase().contains(
          search.toLowerCase(),
        );
      }).toList();
    }

    // pagination.
    final startIndex = (page - 1) * pageSize;

    if (startIndex >= todos.length) {
      return [];
    }

    int endIndex;

    if ((startIndex + pageSize) > todos.length) {
      endIndex = todos.length;
    } else {
      endIndex = startIndex + pageSize;
    }

    return todos.sublist(
      startIndex,
      endIndex,
    );
  }
}