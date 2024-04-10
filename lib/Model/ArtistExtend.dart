import 'package:database_project/Model/Artist.dart';
import 'package:database_project/Model/MusicExtend.dart';

class ArtistExtend{
  Artist artist;
  List<MusicExtend> musics;

  ArtistExtend({required this.artist, required this.musics});

  factory ArtistExtend.fromMap(Map<String , dynamic> map){
    return ArtistExtend(
      artist: Artist.fromMap(map['artist']),
      musics: (map['musics'] as List<dynamic>).map((e) => MusicExtend.fromMap(e)).toList()
    );
  }
}