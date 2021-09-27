import '../entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationsParams params);
}

class AuthenticationsParams {
  final String email;
  final String secret;

  AuthenticationsParams({
    required this.email,
    required this.secret,
  });
}
