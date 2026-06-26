import 'package:flutter/material.dart';

class Course {
  const Course({
    required this.title,
    required this.author,
    required this.price,
    required this.hours,
    this.hasVideos = true,
  });

  final String title;
  final String author;
  final String price;
  final String hours;
  final bool hasVideos;
}

enum LessonAction { play, pause, locked }

class Lesson {
  const Lesson({
    required this.number,
    required this.title,
    required this.duration,
    required this.action,
  });

  final int number;
  final String title;
  final String duration;
  final LessonAction action;

  bool get isLocked => action == LessonAction.locked;
}

class MyCourse {
  const MyCourse({
    required this.title,
    required this.completed,
    required this.color,
    required this.actionColor,
    this.progressTopSpacing = 23,
  });

  final String title;
  final String completed;
  final Color color;
  final Color actionColor;
  final double progressTopSpacing;
}
