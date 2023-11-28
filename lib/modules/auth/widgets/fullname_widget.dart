import 'package:flutter/material.dart';
import '../../../utils/helpers/validator_helpers.dart';

class FullnameWidget extends StatelessWidget {
  final TextEditingController controller;

  const FullnameWidget(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      width: double.infinity,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Fullname',
          prefixIcon: const Icon(Icons.person),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        validator: (value) => fullnameValidator(value),
        controller: controller,
        keyboardType: TextInputType.name,
      ),
    );
  }
}
