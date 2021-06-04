class Playlist {
  final String spotifyUri;
  final String name;

  Playlist({this.spotifyUri , this.name});

  factory Playlist.fromJson( Map<String, dynamic> json ){
    return Playlist(spotifyUri: json["items"], name: json["items"]);
  }
}