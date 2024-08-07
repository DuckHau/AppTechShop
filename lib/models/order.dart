class Order {
  bool? success;
  List<Data>? data;

  Order({this.success, this.data});

  Order.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  User? user;
  TotalPrice? totalPrice;
  List<Items>? items;
  String? paymentStatus;
  String? paymentType;
  String? orderStatus;
  String? orderCode;
  String? createdAt;
  int? iV;

  Data(
      {this.sId,
      this.user,
      this.totalPrice,
      this.items,
      this.paymentStatus,
      this.paymentType,
      this.orderStatus,
      this.orderCode,
      this.createdAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    totalPrice = json['totalPrice'] != null
        ? TotalPrice.fromJson(json['totalPrice'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    paymentStatus = json['paymentStatus'];
    paymentType = json['paymentType'];
    orderStatus = json['orderStatus'];
    orderCode = json['orderCode'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (totalPrice != null) {
      data['totalPrice'] = totalPrice!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['paymentStatus'] = paymentStatus;
    data['paymentType'] = paymentType;
    data['orderStatus'] = orderStatus;
    data['orderCode'] = orderCode;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}

class User {
  String? sId;
  String? fullname;
  String? email;
  String? address;
  String? phone;

  User({this.sId, this.fullname, this.email, this.address, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullname = json['fullname'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fullname'] = fullname;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    return data;
  }
}

class TotalPrice {
  String? numberDecimal;

  TotalPrice({this.numberDecimal});

  TotalPrice.fromJson(Map<String, dynamic> json) {
    numberDecimal = json['$numberDecimal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$numberDecimal'] = numberDecimal;
    return data;
  }
}

class Items {
  String? sId;
  double? payablePrice;
  ProductId? productId;
  int? purchasedQty;

  Items({this.sId, this.payablePrice, this.productId, this.purchasedQty});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    payablePrice = json['payablePrice'];
    productId = json['productId'] != null
        ? ProductId.fromJson(json['productId'])
        : null;
    purchasedQty = json['purchasedQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['payablePrice'] = payablePrice;
    if (productId != null) {
      data['productId'] = productId!.toJson();
    }
    data['purchasedQty'] = purchasedQty;
    return data;
  }
}

class ProductId {
  String? sId;
  List<ProImg>? proImg;
  String? name;

  ProductId({this.sId, this.proImg, this.name});

  ProductId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['proImg'] != null) {
      proImg = <ProImg>[];
      json['proImg'].forEach((v) {
        proImg!.add(ProImg.fromJson(v));
      });
    }
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (proImg != null) {
      data['proImg'] = proImg!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    return data;
  }
}

class ProImg {
  String? sId;
  String? img;

  ProImg({this.sId, this.img});

  ProImg.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['img'] = img;
    return data;
  }
}
