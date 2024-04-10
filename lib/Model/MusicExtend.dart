import 'package:database_project/Model/Album.dart';
import 'package:database_project/Model/Artist.dart';
import 'package:database_project/Model/Music.dart';

class MusicExtend{
  final Music music;
  final List<Artist> artists;
  final Album album;

  MusicExtend({required this.music, required this.artists, required this.album});

  factory MusicExtend.fromMap(Map<String, dynamic> map) {
    return MusicExtend(
      music: Music.fromMap(map['music'] as Map<String, dynamic>),
      artists: (map['artists'] as List<dynamic>)
          .map((artistMap) => Artist.fromMap(artistMap as Map<String, dynamic>))
          .toList(),
      album: Album.fromMap(map['album'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'music': music.toMap(),
      'artists': artists.map((artist) => artist.toMap()).toList(),
      'album': album.toMap(),
    };
  }
}