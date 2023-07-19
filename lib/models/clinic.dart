import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class clinic {
  final int?  rating;
  final String? name;
  final int? id;


  final String? country;
  final String city;
 
  final String? phone;
  clinic({
    this.rating,
    this.name,
    this.id,
    this.country,
    required this.city,
    this.phone,
  });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(rating != null){
      result.addAll({'rating': rating});
    }
    if(name != null){
      result.addAll({'name': name});
    }
    if(id != null){
      result.addAll({'id': id});
    }
    if(country != null){
      result.addAll({'country': country});
    }
    result.addAll({'city': city});
    if(phone != null){
      result.addAll({'phone': phone});
    }
  
    return result;
  }

  factory clinic.fromMap(Map<String, dynamic> map) {
    return clinic(
      rating: map['rating']?.toInt(),
      name: map['name'],
      id: map['id']?.toInt(),
      country: map['country'],
      city: map['city'] ?? '',
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory clinic.fromJson(String source) => clinic.fromMap(json.decode(source));
}
