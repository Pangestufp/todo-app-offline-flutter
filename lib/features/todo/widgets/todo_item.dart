import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_offline/features/todo/widgets/todo_item_content.dart';
import 'package:todo_app_offline/shared/widgets/confirm_dialog.dart';

import '../models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onEdit; // menerima fungsi yg menerima input todo
  final Function(Todo) onFinish;
  final Function(Todo) onDelete;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onEdit,
    required this.onFinish,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),

      direction: DismissDirection.horizontal,

      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),

      confirmDismiss: (_) async {
        return await ConfirmDialog.show(
          title: "Hapus Todo",
          message: "Yakin ingin menghapus '${todo.title}'?",
        );
      },

      onDismissed: (_) {
        onDelete(todo);
        Get.snackbar(
          "Berhasil",
          "Todo berhasil dihapus",
          snackPosition: SnackPosition.BOTTOM,
        );
      },

      child: TodoCardContent(
        todo: todo,
        onEdit: () => onEdit(todo), // karna tidak ada input maka bisa langsung pakai VoidCallback
        onFinish: () => onFinish(todo),
      ),
    );
  }
}