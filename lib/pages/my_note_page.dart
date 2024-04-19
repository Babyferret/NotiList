import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notilist/models/controller.dart';
import 'package:notilist/pages/add_note_page.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final NoteController nc = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(
          255, 255, 255, 255), // Set the background color to transparent
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo App'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'unique2', // Add a unique heroTag for the FloatingActionButton
        child: Icon(Icons.add, color: Colors.black87),
        backgroundColor: Colors.white,
        onPressed: () {
          Get.to(() => MyNote());
        },
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xfffff9f2).withOpacity(1),
              const Color(0xffffb763)
                  .withOpacity(0.1), // Cream gradient color end
            ],
            stops: [0.0, 0.5], // Adjust the gradient stops if needed
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: getTodoList(),
        ),
      ),
    );
  }

  Widget getTodoList() {
    return Obx(
      () => nc.notes.isEmpty
          ? Center(
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
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      tileColor: note.isBookmarked
                          ? Colors.blue.withOpacity(0.1)
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
                                  ? Colors.blue
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
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              note.title,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
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
