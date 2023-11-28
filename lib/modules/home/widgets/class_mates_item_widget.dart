import 'package:flutter/material.dart';
import '../../../api/app_routes.dart';
import '../screens/detail/detail_user_arguments.dart';

class ClassMatesItemWidget extends StatelessWidget {
  final int id;
  final String avatarUrl;
  final String fullName;
  final String email;

  const ClassMatesItemWidget(this.id, this.avatarUrl, this.fullName, this.email,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
        ),
        child: ListTile(
          leading: SizedBox(
            width: 65,
            height: 70,
            child: CircleAvatar(
              foregroundImage: NetworkImage(avatarUrl),
            ),
          ),
          title: Text(
            fullName,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Container(
            margin: const EdgeInsets.only(
              top: 6,
            ),
            child: Text(
              email,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () {
            var args = DetailUserArguments(
              userName: fullName,
              email: email,
              avatarUrl: avatarUrl,
            );
            Navigator.pushNamed(context, AppRoutes.detailUser, arguments: args);
          },
        ),
      ),
    );
  }
}
