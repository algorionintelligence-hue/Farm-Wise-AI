class BreedDetailModel {
  final String breedName;
  final int quantity;

  BreedDetailModel({
    required this.breedName,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      "breedName": breedName,
      "quantity": quantity,
    };
  }

  factory BreedDetailModel.fromJson(Map<String, dynamic> json) {
    return BreedDetailModel(
      breedName: json["breedName"],
      quantity: json["quantity"],
    );
  }
}