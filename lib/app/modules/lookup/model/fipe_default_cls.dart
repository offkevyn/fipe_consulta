
class FipeDefaultCls {
  final String name;
  final String cod;

  FipeDefaultCls({
    required this.name,
    required this.cod,
  });

  static FipeDefaultCls get empty => FipeDefaultCls(name: '', cod: '');

  factory FipeDefaultCls.fromMapApi(Map<String, dynamic> map) {
    return FipeDefaultCls(
      name: map['nome'] ?? '',
      cod: map['codigo'] != null ? map['codigo'].toString() : '',
    );
  }

  @override
  String toString() => name;
}
