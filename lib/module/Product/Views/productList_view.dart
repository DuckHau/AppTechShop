// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

// 🌎 Project imports:
import 'package:techshop_app/models/category.dart';
import 'package:techshop_app/models/product.dart';
import 'package:techshop_app/module/Cart/Controller/cart_controller.dart';
import 'package:techshop_app/module/Category/Controller/category_controller.dart';
import 'package:techshop_app/module/Product/Controller/product_controller.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ProductController _productController = Get.find<ProductController>();
  final CategoryController _categoryController = Get.put(CategoryController());
  final ScrollController _scrollController = ScrollController();
  final Map<String, String?> data = Get.arguments ?? {};
  bool _isDisposed = false;
  String? _selectedCategoryName;
  String? _selectedSortOption;
  String? _selectedFilterOption;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isDisposed = false;
    _scrollController.addListener(() {
      if (!_scrollController.hasClients || _isDisposed) {
        return;
      }

      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _productController.fetchProducts(
            category: data['category'], brand: data['brand'],keyword: data['keyword']);
      }
    });
    _categoryController.getCategories(); // Fetch categories
  }

  final Map<String, String> sortOptions = {
    'Giá: Thấp đến Cao': 'price',
    'Giá: Cao đến Thấp': '-price',
  };

  final Map<String, String> filterOptions = {
    'Còn hàng': '1',
    'Hết hàng': '0',
  };

  Future<void> _refresh() async {
    if (data['category'] != null) {
      _productController.fetchProducts(
        category: data['category'],
        isCategoryFetch: true,
      );
    } else if (data['brand'] != null) {
      _productController.fetchProducts(
        brand: data['brand'],
        isBrandFetch: true,
      );
    } else {
      _productController.fetchAllProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data['category'] != null) {
      _productController.fetchProducts(
        category: data['category'],
        isCategoryFetch: true,
      );
    }
    if (data['brand'] != null) {
      _productController.fetchProducts(
        brand: data['brand'],
        isBrandFetch: true,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sản phẩm',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.toNamed('/');
          },
        ),
      ),
      body: Column(
        children: [
          Obx(() {
            if (_categoryController.status.value.isLoading) {
              return const CircularProgressIndicator();
            }
            if (_categoryController.category.value.categoryList == null ||
                _categoryController.category.value.categoryList!.isEmpty) {
              return const Text('Không tồn tại danh mục');
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                borderRadius: BorderRadius.circular(10.0),
                hint: Text(
                  _selectedSortOption != null
                      ? _categoryController.category.value.categoryList!
                          .firstWhere(
                              (category) => category.sId == _selectedSortOption,
                              orElse: () => CategoryList(name: 'Danh mục'))
                          .name!
                      : 'Danh mục',
                  style: const TextStyle(color: Colors.black),
                ),
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('Tất cả'),
                  ),
                  ..._categoryController.category.value.categoryList!
                      .map((CategoryList category) {
                    return DropdownMenuItem<String>(
                      value: category.sId,
                      child: Text(category.name!),
                    );
                  }),
                ],
                selectedItemBuilder: (BuildContext context) {
                  return [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text(
                        'Tất cả',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ..._categoryController.category.value.categoryList!
                        .map((CategoryList category) {
                      return DropdownMenuItem<String>(
                        value: category.sId,
                        child: Text(
                          category.name!,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }),
                  ];
                },
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedCategoryName = _categoryController
                          .category.value.categoryList!
                          .firstWhere((category) => category.sId == newValue)
                          .name;
                    });
                    _productController.fetchProducts(
                      category: newValue,
                      isCategoryFetch: true,
                    );
                  } else {
                    setState(() {
                      _selectedCategoryName = 'Tất cả';
                    });
                    _productController.fetchAllProducts();
                  }
                },
                icon: const Icon(
                  FluentIcons.caret_down_16_filled,
                  color: Colors.black,
                ),
              ),
            );
          }),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    hint: Text(
                      _selectedSortOption != null
                          ? sortOptions.keys.firstWhere(
                              (k) => sortOptions[k] == _selectedSortOption,
                              orElse: () => 'Sắp xếp theo')
                          : 'Sắp xếp theo',
                      style: const TextStyle(color: Colors.black),
                    ),
                    items: sortOptions.keys.map((String key) {
                      return DropdownMenuItem<String>(
                        value: sortOptions[key],
                        child: Text(key),
                      );
                    }).toList(),
                    selectedItemBuilder: (BuildContext context) {
                      return sortOptions.keys.map((String key) {
                        return DropdownMenuItem<String>(
                          value: sortOptions[key],
                          child: Text(
                            key,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList();
                    },
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedSortOption = newValue;
                        });
                        _productController.fetchProducts(
                          sort: newValue,
                          isSortFetch: true,
                        );
                      }
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.sort,
                      size: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    hint: Text(
                      _selectedFilterOption != null
                          ? filterOptions.keys.firstWhere(
                              (k) => filterOptions[k] == _selectedFilterOption,
                              orElse: () => 'Lọc theo')
                          : 'Lọc theo',
                      style: const TextStyle(color: Colors.black),
                    ),
                    items: filterOptions.keys.map((String key) {
                      return DropdownMenuItem<String>(
                        value: filterOptions[key],
                        child: Text(key),
                      );
                    }).toList(),
                    selectedItemBuilder: (BuildContext context) {
                      return filterOptions.keys.map((String key) {
                        return DropdownMenuItem<String>(
                          value: filterOptions[key],
                          child: Text(
                            key,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList();
                    },
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedFilterOption = newValue;
                        });
                        _productController.fetchProducts(
                          stock: int.parse(newValue),
                          isStockFetch: true,
                        );
                      }
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.filter,
                      size: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GetBuilder<ProductController>(
              init: _productController,
              initState: (_) {
                _productController.fetchProducts(
                    category: data['category'], brand: data['brand']);
              },
              builder: (_) {
                if (_productController.isLoading.value) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return itemLoading();
                    },
                  );
                }

                if (_productController.productItems.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    controller: _scrollController,
                    itemCount: _productController.productItems.length,
                    itemBuilder: (context, index) {
                      if (index == _productController.productItems.length) {
                        if (_productController.hasMore.value) {
                          return itemLoading();
                        } else {
                          return const SizedBox.shrink();
                        }
                      }
                      final product = _productController.productItems[index];
                      return itemGridView(product);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget itemGridView(Products proItem) {
  final CartController cartController = Get.find<CartController>();
  final formatter = NumberFormat('#,###', 'vi_VN');
  final value = proItem.price!.$numberDecimal!;
  final formatPrice = formatter.format(double.parse(value) * 1000000);
  return GestureDetector(
    onTap: () => {
      Get.toNamed('/product/detail', parameters: {'slug': proItem.slug!})
    },
    child: Card(
      color: Colors.grey.shade200,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CachedNetworkImage(
              imageUrl: proItem.proImg?.elementAt(0).img ?? 'N/A',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey.shade200,
                highlightColor: Colors.grey.shade400,
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.white,
                ),
              ),
              fadeInDuration: const Duration(milliseconds: 200),
              fadeOutDuration: const Duration(milliseconds: 200),
              errorWidget: (context, url, error) => const FaIcon(
                FontAwesomeIcons.image,
                size: 16,
              ),
            ),
            Text(
              proItem.name ?? 'N/A',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              proItem.brand ?? 'N/A',
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            Text(' $formatPrice ₫',
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {
                cartController.addToCart([
                  {'product': proItem.sId, 'quantity': 1}
                ]);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 162, 95, 230),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    FontAwesomeIcons.cartPlus,
                    size: 18,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Thêm vào giỏ',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget itemLoading() {
  return Card(
    color: Colors.grey.shade200,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade400,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10), // Added radius
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade400,
            child: Container(
              height: 20,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10), // Added radius
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade400,
            child: Container(
              height: 20,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10), // Added radius
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade400,
            child: Container(
              height: 20,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10), // Added radius
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade400,
            child: Container(
              height: 30,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10), // Added radius
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
