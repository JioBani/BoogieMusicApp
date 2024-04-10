import 'package:database_project/Common/ImageUrls.dart';
import 'package:database_project/Model/Album.dart';
import 'package:database_project/Model/AlbumExtend.dart';
import 'package:database_project/Model/Artist.dart';
import 'package:database_project/Model/Music.dart';
import 'package:database_project/Model/MusicExtend.dart';
import 'package:database_project/View/AlbumElementWidget.dart';
import 'package:database_project/View/ArtistElementWidget.dart';
import 'package:database_project/View/MusicElementWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultPageView extends StatefulWidget {
  const SearchResultPageView({super.key, this.musicList, this.albumList, this.artistList});
  
  final List<MusicExtend>? musicList;
  final List<Album>? albumList;
  final List<Artist>? artistList;

  @override
  State<SearchResultPageView> createState() => _SearchResultPageViewState();
}

class _SearchResultPageViewState extends State<SearchResultPageView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
      child: Column(
        children: [
          SizedBox(height: 20.h,),
          Expanded(
            child: Builder(
              builder: (context) {
                if(widget.musicList != null){
                  return ListView.builder(
                    itemCount: widget.musicList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MusicElementWidget(musicExtend: widget.musicList![index]);
                    },
                  );
                }
                else if(widget.albumList != null){
                  return ListView.builder(
                    itemCount: widget.albumList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AlbumElementWidget(album: widget.albumList![index]);
                    },
                  );
                }
                else if(widget.artistList != null){
                  return ListView.builder(
                    itemCount: widget.artistList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ArtistElementWidget(artist: widget.artistList![index]);
                    },
                  );
                }
                else{
                  return SizedBox();
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
