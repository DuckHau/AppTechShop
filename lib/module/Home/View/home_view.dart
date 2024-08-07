// 🎯 Dart imports:
import 'dart:convert';
import 'dart:math';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

// 🌎 Project imports:
import 'package:techshop_app/Routes/app_pages.dart';
import 'package:techshop_app/models/product.dart';
import 'package:techshop_app/module/Auth/Controller/auth_controller.dart';
import 'package:techshop_app/module/Brand/Views/brand_view.dart';
import 'package:techshop_app/module/Cart/Controller/cart_controller.dart';
import 'package:techshop_app/module/Product/Controller/product_controller.dart';
import '../../../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController authController = Get.put(AuthController());
  final ProductController productController = Get.find<ProductController>();
  final CartController cartController = Get.find<CartController>();

  final List<String> categories = [
    '6552ee08ea3b4606a040af7a',
    '6552ee08ea3b4606a040af7b',
    '6552ee08ea3b4606a040af7c',
    '6552ee08ea3b4606a040af7d',
  ];
  final List<String> carouselImages = [
    'assets/images/BannerAsus.jpg',
    'assets/images/BannerLogi.png',
    'assets/images/BannerRazer.png',
    'assets/images/BannerAkko.jpg',
  ];
  
  late FloatingSearchBarController _searchBarController;

  @override
  void initState() {
    super.initState();
    _searchBarController = FloatingSearchBarController();
    _loadData();
  }

  Future<void> _loadData() async {
    for (var category in categories) {
      await productController.fetchProductsByCategory(category);
    }
  }

  Future<void> _refresh() async {
    if (productController.isLoading.value) {
      await Future.delayed(const Duration(seconds: 30), () {
        _loadData();
      });
    }
  }

  @override
Widget build(BuildContext context) {
  return FutureBuilder<String?>(
    future: _retrieveUserData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      return Scaffold(
        body: FloatingSearchBar(
          controller: _searchBarController,
          hint: 'Nhập sản phẩm...',
          scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
          transitionDuration: const Duration(milliseconds: 800),
          transitionCurve: Curves.easeInOut,
          physics: const BouncingScrollPhysics(),
          debounceDelay: const Duration(milliseconds: 500),
          onQueryChanged: (query) {
            productController.fetchProducts(
              keyword: query,
              isSearchFetch: false,
              isSuggestionFetch: true,
              
            );           
          },
          onSubmitted: (query) {
            productController.fetchProducts(
              keyword: query,
              isSearchFetch: true,
            );
            Get.toNamed(Routes.PRODUCT, arguments: {'keyword': query});
          },
          builder: (context, transition) {
            return Obx(() {
              final suggestions = productController.suggestedProducts;
              return suggestions.isEmpty
                  ? Container()
                  :
                       ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: suggestions.length,
                        itemBuilder: (context, index) {
                          final product = suggestions[index];
                          return ListTile(
                            title: Text(product.name!),
                            onTap: () {
                              _searchBarController.query = product.name!;
                              productController.fetchProducts(
                                keyword: product.name,
                                isSearchFetch: true,
                              );
                              Get.toNamed(Routes.PRODUCTDETAIL, arguments: {'slug': product.slug});
                            },
                          );
                        },
                      );
                    
            });
          },
        ),
      );
    },
  );
}




  Future<String?> _retrieveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      final user = User.fromJson(jsonDecode(userData));
      authController.user.user!.value = user;
      return 'Success';
    }
    return null;
  }
}
