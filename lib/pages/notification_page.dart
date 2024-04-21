import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:notilist/weather.dart';
import 'package:weather/weather.dart';
import 'package:notilist/models/controller.dart';
import 'package:get/get.dart';
import 'package:notilist/models/Data.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final TodoController nc = Get.put(TodoController());
  late Task closestTask; // Define a variable to hold the closest task

  @override
  void initState() {
    super.initState();
    // Find the task with the closest start time
    closestTask = findClosestTask();
  }

  Task findClosestTask() {
    DateTime now = DateTime.now();
    DateTime? closestTime;
    Task? closestTask;

    for (Task task in nc.tasks) {
      if (task.startTime == null) continue; // Skip tasks without start time

      // Convert TimeOfDay to DateTime for comparison
      DateTime taskDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        task.startTime!.hour,
        task.startTime!.minute,
      );

      // Compare with closestTime, update if closer
      if (closestTime == null || taskDateTime.isBefore(closestTime)) {
        closestTime = taskDateTime;
        closestTask = task;
      }
    }

    return closestTask ?? Task(title: 'No tasks', description: '', date: null);
  }

  DateTime today = DateTime.now();
  final src =
      'https://variety.com/wp-content/uploads/2023/03/john-wick-chapter-4-keanu.jpg?w=1000&h=563&crop=1';
  String date = DateFormat("MMMM d, yyyy").format(DateTime.now());
  final auth = FirebaseAuth.instance;
  final WeatherFactory wf = WeatherFactory(api);
  Weather? weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NotiList',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(244, 211, 189, 1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black45, spreadRadius: 2, blurRadius: 10),
            ],
          ),
        ),
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xfffff9f2).withOpacity(1),
                const Color(0xffffb763).withOpacity(0.1),
              ],
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 30.0),
                height: 130,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black45,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2))
                  ],
                ),
                child: Column(
                  children: [
                    info_bar(),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                height: 350,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    border: Border.all(color: Colors.black)),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Icon(Icons.border_color_outlined),
                        title: Text(
                          'Title',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            closestTask.title), // Show closest task's title
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Icon(Icons.description_outlined),
                        title: Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(closestTask
                            .description), // Show closest task's description
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Icon(Icons.calendar_today),
                        title: Text(
                          'Date',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: closestTask.startTime != null
                            ? Text(
                                DateFormat('MMM dd, yyyy HH:mm').format(
                                  DateTime(
                                    today.year,
                                    today.month,
                                    today.day,
                                    closestTask.startTime!.hour,
                                    closestTask.startTime!.minute,
                                  ),
                                ),
                              )
                            : Text('No start time available'),
                        // Show closest task's start time if available
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding info_bar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10, top: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.attach_file,
                        size: 30,
                      ),
                      Text(
                        'Hello,',
                        style: TextStyle(
                            color: Color(0xff7a2d2d),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Adamina',
                            fontSize: 22),
                      ),
                    ],
                  ),
                  Text(
                    auth.currentUser?.email ?? 'No email available',
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(src),
              ),
            ],
          ),
          const Row(
            children: [
              Text(
                'You have a new reminder',
                style: TextStyle(
                    color: Color(0xff402b1c),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          )
        ],
      ),
    );
  }
}
