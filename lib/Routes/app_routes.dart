// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const DASHBOARD = _Paths.DASHBOARD;
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const PRODUCT = _Paths.PRODUCT;
  static const PRODUCTDETAIL = _Paths.PRODUCTDETAIL;
  static const CART = _Paths.CART;
  static const ORDER = _Paths.ORDER;
  static const ORDERDETAIL = _Paths.ORDERDETAIL;
  static const ORDER_SUCCESS = _Paths.ORDER_SUCCESS;
  static const ORDER_FAIL = _Paths.ORDER_FAIL;
  static const PROFILE = _Paths.PROFILE;
  static const UPDATEPROFILE = _Paths.UPDATEPROFILE;
  // static const WAITING = _Paths.WAITING;
  // static const SEARCH = _Paths.SEARCH;
  // static const SAVED = _Paths.SAVED;
}

abstract class _Paths {
  _Paths._();
  static const DASHBOARD = '/';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const PRODUCT = '/product';
  static const PRODUCTDETAIL = '/product/detail';
  static const CART = '/cart';
  static const ORDER = '/order';
  static const ORDERDETAIL = '/order/detail';
  static const ORDER_SUCCESS = '/checkout/order-success';
  static const ORDER_FAIL = '/checkout/order-failed';
  static const PROFILE = '/profile';
  static const UPDATEPROFILE = '/profile/update';
  // static const WAITING = '/waiting';
  // static const SEARCH = '/search';
  // static const SAVED = '/saved';
}
