import 'package:database_project/Common/ImageUrls.dart';

class Music {
  final int id;
  final String title;
  final int albumId;
  final int streamingCount;
  final String? lyrics;
  //TODO 이미지 url 옮기기
  final String imageUrl = ImageUrls.coverImage01_butter;

  Music({
    required this.id,
    required this.title,
    required this.albumId,
    required this.streamingCount,
    this.lyrics,
  });

  factory Music.fromMap(Map<String, dynamic> map) {
    return Music(
      id: map['music_id'] as int,
      title: map['music_title'] as String,
      albumId: map['album_id'] as int,
      streamingCount: map['streaming_count'] as int,
      lyrics: map['lyrics'] as String?,
    );
  }

  factory Music.forTest() {
    return Music(
      id: -1,
      title: 'test',
      albumId: -1,
      streamingCount: -1,
      lyrics: "테스트",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'music_id': id,
      'music_title': title,
      'album_id': albumId,
      'streaming_count': streamingCount,
      'lyrics': lyrics,
    };
  }
}
