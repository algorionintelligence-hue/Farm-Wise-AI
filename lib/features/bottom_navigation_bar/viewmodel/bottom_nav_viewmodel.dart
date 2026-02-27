import 'package:farm_wise_ai/features/dashboard/view/dashboard_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navIndexProvider = StateProvider<int>((ref) => 0);

final List<Widget> screens = [
  const DashboardScreen(),
  const Center(child: Text('Offer Screen')),     // 0
  const Center(child: Text('Trophy Screen')),    // 1
                      // 2 (HOME)
  const Center(child: Text('Music Screen')),     // 3
  const Center(child: Text('Profile Screen')),   // 4
];

