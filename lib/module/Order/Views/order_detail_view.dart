// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// 🌎 Project imports:
import 'package:techshop_app/module/Order/Controller/order_controller.dart';

class OrderDetailView extends StatefulWidget {
  const OrderDetailView({super.key});

  @override
  _OrderDetailViewState createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  final OrderController orderController = Get.find<OrderController>();
  final String? orderId = Get.parameters['orderId'];

  @override
  void initState() {
    super.initState();
    if (orderId != null) {
      orderController.getOrderDetail(orderId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đơn hàng',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Obx(
        () {
          if (orderController.status.value.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final order = orderController.orderDetail.value;
          if (order == null) {
            return const Center(child: Text('No order details available.'));
          }
          if (orderController.status.value.isError) {
            return Center(
                child: Text('Error: ${orderController.status.value}'));
          }
          if (orderController.status.value.isSuccess) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Mã đơn hàng: ${order.orderCode}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 20),
                  _buildOrderStatusTimeline(order.orderStatus),
                  const SizedBox(height: 20),
                  const Text('Sản phẩm đã đặt',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 10),
                  ...order.items?.map((item) => Card(
                            color: Colors.grey[200],
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: item.productId?.proImg != null &&
                                      item.productId!.proImg!.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          item.productId!.proImg!.first.img ??
                                              '',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover)
                                  : null,
                              title: Text(item.productId?.name ?? '',
                                  style: const TextStyle(color: Colors.black)),
                              subtitle: Text('Số lượng: ${item.purchasedQty}'),
                              trailing: Text(
                                  '${formatter.format(item.payablePrice! * 1000000)} đ',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )) ??
                      [],
                  const SizedBox(height: 20),
                  const Text('Thông tin vận chuyển',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Người đặt hàng: ${order.user!.fullname}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        const SizedBox(height: 10),
                        Text("Địa chỉ: ${order.user!.address}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        const SizedBox(height: 10),
                        Text("SĐT: ${order.user!.phone}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Phương thức thanh toán: ${order.paymentType}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        const SizedBox(height: 10),
                        Text("Trạng thái thanh toán:  ${order.paymentStatus}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        const SizedBox(height: 10),
                        Text("Trạng thái đơn hàng: ${order.orderStatus}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildOrderStatusTimeline(String? orderStatus) {
    final statuses = [
      {'status': 'Đã đặt hàng', 'date': '28/5/2024', 'isCompleted': true},
      {
        'status': 'Đang xử lý',
        'date': '29/5/2024',
        'isCompleted': orderStatus != 'pending'
      },
      {
        'status': 'Đã giao hàng',
        'date': '30/5/2024',
        'isCompleted': orderStatus == 'delivered'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: statuses.map((status) {
        return Column(
          children: [
            Row(
              children: [
                Icon(
                  status['isCompleted'] != null
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: status['isCompleted'] != null
                      ? Colors.purple
                      : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  status['status']!.toString(),
                  style: TextStyle(
                    color: status['isCompleted'] != null
                        ? Colors.black
                        : Colors.grey,
                    fontWeight: status['isCompleted'] != null
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                const Spacer(),
                Text(
                  status['date']!.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            if (status != statuses.last)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    Container(
                      width: 2,
                      height: 20,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
          ],
        );
      }).toList(),
    );
  }
}
