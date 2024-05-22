import 'package:game_of_fortune/core/extensions/validation.dart';
import 'package:intl/intl.dart';

class ValidationService {
  //private constructor
  ValidationService._privateConstructor();

  //singleton instance variable
  static ValidationService? _instance;

  //This code ensures that the singleton instance is created only when it's accessed for the first time.
  //Subsequent calls to ValidationService.instance will return the same instance that was created before.

  //getter to access the singleton instance
  static ValidationService get instance {
    _instance ??= ValidationService._privateConstructor();
    return _instance!;
  }

  //empty validator
  String? emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Field is required";
    }
    return null;
  }

  //email validator
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    } else if (value.isValidEmail() == false) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }

  //username validator
  String? userNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    } else if (value.isValidUsername() == false) {
      return 'Invalid username';
    } else {
      return null;
    }
  }

  //password validator
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null; // Return null if the password is valid
  }

  //password match function
  String? validateMatchPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password again';
    } else if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  //password match function
  String? validateMatchTime(DateTime? endTime, DateTime startTime) {
    if (endTime!.isBefore(startTime)) {
      return 'Please select the endtime after ${DateFormat('HH:mm').format(endTime)}';
    }
    return null;
  }
}
