import 'package:flutter/material.dart';
import '../../widgets/class_mate_list_widget.dart';
import '../../widgets/home_banner_widget.dart';
import '../../../../utils/services/rest_api_services.dart';
import '../../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Datum>> _userData;

  @override
  void initState() {
    _userData = RestApiService.usersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HomeBannerWidget(),
          Container(
            margin: const EdgeInsets.only(
              top: 24,
              bottom: 14,
              left: 20,
            ),
            width: double.infinity,
            child: const Text(
              'Classmates',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          fetchUserData(),
        ],
      ),
    );
  }

  FutureBuilder<List<Datum>> fetchUserData() => FutureBuilder<List<Datum>>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ClassMateListWidget(snapshot.data as List<Datum>);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return const CircularProgressIndicator();
        },
      );
}
