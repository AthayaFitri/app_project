String? emailValidator(String? value) {
  const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
  final regExp = RegExp(pattern);

  if (value == null) {
    return 'Enter an email';
  } else if (!regExp.hasMatch(value)) {
    return 'Enter a valid email';
  } else {
    return null;
  }
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

String? fullnameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your full name';
  }
  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
    return 'Full name should only contain letters';
  }
  return null;
}

String? phoneNumberValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your phone number';
  }
  if (!RegExp(r'^[0-9-+]+$').hasMatch(value)) {
    return 'Invalid phone number';
  }
  if (value.length < 10 || value.length > 15) {
    return 'Phone number should be between 10 and 15 digits';
  }
  return null;
}
