import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/herd.dart';

class HerdViewModel extends StateNotifier<HerdInputModel> {
  // ✅ Fix: null ki jagah empty model se start karo
  HerdViewModel() : super(HerdInputModel());

  final animalIdController = TextEditingController();
  final weightController = TextEditingController();
  final avgMilkController = TextEditingController();
  final milkPriceController = TextEditingController();
  final milkSoldController = TextEditingController();
  final feedCostController = TextEditingController();
  final medicalCostController = TextEditingController();
  final laborCostController = TextEditingController();
  final expectedSaleController = TextEditingController();

  String? category;
  String? stage;

  DateTime? serviceDate;
  DateTime? pdDate;
  DateTime? calvingDate;

  int expectedCalves() {
    if (serviceDate == null) return 0;
    final diff = DateTime.now().difference(serviceDate!).inDays;
    return diff < 180 ? 1 : 0;
  }

  double monthlyRevenue() {
    final milk = double.tryParse(avgMilkController.text) ?? 0;
    final price = double.tryParse(milkPriceController.text) ?? 0;
    final percent = (double.tryParse(milkSoldController.text) ?? 100) / 100;
    return milk * price * percent * 30;
  }

  double monthlyCost() {
    return (double.tryParse(feedCostController.text) ?? 0) +
        (double.tryParse(medicalCostController.text) ?? 0) +
        (double.tryParse(laborCostController.text) ?? 0);
  }

  double monthlyProfit() => monthlyRevenue() - monthlyCost();

  void save() {
    state = HerdInputModel(
      animalId: animalIdController.text,
      category: category,
      stage: stage,
      weight: double.tryParse(weightController.text),
      serviceDate: serviceDate,
      pdDate: pdDate,
      calvingDate: calvingDate,
      avgMilkPerDay: double.tryParse(avgMilkController.text),
      milkSalePrice: double.tryParse(milkPriceController.text),
      milkSoldPercentage: double.tryParse(milkSoldController.text),
      feedCost: double.tryParse(feedCostController.text),
      medicalCost: double.tryParse(medicalCostController.text),
      laborCost: double.tryParse(laborCostController.text),
      expectedSaleAnimals: int.tryParse(expectedSaleController.text) ?? 0,
    );
  }

  // ✅ Fix: copyWith se naya object — Riverpod rebuild karega
  void refreshDates() {
    state = state.copyWith(
      serviceDate: serviceDate,
      pdDate: pdDate,
      calvingDate: calvingDate,
    );
  }

  @override
  void dispose() {
    animalIdController.dispose();
    weightController.dispose();
    avgMilkController.dispose();
    milkPriceController.dispose();
    milkSoldController.dispose();
    feedCostController.dispose();
    medicalCostController.dispose();
    laborCostController.dispose();
    expectedSaleController.dispose();
    super.dispose();
  }
}

final herdProvider =
StateNotifierProvider<HerdViewModel, HerdInputModel>(
        (ref) => HerdViewModel());
