import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/radio_provider.dart';

class RadioWidget extends ConsumerWidget {
  final Color categoryColor;
  final String titleRadio;
  final int valueInput;

  const RadioWidget(
      {super.key,
      required this.categoryColor,
      required this.titleRadio,
      required this.valueInput});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radioGroupValue = ref.watch(radioProvider);
    return RadioListTile(
      activeColor: categoryColor,
      contentPadding: const EdgeInsets.all(0),
      title: Transform.translate(
          offset: const Offset(-22, 0),
          child: Text(
            titleRadio,
            style: TextStyle(color: categoryColor),
          )),
      value: valueInput,
      groupValue: radioGroupValue,
      onChanged: (value) {
        ref.read(radioProvider.notifier).update((state) => value!);
      },
    );
  }
}
