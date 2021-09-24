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
  HttpClientSpy httpClient;
  String url;
  RemoteAuthentication sut;
  setUp((){
      httpClient = HttpClientSpy();
      url = faker.internet.httpUrl();
      /// Design Pattern 3A
      /// Arrange: onde o teste é organizado
      sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });
  test(
    'Should call HttpClient with corret values',
    () async {
      /// Act: Ação
      sut.auth();

      /// Accert
      verify(httpClient.request(url: url, method: 'post'));
    },
  );
}
