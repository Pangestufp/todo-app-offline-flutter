
import 'package:todo_app_offline/features/todo/models/todo.dart';

abstract class TodoService {//fungsi abstarct untuk service todo
  Future<void> create(Todo todo);
  Future<void> update(Todo todo);
  Future<void> delete(String id);
  Future<List<Todo>> getByFilter(String? status,String? search, int page);// jika null keduanya maka akan get all
}