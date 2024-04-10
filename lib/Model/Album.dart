class Album {
  final int albumId;
  final String albumTitle;
  final String albumImageUrl;

  Album({
    required this.albumId,
    required this.albumTitle,
    required this.albumImageUrl,
  });

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      albumId: map['album_id'] as int,
      albumTitle: map['album_title'] as String,
      albumImageUrl: map['album_image_url'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'album_id': albumId,
      'album_title': albumTitle,
      'album_image_url': albumImageUrl,
    };
  }
}
