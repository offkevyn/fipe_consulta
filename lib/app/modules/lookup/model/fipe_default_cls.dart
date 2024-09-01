import 'dart:convert';

class FipeDefaultCls {
  final String name;
  final String cod;

  FipeDefaultCls({
    required this.name,
    required this.cod,
  });

  static FipeDefaultCls get empty => FipeDefaultCls(name: '', cod: '');

  bool get isEmpty => name.isEmpty || cod.isEmpty;

  bool get isNotEmpty => name.isNotEmpty && cod.isNotEmpty;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cod': cod,
    };
  }

  factory FipeDefaultCls.fromMap(Map<String, dynamic> map) {
    return FipeDefaultCls(
      name: map['name'] as String,
      cod: map['cod'] as String,
    );
  }

  factory FipeDefaultCls.fromMapApi(Map<String, dynamic> map) {
    return FipeDefaultCls(
      name: map['nome'] as String,
      cod: map['codigo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FipeDefaultCls.fromJson(String source) =>
      FipeDefaultCls.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => name;
}
