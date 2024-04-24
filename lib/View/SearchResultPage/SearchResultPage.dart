import 'package:database_project/Service/ApiService/ApiResponse.dart';
import 'package:database_project/Model/SearchResult.dart';
import 'package:database_project/Service/MusicService.dart';
import 'package:database_project/View/BottomNavBar/BottomNavBar.dart';
import 'package:database_project/View/Player/PlayerView.dart';
import 'package:database_project/View/SearchResultPage/SearchResultPageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key, required this.searchString});
  final String searchString;

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> with TickerProviderStateMixin{

  late TabController _tabController;

  //PlayerController playerController = Get.find<PlayerController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  List<Tab> tabBuilder(SearchResult searchResult){
    return [
      Tab(
        child: SizedBox(
          child: Center(
            child: Text(
              "제목(${searchResult.songsResult.length})",
              style: TextStyle(
                  fontSize: 15.0.w,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87
              ),
            ),
          ),
        ),
      ),
      Tab(
        child: SizedBox(
          child: Center(
            child: Text(
              "아티스트(${searchResult.artistsResult.length})",
              style: TextStyle(
                  fontSize: 15.0.w,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87
              ),
            ),
          ),
        ),
      ),
      Tab(
        child: SizedBox(
          child: Center(
            child: Text(
              "앨범(${searchResult.albumsResult.length})",
              style: TextStyle(
                  fontSize: 15.0.w,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87
              ),
            ),
          ),
        ),
      )
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder(
              future: MusicService.search(widget.searchString),
              builder: (context , snapshot) {
                ApiResponse<SearchResult> response = snapshot.data!;

                if(!response.isSuccess){
                  return Center(
                    child: Text(
                      "검색불가"
                    ),
                  );
                }
                else{
                  SearchResult searchResult = response.response!;
                  return Column(
                    children: [
                      SizedBox(height: 40.h,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Text(
                            "Search",
                            style: TextStyle(
                              fontSize: 35.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Text(
                            "\"${widget.searchString}\" 에 대한 검색 결과입니다.",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                        child: TabBar(
                          labelColor: Colors.black,
                          indicatorColor: Colors.black,
                          unselectedLabelColor: Colors.black,
                          indicatorPadding: EdgeInsets.all(0.0),
                          indicatorWeight: 4.0,
                          controller: _tabController,
                          tabs: tabBuilder(searchResult),
                        ),
                      ),
                      Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              SearchResultPageView(musicList: searchResult.songsResult,),
                              SearchResultPageView(artistList: searchResult.artistsResult,),
                              SearchResultPageView(albumList: searchResult.albumsResult,),
                            ],
                          )
                      )
                    ],
                  );
                }
              }
            ),
            PlayerWidget()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
