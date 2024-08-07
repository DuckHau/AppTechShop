class Product {
  bool? success;
  int? productsCount;
  int? totalPages;
  int? currentPage;
  int? resPerPage;
  int? filteredProductsCount;
  List<Products>? products;

  Product(
      {this.success,
      this.productsCount,
      this.totalPages,
      this.currentPage,
      this.resPerPage,
      this.filteredProductsCount,
      this.products});

  Product.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    productsCount = json['productsCount'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    resPerPage = json['resPerPage'];
    filteredProductsCount = json['filteredProductsCount'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['productsCount'] = productsCount;
    data['totalPages'] = totalPages;
    data['currentPage'] = currentPage;
    data['resPerPage'] = resPerPage;
    data['filteredProductsCount'] = filteredProductsCount;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  Richdescription? richdescription;
  int? totalRating;
  String? sId;
  List<ProImg>? proImg;
  Category? category;
  int? stock;
  int? sold;
  int? numReviews;
  String? brand;
  String? name;
  Price? price;
  String? description;
  String? slug;
  List<Null>? rating;

  Products(
      {this.richdescription,
      this.totalRating,
      this.sId,
      this.proImg,
      this.category,
      this.stock,
      this.sold,
      this.numReviews,
      this.brand,
      this.name,
      this.price,
      this.description,
      this.slug,
      this.rating});

  Products.fromJson(Map<String, dynamic> json) {
    richdescription = json['richdescription'] != null
        ? Richdescription.fromJson(json['richdescription'])
        : null;
    totalRating = json['totalRating'];
    sId = json['_id'];
    if (json['proImg'] != null) {
      proImg = <ProImg>[];
      json['proImg'].forEach((v) {
        proImg!.add(ProImg.fromJson(v));
      });
    }
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    stock = json['stock'];
    sold = json['sold'];
    numReviews = json['numReviews'];
    brand = json['brand'];
    name = json['name'];
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    description = json['description'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (richdescription != null) {
      data['richdescription'] = richdescription!.toJson();
    }
    data['totalRating'] = totalRating;
    data['_id'] = sId;
    if (proImg != null) {
      data['proImg'] = proImg!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['stock'] = stock;
    data['sold'] = sold;
    data['numReviews'] = numReviews;
    data['brand'] = brand;
    data['name'] = name;
    if (price != null) {
      data['price'] = price!.toJson();
    }
    data['description'] = description;
    data['slug'] = slug;
    return data;
  }
}

class Richdescription {
  String? kichthuocmanhinh;
  String? tyle;
  String? khuvuchienthi;
  String? loaimanhinh;
  String? tamnen;
  String? gocnhin;
  String? pixelpitch;
  String? dophangiai;
  String? dosang;
  String? mausachienthi;
  String? tansoquet;
  String? conggiaotiep;
  String? dienang;
  String? kichthuoc;
  String? phukien;
  String? trongluong;

  Richdescription(
      {this.kichthuocmanhinh,
      this.tyle,
      this.khuvuchienthi,
      this.loaimanhinh,
      this.tamnen,
      this.gocnhin,
      this.pixelpitch,
      this.dophangiai,
      this.dosang,
      this.mausachienthi,
      this.tansoquet,
      this.conggiaotiep,
      this.dienang,
      this.kichthuoc,
      this.phukien,
      this.trongluong});

  Richdescription.fromJson(Map<String, dynamic> json) {
    kichthuocmanhinh = json['kichthuocmanhinh'];
    tyle = json['tyle'];
    khuvuchienthi = json['khuvuchienthi'];
    loaimanhinh = json['loaimanhinh'];
    tamnen = json['tamnen'];
    gocnhin = json['gocnhin'];
    pixelpitch = json['pixelpitch'];
    dophangiai = json['dophangiai'];
    dosang = json['dosang'];
    mausachienthi = json['mausachienthi'];
    tansoquet = json['tansoquet'];
    conggiaotiep = json['conggiaotiep'];
    dienang = json['dienang'];
    kichthuoc = json['kichthuoc'];
    phukien = json['phukien'];
    trongluong = json['trongluong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kichthuocmanhinh'] = kichthuocmanhinh;
    data['tyle'] = tyle;
    data['khuvuchienthi'] = khuvuchienthi;
    data['loaimanhinh'] = loaimanhinh;
    data['tamnen'] = tamnen;
    data['gocnhin'] = gocnhin;
    data['pixelpitch'] = pixelpitch;
    data['dophangiai'] = dophangiai;
    data['dosang'] = dosang;
    data['mausachienthi'] = mausachienthi;
    data['tansoquet'] = tansoquet;
    data['conggiaotiep'] = conggiaotiep;
    data['dienang'] = dienang;
    data['kichthuoc'] = kichthuoc;
    data['phukien'] = phukien;
    data['trongluong'] = trongluong;
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

class Category {
  String? sId;
  String? name;
  String? slug;

  Category({this.sId, this.name, this.slug});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['slug'] = slug;
    return data;
  }
}

class Price {
  String? $numberDecimal;

  Price({this.$numberDecimal});

  Price.fromJson(Map<String, dynamic> json) {
    $numberDecimal = json['\$numberDecimal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$numberDecimal'] = $numberDecimal;
    return data;
  }
}
