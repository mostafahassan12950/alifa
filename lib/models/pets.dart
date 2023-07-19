import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class Pet {
  final String description;
  final String? name;

  final int? id;
  final String? image_url;
  final String status;
   String type;
  final int? price;
  final String city;
  final String? country;
  final String gender;
  final String? user_id;
  final String? user_name;
  final String? user_phone;
  final int? like;
  final String? date_added;
  Pet({
    required this.description,
    this.name,
    this.id,
    this.image_url,
    required this.status,
    required this.type,
    this.price,
    required this.city,
    this.country,
    required this.gender,
    this.user_id,
    this.user_name,
    this.like,
    this.date_added,
    this.user_phone,
  });


  


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'description': description});
    if(name != null){
      result.addAll({'name': name});
    }
    if(id != null){
      result.addAll({'id': id});
    }
    if(image_url != null){
      result.addAll({'image_url': image_url});
    }
    result.addAll({'status': status});
    result.addAll({'type': type});
    if(price != null){
      result.addAll({'price': price});
    }
    result.addAll({'city': city});
    if(country != null){
      result.addAll({'country': country});
    }
    result.addAll({'gender': gender});
    if(user_id != null){
      result.addAll({'user_id': user_id});
    }if(user_phone != null){
      result.addAll({'user_phone': user_phone});
    }
    if(user_name != null){
      result.addAll({'user_name': user_name});
    }
    if(like != null){
      result.addAll({'like': like});
    }
    if(date_added != null){
      result.addAll({'date_added': date_added});
    }
  
    return result;
  }

  factory Pet.fromJson(Map<String, dynamic> map) {
    return Pet(
      description: map['description'] ?? '',
      name: map['name'],
      id: map['id']?.toInt(),
      image_url: map['image_url'],
      status: map['status'] ?? '',
      type: map['type'] ?? '',
      price: map['price']?.toInt(),
      city: map['city'] ?? '',
      country: map['country'],
      gender: map['gender'] ?? '',
      user_id: map['user_id'].toString(),
      user_name: map['user_name'],
      user_phone: map['user_phone'],
      like: map['like']?.toInt(),
      date_added: map['date_added'],
    );
  }

  String toJson() => json.encode(toMap());

}
