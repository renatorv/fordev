import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fordev/data/http/http_client.dart';
import 'package:fordev/data/usecases/usecases.dart';
import 'package:fordev/domain/helpers/helpers.dart';
import 'package:fordev/domain/usecases/authentication.dart';
import 'package:mockito/mockito.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  test(
    'Should call HttpClient with corret values',
    () async {
      final httpClient = HttpClientSpy();
      final url = faker.internet.httpUrl();

      final params = AuthenticationsParams(
        email: faker.internet.email(),
        secret: faker.internet.password(),
      );

      /// Design Pattern 3A
      /// Arrange: onde o teste é organizado
      final sut = RemoteAuthentication(httpClient: httpClient, url: url);

      /// Act: Ação
      sut.auth(params);

      /// Accert
      verify(
        httpClient.request(
            url: url,
            method: 'post',
            body: {'email': params.email, 'password': params.secret}),
      );
    },
  );

  test(
    'Should throw UnexpectedError if HttpClient return 400',
    () async {
      
      final httpClient = HttpClientSpy();
      final url = faker.internet.httpUrl();

      when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
        .thenThrow(HttpError.badRequest);

      final params = AuthenticationsParams(
        email: faker.internet.email(),
        secret: faker.internet.password(),
      );

      final sut = RemoteAuthentication(httpClient: httpClient, url: url);

      final future = sut.auth(params);

      expect(future, throwsA(DomainError.unexpected));
    },
  );
}
