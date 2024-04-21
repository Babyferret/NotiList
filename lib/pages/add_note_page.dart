import 'package:flutter/material.dart';
import 'package:notilist/models/Data.dart';
import 'package:get/get.dart';
import 'package:notilist/models/controller.dart';

class MyNote extends StatefulWidget {
  final int? index;

  const MyNote({super.key, this.index});

  @override
  _MyNoteState createState() => _MyNoteState();
}

class _MyNoteState extends State<MyNote> {
  final NoteController nc = Get.find();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      Note note = nc.notes[widget.index!];
      titleController.text = note.title;
      descriptionController.text = note.description;
    }
  }

  bool _validateForm() {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Note',
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
            color: Color(0xfff4d3bd),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                titletext(),
                const SizedBox(height: 5),
                titlefield(),
                const SizedBox(height: 15),
                notetext(),
                const SizedBox(height: 5),
                notefield(),
                const SizedBox(height: 15),
                addbutton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton addbutton() {
    return ElevatedButton(
      onPressed: () {
        if (_validateForm()) {
          if (widget.index == null) {
            nc.add(Note(
              title: titleController.text,
              description: descriptionController.text,
            ));
          } else {
            var updateNote = nc.notes[widget.index!];
            updateNote.title = titleController.text;
            updateNote.description = descriptionController.text;
            nc.notes[widget.index!] = updateNote;
          }
          Get.back();
        }
      },
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(125, 50),
          textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          backgroundColor: const Color(0xffc58d65),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          foregroundColor: Colors.white),
      child: widget.index == null ? const Text('Add') : const Text('Edit'),
    );
  }

  Container notefield() {
    return Container(
      width: double.maxFinite,
      height: 350,
      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black),
        color: Colors.white,
      ),
      child: TextField(
        controller: descriptionController,
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Enter note here',
          hintStyle: TextStyle(
            color: const Color(0xff241c1c).withOpacity(0.6),
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Padding notetext() {
    return const Padding(
      padding: EdgeInsets.only(left: 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Note',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Container titlefield() {
    return Container(
      width: double.maxFinite,
      height: 48,
      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black),
        color: Colors.white,
      ),
      child: TextField(
        controller: titleController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Title name',
          hintStyle: TextStyle(
            color: const Color(0xff241c1c).withOpacity(0.6),
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Padding titletext() {
    return const Padding(
      padding: EdgeInsets.only(left: 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Title',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
