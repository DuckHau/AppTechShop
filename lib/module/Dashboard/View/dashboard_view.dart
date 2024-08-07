// 🎯 Dart imports:
import 'dart:developer';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:techshop_app/Routes/app_pages.dart';

// 🌎 Project imports:
import 'package:techshop_app/module/Auth/Controller/auth_controller.dart';
import 'package:techshop_app/module/Auth/Views/Proflie/user_profile_view.dart';
import 'package:techshop_app/module/Cart/Controller/cart_controller.dart';
import 'package:techshop_app/module/Category/Views/category_view.dart';
import 'package:techshop_app/module/Home/View/home_view.dart';
import 'package:techshop_app/module/Order/Controller/order_controller.dart';
import 'package:techshop_app/module/Order/Views/order_list_view.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final CartController cartController = Get.find<CartController>();
  final OrderController orderController = Get.find<OrderController>();
  final AuthController authController = Get.find<AuthController>();

  final PageController _pageController =
      PageController(initialPage: Get.arguments ?? 0);
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: Get.arguments ?? 0);

  final List<Widget> _children = [
    const HomePage(),
    const CategoryList(),
    const OrderListView(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    cartController.fetchCartItems();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: <Widget>[
            Stack(
              children: <Widget>[
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.cartShopping,
                    size: 18,
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.CART);
                  },
                ),
                
                Positioned(
                  right: 7,
                  top: 7,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      cartController.totalItems.toString(), //Count item in cart
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _children,
        ),
        extendBody: true,
        bottomNavigationBar: AnimatedNotchBottomBar(
          notchBottomBarController: _controller,
          color: const Color.fromARGB(255, 162, 95, 230),
          showLabel: false,
          textOverflow: TextOverflow.visible,
          maxLine: 1,
          shadowElevation: 5,
          kBottomRadius: 16.0,
          notchColor: Colors.black54,
          removeMargins: false,
          bottomBarWidth: 500,
          showShadow: false,
          durationInMilliSeconds: 300,
          itemLabelStyle: const TextStyle(fontSize: 10),
          elevation: 1,
          bottomBarItems: const [
            BottomBarItem(
              inActiveItem: Icon(
                FluentIcons.home_32_regular,
                color: Colors.white,
              ),
              activeItem: Icon(
                FluentIcons.home_32_filled,
                color: Color.fromARGB(255, 162, 95, 230),
              ),
              itemLabel: 'Trang chủ',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                FluentIcons.grid_28_regular,
                color: Colors.white,
              ),
              activeItem: Icon(
                FluentIcons.filter_32_filled,
                color: Color.fromARGB(255, 162, 95, 230),
              ),
              itemLabel: 'Danh mục',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                FluentIcons.receipt_32_regular,
                color: Colors.white,
              ),
              activeItem: Icon(
                FluentIcons.receipt_32_filled,
                color: Color.fromARGB(255, 162, 95, 230),
              ),
              itemLabel: 'Đơn hàng',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                FluentIcons.person_32_regular,
                color: Colors.white,
              ),
              activeItem: Icon(
                FluentIcons.person_32_filled,
                color: Color.fromARGB(255, 162, 95, 230),
              ),
              itemLabel: 'Tôi',
            ),
          ],
          onTap: (index) {
            log('current selected index $index');
            _pageController.jumpToPage(index);
            _controller.index = index;
          },
          kIconSize: 24.0,
        ),
      ),
    );
  }
}
