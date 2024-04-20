import 'package:flutter/material.dart';
import 'package:notilist/models/Data.dart';
import 'package:get/get.dart';
import 'package:notilist/models/controller.dart';

class MyTodo extends StatefulWidget {
  final int? index;

  MyTodo({this.index});

  @override
  _MyTodoState createState() => _MyTodoState();
}

class _MyTodoState extends State<MyTodo> {
  final colorList = [
    const Color.fromRGBO(255, 255, 255, 1),
    const Color.fromRGBO(255, 174, 174, 1),
    const Color.fromRGBO(255, 211, 146, 1),
    const Color.fromRGBO(183, 246, 255, 1),
    const Color.fromRGBO(205, 175, 255, 1),
  ];

  final TodoController nc = Get.find();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  int selectedColorIndex = 0; // Default color index is 0 (white)

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
    );
    if (pickedTime != null && pickedTime != selectedStartTime) {
      setState(() {
        selectedStartTime = pickedTime;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
    );
    if (pickedTime != null && pickedTime != selectedEndTime) {
      setState(() {
        selectedEndTime = pickedTime;
      });
    }
  }

  bool _validateForm() {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      Task task = nc.tasks[widget.index!];
      titleController.text = task.title;
      descriptionController.text = task.description;
      selectedDate = task.date ?? DateTime.now();
      selectedStartTime = task.startTime ?? TimeOfDay.now();
      selectedEndTime = task.endTime ?? TimeOfDay.now();
      selectedColorIndex = task.colorIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task',
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                titletext(),
                const SizedBox(height: 5),
                titlefield(),
                const SizedBox(height: 10),
                descriptiontext(),
                const SizedBox(height: 5),
                descriptionfield(),
                const SizedBox(height: 10),
                datetext(),
                const SizedBox(height: 5),
                datefield(),
                const SizedBox(height: 10),
                timefield(),
                const SizedBox(height: 15),
                colortext(),
                const SizedBox(height: 10),
                colorSelection(),
                const SizedBox(height: 15),
                addbutton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget colorSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: colorList.asMap().entries.map((entry) {
          final index = entry.key;
          final color = entry.value;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedColorIndex = index;
              });
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                border: Border.all(
                  color: selectedColorIndex == index
                      ? Colors.black
                      : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  ElevatedButton addbutton() {
    return ElevatedButton(
      onPressed: () {
        if (_validateForm()) {
          if (widget.index == null) {
            nc.add(Task(
              title: titleController.text,
              description: descriptionController.text,
              date: selectedDate,
              startTime: selectedStartTime,
              endTime: selectedEndTime,
              colorIndex: selectedColorIndex, // Pass selectedColorIndex here
            ));
          } else {
            var updateTodo = nc.tasks[widget.index!];
            updateTodo.title = titleController.text;
            updateTodo.description = descriptionController.text;
            updateTodo.date = selectedDate;
            updateTodo.startTime = selectedStartTime;
            updateTodo.endTime = selectedEndTime;
            updateTodo.colorIndex =
                selectedColorIndex; // Update selectedColorIndex
            nc.tasks[widget.index!] = updateTodo;
          }
          Get.back();
        }
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(125, 50),
        textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        backgroundColor: const Color(0xffc58d65),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        foregroundColor: Colors.white,
      ),
      child: widget.index == null ? const Text('Add') : const Text('Edit'),
    );
  }

  Widget timefield() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              starttimetext(),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () => _selectStartTime(context),
                child: Container(
                  height: 48,
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${selectedStartTime.hour}:${selectedStartTime.minute}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(Icons.access_time),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
            width: 10), // Added spacing between Start Time and End Time
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              endtimetext(), // End Time text positioned above the End Time selection box
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () => _selectEndTime(context),
                child: Container(
                  height: 48,
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${selectedEndTime.hour}:${selectedEndTime.minute}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(Icons.access_time),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  GestureDetector datefield() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        height: 48,
        margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(Icons.calendar_today),
          ],
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

  Container descriptionfield() {
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
        controller: descriptionController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Enter Description',
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

  Padding descriptiontext() {
    return const Padding(
      padding: EdgeInsets.only(left: 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Description',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Padding datetext() {
    return const Padding(
      padding: EdgeInsets.only(left: 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Date',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Padding colortext() {
    return const Padding(
      padding: EdgeInsets.only(left: 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Color',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Padding starttimetext() {
    return const Padding(
      padding: EdgeInsets.only(left: 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Start Time',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Padding endtimetext() {
    return const Padding(
      padding: EdgeInsets.only(left: 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'End Time',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
