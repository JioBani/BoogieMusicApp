import 'package:database_project/GetxTest/GetxControllerTest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GetxTestPage extends StatefulWidget {
  const GetxTestPage({super.key});

  @override
  State<GetxTestPage> createState() => _GetxTestPageState();
}

class _GetxTestPageState extends State<GetxTestPage> {
  final con = Get.put(GetxControllerTest());

  @override
  void initState(){
    super.initState();
    con.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetX<GetxControllerTest>(
          builder: (controller){
            return Column(
              children: [
                Text(
                  controller.textValue.value.toString()
                ),
                Text(
                  controller.playlistLibraryItemData.value?.name ?? "null"
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
