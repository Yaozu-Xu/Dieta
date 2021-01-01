import 'package:firebase_auth/firebase_auth.dart';

class UserFields {
  String displayName;
  String email;
  bool emailVerified;
  bool isAnonymous;
  String phoneNumber;
  String photoURL;
  String uid;

  UserFields({
    this.displayName,
    this.email,
    this.emailVerified,
    this.isAnonymous,
    this.phoneNumber,
    this.photoURL,
    this.uid,
  });

  factory UserFields.fromJson(User user) {
    return UserFields(
      displayName: user.displayName,
      email: user.email,
      emailVerified: user.emailVerified,
      isAnonymous: user.isAnonymous,
      phoneNumber: user.phoneNumber,
      photoURL: user.photoURL,
      uid: user.uid,
    );
  }
}
