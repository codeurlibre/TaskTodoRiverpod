import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_reverpod/services/todo_service.dart';

import '../models/todo_model.dart';

final serviceProvider = StateProvider<TodoService>((ref) => TodoService());

final fetchStreamProvider = StreamProvider<List<TodoModel>>((ref) async*{
  final getData = FirebaseFirestore.instance
      .collection("todoApp")
      .snapshots()
      .map((event) => event.docs.map((snapshot) => TodoModel.fromSnapshot(snapshot)).toList());
  yield* getData;

});
