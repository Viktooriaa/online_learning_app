import 'package:flutter/material.dart';

class MessageItem {
  const MessageItem({
    required this.name,
    required this.status,
    required this.time,
    required this.text,
    this.hasPreview = false,
  });

  final String name;
  final String status;
  final String time;
  final String text;
  final bool hasPreview;
}

class NotificationItem {
  const NotificationItem({
    required this.iconPath,
    required this.iconBackgroundColor,
    required this.iconWidth,
    required this.iconHeight,
    required this.title,
    required this.time,
  });

  final String iconPath;
  final Color iconBackgroundColor;
  final double iconWidth;
  final double iconHeight;
  final String title;
  final String time;
}
