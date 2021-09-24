import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth() async {
    await httpClient.request(url: url, method: 'post');
  }
}

abstract class HttpClient {
  Future<void> request({
    required String url,
    required String method,
  });
}

class HttpClientSpy extends Mock implements HttpClient{}

void main() {
  test(
    'Should call HttpClient with corret values',
    () async {
      final httpClient = HttpClientSpy();
      final url = faker.internet.httpUrl();

      /// Design Pattern 3A
      /// Arrange: onde o teste é organizado
      final sut = RemoteAuthentication(httpClient: httpClient, url: url);

      /// Act: Ação
      sut.auth();

      /// Accert
      verify(httpClient.request(url: url, method: 'post'));
    },
  );
}
