import 'dart:convert';

class CreatePlaylistDto{
  String name;
  String userId;

  CreatePlaylistDto({
    required this.name,
    required this.userId,
  });


  factory CreatePlaylistDto.fromMap(Map<String, dynamic> json) {
    return CreatePlaylistDto(
      name: json['playlist_name'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'playlist_name': name,
    };
  }

  String toJson(){
    return jsonEncode(toMap());
  }
}