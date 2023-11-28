import 'package:flutter/material.dart';
import 'package:app_project/utils/helpers/validator_helpers.dart';

class PasswordWidget extends StatefulWidget {
  final TextEditingController controller;

  const PasswordWidget(this.controller, {super.key});

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool _isHidePass = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
        left: 20,
        right: 20,
      ),
      width: double.infinity,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Password',
          prefixIcon: const Icon(Icons.password),
          suffixIcon: IconButton(
            onPressed: () {
              setState(
                () {
                  _isHidePass = !_isHidePass;
                },
              );
            },
            icon: Icon(_isHidePass ? Icons.visibility : Icons.visibility_off),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        validator: (value) => passwordValidator(value),
        controller: widget.controller,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _isHidePass,
      ),
    );
  }
}
