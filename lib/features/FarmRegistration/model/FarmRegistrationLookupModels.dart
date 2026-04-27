class CurrencyModel {
  final int id;
  final String name;

  CurrencyModel({
    required this.id,
    required this.name,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}



class BusinessTypeModel {
  final int id;
  final String name;

  BusinessTypeModel({
    required this.id,
    required this.name,
  });

  factory BusinessTypeModel.fromJson(Map<String, dynamic> json) {
    return BusinessTypeModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}