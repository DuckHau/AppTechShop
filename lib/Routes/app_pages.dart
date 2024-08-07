// ignore_for_file: constant_identifier_names

// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import 'package:techshop_app/module/Auth/Binding/auth_binding.dart';
import 'package:techshop_app/module/Auth/Views/Proflie/update_profile_view.dart';
import 'package:techshop_app/module/Auth/Views/Proflie/user_profile_view.dart';
import 'package:techshop_app/module/Auth/Views/login_view.dart';
import 'package:techshop_app/module/Auth/Views/register_view.dart';
import 'package:techshop_app/module/Brand/Binding/brand_binding.dart';
import 'package:techshop_app/module/Brand/Views/brand_view.dart';
import 'package:techshop_app/module/Cart/Binding/cart_binding.dart';
import 'package:techshop_app/module/Cart/Views/cart_view.dart';
import 'package:techshop_app/module/Category/Binding/category_binding.dart';
import 'package:techshop_app/module/Category/Views/category_view.dart';
import 'package:techshop_app/module/Dashboard/Binding/dashboard_binding.dart';
import 'package:techshop_app/module/Dashboard/View/dashboard_view.dart';
import 'package:techshop_app/module/Home/Binding/home_binding.dart';
import 'package:techshop_app/module/Home/View/home_view.dart';
import 'package:techshop_app/module/Order/Binding/order_binding.dart';
import 'package:techshop_app/module/Order/Views/checkout_view.dart';
import 'package:techshop_app/module/Order/Views/order_detail_view.dart';
import 'package:techshop_app/module/Order/Views/order_failed_view.dart';
import 'package:techshop_app/module/Order/Views/order_list_view.dart';
import 'package:techshop_app/module/Order/Views/order_success_view.dart';
import 'package:techshop_app/module/Product/Binding/product_binding.dart';
import 'package:techshop_app/module/Product/Views/productDetail_view.dart';
import 'package:techshop_app/module/Product/Views/productList_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfilePage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.UPDATEPROFILE,
      page: () => const UpdateProfilePage(),
      binding: AuthBinding(),
    ),
    GetPage(
        name: _Paths.PRODUCTDETAIL,
        page: () => const ProductDetailView(),
        binding: ProductBinding()),
    GetPage(
        name: _Paths.PRODUCT,
        page: () => const ProductListPage(),
        binding: ProductBinding()),
    GetPage(
        name: '/category',
        page: () => const CategoryList(),
        binding: CategoryBinding()),
    GetPage(
      name: '/brand',
      page: () => BrandView(),
      binding: BrandBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_SUCCESS,
      page: () => const OrderSuccessView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_FAIL,
      page: () => const OrderFailedView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: '/checkout',
      page: () => const CheckoutView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartPage(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => const OrderListView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.ORDERDETAIL,
      page: () => const OrderDetailView(),
      binding: OrderBinding(),
    ),
  ];
}
