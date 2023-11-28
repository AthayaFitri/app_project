// ignore_for_file: unused_local_variable

import 'package:app_project/db/data_courses.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'api/app_routes.dart';
import 'modules/auth/screens/login/login_screen.dart';
import 'modules/auth/screens/register/register_screen.dart';
import 'modules/home/screens/detail/detail_user_arguments.dart';
import 'modules/home/screens/detail/detail_user_screen.dart';
import 'modules/home/screens/home_screen.dart';
import 'utils/services/local_storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.initializePreference();

  // Inisialisasi Hive
  await Hive.initFlutter();

  // Daftarkan adapter untuk model DataCoursesHive
  Hive.registerAdapter(
      DataCoursesHiveAdapter()); // Sesuaikan dengan nama adapter yang digunakan

  await Hive.openBox<DataCoursesHive>('data_courses_box');
  runApp(const MyApp());
  await Hive.close();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void dispose() {
    // Disini kamu dapat menutup Hive atau melakukan hal lain yang perlu di-dispose
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Comfortaa',
      ),
      title: 'My Project',
      debugShowCheckedModeBanner: false,
      initialRoute: getInitialRoute(),
      onGenerateRoute: (settings) => configRoute(settings),
    );
  }

  String getInitialRoute() {
    if (LocalStorageService.getStateLogin()) {
      return AppRoutes.home;
    } else {
      return AppRoutes.login;
    }
  }

  Route? configRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return buildRoute(const LoginScreen(), settings: settings);
      case AppRoutes.register:
        return buildRoute(const RegisterScreen(), settings: settings);
      case AppRoutes.home:
        return buildRoute(const HomeScreen(), settings: settings);
      case AppRoutes.detailUser:
        final DetailUserArguments args =
            settings.arguments as DetailUserArguments;
        return buildRoute(DetailUserScreen(args), settings: settings);
      default:
        return null;
    }
  }

  MaterialPageRoute buildRoute(Widget child,
          {required RouteSettings settings}) =>
      MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => child,
      );
}
