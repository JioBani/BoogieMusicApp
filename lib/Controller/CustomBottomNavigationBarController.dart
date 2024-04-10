import 'package:get/get.dart';

class CustomBottomNavigationBarController extends GetxController{
  RxInt currentIndex = 0.obs;

  void onTap(int value){
    currentIndex.value = value;
  }
}