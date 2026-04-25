class HealthEventRecord {
  const HealthEventRecord({
    required this.id,
    required this.animalRef,
    required this.eventDate,
    required this.eventType,
    required this.diagnosis,
    required this.vetName,
    required this.vetFee,
    required this.medicineCost,
    required this.notes,
  });

  final String id;
  final String animalRef;
  final DateTime eventDate;
  final String eventType;
  final String diagnosis;
  final String vetName;
  final double vetFee;
  final double medicineCost;
  final String notes;

  double get totalCost => vetFee + medicineCost;

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'animal_ref': animalRef,
      'event_date': eventDate.toIso8601String(),
      'event_type': eventType,
      'diagnosis': diagnosis,
      'vet_name': vetName,
      'vet_fee': vetFee,
      'medicine_cost': medicineCost,
      'notes': notes,
    };
  }

  factory HealthEventRecord.fromMap(Map<String, Object?> map) {
    return HealthEventRecord(
      id: map['id'] as String? ?? '',
      animalRef: map['animal_ref'] as String? ?? '',
      eventDate: DateTime.tryParse(map['event_date'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      eventType: map['event_type'] as String? ?? '',
      diagnosis: map['diagnosis'] as String? ?? '',
      vetName: map['vet_name'] as String? ?? '',
      vetFee: _toDouble(map['vet_fee']),
      medicineCost: _toDouble(map['medicine_cost']),
      notes: map['notes'] as String? ?? '',
    );
  }
}

double _toDouble(Object? value) {
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0;
  return 0;
}
