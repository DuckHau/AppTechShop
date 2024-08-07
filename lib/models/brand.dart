class Brand {
  bool? success;
  List<String>? data;

  Brand({this.success, this.data});

  Brand.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = this.data;
    return data;
  }
}
