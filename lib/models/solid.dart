import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class SOLID {
  final String description;
  final String? name;
   String type;
  final int? id;
  final String? image_url;
  final int price;
  final String? country;
  final String city;
  final int? user_id;
  final String? user_name;
  final String? user_image;
  final int? like;
  final String? date_added;
  final String? table_name;
  final String? user_phone;

  SOLID({
    required this.description,
    this.name,
    required this.type,
    this.id,
    this.image_url,
    required this.price,
    required this.city,
    this.user_id,
    this.country,
    this.user_name,
    this.user_image,
    this.like,
    this.date_added,
    this.table_name,
        this.user_phone,

  });

 

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'description': description});
    if(name != null){
      result.addAll({'name': name});
    }
    result.addAll({'type': type});
    if(id != null){
      result.addAll({'id': id});
    }
    if(image_url != null){
      result.addAll({'image_url': image_url});
    }
    result.addAll({'price': price});
    if(country != null){
      result.addAll({'country': country});
    }
    result.addAll({'city': city});
    if(user_id != null){
      result.addAll({'user_id': user_id});
    }
    if(user_name != null){
      result.addAll({'user_name': user_name});
    }
    if(user_image != null){
      result.addAll({'user_image': user_image});
    }if(user_phone != null){
      result.addAll({'user_phone': user_phone});}
    if(like != null){
      result.addAll({'like': like});
    }
    if(date_added != null){
      result.addAll({'date_added': date_added});
    }
    if(table_name != null){
      result.addAll({'table_name': table_name});
    }
  
    return result;
  }

  factory SOLID.fromJson(Map<String, dynamic> map) {
    return SOLID(
      description: map['description'] ?? '',
      name: map['name'],
      type: map['type'] ?? '',
      id: map['id']?.toInt(),
      image_url: map['image_url'],
      price: map['price']?.toInt() ?? 0,
      country: map['country'],
      city: map['city'] ?? '',
      user_id: map['user_id']?.toInt(),
      user_name: map['user_name'],
      user_image: map['user_image'],
      like: map['like']?.toInt(),
      date_added: map['date_added'],
      table_name: map['table_name'],
      user_phone: map['user_phone'],

    );
  }

  String toJson() => json.encode(toMap());

}
