// ignore_for_file: depend_on_referenced_packages

import 'package:hive/hive.dart';

part 'data_courses.g.dart';

@HiveType(typeId: 0)
class DataCoursesHive extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String isFavorite; // Ubah tipe menjadi String

  DataCoursesHive({
    required this.id,
    required this.isFavorite,
  });
}
