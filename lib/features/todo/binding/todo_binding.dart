
import 'package:get/get.dart';
import 'package:todo_app_offline/features/todo/controller/todo_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {

    // Mendaftarkan TodoController
    Get.lazyPut(() => TodoController());
  }
}