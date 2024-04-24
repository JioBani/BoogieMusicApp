import 'package:database_project/Model/MusicExtend.dart';

import 'CurrentPlaylistElement.dart';

class CurrentPlaylistElementDto{
  CurrentPlaylistElement playlistElement;
  MusicExtend musicDto;

  CurrentPlaylistElementDto({
    required this.playlistElement,
    required this.musicDto,
  });

  factory CurrentPlaylistElementDto.fromMap(Map<String , dynamic> map){
    return CurrentPlaylistElementDto(
        playlistElement: CurrentPlaylistElement.fromMap(map['nowPlay']), 
        musicDto: MusicExtend.fromMap(map['musicDto'])
    );
  }
}