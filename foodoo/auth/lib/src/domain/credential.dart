import 'package:flutter/foundation.dart';

class Credential {
  final AuthType type;
  final String name;
  final String email;
  final String password;

  //Constructor
  Credential({
    @required this.type,
    this.name,
    @required this.email,
    @required this.password,
  });
}

//Authentication type to know whether user was authenticated using email or google

enum AuthType {email, google}