import 'package:database_project/Common/ImageUrls.dart';
import 'package:database_project/Controller/PlayerController.dart';
import 'package:database_project/Controller/PlaylistLibraryController.dart';
import 'package:database_project/Model/Playlist/Playlist.dart';
import 'package:database_project/Model/Playlist/PlaylistExtend.dart';
import 'package:database_project/Service/LoadingState.dart';
import 'package:database_project/Service/LoginService.dart';
import 'package:database_project/Service/PlaylistService.dart';
import 'package:database_project/View/BottomNavBar/BottomNavBar.dart';
import 'package:database_project/View/LoginNeededPage/LoginNeededWidget.dart';
import 'package:database_project/View/Player/PlayerView.dart';
import 'package:database_project/View/PlaylistLibraryPage/PlayListAddWidget.dart';
import 'package:database_project/View/PlaylistLibraryPage/PlaylistLibraryItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PlayListLibraryPage extends StatefulWidget {
  const PlayListLibraryPage({Key? key}) : super(key: key);

  @override
  State<PlayListLibraryPage> createState() => _PlayListLibraryPageState();
}

class _PlayListLibraryPageState extends State<PlayListLibraryPage> {
  int _currentIndex = 0;

  final _pageViewController = PageController(initialPage: 0, viewportFraction: 0.75);
  //PlaylistLibraryController controller = Get.put(PlaylistLibraryController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return GetX<LoginService>(
              builder: (service) {
                if(!service.loggedIn){
                  return const LoginNeededWidget();
                }
                return Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 40.h,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Text(
                              "Playlist",
                              style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        GetX<PlaylistService>(
                          builder: (service) {
                            if(service.loadingState.value == LoadingState.fail || service.loadingState.value == LoadingState.beforeLoading){
                              return const Expanded(
                                  child: Center(
                                      child: LoginNeededWidget()
                                  )
                              );
                            }
                            if(service.playlistMap.isEmpty){
                              return Expanded(
                                child: PageView.builder(
                                    controller: _pageViewController,
                                    itemCount: 1,
                                    physics: const BouncingScrollPhysics(
                                        parent: AlwaysScrollableScrollPhysics()),
                                    onPageChanged: (index) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    },
                                    itemBuilder: (context, index) {
                                      return PlayListAddWidget(
                                        pageController: _pageViewController,
                                        currentIndex: _currentIndex,
                                        index: index,
                                      );
                                    }),
                              );
                            }
                            else{
                              final List<PlaylistExtend> playlistList = service.playlistMap.values.toList();
                              return Expanded(
                                child: PageView.builder(
                                    controller: _pageViewController,
                                    itemCount: playlistList.length + 1,
                                    physics: const BouncingScrollPhysics(
                                        parent: AlwaysScrollableScrollPhysics()),
                                    onPageChanged: (index) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    },
                                    itemBuilder: (context, index) {
                                      if(index == playlistList.length){
                                        return PlayListAddWidget(
                                          pageController: _pageViewController,
                                          currentIndex: _currentIndex,
                                          index: index,
                                        );
                                      }
                                      else{
                                        return PlaylistLibraryItemWidget(
                                          pageController: _pageViewController,
                                          currentIndex: _currentIndex,
                                          index: index,
                                          playlistExtend: playlistList[index],
                                          imageUrl: ImageUrls.playlistCoverList[index],
                                        );
                                      }
                                    }),
                              );
                            }
                          }
                        ),
                      ],
                    ),
                    PlayerWidget()
                  ],
                );
              }
            );
          }
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}