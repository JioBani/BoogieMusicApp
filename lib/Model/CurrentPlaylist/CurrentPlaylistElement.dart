class CurrentPlaylistElement{
  String userId;
  DateTime playTime;
  int musicId;

  CurrentPlaylistElement({
    required this.userId,
    required this.playTime,
    required this.musicId,
  });

  CurrentPlaylistElement.fromMap(Map<String, dynamic> map)
      : userId = map['user_id'],
        playTime = DateTime.fromMillisecondsSinceEpoch(int.parse(map['play_time'] as String)),
        musicId = map['music_id'];

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'play_time': playTime.toIso8601String(),
      'music_id': musicId,
    };
  }
}