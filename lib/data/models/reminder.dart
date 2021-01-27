import 'dart:convert';

import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Reminder {
  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime createdAt;

  @HiveField(2)
  DateTime dueAt;
  Reminder({
    this.name,
    this.createdAt,
    this.dueAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'dueAt': dueAt?.millisecondsSinceEpoch,
    };
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Reminder(
      name: map['name'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      dueAt: DateTime.fromMillisecondsSinceEpoch(map['dueAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Reminder.fromJson(String source) =>
      Reminder.fromMap(json.decode(source));

  @override
  String toString() =>
      'Reminder(name: $name, createdAt: $createdAt, dueAt: $dueAt)';
}

class ReminderAdapter extends TypeAdapter<Reminder> {
  @override
  final typeId = 1;

  @override
  Reminder read(BinaryReader reader) {
    return Reminder();
  }

  @override
  void write(BinaryWriter writer, Reminder obj) {
    writer.write(obj.name);
  }
}
