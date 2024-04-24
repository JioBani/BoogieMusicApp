import 'dart:convert';

class CreatePlaylistDto{
  String name;

  CreatePlaylistDto({
    required this.name,
  });


  factory CreatePlaylistDto.fromMap(Map<String, dynamic> json) {
    return CreatePlaylistDto(
      name: json['playlist_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'playlist_name': name,
    };
  }

  String toJson(){
    return jsonEncode(toMap());
  }
}