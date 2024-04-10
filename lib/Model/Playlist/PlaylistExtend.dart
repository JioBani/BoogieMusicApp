import 'package:database_project/Model/MusicExtend.dart';
import 'Playlist.dart';


class PlaylistExtend {
  final Playlist playlist;
  final List<MusicExtend> musics;

  PlaylistExtend({
    required this.playlist,
    required this.musics,
  });

  factory PlaylistExtend.fromMap(Map<String, dynamic> map) {
    return PlaylistExtend(
      playlist: Playlist.fromMap(map['playlist'] as Map<String, dynamic>),
      musics: (map['musics'] as List<dynamic>)
          .map((musicMap) => MusicExtend.fromMap(musicMap as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'playlist': playlist.toMap(),
      'musics': musics.map((music) => music.toMap()).toList(),
    };
  }
}