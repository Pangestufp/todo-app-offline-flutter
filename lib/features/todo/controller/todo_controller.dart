import 'package:get/get.dart';
import 'package:todo_app_offline/features/todo/service/todo_service.dart';

class TodoController extends GetxController {
  final TodoService _service;

  TodoController(this._service);

}