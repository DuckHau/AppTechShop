// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// 🌎 Project imports:
import 'package:techshop_app/models/user.dart';
import 'package:techshop_app/module/Auth/Controller/auth_controller.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _authController.getUserProfile();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
      // Handle the image upload logic here
      // For example, you can upload the image to your server and update the user's avatar URL
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (_authController.status.value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final user = _authController.user.user;
        if (user == null) {
          return const Center(child: Text('User data is not available.'));
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Chỉnh sửa thông tin'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _image != null
                            ? (kIsWeb
                                    ? NetworkImage(_image!.path)
                                    : FileImage(File(_image!.path)))
                                as ImageProvider
                            : NetworkImage(user.avatar!),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt,
                                color: Colors.white),
                            onPressed: _pickImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildTextField('Tên người dùng', user.fullname!, Icons.person,
                      nameController),
                  buildTextField(
                      'Email', user.email!, Icons.email, emailController),
                  buildTextField('Số điện thoại', user.phone!, Icons.phone,
                      phoneController),
                  buildTextField('Mật khẩu', '************', Icons.lock,
                      passwordController,
                      isPassword: true),
                  buildTextField('Địa chỉ', user.address!, Icons.location_on,
                      addressController),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final updatedUser = User(
                        user: UserPro(
                          fullname: nameController.text.isEmpty
                              ? user.fullname
                              : nameController.text,
                          email: emailController.text.isEmpty
                              ? user.email
                              : emailController.text,
                          phone: phoneController.text.isEmpty
                              ? user.phone
                              : phoneController.text,
                          address: addressController.text.isEmpty
                              ? user.address
                              : addressController.text,
                          password: passwordController.text.isEmpty
                              ? user.password
                              : passwordController.text,
                        ),
                      );
                      print(updatedUser.user.toString());
                      _authController.updateUserProfile(
                          updatedUser.user!.fullname!,
                          updatedUser.user!.email!,
                          updatedUser.user!.password!,
                          updatedUser.user!.phone!,
                          updatedUser.user!.address!,
                          _image);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 162, 95, 230),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text(
                      'Lưu thông tin',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildTextField(String label, String placeholder, IconData icon,
      TextEditingController controller,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          hintText: placeholder,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
