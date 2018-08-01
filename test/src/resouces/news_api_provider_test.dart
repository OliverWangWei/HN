import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('FetchTopIds returns a list of ids', () async {
    // set up the test case
    final newsApi = NewsApiProvider();

    // when client get is excuted rather than making he real request
    // the inner function will be invoked
    // and it return to response in news_api_provider.dart

    // the moment async function is called it will return future
    newsApi.client = MockClient((request) async {
      // the response
      return Response(json.encode([1, 2, 3]), 200);
    });

    final ids = await newsApi.fetchTopIds();

    // expectation   (actual, matcher)

    expect(ids, [1, 2, 3]);

  });

  test('FetchItem returns item model', () async {

    final newsApi = NewsApiProvider();

    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });
    final item = await newsApi.fetchItem(999);

    expect(item.id, 123);

  });

}