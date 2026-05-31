import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_offline/features/todo/controller/todo_controller.dart';
import 'package:todo_app_offline/features/todo/widgets/todo_item.dart';
import 'package:todo_app_offline/shared/routes/routes.dart';
import 'package:todo_app_offline/shared/widgets/styles.dart';

class TodoPage extends GetView<TodoController> {
  const TodoPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.secondaryColor,
      appBar: Styles.bar("Home"),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(
            Routes.FORM_TODO,
            arguments: null,
          );
        },
        backgroundColor: Styles.primaryColor,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body:Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: controller.searchController,
                      decoration: Styles.roundedInput("Search..."),
                      onChanged: controller.search,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 2,
                    child: Obx(() {
                      return DropdownButtonFormField<String>(
                        value: controller.selectedFilter.value,
                        decoration: Styles.dropdownDecoration("Filter"),
                        items: controller.filterList.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.changeFilter(value);
                          }
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
                child:  Obx(() {

                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.todoList.isEmpty) {
                  return const Center(child: Text("Tidak ada data Todo"));
                }

                return ListView.builder(
                  itemCount: controller.todoList.length,
                  itemBuilder: (context, index) {
                    final todo = controller.todoList[index];

                    return TodoItem(
                      todo: todo,
                      onEdit: (todo) {
                        Get.toNamed(Routes.FORM_TODO, arguments: todo);
                      },
                      onDelete: (todo) {
                        controller.delete(todo);
                      },
                      onFinish: (todo) {
                        controller.finishTodo(todo);
                      },
                    );
                  },
                );
              })

            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return ElevatedButton(
                      onPressed: controller.page.value > 1 ? controller.previousPage : null,
                      child: const Text("Prev"),
                      style: Styles.EleButtonDecoration(),
                    );
                  }),
                  const SizedBox(width: 20),
                  Obx((){
                    return Text("Page ${controller.page.value}");
                  }),

                  const SizedBox(width: 20),

                  ElevatedButton(
                    onPressed: controller.nextPage,
                    child: const Text("Next"),
                    style: Styles.EleButtonDecoration(),
                  ),
                ],
              ),
            ),
          ],
        )

    );
  }
}