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
    this.colorIndex = 0, 
    this.isChecked = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      colorIndex: json['colorIndex'] ?? 0, 
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
      title: json['title'] ?? '', 
      description: json['description'] ?? '', 

    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
      };
}


