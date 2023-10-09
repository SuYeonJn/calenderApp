import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scheduler/database/schema.dart';

class ScheduleManager {

  late Isar isar;

  openDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [ChunkSchema, AppointmentSchema, ScheduleSchema],
      directory: dir.path,
    );
    print("Isar database opened at ${isar.directory}");

    /*
    final newUser = User()..name = 'Jane Doe'..age = 36;
    await isar.writeTxn(() async {
      await isar.users.put(newUser); // insert & update
    });


    final existingUser = await isar.users.get(newUser.id); // get
    print("the user id is ${existingUser!.id}");

    await isar.writeTxn(() async {
      await isar.users.delete(existingUser.id!); // delete
    });
    */
  }

}