// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:hive/hive.dart';

import '../../db/data_courses.dart';

class FavoriteService {
  static final Box<DataCoursesHive> box =
      Hive.box<DataCoursesHive>('data_courses_box');

  static Future<void> addToFavorites(int itemId) async {
    await box.put(itemId, DataCoursesHive(id: itemId, isFavorite: true));
  }

  static Future<void> removeFromFavorites(int itemId) async {
    await box.delete(itemId);
  }

  static bool isFavorite(int itemId) {
    final dataFromHive = box.get(itemId);
    print('Data from Hive for $itemId: $dataFromHive');
    return dataFromHive?.isFavorite ?? false;
  }
}
