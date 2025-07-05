import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorFilterService {
  static const _key = 'selected_color_hex';

  /// Color'ni `#RRGGBB` formatida saqlaydi
  static Future<void> saveSelectedColor(Color? color) async {
    final prefs = await SharedPreferences.getInstance();
    if (color == null) {
      await prefs.remove(_key);
    } else {
      final hex = '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
      await prefs.setString(_key, hex);
    }
  }

  /// Saqlangan `Color`ni qaytaradi
  static Future<Color?> loadSelectedColor() async {
    final prefs = await SharedPreferences.getInstance();
    final hex = prefs.getString(_key);
    if (hex == null) return null;

    try {
      final color = Color(int.parse('FF${hex.substring(1)}', radix: 16));
      return color;
    } catch (_) {
      return null;
    }
  }

  /// Saqlangan hex stringni olish (kerak bo‘lsa)
  static Future<String?> loadSelectedColorHex() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }
}
