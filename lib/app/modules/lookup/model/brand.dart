import 'dart:convert';

class Brand {
  final String name;
  final String cod;

  Brand({
    required this.name,
    required this.cod,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cod': cod,
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      name: map['name'] as String,
      cod: map['cod'] as String,
    );
  }

  factory Brand.fromMapApi(Map<String, dynamic> map) {
    return Brand(
      name: map['nome'] as String,
      cod: map['codigo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) =>
      Brand.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => name;
}
