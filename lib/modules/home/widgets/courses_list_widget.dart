import 'package:flutter/material.dart';
import 'courses_item_widget.dart';
import '../models/courses.dart';

class CoursesListWidget extends StatelessWidget {
  final List<DataCourses> dataCourses;

  const CoursesListWidget(this.dataCourses, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Container(
          padding: const EdgeInsets.only(
            bottom: 16,
          ),
          child: ListView.builder(
            physics: const ScrollPhysics(
              parent: null,
            ),
            itemCount: dataCourses.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final data = dataCourses[index];
              return CoursesItemWidget(
                data.id,
                data.name,
                data.year,
                data.color,
                data.pantoneValue,
              );
            },
          ),
        ),
      ),
    );
  }
}
