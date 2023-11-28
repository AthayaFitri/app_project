// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '../../../../api/app_routes.dart';
import '../../widgets/fullname_widget.dart';
import '../../widgets/phone_widget.dart';
import '../../../../components/button_widget.dart';
import '../../../../components/logo_widget.dart';
import '../../widgets/email_widget.dart';
import '../../widgets/password_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullname = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Register',
        ),
        centerTitle: true,
      ),
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
                        'Daftar',
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
                          'Silahkan Register mendapatkan akun dll',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FullnameWidget(_fullname),
                EmailWidget(_email),
                PhoneWidget(_phoneNumber),
                PasswordWidget(_password),
                ButtonWidget(
                  'Register',
                  24,
                  () {
                    FocusScope.of(context).unfocus();
                    var isValid = _formKey.currentState!.validate();
                    checkRegisterStatus(context, isValid);
                  },
                ),
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

  void checkRegisterStatus(BuildContext context, bool isValid) async {
    if (isValid) {
      setState(() => _isLoading = true);

      try {
        final response = await http.post(
          Uri.parse('http://192.168.43.140/app_project/api_verification.php'),
          body: {
            'flag': 2.toString(),
            'name': _fullname.text,
            'email': _email.text,
            'mobile': _phoneNumber.text,
            'password': _password.text,
            'fcm_token': 'test_fcm_token',
          },
        );

        final data = jsonDecode(response.body);
        int value = data['value'];
        String message = data['message'];
        print(value);
        if (value == 1) {
          Navigator.pop(context);
          print(message);
          registerToast(message, Colors.green);
          _navigateToLoginScreen();
        } else {
          print(message);
          registerToast(message, Colors.green);
        }
      } catch (e) {
        if (e is SocketException) {
          print('Error: Koneksi jaringan terputus.');
        } else {
          print('Error: $e');
        }
        // print('Error: $e');
        registerToast('Something went wrong', Colors.red);
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void registerToast(String toast, Color color) {
    Fluttertoast.showToast(
      msg: toast,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
    );
  }

  void _navigateToLoginScreen() {
    Navigator.popAndPushNamed(context, AppRoutes.login);
  }
}
