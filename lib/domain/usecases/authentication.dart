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

  // Criação, na aula: 4 - Testando o body do request
  /// o clean arquitecture não recomenda o envio de nomes de campos
  /// fixado como no map abaixo ( email e password ), pois nem caso de
  /// alguma mudança de API, ex. password para pwd geraria problemas 
  /// de compatibilidade.
  Map toJson() => {'email': email, 'password': secret};
}
