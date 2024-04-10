import 'package:database_project/Common/MusicApiResponse.dart';
import 'package:database_project/Common/StaticLogger.dart';
import 'package:database_project/Model/AlbumExtend.dart';
import 'package:database_project/Model/ArtistExtend.dart';
import 'package:database_project/Model/CurrentPlaylist/CreateCurrentPlaylistDto.dart';
import 'package:database_project/Model/CurrentPlaylist/CurrentPlaylist.dart';
import 'package:database_project/Model/Music.dart';
import 'package:database_project/Model/MusicExtend.dart';
import 'package:database_project/Model/Playlist/CreatePlaylistDto.dart';
import 'package:database_project/Model/Playlist/CreatePlaylistSongDto.dart';
import 'package:database_project/Model/Playlist/PlaylistExtend.dart';
import 'package:database_project/Model/SearchResult.dart';
import 'package:database_project/Model/TopChart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

import '../Model/Playlist/Playlist.dart';

class MusicService{

  static String getLink(String path){
    return "http://10.0.2.2:3000/$path";
  }

  //#. 플레이리스트

  //#. 플레이리스트 목록 가져오기
  static Future<MusicApiResponse<List<Playlist>>> getPlaylistsByUserId(String userId) {
    return MusicApiResponse.handleRequest(
        request: http.get(Uri.parse(getLink("playlists/user/$userId"))).timeout(const Duration(seconds: 1)),
        action: (response){
          final List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
          return jsonData.map((e) => Playlist.fromMap(e)).toList();
        }
    );
  }

  //#. 플레이리스트 세부 항목 가져오기
  static Future<MusicApiResponse<PlaylistExtend>> getPlaylistExtend(int playlistId) async {
    return MusicApiResponse.handleRequest(
        request: http.get(Uri.parse(getLink("playlists/id/extend/$playlistId"))).timeout(const Duration(seconds: 1)),
        action: (response){
          return PlaylistExtend.fromMap(jsonDecode(utf8.decode(response.bodyBytes)));
        }
    );
  }

  //#. 플레이리스트 만들기
  static Future<MusicApiResponse<dynamic>> createPlaylist(CreatePlaylistDto createPlaylistDto) async {
    StaticLogger.logger.i(jsonEncode(createPlaylistDto.toMap()));
    return MusicApiResponse.handleRequest(
        request: http.post(
          Uri.parse(getLink("playlists")),
          headers: {"Content-Type": "application/json"},
          body: createPlaylistDto.toJson()
        ).timeout(const Duration(seconds: 1)),
        action: (response){
          return response.body;
        }
    );
  }

  //#. 플레이리스트 변경
  static Future<MusicApiResponse<dynamic>> updatePlaylist(int playlistId , CreatePlaylistDto createPlaylistDto) async {
    return MusicApiResponse.handleRequest(
        request: http.patch(
            Uri.parse(getLink("playlists/$playlistId")),
            headers: {"Content-Type": "application/json"},
            body: createPlaylistDto.toJson()
        ).timeout(const Duration(seconds: 1)),
        action: (response){
          return response.body;
        }
    );
  }

  //#. 플레이리스트 삭제
  static Future<MusicApiResponse<dynamic>> deletePlaylist(int playlistId) async {
    return MusicApiResponse.handleRequest(
        request: http.delete(
            Uri.parse(getLink("playlists/$playlistId")),
        ).timeout(const Duration(seconds: 1)),
        action: (response){
          return response.body;
        }
    );
  }

  static Future<MusicApiResponse<dynamic>> addMusicAtPlaylist(int playlistId, int musicId) async {
    return MusicApiResponse.handleRequest(
        request: http.post(
          Uri.parse(getLink("playlist-songs")),
            headers: {"Content-Type": "application/json"},
            body: CreatePlaylistSongDto(playlistId: playlistId, musicId: musicId).toJson()
        ).timeout(const Duration(seconds: 1)),
        action: (response){
          return response.body;
        }
    );
  }


  //#. 인기차트

  //#. 인기차트 가져오기
  static Future<MusicApiResponse<List<MusicExtend>>> getTopChart() async {
    return MusicApiResponse.handleRequest(
        request: http.get(
          Uri.parse(getLink("top-charts")),
        ).timeout(const Duration(seconds: 1)),
        action: (response){
          final List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
          return jsonData.map((e) => MusicExtend.fromMap(e)).toList();
        }
    );
  }


  //#. 검섹
  static Future<MusicApiResponse<SearchResult>> search(String text) async {
    return MusicApiResponse.handleRequest(
        request: http.get(
          Uri.parse(getLink("search/$text")),
        ).timeout(const Duration(seconds: 1)),
        action: (response){
          return SearchResult.fromMap(jsonDecode(utf8.decode(response.bodyBytes)));
        }
    );
  }

  //#. 현재 플레이리스트 가져오기
  static Future<MusicApiResponse<CurrentPlaylist>> getCurrentPlaylistByUserId(String userId) async{
    return MusicApiResponse.handleRequest(
        request: http.get(
          Uri.parse(getLink("now-plays/extend/$userId")),
        ).timeout(const Duration(seconds: 10)),
        action: (response){
          return CurrentPlaylist.fromMap(jsonDecode(utf8.decode(response.bodyBytes)));
        }
    );
  }

  //#. 현재 플레이리스트에 음악 추가
  static Future<MusicApiResponse<dynamic>> addMusicAtCurrentPlaylist(String userId , int musicId) async{
    StaticLogger.logger.i(CreateCurrentPlaylistDto(userId: userId,musicId: musicId,playTime: DateTime.now().millisecondsSinceEpoch).toCreateJson());
    return MusicApiResponse.handleRequest(
        request: http.post(
          Uri.parse(getLink("now-plays")),
          headers: {"Content-Type": "application/json"},
          body: CreateCurrentPlaylistDto(userId: userId,musicId: musicId,playTime: DateTime.now().millisecondsSinceEpoch).toCreateJson(),
        ).timeout(const Duration(seconds: 1)),
        action: (response){
          return response.body;
        }
    );
  }

  static Future<MusicApiResponse<dynamic>> deleteMusicFromCurrentPlaylist(String userId , int musicId) async{
    return MusicApiResponse.handleRequest(
        request: http.delete(
          Uri.parse(getLink("now-plays?user_id=$userId&music_id=$musicId")),
        ).timeout(const Duration(seconds: 1)),
        action: (response){
          return response.body;
        }
    );
  }

  //#. 앨범
  static Future<MusicApiResponse<AlbumExtent>> getAlbumExtend(int albumId) async{
    return MusicApiResponse.handleRequest(
        request: http.get(
          Uri.parse(getLink("albums/extend/$albumId")),
        ).timeout(const Duration(seconds: 1)),
        action: (response){
          return AlbumExtent.fromMap(jsonDecode(utf8.decode(response.bodyBytes)));
        }
    );
  }

  //#. 아티스트
  static Future<MusicApiResponse<ArtistExtend>> getArtistExtend(int artistId) async{
    return MusicApiResponse.handleRequest(
        request: http.get(
          Uri.parse(getLink("artists/extend/$artistId")),
        ).timeout(const Duration(seconds: 1)),
        action: (response){
          return ArtistExtend.fromMap(jsonDecode(utf8.decode(response.bodyBytes)));
        }
    );
  }
}