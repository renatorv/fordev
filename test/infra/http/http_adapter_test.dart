import 'dart:convert';
import 'package:faker/faker.dart';
import 'package:fordev/data/http/http_client.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<Map> request({
    required String url,
    required String method,
    required Map body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final response = await client.post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    if(response.statusCode == 200){
      return response.body.isEmpty ? null : jsonDecode(response.body);
    }else{
      return null;
    }
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  group('post', () {
    test('Shoul call post with correct values', () async {
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();

      await sut
          .request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(client.post(Uri.parse(url),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: '{"any_key":"any_value"}'));
    });

    test('Shoul return data if post returns 200', () async {
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();

      when(client.post(url, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      final response = await sut.request(url: url, method: 'post', body: {'any_key': 'any_value'});

      expect('any_key', 'any_value');
    });
  });
}
