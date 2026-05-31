import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_offline/features/todo/controller/todo_controller.dart';
import 'package:todo_app_offline/shared/widgets/styles.dart';

class TodoFormPage extends GetView<TodoController> {
  const TodoFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final todo = Get.arguments;
    final bool isCreate = todo == null;// jika todo null dari argument berarti dia create

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isCreate) {
        controller.clearForm();
      } else {
        controller.setForm(todo);
      }
    });

    return Scaffold(
      appBar: Styles.bar(isCreate ? "Create Todo": "Edit Todo"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
          
              // title
              TextFormField(
                controller: controller.titleController,
                decoration: Styles.underlineInput("Title"),
                validator: (value) => value == null || value.isEmpty ? "Title can't be empty" : null // jika null maka akan muncul pesan
              ),
          
              const SizedBox(height: 12),
          
              // deskripsi
              TextFormField(
                controller: controller.descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: Styles.underlineInput("Description"),
                validator: (value) => value == null || value.isEmpty ? "Title can't be empty" : null
              ),

              const SizedBox(height: 12),

              // hanya bisa ubah status manual di edit mode
              if (!isCreate)
                Obx(() {
                  return DropdownButtonFormField<String>(
                    value: controller.selectedStatus.value,
                    items: controller.statusList
                        .map(
                          (status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedStatus.value = value;
                      }
                    },
                    decoration: Styles.dropdownDecoration("Status")
                  );
                }),
          
              const SizedBox(height: 20),
          
              // BUTTON
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                      if(_formKey.currentState?.validate() ?? false) {// validasi semua validator dalam form
                        if (!isCreate) {
                          controller.updateTodo();
                        } else {
                          controller.createTodo();
                        }
                      }
                    },
                    child: Text(
                      controller.isLoading.value
                          ? "Loading..."
                          : (!isCreate ? "Update" : "Create"),
                    ),
                    style: Styles.EleButtonDecoration(),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}