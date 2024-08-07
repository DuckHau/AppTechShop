// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

// 🌎 Project imports:
import 'package:techshop_app/Routes/app_pages.dart';
import 'package:techshop_app/models/order.dart';
import 'package:techshop_app/module/Auth/Controller/auth_controller.dart';
import 'package:techshop_app/module/Auth/Views/check_login_view.dart';
import 'package:techshop_app/module/Order/Controller/order_controller.dart';
import 'package:techshop_app/module/Order/Views/order_emty_view.dart';

class OrderListView extends StatefulWidget {
  const OrderListView({super.key});

  @override
  _OrderListViewState createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  final OrderController orderController = Get.find<OrderController>();
  final AuthController authController = Get.find<AuthController>();
  String? selectedOrderStatus;
  final List<String> orderStatuses = [
    'Đang xử lý',
    'Vận chuyển',
    'Đã giao',
    'Đã hủy'
  ];

  void onOrderStatusSelected(String orderStatus) {
    setState(() {
      selectedOrderStatus = orderStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    orderController.getOrder();
  }

  bool shimmer = false;
  Future<void> _refresh() async {
    setState(() {
      shimmer = true;
    });
    return Future.microtask(() {
      orderController.getOrder(orderStatus: selectedOrderStatus);
      setState(() {
        shimmer = false;
      });
    });
  }

  Widget buildFilterChip(String label, String orderStatus, String apiStatus) {
    return FilterChip(
      checkmarkColor: Colors.white,
      label: Text(
        label,
      ),
      selected: selectedOrderStatus == orderStatus,
      onSelected: (bool value) {
        onOrderStatusSelected(orderStatus);
        orderController.getOrder(orderStatus: apiStatus);
      },
      selectedColor: const Color.fromARGB(255, 162, 95, 230),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!authController.isLoggedIn) {
        return const CheckLoginView();
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text('Đơn hàng',
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: buildFilterChip('Tất cả', '', ''),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: buildFilterChip(
                          orderStatuses[0], orderStatuses[0], 'processing'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: buildFilterChip(
                          orderStatuses[1], orderStatuses[1], 'shipping'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: buildFilterChip(
                          orderStatuses[2], orderStatuses[2], 'delivered'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: buildFilterChip(
                          orderStatuses[3], orderStatuses[3], 'cancelled'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (orderController.status.value.isLoading) {
                  return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return itemLoading();
                    },
                  );
                }
                if (orderController.orders.isEmpty) {
                  return const OrderEmptyView();
                }

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                    itemCount: orderController.orders.length,
                    itemBuilder: (context, index) {
                      final order = orderController.orders[index];
                      //format orderdate
                      // final formattedDate = DateFormat('dd/MM/yy')
                      //     .format(DateTime.parse(order.createdAt!));
                      return shimmer ? itemLoading() : itemListView(order);
                    },
                  ),
                );
              }),
            )
          ],
        ),
      );
    });
  }

  Widget itemListView(Data order) {
    final formattedDate =
        DateFormat('dd/MM/yy').format(DateTime.parse(order.createdAt!));
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: const Icon(Icons.receipt_long),
        title: Text(
          'Đơn #${order.orderCode}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${order.items?.length ?? 0} sản phẩm'),
            Text('Trạng thái: ${order.orderStatus}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              formattedDate,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
        onTap: () {
          if (order.sId != null && order.sId!.isNotEmpty) {
            Get.toNamed(
              Routes.ORDERDETAIL,
              parameters: {'orderId': order.sId!},
            );
          } else {
            Get.snackbar('Error', 'Order ID is null or empty');
          }
        },
      ),
    );
  }
}

Widget itemLoading() {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    elevation: 4,
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade400,
      child: ListTile(
        leading: const Icon(Icons.receipt_long),
        title: Container(
          width: 100,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Container(
              width: 50,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 100,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 30,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    ),
  );
}
