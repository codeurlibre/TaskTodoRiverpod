import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final textProvider = StateProvider<String>((ref) => "");

class TextFieldWidget extends ConsumerWidget {
  final TextEditingController textController;
  final String hintText;
  final int maxLine;
  const TextFieldWidget({super.key, required this.textController, required this.hintText, required this.maxLine});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // textController.text = ref.watch(textProvider);
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      child:  TextField(
        keyboardType: TextInputType.text,
        controller: textController,
        maxLines: maxLine,
        cursorColor: Colors.grey,
        decoration: InputDecoration(

            /*filled: true,
            fillColor: Colors.grey.shade200,*/
            border: const OutlineInputBorder(
                // borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 15)),
      ),

    );
  }
}
