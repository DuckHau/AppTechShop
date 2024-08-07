class User {
  bool? success;
  String? token;
  UserPro? user;

  User({this.success, this.token, this.user});

  User.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    user = json['user'] != null ? UserPro.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class UserPro {
  String? sId;
  String? fullname;
  String? email;
  String? avatar;
  String? password;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? refreshToken;
  String? address;
  String? phone;

  UserPro({
    this.sId,
    this.fullname,
    this.email,
    this.avatar,
    this.password,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.refreshToken,
    this.address,
    this.phone,
  });

  UserPro.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullname = json['fullname'];
    email = json['email'];
    avatar = json['avatar'];
    password = json['password'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    refreshToken = json['refreshToken'];
    address = json['address'];
    phone = json['phone'];
  }

  set value(User value) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fullname'] = fullname;
    data['email'] = email;
    data['avatar'] = avatar;
    data['password'] = password;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['refreshToken'] = refreshToken;
    data['address'] = address;
    data['phone'] = phone;
    return data;
  }

  @override
  String toString() {
    return 'UserPro(sId: $sId, fullname: $fullname, email: $email, avatar: $avatar, password: $password, role: $role, createdAt: $createdAt, updatedAt: $updatedAt, iV: $iV, refreshToken: $refreshToken, address: $address, phone: $phone)';
  }
}
