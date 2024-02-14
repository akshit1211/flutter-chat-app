import 'package:firebase_auth/firebase_auth.dart';

class Users {
  String? name;
  String? email;
  String? uid;
  String? password;

  bool? isOnline;
  String? profilePhoto;

  Users(this.name, this.email, this.uid, this.password, this.isOnline,
      this.profilePhoto);

  // it acts as in-built function of this class
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(json["name"], json["email"], json['uid'], json['password'],
        json['isOnline'], json['profilePhoto']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "password": password,
      "isOnline": isOnline,
      "profilePhoto": profilePhoto,
    };
  }
}
