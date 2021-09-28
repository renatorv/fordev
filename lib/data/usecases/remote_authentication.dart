import 'package:fordev/domain/entities/account_entity.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../http/http.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<AccountEntity> auth(AuthenticationsParams params) async {
    final body = RemoteAuthenticationsParams.fromDomain(params).toJson();

    try {
      final httpResponse =
          await httpClient.request(url: url, method: 'post', body: body);
      return AccountEntity.fromjson(httpResponse);
    } on HttpError catch (error) {
      throw error == HttpError.unautorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationsParams {
  final String email;
  final String password;

  RemoteAuthenticationsParams({
    required this.email,
    required this.password,
  });

  factory RemoteAuthenticationsParams.fromDomain(
          AuthenticationsParams params) =>
      RemoteAuthenticationsParams(email: params.email, password: params.email);

  // Criação, na aula: 4 - Testando o body do request
  /// o clean arquitecture não recomenda o envio de nomes de campos
  /// fixado como no map abaixo ( email e password ), pois nem caso de
  /// alguma mudança de API, ex. password para pwd geraria problemas
  /// de compatibilidade.
  Map toJson() => {'email': email, 'password': password};
}
