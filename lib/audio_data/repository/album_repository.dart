import 'dart:convert';
import 'package:bloc_example/audio_data/audio_constants/audio_constants.dart';
import 'package:bloc_example/audio_data/models/albums_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AlbumRepository {

  Future<AlbumsResponse> getAlbums({@required int limit}) async {
    String url =
        'https://api.spotify.com/v1/albums/4aawyAB9vmqN3uQ7FjRGTy/tracks?market=ES&limit=$limit&offset=5';
   var response = await http.get(
      url,
      headers: {
        'Content-Type': '${AudioConstants.contentType}',
        'Authorization': '${AudioConstants.accessToken}'
      },
    );

   print('Response Code: ${response.statusCode}');
   print('Response: ${json.decode(response.body)}');

    return AlbumsResponse.fromJson(json.decode(response.body));
  }
}
