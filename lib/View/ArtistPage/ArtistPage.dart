import 'package:database_project/Service/ApiService/ApiResponse.dart';
import 'package:database_project/Model/Album.dart';
import 'package:database_project/Model/AlbumExtend.dart';
import 'package:database_project/Model/Artist.dart';
import 'package:database_project/Model/ArtistExtend.dart';
import 'package:database_project/Service/MusicService.dart';
import 'package:database_project/Style/Images.dart';
import 'package:database_project/Style/ShadowPalette.dart';
import 'package:database_project/View/MusicElementWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArtistPage extends StatelessWidget {
  const ArtistPage({super.key, required this.artist});
  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: MusicService.getArtistExtend(artist.id),
            builder: (context , snapshot) {
              if(!snapshot.hasData){
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              else if(snapshot.hasError){
                return Center(
                  child: Text("데이터를 가져 올 수 없습니다."),
                );
              }
              else{
                ApiResponse<ArtistExtend> apiResponse = snapshot.data!;
                if(!apiResponse.isSuccess){
                  return Center(
                    child: Text("데이터를 가져 올 수 없습니다."),
                  );
                }
                else{
                  ArtistExtend artistExtend = apiResponse.response!;
                  return Stack(
                    children: [
                      Image.network(
                        Images.tempImageUrl,
                        fit: BoxFit.fill,
                        width: 360.w,
                        height: 360.w,
                      ),
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 50.w,
                            decoration: BoxDecoration(
                                color: Colors.black54
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.w),
                                    child: IconButton(
                                        onPressed: (){},
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          size: 25.sp,
                                          color: Colors.white,
                                        )
                                    ),
                                  ),
                                ),
                                Center(
                                    child: Text(
                                      artistExtend.artist.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20.sp,
                                          color: Colors.white
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 30.w),
                                padding: EdgeInsets.fromLTRB(10.w, 40.w, 10.w,0),
                                height: 550.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(20.r) , topLeft: Radius.circular(20.r)),
                                    color: Colors.white
                                ),
                                child: ListView(
                                  children: artistExtend.musics.map((e) => MusicElementWidget(musicExtend: e)).toList(),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                                child: InkWell(
                                  onTap: (){

                                  },
                                  child: Container(
                                    width: 60.sp,
                                    height: 60.sp,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.r),
                                        color: Colors.black,
                                        boxShadow: [ShadowPalette.defaultShadowLight]
                                    ),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 35.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                      // Padding(
                      //   padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                      //   child: Row(
                      //     children: [
                      //       SizedBox(
                      //         width: 160.w,
                      //         height: 160.w,
                      //         child: ClipRRect(
                      //           child: Image.network(Images.tempImageUrl),
                      //         ),
                      //       ),
                      //       Text(
                      //         "Butter",
                      //         style: TextStyle(
                      //           fontSize: 17.sp,
                      //           fontWeight: FontWeight.w700
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  );
                }
              }
            }
        ),
      ),
    );
  }
}
