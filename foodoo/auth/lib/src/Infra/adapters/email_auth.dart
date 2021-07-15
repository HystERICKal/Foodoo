import 'package:flutter/foundation.dart';

import '../../domain/auth_service_contract.dart';
import '../../domain/credential.dart';
import '../../domain/signup_service_contract.dart';
import '../../domain/token.dart';
import 'package:async/async.dart';

import '../api/auth_api_contract.dart';

class EmailAuth implements IAuthService, ISignUpService {
  final IAuthApi _api;
  Credential _credential;
  EmailAuth(this._api); //dependency to call the endpoint using the API

  void credential({
    @required String email,
    @required String password,
  }) {
    _credential = Credential(
      type: AuthType.email,
      email: email,
      password: password,
    );
  }

  @override
  Future<Result<Token>> signIn() async {
    //Whenever user has signed in make sure the credentials are added
    assert(_credential != null);
    //call api endpoint
    var result = await _api.signIn(_credential);
    if (result.isError) return result.asError;

    return Result.value(Token(result.asValue.value));
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<Result<Token>> signUp(
    String name,
    String email,
    String password,
  ) async {
    Credential credential = Credential(
      type: AuthType.email,
      email: email,
      name: name,
      password: password,
    );

    //call api endpoint
    //pass in credential
    var result = await _api.signUp(credential);
    if (result.isError) return result.asError;
    //otherwise return value as token
    return Result.value(Token(result.asValue.value));
  }
}
