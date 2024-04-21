import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notilist/models/controller.dart';
import 'package:notilist/pages/add_note_page.dart';
import 'package:notilist/weather.dart';
import 'package:weather/weather.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final NoteController nc = Get.put(NoteController());

  DateTime today = DateTime.now();
  final src =
      'https://variety.com/wp-content/uploads/2023/03/john-wick-chapter-4-keanu.jpg?w=1000&h=563&crop=1';
  String date = DateFormat("MMMM d, yyyy").format(DateTime.now());
  final auth = FirebaseAuth.instance;
  final WeatherFactory wf = WeatherFactory(api);
  Weather? weather;

  @override
  void initState() {
    super.initState();
    wf.currentWeatherByCityName("Bangkok").then((w) {
      setState(() {
        weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 255, 255, 255), // Set the background color to transparent
      appBar: AppBar(
        backgroundColor: const Color(0xffff7a00).withOpacity(0.3),
        title: Padding(
          padding: const EdgeInsets.only(left: 20, right: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'My Note,',
                        style: TextStyle(
                            color: Color(0xff7a2d2d),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Adamina'),
                      ),
                      Text(
                        auth.currentUser?.email ?? 'No email available',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(src),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.device_thermostat),
                  if (weather != null)
                    Text(
                      "${weather?.temperature!.celsius!.toStringAsFixed(2)} °C  |  $date",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  if (weather == null)
                    Text(
                      'N/A °C  |  $date',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                ],
              )
            ],
          ),
        ),
        toolbarHeight: 140,
        elevation: 0.0,
        flexibleSpace: Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 30.0),
          height: double.maxFinite,
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'unique2',
        backgroundColor: Colors.white,
        onPressed: () {
          Get.to(() => const MyNote());
        }, // Add a unique heroTag for the FloatingActionButton
        child: const Icon(Icons.add, color: Colors.black87),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color(0xffff7a00).withOpacity(0.3),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color(0xffffefdb),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: getTodoList(),
          ),
        ),
      ),
    );
  }

  Widget getTodoList() {
    return Obx(
      () => nc.notes.isEmpty
          ? const Center(
              child: Text('No notes yet')) // Placeholder text for empty list
          : ListView.builder(
              itemCount: nc.notes.length,
              itemBuilder: (context, index) {
                final note = nc.notes[index];
                return GestureDetector(
                  onTap: () {
                    nc.notes.remove(note);
                    nc.notes.insert(0, note);
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      tileColor: note.isBookmarked
                          ? Color.fromARGB(255, 196, 196, 196).withOpacity(0.1)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      title: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              note.isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: note.isBookmarked
                                  ? Color.fromARGB(255, 0, 0, 0)
                                  : null, // Update color based on isBookmarked
                            ),
                            onPressed: () {
                              nc.notes[index].isBookmarked =
                                  !nc.notes[index].isBookmarked;
                              nc.notes.refresh();
                              // Sort the notes based on bookmark status and refresh the UI
                              nc.notes.sort((a, b) => b.isBookmarked ? 1 : -1);
                              nc.notes.refresh();
                            },
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  note.title.length > 15
                                      ? note.title.substring(0, 15).removeAllWhitespace
                                      : note.title.removeAllWhitespace,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  note.description.length > 15
                                      ? note.description
                                          .split('\n')
                                          .first
                                          .substring(0, 15)
                                          .removeAllWhitespace
                                      : note.description
                                          .split('\n')
                                          .first
                                          .removeAllWhitespace,
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                Get.to(() => MyNote(index: index));
                              } else if (value == 'delete') {
                                Get.defaultDialog(
                                  title: 'Delete Task',
                                  middleText: note.title,
                                  onCancel: () => Get.back(),
                                  confirmTextColor: Colors.white,
                                  onConfirm: () {
                                    nc.notes.removeAt(index);
                                    Get.back();
                                  },
                                );
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'edit',
                                child: Text('Edit'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
