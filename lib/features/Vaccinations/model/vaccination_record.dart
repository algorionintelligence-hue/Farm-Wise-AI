class VaccinationRecord {
  const VaccinationRecord({
    required this.id,
    required this.animalRef,
    required this.vaccineName,
    required this.dateGiven,
    required this.nextDueDate,
    required this.cost,
    required this.batchNumber,
  });

  final String id;
  final String animalRef;
  final String vaccineName;
  final DateTime dateGiven;
  final DateTime? nextDueDate;
  final double cost;
  final String batchNumber;

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'animal_ref': animalRef,
      'vaccine_name': vaccineName,
      'date_given': dateGiven.toIso8601String(),
      'next_due_date': nextDueDate?.toIso8601String(),
      'cost': cost,
      'batch_number': batchNumber,
    };
  }

  factory VaccinationRecord.fromMap(Map<String, Object?> map) {
    return VaccinationRecord(
      id: map['id'] as String? ?? '',
      animalRef: map['animal_ref'] as String? ?? '',
      vaccineName: map['vaccine_name'] as String? ?? '',
      dateGiven: DateTime.tryParse(map['date_given'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      nextDueDate: DateTime.tryParse(map['next_due_date'] as String? ?? ''),
      cost: _toDouble(map['cost']),
      batchNumber: map['batch_number'] as String? ?? '',
    );
  }
}

double _toDouble(Object? value) {
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0;
  return 0;
}
