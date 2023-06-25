import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_reverpod/models/todo_model.dart';

class TodoService {
  final todoCollection = FirebaseFirestore.instance.collection("todoApp");

//  * CREATE
  void addNewTask(TodoModel model) async {
    await todoCollection.add(model.toMap());
  }

// * UPDATE
  void updateTask({
    required String titleTask,
    String? docID
  }) async {
    await todoCollection.doc(docID).update({
      "titleTask": titleTask,
    });
  }

// * DELETE
  void deleteTask(String? docID){
    todoCollection.doc(docID).delete();
  }
}
