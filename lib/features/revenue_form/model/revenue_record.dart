class RevenueRecord {
  final String id;
  final String animalRef;
  final DateTime revenueDate;
  final String revenueType;
  final double quantity;
  final double unitPrice;
  final double commission;
  final String? notes;

  RevenueRecord({
    required this.id,
    required this.animalRef,
    required this.revenueDate,
    required this.revenueType,
    required this.quantity,
    required this.unitPrice,
    required this.commission,
    this.notes,
  });

  double get netAmount => (quantity * unitPrice) - commission;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'animal_ref': animalRef,
      'revenue_date': revenueDate.toIso8601String(),
      'revenue_type': revenueType,
      'quantity': quantity,
      'unit_price': unitPrice,
      'commission': commission,
      'net_amount': netAmount,
      'notes': notes,
    };
  }

  factory RevenueRecord.fromMap(Map<String, dynamic> map) {
    return RevenueRecord(
      id: map['id'] as String? ?? '',
      animalRef: map['animal_ref'] as String? ?? '',
      revenueDate: DateTime.parse(map['revenue_date'] as String? ?? DateTime.now().toIso8601String()),
      revenueType: map['revenue_type'] as String? ?? '',
      quantity: (map['quantity'] as num?)?.toDouble() ?? 0.0,
      unitPrice: (map['unit_price'] as num?)?.toDouble() ?? 0.0,
      commission: (map['commission'] as num?)?.toDouble() ?? 0.0,
      notes: map['notes'] as String? ?? '',
    );
  }

  RevenueRecord copyWith({
    String? id,
    String? animalRef,
    DateTime? revenueDate,
    String? revenueType,
    double? quantity,
    double? unitPrice,
    double? commission,
    String? notes,
  }) {
    return RevenueRecord(
      id: id ?? this.id,
      animalRef: animalRef ?? this.animalRef,
      revenueDate: revenueDate ?? this.revenueDate,
      revenueType: revenueType ?? this.revenueType,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      commission: commission ?? this.commission,
      notes: notes ?? this.notes,
    );
  }
}
