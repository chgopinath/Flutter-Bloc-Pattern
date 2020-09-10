import 'package:bloc_example/articles_data/articles_constants/articles_constants.dart';
import 'package:bloc_example/articles_data/models/articles_response.dart';
import 'package:bloc_example/articles_data/repository/articles_repository.dart';
import 'package:bloc_example/audio_data/audio_constants/audio_constants.dart';
import 'package:bloc_example/audio_data/models/albums_response.dart';
import 'package:bloc_example/audio_data/repository/album_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

main(){
  group('fetchAlbums', () {
    test('returns a Albums if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get('https://api.spotify.com/v1/albums/4aawyAB9vmqN3uQ7FjRGTy/tracks?market=ES&limit=5&offset=5', headers: {
        'Content-Type': '${AudioConstants.contentType}',
        'Authorization': '${AudioConstants.accessToken}'
      },))
          .thenAnswer((_) async => http.Response('{"status": "ok"}', 200));

      expect(await AlbumRepository().getAlbums(limit: 5), isA<AlbumsResponse>());
    });

  });

}