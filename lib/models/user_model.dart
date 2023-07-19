import 'dart:convert';

class UserModel {
  late final String name;
  final String image_url;
  final String email;
  final String password;
  final String password_confirm;
  final String city;
  final String? country;
  final String? phone;
  final String? id;
  final String? token;
  final String? status;
  final String? role;

  UserModel({
    required this.name,
    required this.image_url,
    required this.email,
    required this.password,
    required this.password_confirm,
    required this.city,
    this.country,
    this.phone,
    this.id,
    this.token,
    this.status,
    this.role,
  });

  UserModel copyWith({
    String? name,
    String? image_url,
    String? email,
    String? password,
    String? password_confirm,
    String? city,
    String? country,
    String? phone,
    String? id,
    String? token,
    String? status,
    String? role,
  }) {
    return UserModel(
      name: name ?? this.name,
      image_url: image_url ?? this.image_url,
      email: email ?? this.email,
      password: password ?? this.password,
      password_confirm: password_confirm ?? this.password_confirm,
      city: city ?? this.city,
      country: country ?? this.country,
      phone: phone ?? this.phone,
      id: id ?? this.id,
      token: token ?? this.token,
      status: status ?? this.status,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'image_url': image_url});
    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'password_confirm': password_confirm});
    result.addAll({'city': city});
    if (country != null) {
      result.addAll({'country': country});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (id != null) {
      result.addAll({'id': id});
    }
    if (token != null) {
      result.addAll({'token': token});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (role != null) {
      result.addAll({'role': role});
    }

    return result;
  }

  factory UserModel.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    final model = json['data']['model'];
    return UserModel(
      name: model['name'],
      image_url: model['image_url'],
      email: model['email'],
      password: model['password'],
      password_confirm: model['password_confirm'] ?? '',
      city: model['city'],
      country: model['country'],
      role: model['role'],
      phone: model['phone'],
      id: model['id'].toString(),
      token: json['token'],
      status: json['status'],
    );
  }

  String toJson() => json.encode(toMap());
}