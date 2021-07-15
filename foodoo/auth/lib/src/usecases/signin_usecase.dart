import '../domain/auth_service_contract.dart';
import '../domain/token.dart';

import 'package:async/async.dart';

class SignInUseCase {
  final IAuthService _authService;

  SignInUseCase(this._authService);

  Future<Result<Token>> execute() async {
    return await _authService.signIn();
  }
}
