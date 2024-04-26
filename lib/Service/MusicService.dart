import 'package:database_project/Service/ApiService/ApiResponse.dart';
import 'package:database_project/Common/StaticLogger.dart';
import 'package:database_project/Model/AlbumExtend.dart';
import 'package:database_project/Model/ArtistExtend.dart';
import 'package:database_project/Model/CurrentPlaylist/CreateCurrentPlaylistDto.dart';
import 'package:database_project/Model/CurrentPlaylist/CurrentPlaylistDto.dart';
import 'package:database_project/Model/Playlist/CreatePlaylistDto.dart';
import 'package:database_project/Model/Playlist/CreatePlaylistSongDto.dart';
import 'package:database_project/Model/Playlist/PlaylistExtend.dart';
import 'package:database_project/Model/SearchResult.dart';
import 'package:database_project/Model/TopChart/TopChartDto.dart';
import 'package:database_project/Service/ApiService/ApiService.dart';
import 'package:database_project/Service/ApiService/Exception.dart';
import 'package:database_project/Service/LoginService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import '../Model/Playlist/Playlist.dart';

class MusicService{

  static String getLink(String path){
    return "http://10.0.2.2:3000/$path";
  }

  //#. 플레이리스트

  //#. 플레이리스트 목록 가져오기
  static Future<ApiResponse<List<Playlist>>> getPlaylistsByUserId() async {
    return LoginService.tokenPipeline(
        request:() => http.get(Uri.parse(
            getLink("playlists/user")),
          headers: {
            "Content-Type": "application/json",
            "Authorization" : "Bearer ${LoginService.instance.accessToken!}"
          },
        ),
        action: (response){
          final List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
          return jsonData.map((e) => Playlist.fromMap(e)).toList();
        }
    );
  }

  //#. 플레이리스트 세부 항목 가져오기
  static Future<ApiResponse<PlaylistExtend>> getPlaylistExtend(int playlistId) async {
    return LoginService.tokenPipeline(
        request:() =>  http.get(Uri.parse(
            getLink("playlists/extend/$playlistId")),
          headers: {
            "Content-Type": "application/json",
            "Authorization" : "Bearer ${LoginService.instance.accessToken}"
          },
        ),
        action: (response)=> PlaylistExtend.fromMap(jsonDecode(utf8.decode(response.bodyBytes)))
    );
  }

  //#. 유저 id로 플레이리스트 세부 항목 가져오기
  static Future<ApiResponse<List<PlaylistExtend>>> getPlaylistExtendsByUser() async {
    return LoginService.tokenPipeline(
        request:() =>  http.get(Uri.parse(
            getLink("playlists/extend")),
          headers: {
            "Content-Type": "application/json",
            "Authorization" : "Bearer ${LoginService.instance.accessToken}"
          },
        ),
        action: (response) => (jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>).map((e) =>
            PlaylistExtend.fromMap(e)
        ).toList()
    );
  }

  //#. 플레이리스트 만들기
  static Future<ApiResponse<Playlist>> createPlaylist(CreatePlaylistDto createPlaylistDto) async {
    return LoginService.tokenPipeline(
        request:() =>  http.post(
            Uri.parse(getLink("playlists")),
            headers: {
              "Content-Type": "application/json",
              "Authorization" : "Bearer ${LoginService.instance.accessToken}"
            },
            body: createPlaylistDto.toJson()
        ),
        action: (response){
          return Playlist.fromMap(jsonDecode(response.body));
        }
    );
  }

  //#. 플레이리스트 변경
  static Future<ApiResponse<dynamic>> updatePlaylist(int playlistId , CreatePlaylistDto createPlaylistDto) async {
    return LoginService.tokenPipeline(
        request: () =>
            http.patch(
                Uri.parse(getLink("playlists/$playlistId")),
                headers: {
                  "Content-Type": "application/json",
                  "Authorization": "Bearer ${LoginService.instance.accessToken}"
                },
                body: createPlaylistDto.toJson()
            ),
        action: (response) => response.body
    );
  }

  //#. 플레이리스트 삭제
  static Future<ApiResponse<dynamic>> deletePlaylist(int playlistId) async {
    return LoginService.tokenPipeline(
        request: () => http.delete(
          Uri.parse(getLink("playlists/$playlistId")),
          headers: {
            "Content-Type": "application/json",
            "Authorization" : "Bearer ${LoginService.instance.accessToken}"
          },
        ),
        action: (response) => response.body
    );
  }

