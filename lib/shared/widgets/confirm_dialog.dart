import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_offline/shared/widgets/styles.dart';

class ConfirmDialog {
  static Future<bool> show({
    required String title,
    required String message,
  }) async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            style: Styles.EleButtonDecoration(),
            onPressed: () {
              Get.back(result: false);// back dengan fungsi get x, return result false
            },
            child: Text("Tidak"),
          ),
          ElevatedButton(
            style: Styles.EleButtonDecoration(),
            onPressed: () {
              Get.back(result: true);// back dengan fungsi get x, return result true
            },
            child: Text("Ya"),
          ),
        ],
      ),
    ) ??
        false;
  }
}