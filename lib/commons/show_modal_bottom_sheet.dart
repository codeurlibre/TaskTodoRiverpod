// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_reverpod/models/todo_model.dart';
import 'package:todo_reverpod/provider/radio_provider.dart';
import 'package:todo_reverpod/widgets/radio_widget.dart';
import 'package:uuid/uuid.dart';

import '../constants/app_style.dart';
import '../provider/date_time_provider.dart';
import '../provider/service_provider.dart';
import '../widgets/date_time_widget.dart';
import '../widgets/textfield_widget.dart';

// final selectedTime = Provider((ref) => selectTimeProvider);

class AddContainerModalBottomSheet extends ConsumerStatefulWidget {
  const AddContainerModalBottomSheet({super.key});

  @override
  ConsumerState createState() => _AddContainerModalBottomSheetState();
}

class _AddContainerModalBottomSheetState
    extends ConsumerState<AddContainerModalBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  dynamic selectedDate;
  dynamic selectedTime;

  @override
  void initState() {
    selectedDate = ref.read(selectDateProvider);
    selectedTime = ref.read(selectTimeProvider);
    print(selectedDate);
    print(selectedTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectedDate = ref.watch(selectDateProvider);
    selectedTime = ref.watch(selectTimeProvider);
    final service = ref.watch(serviceProvider);
    // * Select Date
    newDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2025));

      if (picked != null && picked != selectedDate) {
        ref.read(selectDateProvider.notifier).update(
              (state) => selectedDate = picked,
            );
      }
    }

    // * Select Time
    newTime(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime:
              TimeOfDay(hour: selectedTime.hour, minute: selectedTime.minute));

      if (picked != null && picked != selectedTime) {
        ref
            .read(selectTimeProvider.notifier)
            .update((state) => selectedTime = picked);
      }
    }

    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.70,
      // width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
                child: Text(
              "New Task Todo",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            )),
            Divider(
              thickness: 1.2,
              color: Colors.grey.shade200,
            ),
            const Gap(12),
            const Text("Title Task", style: headingStyleOne),
            const Gap(6),
            TextFieldWidget(
              textController: titleController,
              hintText: "Add Task name..",
              maxLine: 1,
            ),
            const Gap(12),
            const Text("Description", style: headingStyleOne),
            const Gap(6),
            TextFieldWidget(

              textController: descriptionController,
              hintText: "Add Description..",
              maxLine: 5,
            ),
            const Gap(12),
            const Text("Categories", style: headingStyleOne),
            const Gap(6),
            Row(
              children: [
                const Expanded(
                    child: RadioWidget(
                  categoryColor: Colors.green,
                  titleRadio: "LRN",
                  valueInput: 1,
                )),
                Expanded(
                    child: RadioWidget(
                  categoryColor: Colors.blue.shade700,
                  titleRadio: "WRK",
                  valueInput: 2,
                )),
                Expanded(
                    child: RadioWidget(
                  categoryColor: Colors.amberAccent.shade700,
                  titleRadio: "GN",
                  valueInput: 3,
                )),
              ],
            ),
            // * Date and Time section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: DateTimeWidget(
                  title: "Date",
                  text: DateFormat("dd/MMM/yy").format(selectedDate),
                  icon: CupertinoIcons.calendar,
                  onTap: () => newDate(context) /*() => print("Date")*/,
                )),
                const Gap(6),
                Expanded(
                    child: DateTimeWidget(
                  title: "Time",
                  text: "${selectedTime.hour}:${selectedTime.minute}",
                  icon: CupertinoIcons.clock,
                  onTap: () => newTime(context),
                ))
              ],
            ),
            const Gap(12),
            //  * Button section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 13),
                        foregroundColor: Colors.blue,
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 14),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      final getRadioValue = ref.watch(radioProvider);
                      String docID = const Uuid().v1();
                      String category = "";

                      switch (getRadioValue) {
                        case 1:
                          category = "Learning";
                          break;

                        case 2:
                          category = "Working";
                          break;

                        case 3:
                          category = "General";
                          break;
                      }

                      service.addNewTask(TodoModel(
                          // docID: docID,
                          titleTask: titleController.text,
                          description: descriptionController.text,
                          category: category,
                          dateTask:
                              DateFormat("dd/MMM/yy").format(selectedDate),
                          timeTask:
                              "${selectedTime.hour}:${selectedTime.minute}",
                          // isDone: false
                      ));
                      titleController.clear();
                      descriptionController.clear();

                      ref.read(radioProvider.notifier).update((state) => 0);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 3),
                          content: Text("Task Saving")));
                      print("Save");
                      // displayMessage("Task saving");
                    },
                    child: const Text("Create")),
              ],
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }
}
/*
class AddContainerModalBottomSheet extends ConsumerWidget {
  const AddContainerModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.70,
      // width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
                child: Text(
              "New Task Todo",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            )),
            Divider(
              thickness: 1.2,
              color: Colors.grey.shade200,
            ),
            const Gap(12),
            const Text("Title Task", style: headingStyleOne),
            const Gap(6),
            const TextFieldWidget(
              hintText: "Add Task name..",
              maxLine: 1,
            ),
            const Gap(12),
            const Text("Description", style: headingStyleOne),
            const Gap(6),
            const TextFieldWidget(
              hintText: "Add Description..",
              maxLine: 5,
            ),
            const Gap(12),
            const Text("Categories", style: headingStyleOne),
            const Gap(6),
            Row(
              children: [
                const Expanded(
                    child: RadioWidget(
                  categoryColor: Colors.green,
                  titleRadio: "LRN",
                  valueInput: 1,
                )),
                Expanded(
                    child: RadioWidget(
                  categoryColor: Colors.blue.shade700,
                  titleRadio: "WRK",
                  valueInput: 2,
                )),
                Expanded(
                    child: RadioWidget(
                  categoryColor: Colors.amberAccent.shade700,
                  titleRadio: "GN",
                  valueInput: 3,
                )),
              ],
            ),
            // * Date and Time section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: DateTimeWidget(
                  title: "Date",
                  text: "dd/mm/yy",
                  icon: CupertinoIcons.calendar,
                  onTap: () => print("Date"),
                )),
                const Gap(6),
                Expanded(
                    child: DateTimeWidget(
                  title: "Time",
                  text: "hh:mm",
                  icon: CupertinoIcons.clock,
                  onTap: () => print("Time"),
                ))
              ],
            ),
            const Gap(12),
            //  * Button section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 13),
                        foregroundColor: Colors.blue,
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 14),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {},
                    child: const Text("Create")),
              ],
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }
}*/
