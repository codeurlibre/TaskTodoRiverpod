import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowDate = DateTime.now();
TimeOfDay nowTime = TimeOfDay.now() /*(hour: 0, minute: 0)*/
    ;

final selectDateProvider = StateProvider<DateTime>((ref) => nowDate);
final selectTimeProvider = StateProvider<TimeOfDay>((ref) => nowTime);
