import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_offline/features/todo/models/todo.dart';
import 'package:todo_app_offline/shared/widgets/styles.dart';

class TodoCardContent extends StatelessWidget {
  final Todo todo;
  final VoidCallback onEdit;
  final VoidCallback onFinish;

  const TodoCardContent({
    super.key,
    required this.todo,
    required this.onEdit,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM yyyy, HH:mm').format(DateTime.parse(todo.createdDate));

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(todo.description),
            const SizedBox(height: 8),
            Text(formattedDate),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Chip(
                label: Text(todo.status),
                backgroundColor: todo.status == "Finish"
                    ? Styles.tertiaryColor
                    : Colors.amber,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  style: Styles.EleButtonDecoration(),
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text("Edit", style:
                    TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

                if (todo.status != "Finish")
                  const SizedBox(width: 8),

                if (todo.status != "Finish")
                  ElevatedButton.icon(
                    style: Styles.EleButtonDecoration(),
                    onPressed: onFinish,
                    icon: const Icon(Icons.check, color:  Colors.white),
                    label: const Text("Finish",
                    style: TextStyle(
                      color: Colors.white
                    ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}