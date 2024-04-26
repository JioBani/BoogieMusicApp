
import 'package:database_project/Model/Playlist/CreatePlaylistDto.dart';

class Playlist{
  int id;
  String name;
  String userId;

  Playlist({
    required this.id,
    required this.name,
    required this.userId,
  });


  factory Playlist.fromMap(Map<String, dynamic> json) {
    return Playlist(
        id: json['playlist_id'] as int,
        name: json['playlist_name'],
        userId: json['user_id'],
    );
  }

  factory Playlist.fromJsonCurrent(Map<String, dynamic> json) {
    return Playlist(
        id: 0,
        name: json['playlist_name'],
        userId: json['user_id'],
    );
  }

  // factory Playlist.fromCreatePlaylistDto(CreatePlaylistDto createPlaylistDto) {
  //   return Playlist(
  //     id: json['playlist_id'] as int,
  //     name: json['playlist_name'],
  //     userId: json['user_id'],
  //   );
  // }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'userId': userId,
    };
  }
}