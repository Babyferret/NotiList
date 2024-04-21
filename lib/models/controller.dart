import 'package:get/get.dart';  
import 'package:get_storage/get_storage.dart';  
import 'package:notilist/models/Data.dart';  

class NoteController extends GetxController {
  var notes = <Note>[].obs;

  void add(Note n) {
    notes.add(n);
  }
  
  @override
  void onInit() {
    List<dynamic>? storedNotes = GetStorage().read<List<dynamic>>('notes');
    if (storedNotes != null) {
      notes = storedNotes.map((e) => Note.fromJson(e)).toList().obs;
    }
    ever(notes, (_) {
      GetStorage().write('notes', notes.toList());
    });
    super.onInit();
  }

}

class TodoController extends GetxController {
  var tasks = <Task>[].obs;

  void add(Task n) {
    tasks.add(n);
  }

  @override
  void onInit() {
    List<dynamic>? storedTasks = GetStorage().read<List<dynamic>>('tasks');
    if (storedTasks != null) {
      tasks = storedTasks.map((e) => Task.fromJson(e)).toList().obs;
    }
    ever(tasks, (_) {
      GetStorage().write('tasks', tasks.toList());
    });
    super.onInit();
  }
}
