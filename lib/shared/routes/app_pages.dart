import 'package:get/get.dart';
import 'package:todo_app_offline/features/todo/binding/todo_binding.dart';
import 'package:todo_app_offline/features/todo/view/todo_form_page.dart';
import 'package:todo_app_offline/features/todo/view/todo_page.dart';
import 'package:todo_app_offline/shared/routes/routes.dart';


class AppPages {
  AppPages._();// class ini hanya berisi member static dan tidak dibuat object-nya

  // registrasi seluruh halaman aplikasi beserta route dan binding-nya. jadi flutter tau controller apa yg dipersiapkan di halaman
  static final routes = [
    // Menu
    GetPage(
      name: Routes.MENU_TODO,
      page: () => TodoPage(),
      binding: TodoBinding(),
    ),
    GetPage(
      name: Routes.FORM_TODO,
      page: () => TodoFormPage(),
      binding: TodoBinding(),
    )
  ];
}
