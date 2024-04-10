import 'package:database_project/Model/Album.dart';
import 'package:database_project/Model/Music.dart';
import 'package:database_project/Model/MusicExtend.dart';

class AlbumExtent{
  final Album album;
  final List<MusicExtend> musics;

  AlbumExtent({required this.album , required this.musics});

  factory AlbumExtent.fromMap(Map<String ,dynamic> map){
    return AlbumExtent(
      album: Album.fromMap(map['album']),
      musics: (map['musics'] as List<dynamic>).map((e) => MusicExtend.fromMap(e)).toList(),
    );
  }
}