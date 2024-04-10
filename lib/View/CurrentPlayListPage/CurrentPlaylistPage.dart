import 'package:database_project/Common/DubleTapExitWidget.dart';
import 'package:database_project/Controller/CurrentPlaylistController.dart';
import 'package:database_project/Controller/PlayerController.dart';
import 'package:database_project/Service/CurrentPlaylistService.dart';
import 'package:database_project/View/BottomNavBar/BottomNavBar.dart';
import 'package:database_project/View/MusicElementWidget.dart';
import 'package:database_project/View/Player/PlayerView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CurrentPlaylistPage extends StatefulWidget {
  const CurrentPlaylistPage({super.key});

  @override
  State<CurrentPlaylistPage> createState() => _CurrentPlaylistPageState();
}

class _CurrentPlaylistPageState extends State<CurrentPlaylistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: DoubleTapExitWidget(
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 50.h,),
                    Padding(
                      padding: EdgeInsets.only(left: 30.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "현재 플레이리스트",
                          style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
                        padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r) , topRight: Radius.circular(30.r)),
                          //color: Color(0xffEBC7E4)
                        ),
                        child: Obx((){
                          var service = Get.find<CurrentPlaylistService>();
                          return ListView.builder(
                              itemCount:  service.playlist.value == null ? 0 : service.playlist.value!.musics.length,
                              itemBuilder: (context , index){
                                return MusicElementWidget(
                                  musicExtend: service.playlist.value!.musics[index],
                                  isInCurrentPlaylist: true,
                                );
                              }
                          );
                        })
                        // child: GetX<CurrentPlaylistService>(
                        //   builder: (service) {
                        //     return ListView.builder(
                        //         itemCount:  service.playlist.value == null ? 0 : service.playlist.value!.musics.length,
                        //         itemBuilder: (context , index){
                        //           return MusicElementWidget(
                        //             music:  service.playlist.value!.musics[index],
                        //             isInCurrentPlaylist: true,
                        //           );
                        //         }
                        //     );
                        //   }
                        // ),
                      ),
                    ),
                  ],
                ),
                PlayerWidget()
              ],
            ),
          )
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}