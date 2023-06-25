import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_reverpod/models/todo_model.dart';
import 'package:todo_reverpod/provider/service_provider.dart';

import '../provider/checkbox_provider.dart';

class CardTodoListWidget extends ConsumerWidget {
  final int getIndex;

  CardTodoListWidget({super.key, required this.getIndex});

  final TextEditingController updateTitleController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCheck = ref.watch(checkboxProvider);
    final todoData = ref.watch(fetchStreamProvider);

    isChecked() {
      ref.read(checkboxProvider.notifier).update((state) => state = !isCheck);
    }

    // * UPDATE TITLE TASK
    final service = ref.watch(serviceProvider);
    updateTitleTask(
        {required String title,
        required BuildContext context,
        required String docID}) {
      showDialog(
        context: context,
        barrierDismissible: false,
        // false = user must tap button, true = tap outside dialog
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text(title),
            content: TextField(
              controller: updateTitleController,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                },
              ),
              TextButton(
                child: const Text('Update'),
                onPressed: () {
                  ref.read(serviceProvider).updateTask(
                      titleTask: updateTitleController.text, docID: docID);
                  updateTitleController.clear();
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        },
      );
    }

    // * DELETE TASK
    deleteTask({required String titleTask, required String docID}) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text("Voulez-vous supprimer $titleTask ?"),
            content: const Text(
                'Ceci supprimera définitivement le document de la liste'),
            actions: <Widget>[
              TextButton(
                child: const Text('Non'),
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                },
              ),
              TextButton(
                child: const Text('Oui'),
                onPressed: () {
                  service.deleteTask(docID);
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                },
              ),
            ],
          );
        },
      );
    }

    return todoData.when(
      data: (todoData) {
        Color categoryColor = Colors.white;

        final getCategory = todoData[getIndex].category;

        switch (getCategory) {
          case "Learning":
            categoryColor = Colors.green;
            break;

          case "Working":
            categoryColor = Colors.blue.shade700;
            break;

          case "General":
            categoryColor = Colors.amberAccent.shade700;
            break;
        }
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 18,
                decoration: BoxDecoration(
                    color: categoryColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(14),
                        bottomLeft: Radius.circular(14))),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(todoData[getIndex].titleTask),
                        subtitle: Text(todoData[getIndex].description),
                        trailing: Transform.translate(
                          offset: Offset(0, 10),
                          child: Column(
                            children: [
                              Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        updateTitleTask(
                                            title: todoData[getIndex].titleTask,
                                            context: context,
                                            docID:
                                                "${todoData[getIndex].docID}");
                                      },
                                      icon: const Icon(Icons.edit))),
                              const Gap(20),
                              Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        deleteTask(
                                            titleTask:
                                                todoData[getIndex].titleTask,
                                            docID:
                                                "${todoData[getIndex].docID}");
                                        print("Delete");
                                      },
                                      icon: const Icon(Icons.delete))),
                            ],
                          ),
                        ) /*Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          shape: const CircleBorder(),
                          activeColor: Colors.blue.shade800,
                          value: false,
                          onChanged: (value) => isChecked(),
                        ),
                      ),*/
                        ),
                    Expanded(
                      child: Container(
                        child: Transform.translate(
                          offset: const Offset(0, 6),
                          child: Container(
                            child: Column(
                              children: [
                                Divider(
                                  thickness: 1.5,
                                  color: Colors.grey.shade200,
                                ),
                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${todoData[getIndex].dateTask}, "),
                                    Text(todoData[getIndex].timeTask)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
            ],
          ),
        );
      },
      error: (error, stackTrace) => Center(child: Text(stackTrace.toString())),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
