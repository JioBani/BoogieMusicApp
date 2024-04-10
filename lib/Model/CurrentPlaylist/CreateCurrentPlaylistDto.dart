import 'dart:convert';

class CreateCurrentPlaylistDto {
  String userId;
  int playTime;
  int musicId;

  CreateCurrentPlaylistDto({
    required this.userId,
    required this.playTime,
    required this.musicId,
  });

  factory CreateCurrentPlaylistDto.fromMap(Map<String, dynamic> map) {
    return CreateCurrentPlaylistDto(
      userId: map['user_id'] as String,
      playTime: map['play_time'] as int,
      musicId: map['music_id'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'play_time': playTime,
      'music_id': musicId,
    };
  }

  String toJson(){
    return jsonEncode(toMap());
  }

  String toCreateJson(){
    return jsonEncode({
      'user_id': userId,
      'play_time': playTime.toString(),
      'music_id': musicId,
    });
  }
}
