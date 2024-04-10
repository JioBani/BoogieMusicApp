import 'package:database_project/Model/MusicExtend.dart';

import '../Music.dart';

class CurrentPlaylist {
  String userId;
  List<MusicExtend> musics;

  CurrentPlaylist({
    required this.userId,
    required this.musics,
  });

  factory CurrentPlaylist.fromMap(Map<String, dynamic> map) {
    return CurrentPlaylist(
      userId: map['user_id'] as String,
      musics: (map['musics'] as List<dynamic>).map((e) => MusicExtend.fromMap(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'musics': musics.map((music) => music.toMap()).toList(),
    };
  }
}
