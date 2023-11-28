import 'package:flutter/material.dart';
import '../../../utils/helpers/validator_helpers.dart';

class PhoneWidget extends StatelessWidget {
  final TextEditingController controller;

  const PhoneWidget(this.controller, {super.key});

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
          hintText: 'Phone Number',
          prefixIcon: const Icon(Icons.local_phone),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        validator: (value) => phoneNumberValidator(value),
        controller: controller,
        keyboardType: TextInputType.phone,
      ),
    );
  }
}
