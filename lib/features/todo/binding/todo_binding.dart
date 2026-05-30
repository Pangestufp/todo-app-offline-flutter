
import 'package:get/get.dart';
import 'package:todo_app_offline/features/todo/controller/todo_controller.dart';
import 'package:todo_app_offline/features/todo/service/todo_service.dart';
import 'package:todo_app_offline/features/todo/service/todo_service_impl.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    // Mendaftarkan implementasi TodoService.
    Get.lazyPut<TodoService>(() => TodoServiceImpl());

    // Mendaftarkan TodoController dan mengambil
    // dependency TodoService yang telah didaftarkan sebelumnya.
    Get.lazyPut(() => TodoController(Get.find<TodoService>()));
  }
}