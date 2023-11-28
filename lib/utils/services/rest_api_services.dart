import 'dart:convert';
import 'package:http/http.dart';
import '../../modules/home/models/courses.dart';
import '../../api/api_path.dart';
import '../../modules/home/models/user.dart';

class RestApiService {
  static Future<List<Datum>> usersData() async {
    final response = await get(
      Uri.parse(ApiPath.getUsersRequestUrl),
    );

    if (response.statusCode == 200) {
      var results = User.fromJson(jsonDecode(response.body));
      return results.data;
    } else {
      throw Exception('Failed to load Data');
    }
  }

  static Future<List<DataCourses>> coursesData() async {
    final response = await get(
      Uri.parse(ApiPath.getCoursesRequestUrl),
    );

    if (response.statusCode == 200) {
      var results = Courses.fromJson(jsonDecode(response.body));
      return results.data;
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
