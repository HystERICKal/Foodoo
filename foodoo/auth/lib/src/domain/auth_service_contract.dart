import 'token.dart';
import 'package:async/async.dart';

abstract class IAuthService {
  //Return a result type which is either a valid result or an error during a sign in

  Future<Result<Token>> signIn(); //return a token during a sign in
  Future<void> signOut(); //return a void during a sign in
}
