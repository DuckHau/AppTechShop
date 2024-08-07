// ignore_for_file: file_names

class AppUrl {
  AppUrl._();

  // base url
  //static const String baseUrl =
      // 'http://192.168.0.101:8080'; // For Home network
      //'http://192.168.172.162:8080'; // For School network
  // static const String baseUrl = 'http://10.0.2.2:8080'; // For Android Emulator
   static const String baseUrl = 'http://127.0.0.1:8080'; // For Web

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 15000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 15000);

  // image url
  static const String imageUrl = 'assets/images/';
}
