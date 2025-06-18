class ValidatorHelper{
  static final emailRegex = RegExp(r'^[a-zA-Z0-9._%-]+@gmail\.com$');

  static String? validateEmailId(String? value){
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid Gmail address';
    }
    return null;
  }

    static String? serching(String? text){
    return null;
  }


  static String? validateTaskTitle(String? val) {
  if (val == null || val.trim().isEmpty) {
    return 'Please enter a valid task.';
  }

  final trimmedName = val.trim();

  if (trimmedName.length < 3) {
    return 'Task must be at least 3 characters long.';
  }

  if (trimmedName.contains(RegExp(r'\s{2,}'))) {
    return 'Avoid multiple spaces in the task.';
  }

  if (trimmedName.length > 80) {
    return 'Task must be less than 80 characters.';
  }

  return null;
}

  static String? validateTaskDescription(String? val) {
  if (val == null || val.trim().isEmpty) {
    return 'Please enter a valid information about the task.';
  }

  final trimmedName = val.trim();

  if (trimmedName.length < 10) {
    return 'Description must be at least 10 characters long.';
  }

  if (trimmedName.length > 2000) {
    return 'Task must be less than 2000 characters.';
  }

  return null;
}

    static String? loginValidation(String? password){
    if(password == null || password.isEmpty){
      return 'please enter your password';
    }else if (password.length > 15){
        return 'Oops! That password doesn’t look right.';
    }
    return null;
  }

    static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please fill the field';
    }

    if (password.length < 6 || password.length > 15) {
      return 'Password must be between 6 and 15 range.';
    }

    if (password.contains(' ')) {
      return 'Spaces are not allowed in the password.';
    }

    if (!RegExp(r'^[A-Z]').hasMatch(password)) {
      return 'The first letter must be uppercase.';
    }
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }


    static String? validatePasswordMatch(
      String? password, String? confirmPassword) {
    if (password == null || password.isEmpty) {
      return 'Create a new Password';
    }
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please fill the field';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match.';
    }
    return null;
  }
}