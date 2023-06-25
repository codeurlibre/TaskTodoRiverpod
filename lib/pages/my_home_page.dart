// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_reverpod/commons/show_modal_bottom_sheet.dart';
import 'package:todo_reverpod/widgets/card_todo_list_widget.dart';

import '../provider/service_provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
   var value = todoData.value?.length??"";
    var len = value;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.amber.shade200,
            child: Image.asset("assets/images/man-avatar.jpg"),
          ),
          title: const Text(
            "Hello i'm",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          subtitle: const Text(
            "Codeur Libre",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
          IconButton(
              onPressed: () {}, icon: const Icon(CupertinoIcons.calendar)),
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.bell)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text("Wednesday, 11 May",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue.shade700,
                          backgroundColor: const Color(0xFFD5E8FA),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () => showModalBottomSheet(
                          isDismissible: false,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) =>
                              const AddContainerModalBottomSheet()),
                      child: const Text("+ New Task")),
                ],
              ),
              const Gap(20),
              //  * Card list task
              ListView.builder(
                shrinkWrap: true,
                itemCount: todoData.value?.length??"".length/*todoData.value.length*/,
                itemBuilder: (context, index) => CardTodoListWidget(getIndex: index,)
              )
            ],
          ),
        ),
      ),
    );
  }
}
