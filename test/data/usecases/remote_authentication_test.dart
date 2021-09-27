import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fordev/data/http/http_client.dart';
import 'package:fordev/data/usecases/usecases.dart';
import 'package:fordev/domain/usecases/authentication.dart';
import 'package:mockito/mockito.dart';

// class RemoteAuthentication {
//   final HttpClient httpClient;
//   final String url;

//   RemoteAuthentication({required this.httpClient, required this.url});

//   Future<void> auth(AuthenticationsParams params) async {
//     await httpClient.request(url: url, method: 'post', body: params.toJson());
//   }
// }

// abstract class HttpClient {
//   Future<void> request({
//     required String url,
//     required String method,
//     Map body,
//   });
// }

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
}
