// ignore_for_file: avoid_print, unused_field

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '../../../../api/app_routes.dart';
import '../../../../components/button_widget.dart';
import '../../../../components/logo_widget.dart';
import '../../widgets/email_widget.dart';
import '../../widgets/password_widget.dart';
import '../../../../utils/services/local_storage_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _email = TextEditingController();
  final _password = TextEditingController();

  check() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    final response = await http.post(
      Uri.parse('http://192.168.43.140/app_project/api_verification.php'),
      body: {
        'flag': 1.toString(),
        'email': _email.text,
        'password': _password.text,
        'fcm_token': 'test_fcm_token',
      },
    );

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String emailAPI = data['email'];
    String nameAPI = data['name'];
    String id = data['id'];

    if (value == 1) {
      setState(
        () {
          _loginStatus = LoginStatus.signIn;
          savePref(value, emailAPI, nameAPI, id);
        },
      );
      print(message);
      loginToast(message, Colors.green);
    } else {
      print('fail');
      print(message);
      loginToast(message, Colors.red);
    }
  }

  loginToast(String toast, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: toast,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.black,
    );
  }

  savePref(int value, String email, String name, String id) async {
    await LocalStorageService.setStateLogin(true);
    await LocalStorageService.saveUserData(email, name, id);
  }

  // ignore: prefer_typing_uninitialized_variables
  var value;

  @override
  void initState() {
    super.initState();
    getPref();
  }

  getPref() async {
    await LocalStorageService.initializePreference();
    setState(
      () {
        _loginStatus = LocalStorageService.getStateLogin()
            ? LoginStatus.signIn
            : LoginStatus.notSignIn;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoWidget(),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 24,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Welcome',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: const Text(
                          'Masuk untuk dapat mengakses informasi dll',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                EmailWidget(_email),
                PasswordWidget(_password),
                const SizedBox(
                  height: 18,
                ),
                loginButton(),
                registerButton(),
                if (_isLoading)
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 16,
                      ),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget loginButton() => Builder(
        builder: (context) => ButtonWidget('Masuk', 0, () {
          FocusScope.of(context).unfocus();
          var isValid = _formKey.currentState!.validate();
          checkLoginStatus(context, isValid);
        }),
      );

  Widget registerButton() => Builder(
        builder: (context) => Container(
          height: 55,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.indigo,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => navigateToRegister(context),
            child: const Text(
              'Register',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      );

  checkLoginStatus(BuildContext context, bool isValid) {
    if (isValid) {
      setState(() => _isLoading = true);
      setLoginState();
      navigateToHomeScreen(context);
      setState(() => _isLoading = false);
    }
  }

  void navigateToHomeScreen(BuildContext context) {
    Navigator.popAndPushNamed(context, AppRoutes.home);
  }

  navigateToRegister(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.register);
  }

  Future setLoginState() async {
    LocalStorageService.setStateLogin(true);
  }
}
