import 'package:flutter/rendering.dart';
import 'package:isar/isar.dart';

part 'schema.g.dart';

@collection
class Chunk {
  Id? id;

  DateTime? startTime;
  DateTime? endTime;
  final appointment = IsarLink<Appointment>();
}

@collection
class Appointment {
  Id? id;
  int? color;

  final chunks = IsarLinks<Chunk>();
}

@collection
class Schedule {
  Id? id;

  final appointments = IsarLinks<Appointment>();
}

