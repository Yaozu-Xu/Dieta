class Validator {
  static final RegExp emailReg = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  static String emailValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    if (!emailReg.hasMatch(value)) {
      return 'Email is invalid';
    }
    return null;
  }

  static String passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    if (value.length < 6) {
      return 'Password is too short';
    }
    return null;
  }

  static String usernameValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    if (value.length < 3) {
      return 'Username is too short';
    }
    return null;
  }

  static String heightValidator(String value) {
    try {
      if (value.isEmpty) {
        return 'Please enter some text';
      }
      if (double.parse(value) < 1.0 || double.parse(value) > 300) {
        return 'Invalid height';
      }
      return null;
    } catch (err) {
      return 'Invalid height';
    }
  }

  static String weightValidator(String value) {
    try {
      if (value.isEmpty) {
        return 'Please enter some text';
      }
      if (double.parse(value) <= 1.0 || double.parse(value) > 400) {
        return 'Invalid weight';
      }
    } catch (err) {
      return 'Invalid weight';
    }

    return null;
  }

  static String ageValidator(String value) {
    try {
      if (value.isEmpty) {
        return 'Please enter some text';
      }
      if (int.parse(value) < 0 || int.parse(value) > 200) {
        return 'Invalid age';
      }
    } catch (err) {
      return 'Invalid age';
    }
    return null;
  }
}
