import 'dart:convert';

import 'package:hive/hive.dart';
import 'dart:math';

part 'reminder.g.dart';

@HiveType(typeId: 0)
class Reminder {
  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime createdAt;

  @HiveField(2)
  DateTime dueAt;

  @HiveField(3)
  int uid;

  Reminder({
    this.name,
    this.createdAt,
    this.dueAt,
  }) {
    this.uid = Random().nextInt(999999);
  }

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
      'Reminder(name: $name, createdAt: $createdAt, dueAt: $dueAt, uid: $uid)';
}
