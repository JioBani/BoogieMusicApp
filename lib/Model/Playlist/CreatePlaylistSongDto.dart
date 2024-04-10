import 'dart:convert';

class CreatePlaylistSongDto{
  int playlistId;
  int musicId;

  CreatePlaylistSongDto({
    required this.playlistId,
    required this.musicId,
  });

  factory CreatePlaylistSongDto.fromMap(Map<String, dynamic> map) {
    return CreatePlaylistSongDto(
      playlistId: map['playlist_id'] as int,
      musicId: map['music_id'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'playlist_id': playlistId,
      'music_id': musicId,
    };
  }

  String toJson(){
    return jsonEncode(toMap());
  }
}