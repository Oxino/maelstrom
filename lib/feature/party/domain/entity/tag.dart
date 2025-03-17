import 'package:flutter/material.dart';

enum Tag {
  techno(color: Colors.purple),
  quizz(color: Colors.yellow);

  final Color color;
  const Tag({required this.color});
}
