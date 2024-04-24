import 'package:database_project/Model/MusicExtend.dart';

import 'CurrentPlaylistElementDto.dart';

class CurrentPlaylistDto{
  String userId;
  List<CurrentPlaylistElementDto> playlist;

  CurrentPlaylistDto({
    required this.userId,
    required this.playlist
  });
  
  factory CurrentPlaylistDto.fromMap(Map<String , dynamic> map){
    return CurrentPlaylistDto(
        userId: map['user_id'],
        playlist: (map['nowPlayDtoList'] as List<dynamic>).map((e) => CurrentPlaylistElementDto.fromMap(e)).toList()
    );
  }

  List<MusicExtend> getMusicDtoList(){
    return playlist.map((e) => e.musicDto).toList();
  }

  void removeElement(){

  }
}