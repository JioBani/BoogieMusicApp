import 'package:database_project/Model/Music.dart';

class TopChart{
  int ranking;
  int musicId;
  Music music;

  TopChart({
    required this.ranking,
    required this.musicId,
    required this.music,
  });

  factory TopChart.fromMap(Map<String, dynamic> map) {
    return TopChart(
      ranking: map['ranking'] as int,
      musicId: map['music_id'] as int,
      music: Music.fromMap(map['music'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ranking': ranking,
      'music_id': musicId,
      'music': music.toMap(),
    };
  }
}