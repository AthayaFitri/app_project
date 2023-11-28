import 'package:flutter/material.dart';
import 'class_mates_item_widget.dart';
import '../models/user.dart';

class ClassMateListWidget extends StatelessWidget {
  final List<Datum> usersData;

  const ClassMateListWidget(this.usersData, {super.key});

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
            itemCount: usersData.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final data = usersData[index];
              return ClassMatesItemWidget(
                data.id ?? 0,
                data.avatar ?? '',
                '${data.firstName} ${data.lastName}',
                data.email ?? '',
              );
            },
          ),
        ),
      ),
    );
  }
}
