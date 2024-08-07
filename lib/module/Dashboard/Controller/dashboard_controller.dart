// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 📦 Package imports:
import 'package:get/get.dart';

class DashboardController extends GetxController {
  late PageController pageController;
  RxInt currentPage = 0.obs;

  void goToPage(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
    update();
  }

  void animatedToTab(int page) {
    currentPage.value = page;
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
