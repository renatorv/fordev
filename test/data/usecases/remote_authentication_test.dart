import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fordev/data/http/http_client.dart';
import 'package:fordev/data/usecases/usecases.dart';
import 'package:fordev/domain/usecases/authentication.dart';
import 'package:mockito/mockito.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  test(
    'Should call HttpClient with corret values',
    () async {
      final httpClient = HttpClientSpy();
      final url = faker.internet.httpUrl();

      when(httpClient.request(url: url, method: 'post')).thenAnswer((_) async =>
          {'accessToken': faker.guid.guid(), 'name': faker.person.name()});

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

  // test(
  //   'Should throw UnexpectedError if HttpClient return 400',
  //   () async {

  //     final httpClient = HttpClientSpy();
  //     final url = faker.internet.httpUrl();

  //     when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
  //       .thenThrow(HttpError.badRequest);

  //     final params = AuthenticationsParams(
  //       email: faker.internet.email(),
  //       secret: faker.internet.password(),
  //     );

  //     final sut = RemoteAuthentication(httpClient: httpClient, url: url);

  //     final future = sut.auth(params);

  //     expect(future, throwsA(DomainError.unexpected));
  //   },
  // );

  //   test(
  //   'Should throw InvalidCredentialerro if HttpClient return 401',
  //   () async {

  //     final httpClient = HttpClientSpy();
  //     final url = faker.internet.httpUrl();

  //     when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
  //       .thenThrow(HttpError.unautorized);

  //     final params = AuthenticationsParams(
  //       email: faker.internet.email(),
  //       secret: faker.internet.password(),
  //     );

  //     final sut = RemoteAuthentication(httpClient: httpClient, url: url);

  //     final future = sut.auth(params);

  //     expect(future, throwsA(DomainError.invalidCredentials));
  //   },
  // );

  test(
    'Should return an Account if HttpClient return 200',
    () async {
      final httpClient = HttpClientSpy();
      final url = faker.internet.httpUrl();

      final accessToken = faker.guid.guid();

      when(httpClient.request(
              url: anyNamed('url'),
              method: anyNamed('method'),
              body: anyNamed('body')))
          .thenAnswer((_) async =>
              {'accessToken': accessToken, 'name': faker.person.name()});

      final params = AuthenticationsParams(
        email: faker.internet.email(),
        secret: faker.internet.password(),
      );

      final sut = RemoteAuthentication(httpClient: httpClient, url: url);

      final account = await sut.auth(params);

      expect(account.token, accessToken);
    },
  );
}
