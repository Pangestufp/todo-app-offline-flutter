
import 'dart:ui';

import 'package:flutter/material.dart';

abstract class Styles {
  static const Color primaryColor = Color(0xFF2E7D32);   // deep green
  static const Color secondaryColor = Color(0xFFF1F8F4); // soft mint white
  static const Color tertiaryColor = Color(0xFFA5D6A7);  // light green

  static AppBar bar(String judul){
    return AppBar(
      title: Text(
        judul,
        style: TextStyle(color: Styles.primaryColor),
      ),
      centerTitle: true,
      backgroundColor: Styles.tertiaryColor,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Styles.primaryColor),
    );
  }

  static InputDecoration roundedInput(String hint) {
    return InputDecoration(
      labelStyle: TextStyle(color: Colors.white),
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white),
      filled: true,
      fillColor: primaryColor,
      suffixIcon: Icon(Icons.search, color: Colors.white),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: primaryColor, width: 1.5), // warna saat gak fokus
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: primaryColor, width: 2),   // warna saat fokus
      ),
    );
  }

  static InputDecoration underlineInput(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    );
  }

  static InputDecoration dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: primaryColor),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: primaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: primaryColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  static ButtonStyle EleButtonDecoration() {
    return ElevatedButton.styleFrom(
      backgroundColor: Styles.primaryColor,
      foregroundColor: Colors.white,
    );
  }

}