  static Future<ApiResponse<dynamic>> addMusicAtPlaylist(int playlistId, int musicId) async {
    return LoginService.tokenPipeline(
        request: () => http.post(
            Uri.parse(getLink("playlist-songs")),
            headers: {
              "Content-Type": "application/json",
              "Authorization" : "Bearer ${LoginService.instance.accessToken}"
            },
            body: CreatePlaylistSongDto(playlistId: playlistId, musicId: musicId).toJson()
        ),
        action: (response) => response.body
    );
  }

  static Future<ApiResponse<dynamic>> deleteMusicAtPlaylist(int playlistId, int musicId) async {
    return LoginService.tokenPipeline(
        request: () => http.delete(
            Uri.parse(getLink("playlist-songs")),
            headers: {
              "Content-Type": "application/json",
              "Authorization" : "Bearer ${LoginService.instance.accessToken}"
            },
            body: CreatePlaylistSongDto(playlistId: playlistId, musicId: musicId).toJson()
        ),
        action: (response) => response.body
    );
  }


  //#. 인기차트

  //#. 인기차트 가져오기
  static Future<ApiResponse<TopChartDto>> getTopChart() async {
    return ApiResponse.handleRequest(
        request: http.get(
          Uri.parse(getLink("top-charts/dto")),
        ),
        action: (response){
          return TopChartDto.fromMap(jsonDecode(utf8.decode(response.bodyBytes)));
        }
    );
  }


  //#. 검섹
  static Future<ApiResponse<SearchResult>> search(String text) async {
    return ApiResponse.handleRequest(
        request: http.get(
          Uri.parse(getLink("search/$text")),
        ),
        action: (response){
          return SearchResult.fromMap(jsonDecode(utf8.decode(response.bodyBytes)));
        }
    );
  }

  //#. 현재 플레이리스트 가져오기
  static Future<ApiResponse<CurrentPlaylistDto>> getCurrentPlaylistByUserId() async{
    return LoginService.tokenPipeline(
        request: () => http.get(
          Uri.parse(getLink("now-plays/dto")),
          headers: {
            "Content-Type": "application/json",
            "Authorization" : "Bearer ${LoginService.instance.accessToken}"
          },
        ),
        action: (response) => CurrentPlaylistDto.fromMap(jsonDecode(utf8.decode(response.bodyBytes)))
    );
  }

  //#. 현재 플레이리스트에 음악 추가
  static Future<ApiResponse<dynamic>> addMusicAtCurrentPlaylist(int musicId) async{
    return LoginService.tokenPipeline(
        request: () => http.post(
          Uri.parse(getLink("now-plays")),
          headers: {
            "Content-Type": "application/json",
            "Authorization" : "Bearer ${LoginService.instance.accessToken}"
          },
          body: CreateCurrentPlaylistDto(
              userId: LoginService.instance.userId ?? '',
              musicId: musicId,
              playTime: DateTime.now().millisecondsSinceEpoch
          ).toCreateJson(),
        ),
        action: (response) => response.body
    );
  }

  static Future<ApiResponse<dynamic>> deleteMusicFromCurrentPlaylist(int musicId) async{
    return LoginService.tokenPipeline(
        request: () => http.delete(
          Uri.parse(getLink("now-plays/$musicId")),
          headers: {
            "Content-Type": "application/json",
            "Authorization" : "Bearer ${LoginService.instance.accessToken}"
          },
        ),
        action: (response) => response.body
    );
  }

  //#. 앨범
  static Future<ApiResponse<AlbumExtent>> getAlbumExtend(int albumId) async{
    return ApiResponse.handleRequest(
        request: http.get(
          Uri.parse(getLink("albums/extend/$albumId")),
        ).timeout(const Duration(seconds: 1)),
        action: (response){
          return AlbumExtent.fromMap(jsonDecode(utf8.decode(response.bodyBytes)));
        }
    );
  }

  //#. 아티스트
  static Future<ApiResponse<ArtistExtend>> getArtistExtend(int artistId) async{
    return ApiResponse.handleRequest(
        request: http.get(
          Uri.parse(getLink("artists/extend/$artistId")),
        ).timeout(const Duration(seconds: 1)),
        action: (response){
          return ArtistExtend.fromMap(jsonDecode(utf8.decode(response.bodyBytes)));
        }
    );
  }
}