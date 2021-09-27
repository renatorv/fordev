import '../../domain/usecases/usecases.dart';

import '../http/http.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth(AuthenticationsParams params) async {
    final body = RemoteAuthenticationsParams.fromDomain(params).toJson();
    await httpClient.request(url: url, method: 'post', body: body);
  }
}

class RemoteAuthenticationsParams {
  final String email;
  final String password;

  RemoteAuthenticationsParams({
    required this.email,
    required this.password,
  });

  factory RemoteAuthenticationsParams.fromDomain(AuthenticationsParams params) =>
    RemoteAuthenticationsParams(email: params.email, password: params.email);

  // Criação, na aula: 4 - Testando o body do request
  /// o clean arquitecture não recomenda o envio de nomes de campos
  /// fixado como no map abaixo ( email e password ), pois nem caso de
  /// alguma mudança de API, ex. password para pwd geraria problemas 
  /// de compatibilidade.
  Map toJson() => {'email': email, 'password': password};
}