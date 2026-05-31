import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_app_offline/features/todo/models/todo.dart';
import 'package:todo_app_offline/features/todo/service/todo_service.dart';
import 'package:uuid/uuid.dart';

class TodoController extends GetxController {
  final TodoService _todoService;

  TodoController(this._todoService);

  final isLoading = false.obs; // untuk tau apakah masih loading atau tidak
  final page = 1.obs; // untuk pagination, sellau mulai dari halaman 1
  final selectedFilter = "All".obs; // filter yg dipiliah di frontend, default all
  final todoList = <Todo>[].obs; // list data todo
  final filterList = [
    "All",
    "Pending",
    "Finish",
  ].obs; // jenis-jenis filter

  final statusList = [
    "Pending",
    "Finish",
  ].obs; // jenis-jenis status

  final selectedStatus = "Pending".obs;
  // default status

  // ini yg dipilih buat edit
  Todo? selectedTodo;

  //beberapa text editing yyg dipakai untuk filter dan crud
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final searchController = TextEditingController();

  @override
  void onInit() { // akan dijalankan saat masuk halaman
    super.onInit();
    loadTodos();
  }

  // mengambil data todo berdasarkan filter, search, dan page
  Future<void> loadTodos() async {
    try {
      isLoading.value = true;

      final todos = await _todoService.getByFilter(
        selectedFilter.value,
        searchController.text,
        page.value,
      );

      todoList.assignAll(todos);
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // menambah todo baru
  Future<void> createTodo() async {
    try {
      isLoading.value = true;

      final todo = Todo(
        id: const Uuid().v4(),
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        status: "Pending",
        createdDate: DateTime.now().toString(),
      );

      await _todoService.create(todo);

      Get.back();

      await loadTodos();

      clearForm();

      Get.snackbar(
        "Success",
        "Todo berhasil ditambahkan",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // mengubah todo yang sudah ada
  Future<void> updateTodo() async {
    final todo = selectedTodo;
    if (todo==null ){
      Get.snackbar(
        "Success",
        "Todo berhasil diubah",
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    try {
      isLoading.value = true;

      final updatedTodo = Todo(
        id: todo.id,
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        status: selectedStatus.value,
        createdDate: todo.createdDate,
      );

      await _todoService.update(updatedTodo);

      Get.back();

      await loadTodos();

      clearForm();

      Get.snackbar(
        "Success",
        "Todo berhasil diubah",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // mengubah status todo menjadi Finish
  Future<void> finishTodo(Todo todo) async {
    try {
      isLoading.value = true;

      final updatedTodo = Todo(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        status: "Finish",
        createdDate: todo.createdDate,
      );

      await _todoService.update(updatedTodo);

      await loadTodos();

      Get.snackbar(
        "Success",
        "Todo selesai",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // menghapus todo
  Future<void> delete(Todo todo) async {
    try {
      isLoading.value = true;

      await _todoService.delete(todo.id);

      await loadTodos();

      Get.snackbar(
        "Success",
        "Todo berhasil dihapus",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // menjalankan pencarian + debounce
  Timer? _searchDebounce;

  Future<void> search(String keyword) async {
    _searchDebounce?.cancel();

    _searchDebounce = Timer(
      const Duration(milliseconds: 500),
          () async {
        page.value = 1;
        await loadTodos();
      },
    );
  }

  // mengubah filter
  Future<void> changeFilter(String filter) async {
    selectedFilter.value = filter;

    page.value = 1;

    await loadTodos();
  }

  // halaman berikutnya
  Future<void> nextPage() async {
    page.value++;

    await loadTodos();
  }

  // halaman sebelumnya
  Future<void> previousPage() async {
    if (page.value > 1) {
      page.value--;

      await loadTodos();
    }
  }

  // mengisi form ketika edit.
  void setForm(Todo todo) {
    selectedTodo = todo;
    titleController.text = todo.title;
    descriptionController.text = todo.description;
    selectedStatus.value = todo.status;
  }

  //bersihkan setelah insert atau update
  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    selectedStatus.value = "Pending";
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    searchController.dispose();
    _searchDebounce?.cancel();

    super.onClose();
  }

}