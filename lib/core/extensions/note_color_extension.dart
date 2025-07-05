import 'package:flutter/material.dart';
import 'package:todo/feature/notes/data/models/note_model.dart';

extension NoteColorExtension on Note {
  Color get resolvedColor {
    if (color == null) return Colors.white;
    try {
      return Color(int.parse(color!.replaceFirst('#', '0xFF')));
    } catch (_) {
      return Colors.white;
    }
  }
}