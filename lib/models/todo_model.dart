import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? docID;
  final String titleTask;
  final String description;
  final String category;
  final String dateTask;
  final String timeTask;

  // bool? isDone;

//<editor-fold desc="Data Methods">
  TodoModel({
    this.docID,
    required this.titleTask,
    required this.description,
    required this.category,
    required this.dateTask,
    required this.timeTask,
    // required this.isDone
  });

  @override
  String toString() {
    return 'TodoModel{'
        'docID: $docID, titleTask: $titleTask, description: $description, category: $category, dateTask: $dateTask, timeTask: $timeTask, }';
  }

  TodoModel copyWith({
    String? docID,
    String? titleTask,
    String? description,
    String? category,
    String? dateTask,
    String? timeTask,
    // bool? isDone,
  }) {
    return TodoModel(
      docID: docID ?? this.docID,
      titleTask: titleTask ?? this.titleTask,
      description: description ?? this.description,
      category: category ?? this.category,
      dateTask: dateTask ?? this.dateTask,
      timeTask: timeTask ?? this.timeTask,
      // isDone: isDone?? this.isDone
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titleTask': titleTask,
      'description': description,
      'category': category,
      'dateTask': dateTask,
      'timeTask': timeTask,
      // 'isDone': isDone,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      docID: map['docID'] as String,
      titleTask: map['titleTask'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      dateTask: map['dateTask'] as String,
      timeTask: map['timeTask'] as String,
      // isDone: map['isDone'] as bool,
    );
  }

  factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel(
      docID: doc.id,
      titleTask: doc['titleTask'],
      description: doc['description'],
      category: doc['category'],
      dateTask: doc['dateTask'],
      timeTask: doc['timeTask'],
      // isDone: doc['idDone'],
    );
  }

//</editor-fold>
}
