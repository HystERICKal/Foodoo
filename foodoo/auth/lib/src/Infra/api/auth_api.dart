import 'dart:convert';

import 'package:async/async.dart';
import 'package:http/http.dart' as http;

import '../../Infra/api/auth_api_contract.dart'; // the '../..' makes the path relative
import '../../domain/credential.dart';
import 'mapper.dart';

class AuthApi implements IAuthApi {
  final http.Client _client; //dependency
  String baseUrl;

  //Use constructor injection to get this in
  AuthApi(this.baseUrl, this._client);

  @override
  Future<Result<String>> signIn(Credential credential) async {
    //returns a token whenever the call to the sign in endpoint is successful
    //create endpoint
    var endpoint = baseUrl + '/auth/signin'; //....'/module_name/method_name'

    return await _postCredential(endpoint, credential);
  }

  @override
  Future<Result<String>> signUp(Credential credential) async {
    var endpoint = baseUrl + '/auth/signup';
    return await _postCredential(endpoint, credential);
  }

  //method that handles the POST calls, accepts the endpoint and the credential
  Future<Result<String>> _postCredential(
      String endpoint, Credential credential) async {
    var response = 
        await _client.post(Uri.parse(endpoint), body: Mapper.toJson(credential));

    if (response.statusCode != 200) return Result.error('Server error');
    //else get the json result from the body of the response
    var json = jsonDecode(response.body);

    //from the json, stripout the auth token
    return json['auth_token'] != null
        ? Result.value(json['auth_token'])
        //else, return error with the messsage property of the returned json object
        : Result.error(json['message']);
  }
}
