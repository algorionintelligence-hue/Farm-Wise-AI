import 'package:farm_wise_ai/features/dashboard/view/DashboardScreen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../BreedingDashboard/view/BreedingDashboard.dart';
import '../../CostIntelligence/view/CashIntelligenceDashboard.dart';
import '../../InventoryDashboard/view/InventoryDashboard.dart';

final navIndexProvider = StateProvider<int>((ref) => 0);

final List<Widget> screens = [
  const DashboardScreen(),
  const InventoryDashboard(),     // 0
  const Center(child: Text('Trophy Screen')),    // 1
                      // 2 (HOME)
  const CashIntelligenceDashboard(),     // 3
  const BreedingDashboard(),   // 4
];


