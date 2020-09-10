// To parse this JSON data, do
//
//     final albumsResponse = albumsResponseFromJson(jsonString);

import 'dart:convert';

AlbumsResponse albumsResponseFromJson(String str) => AlbumsResponse.fromJson(json.decode(str));

String albumsResponseToJson(AlbumsResponse data) => json.encode(data.toJson());

class AlbumsResponse {
  AlbumsResponse({
    this.href,
    this.items,
    this.limit,
    this.next,
    this.offset,
    this.previous,
    this.total,
  });

  String href;
  List<Item> items;
  int limit;
  String next;
  int offset;
  String previous;
  int total;

  factory AlbumsResponse.fromJson(Map<String, dynamic> json) => AlbumsResponse(
    href: json["href"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    limit: json["limit"],
    next: json["next"],
    offset: json["offset"],
    previous: json["previous"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "limit": limit,
    "next": next,
    "offset": offset,
    "previous": previous,
    "total": total,
  };
}

class Item {
  Item({
    this.artists,
    this.discNumber,
    this.durationMs,
    this.explicit,
    this.externalUrls,
    this.href,
    this.id,
    this.isLocal,
    this.isPlayable,
    this.name,
    this.previewUrl,
    this.trackNumber,
    this.type,
    this.uri,
  });

  List<Artist> artists;
  int discNumber;
  int durationMs;
  bool explicit;
  ExternalUrls externalUrls;
  String href;
  String id;
  bool isLocal;
  bool isPlayable;
  String name;
  String previewUrl;
  int trackNumber;
  ItemType type;
  String uri;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    discNumber: json["disc_number"],
    durationMs: json["duration_ms"],
    explicit: json["explicit"],
    externalUrls: ExternalUrls.fromJson(json["external_urls"]),
    href: json["href"],
    id: json["id"],
    isLocal: json["is_local"],
    isPlayable: json["is_playable"],
    name: json["name"],
    previewUrl: json["preview_url"],
    trackNumber: json["track_number"],
    type: itemTypeValues.map[json["type"]],
    uri: json["uri"],
  );

  Map<String, dynamic> toJson() => {
    "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
    "disc_number": discNumber,
    "duration_ms": durationMs,
    "explicit": explicit,
    "external_urls": externalUrls.toJson(),
    "href": href,
    "id": id,
    "is_local": isLocal,
    "is_playable": isPlayable,
    "name": name,
    "preview_url": previewUrl,
    "track_number": trackNumber,
    "type": itemTypeValues.reverse[type],
    "uri": uri,
  };
}

class Artist {
  Artist({
    this.externalUrls,
    this.href,
    this.id,
    this.name,
    this.type,
    this.uri,
  });

  ExternalUrls externalUrls;
  String href;
  String id;
  String name;
  ArtistType type;
  String uri;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    externalUrls: ExternalUrls.fromJson(json["external_urls"]),
    href: json["href"],
    id: json["id"],
    name: json["name"],
    type: artistTypeValues.map[json["type"]],
    uri: json["uri"],
  );

  Map<String, dynamic> toJson() => {
    "external_urls": externalUrls.toJson(),
    "href": href,
    "id": id,
    "name": name,
    "type": artistTypeValues.reverse[type],
    "uri": uri,
  };
}

class ExternalUrls {
  ExternalUrls({
    this.spotify,
  });

  String spotify;

  factory ExternalUrls.fromJson(Map<String, dynamic> json) => ExternalUrls(
    spotify: json["spotify"],
  );

  Map<String, dynamic> toJson() => {
    "spotify": spotify,
  };
}

enum ArtistType { ARTIST }

final artistTypeValues = EnumValues({
  "artist": ArtistType.ARTIST
});

enum ItemType { TRACK }

final itemTypeValues = EnumValues({
  "track": ItemType.TRACK
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
