import 'package:farm_wise_ai/features/cost_intelligence/view/cost_intelligence.dart';
import 'package:farm_wise_ai/features/dashboard/view/dashboard_screen.dart';
import 'package:farm_wise_ai/features/inventory_dashboard/view/inventoryDashboard.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../breeding_dashboard/view/breeding_dashboard.dart';

final navIndexProvider = StateProvider<int>((ref) => 0);

final List<Widget> screens = [
  const DashboardScreen(),
  const InventoryDashboard(),     // 0
  const Center(child: Text('Trophy Screen')),    // 1
                      // 2 (HOME)
  const CashIntelliganceDashboard(),     // 3
  const BreedingDashboard(),   // 4
];

