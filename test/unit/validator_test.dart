import 'package:fyp_dieta/src/utils/validator.dart';
import 'package:test/test.dart';

void main() {
  group('Email test', () {
    test('Empty Email Test', () {
      final String result = Validator.emailValidator('');
      expect(result, 'Please enter some text');
    });
    test('Invalid Email Test', () {
      final String result = Validator.emailValidator('xxxxx');
      expect(result, 'Email is invalid');
    });
    test('Valid Email Test', () {
      final dynamic result = Validator.emailValidator('zoomxu@gmail.com');
      expect(result, null);
    });
  });

  group('Password test', () {
    test('Empty Password Test', () {
      final String result = Validator.passwordValidator('');
      expect(result, 'Please enter some text');
    });
    test('Invalid Password Test', () {
      final String result = Validator.passwordValidator('12345');
      expect(result, 'Password is too short');
    });
    test('Valid Password Test', () {
      final dynamic result = Validator.passwordValidator('tester12345');
      expect(result, null);
    });
  });

  group('User body data test', () {
    test('Invalid Height test', () {
      final String result = Validator.heightValidator('');
      expect(result, 'Please enter some text');
    });
    test('Invalid Height Test', () {
      final String result = Validator.heightValidator('xxx');
      expect(result, 'Invalid height');
    });
    test('Valid Height Test', () {
      final dynamic result = Validator.passwordValidator('tester12345');
      expect(result, null);
    });
  });
}
