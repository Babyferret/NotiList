import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notilist/models/controller.dart';
import 'package:notilist/pages/add_task_page.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TodoController nc = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Set the background color to transparent
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo App'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag:
            'unique1',
        backgroundColor: Colors.white,
        onPressed: () {
          Get.to(() => MyTodo());
        }, // Add a unique heroTag for the FloatingActionButton
        child: const Icon(Icons.add, color: Colors.black87),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xfffff9f2).withOpacity(1),
              const Color(0xffffb763).withOpacity(0.1), 
            ],
            stops: const [0.0, 0.5], // Adjust the gradient stops if needed
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: getTodoList(),
        ),
      ),
    );
  }

 Widget getTodoList() {
  return Obx(
    () => nc.tasks.isEmpty
        ? const Center(child: Text('No notes yet'))
        : ListView.builder(
            itemCount: nc.tasks.length,
            itemBuilder: (context, index) => Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                tileColor: nc.tasks[index].colorIndex != null
                    ? getColorFromIndex(nc.tasks[index].colorIndex)
                    : Colors.white, // Set tile color based on colorIndex
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                title: Row(
                  children: [
                    Checkbox(
                      value: nc.tasks[index].isChecked,
                      onChanged: (newValue) {
                        nc.tasks[index].isChecked = newValue ?? false;
                        nc.tasks.refresh(); // Refresh the observable list
                      },
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                    ),
                    const SizedBox(width: 8), // Add spacing between Checkbox and Text
                    Expanded(
                      child: Text(
                        nc.tasks[index].title,
                        style: TextStyle(
                          decoration: nc.tasks[index].isChecked
                              ? TextDecoration.lineThrough
                              : null,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          Get.to(() => MyTodo(index: index));
                        } else if (value == 'delete') {
                          Get.defaultDialog(
                            title: 'Delete Task',
                            middleText: nc.tasks[index].title,
                            onCancel: () => Get.back(),
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              nc.tasks.removeAt(index);
                              Get.back();
                            },
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
          ),
  );
}



  Color getColorFromIndex(int index) {
    switch (index) {
      case 0:
        return const Color.fromRGBO(255, 255, 255, 1);
      case 1:
        return const Color.fromRGBO(255, 174, 174, 1);
      case 2:
        return const Color.fromRGBO(255, 211, 146, 1);
      case 3:
        return const Color.fromRGBO(183, 246, 255, 1);
      case 4:
        return const Color.fromRGBO(205, 175, 255, 1);
      default:
        return Colors.white;
    }
  }
}

