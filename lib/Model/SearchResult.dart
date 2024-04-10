import 'package:database_project/Model/Album.dart';
import 'package:database_project/Model/Artist.dart';
import 'package:database_project/Model/MusicExtend.dart';

import 'Music.dart';

class SearchResult{
    String searchWord;
    List<MusicExtend> songsResult;
    List<Album> albumsResult;
    List<Artist> artistsResult;


    SearchResult({
      required this.searchWord,
      required this.songsResult,
      required this.albumsResult,
      required this.artistsResult,
    });

    factory SearchResult.fromMap(Map<String, dynamic> json) {

      List<dynamic> songs = json['musics'];
      List<dynamic> albums = json['albums'];
      List<dynamic> artists = json['artists'];

      return SearchResult(
          searchWord: json['searchText'],
          songsResult: songs.map((e) => MusicExtend.fromMap(e)).toList(),
          albumsResult: albums.map((e) => Album.fromMap(e)).toList(),
          artistsResult: artists.map((e) => Artist.fromMap(e)).toList()
      );
    }
}