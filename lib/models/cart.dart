class Cart {
  bool? success;
  int? totalItems;
  String? totalPrice;
  int? totalQuantity;
  List<CartItems>? cartItems;

  Cart(
      {this.success,
      this.totalItems,
      this.totalPrice,
      this.totalQuantity,
      this.cartItems});

  Cart.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalItems = json['total_items'];
    totalPrice = json['total_price'];
    totalQuantity = json['total_quantity'];
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(CartItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['total_items'] = totalItems;
    data['total_price'] = totalPrice;
    data['total_quantity'] = totalQuantity;
    if (cartItems != null) {
      data['cartItems'] = cartItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItems {
  CartItem? cartItem;

  CartItems({this.cartItem});

  CartItems.fromJson(Map<String, dynamic> json) {
    cartItem =
        json['cartItem'] != null ? CartItem.fromJson(json['cartItem']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cartItem != null) {
      data['cartItem'] = cartItem!.toJson();
    }
    return data;
  }
}

class CartItem {
  String? sId;
  String? name;
  String? img;
  double? price;
  int? quantity;

  CartItem({this.sId, this.name, this.img, this.price, this.quantity});

  CartItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    img = json['img'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['img'] = img;
    data['price'] = price;
    data['quantity'] = quantity;
    return data;
  }
}
