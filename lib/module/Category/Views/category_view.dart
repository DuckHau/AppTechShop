// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import 'package:techshop_app/module/Category/Controller/category_controller.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final _categoryController = Get.find<CategoryController>();

  @override
  void initState() {
    super.initState();
    _categoryController.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh mục',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(
        () {
          if (_categoryController.status.value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_categoryController.status.value.isError) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            return ListView.builder(
              itemCount:
                  _categoryController.category.value.categoryList?.length ?? 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed('/product', arguments: {
                      'category': _categoryController
                          .category.value.categoryList![index].sId,
                    });
                  },
                  child: CategoryItem(
                    title: _categoryController
                        .category.value.categoryList![index].name!,
                    imageUrl:
                        'assets/images/${_categoryController.category.value.categoryList![index].slug}.jpg',
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const CategoryItem({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 150,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(15), // Adjust the radius as needed
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey,
                  child: const Center(
                    child: Text(
                      'Image not found',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  15), // Adjust the radius to match the ClipRRect
              color: Colors.black54,
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
