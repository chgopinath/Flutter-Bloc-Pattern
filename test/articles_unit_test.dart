import 'package:bloc_example/articles_data/articles_constants/articles_constants.dart';
import 'package:bloc_example/articles_data/models/articles_response.dart';
import 'package:bloc_example/articles_data/repository/articles_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

main(){
  group('fetchArticles', () {
    test('returns a Article if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(ArticlesConstants.newsAPI))
          .thenAnswer((_) async => http.Response('{"status": "ok"}', 200));

      expect(await ArticlesRepository().getArticlesData(), isA<List<Articles>>());
    });

  });

}