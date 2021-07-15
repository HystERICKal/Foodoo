 import '../../domain/credential.dart';
import 'package:async/async.dart';

abstract class IAuthApi{
   Future<Result<String>> signIn(Credential credential);//Takes in the credential
   Future<Result<String>> signUp(Credential credential);
 }