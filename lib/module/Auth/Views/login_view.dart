import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:techshop_app/module/Auth/Controller/auth_controller.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final Uri _url = Uri.parse('https://flutter.dev'); // Thay bằng URL video của bạn

  LoginPage({super.key});

  Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

  @override
  Widget build(BuildContext context) {
    final loading = ValueNotifier<bool>(false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: const Color.fromARGB(255, 235, 235, 235),
            child: Stack(
              children: [
                Positioned(
                  left: 57,
                  top: 21,
                  child: Container(
                    width: 275,
                    height: 275,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/TechLogo.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                
                Positioned(
                  left: 27,
                  top: 326,
                  child: SizedBox(
                    width: 340,
                    height: 128,
                    child: Column(
                      children: [
                        Container(
                          width: 340,
                          height: 56,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: const Color(0x268E6CEE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: emailController,
                            focusNode: emailFocusNode,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xFF4E4E4E),
                              ),
                            ),
                            style: const TextStyle(
                              color: Color(0xFF4E4E4E),
                              fontSize: 16,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: 340,
                          height: 56,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: const Color(0x268E6CEE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            decoration: const InputDecoration(
                              labelText: 'Mật khẩu',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color(0xFF4E4E4E),
                              ),
                            ),
                            obscureText: true,
                            style: const TextStyle(
                              color: Color(0xFF4E4E4E),
                              fontSize: 16,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 37,
                  top: 466,
                  child: SizedBox(
                    width: 320,
                    height: 17,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Opacity(
                              opacity: 0.80,
                              child: Container(
                                width: 11.41,
                                height: 11.41,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(2.85),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Ghi nhớ đăng nhập',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Quên mật khẩu',
                          style: TextStyle(
                            color: Color(0xFF8E6CEE),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                  ElevatedButton(
              onPressed: _launchUrl,
              child: Text('Show Flutter homepage'),
            ),
                Positioned(
                  left: 80,
                  top: 506,
                  child: SizedBox(
                    height: 95,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: loading,
                          builder: (context, isLoading, child) {
                            return isLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: isLoading
                                        ? null
                                        : () async {
                                            loading.value = true;
                                            bool success =
                                                await authController.login(
                                                    emailController.text,
                                                    passwordController.text);
                                            loading.value = false;
                                            if (success) {
                                              Get.toNamed('/');
                                            } else {
                                              Get.snackbar('Đăng nhập thất bại',
                                                  'Email hoặc mật khẩu không chính xác');
                                            }
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF8E6CEE),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 10),
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    child: const Text('Đăng nhập'),
                                  );
                          },
                        ),
                        const SizedBox(height: 25),
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Bạn không có tài khoản?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Arial',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 4.75),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed('/register');
                                },
                                child: const Text(
                                  'Đăng ký',
                                  style: TextStyle(
                                    color: Color(0xFFFFC42A),
                                    fontSize: 15,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        // Thêm liên kết YouTube ở đây          
          
          
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
