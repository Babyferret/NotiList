import 'package:flutter/material.dart';

class Task {
  String title;
  String description;
  DateTime? date;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  int colorIndex;
  bool isChecked;

  Task({
    required this.title,
    this.description = '',
    this.date,
    this.startTime,
    this.endTime,
    this.colorIndex = 0, // Default color index
    this.isChecked = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      colorIndex: json['colorIndex'] ?? 0, // Default color index
      isChecked: json['isChecked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'colorIndex': colorIndex,
      'isChecked': isChecked,
    };
  }
}

class Note {
  String title;
  String description;
  bool isBookmarked; 

 Note({
    required this.title,
    this.description = '',
    this.isBookmarked = false, 

  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'] ?? '', // Use default value if 'title' is null
      description: json['description'] ?? '', // Use default value if 'description' is null
      // date: DateTime.parse(json['date']), // Parse date directly
      // startTime: TimeOfDay.fromDateTime(DateTime.parse(json['startTime'])), // Parse startTime directly
      // endTime: TimeOfDay.fromDateTime(DateTime.parse(json['endTime'])), // Parse endTime directly
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        // 'date': date.toIso8601String(), // Convert DateTime to ISO 8601 string
        // 'startTime': '${startTime.hour}:${startTime.minute}', // Format startTime as HH:mm string
        // 'endTime': '${endTime.hour}:${endTime.minute}', // Format endTime as HH:mm string
      };
}


