class Validator {

  static final emailReg = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  static String emailValidator(value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    if(!emailReg.hasMatch(value)) {
      return 'Email is invalid';
    }
    return null;
  }

  static String passwordValidator(value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    if(value.length < 6) {
      return 'Password is too short';
    }
    return null;
  }

  static String usernameValidator(value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    if(value.length < 3) {
      return 'Username is too short';
    }
    return null;
  }
}
