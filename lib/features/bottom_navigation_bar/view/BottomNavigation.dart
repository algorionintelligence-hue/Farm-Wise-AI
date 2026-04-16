import 'package:farm_wise_ai/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/sizes.dart';
import '../../../l10n/app_localizations.dart';
import '../../breeding_dashboard/view/BreedingDashboard.dart';

import '../../cost_form/view/CostInputsScreen.dart';
import '../../herd_form/view/HerdStepperScreen.dart';
import '../../health_events/view/AddHealthEventScreen.dart';
import '../../ledger/view/AddLedgerEntryScreen.dart';
import '../../revenue_form/view/RevenueInputsScreen.dart';
import '../../vaccinations/view/AddVaccinationScreen.dart';
import '../../working_capital/view/WorkingCapitalScreen.dart';
import '../viewmodel/BottomNavViewModel.dart';

class QuickAddOption {
  final String Function(AppLocalizations l10n) label;
  final String Function(AppLocalizations l10n) subtitle;
  final IconData icon;
  final Color color;
   final Widget screen;

  const QuickAddOption({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.screen,
  });
}

String addAnimalLabel(AppLocalizations l10n) => l10n.registerAnimal;
String addToHerdLabel(AppLocalizations l10n) => l10n.addToHerd;
String addRevenueLabel(AppLocalizations l10n) => l10n.addRevenue;
String milkSalesLabel(AppLocalizations l10n) => l10n.milkSales;
String addCostsLabel(AppLocalizations l10n) => l10n.addCosts;
String feedVetLabel(AppLocalizations l10n) => l10n.feedVet;
String workingCapitalLabel(AppLocalizations l10n) => l10n.workingCapital;
String cashPayablesLabel(AppLocalizations l10n) => l10n.cashPayables;

String healthEventsLabel(AppLocalizations l10n) => 'Health Events';
String healthEventsSubtitle(AppLocalizations l10n) => 'Vet visits & treatments';
String vaccinationsLabel(AppLocalizations l10n) => 'Vaccinations';
String vaccinationsSubtitle(AppLocalizations l10n) => 'Record vaccines';
String financialLedgerLabel(AppLocalizations l10n) => 'Financial Ledger';
String financialLedgerSubtitle(AppLocalizations l10n) => 'Income & expense entry';

final options = <QuickAddOption>[
  QuickAddOption(
    label: addAnimalLabel,
    subtitle: addToHerdLabel,
    icon: Icons.pets_rounded,
    color: Color(0xFF384A24),
    screen: HerdStepperScreen(),
  ),
  QuickAddOption(
    label: healthEventsLabel,
    subtitle: healthEventsSubtitle,
    icon: Icons.health_and_safety_rounded,
    color: Color(0xFF2E7D32),
    screen: AddHealthEventScreen(),
  ),
  QuickAddOption(
    label: vaccinationsLabel,
    subtitle: vaccinationsSubtitle,
    icon: Icons.vaccines_rounded,
    color: Color(0xFF1565C0),
    screen: AddVaccinationScreen(),
  ),
  QuickAddOption(
    label: addRevenueLabel,
    subtitle: milkSalesLabel,
    icon: Icons.trending_up_rounded,
    color: Color(0xFF0F766E),
    screen: RevenueInputsScreen(),
  ),
  QuickAddOption(
    label: addCostsLabel,
    subtitle: feedVetLabel,
    icon: Icons.receipt_long_rounded,
    color: Color(0xFF7C3AED),
    screen: CostInputsScreen(),
  ),
  QuickAddOption(
    label: financialLedgerLabel,
    subtitle: financialLedgerSubtitle,
    icon: Icons.account_balance_wallet_rounded,
    color: Color(0xFFB45309),
    screen: AddLedgerEntryScreen(),
  ),
  QuickAddOption(
    label: workingCapitalLabel,
    subtitle: cashPayablesLabel,
    icon: Icons.account_balance_outlined,
    color: Color(0xFF6A1B9A),
    screen: WorkingCapitalScreen(),
  ),
];

class BottomNavigation extends ConsumerStatefulWidget {
  const BottomNavigation({super.key});

  @override
  ConsumerState<BottomNavigation> createState() => BottomNavigationState();
}

class BottomNavigationState extends ConsumerState<BottomNavigation>
    with SingleTickerProviderStateMixin {
  bool isMenuOpen = false;
  late AnimationController animController;
  late Animation<double> fadeAnim;
  late Animation<Offset> slideAnim;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    fadeAnim = CurvedAnimation(parent: animController, curve: Curves.easeOut);
    slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  void toggleMenu() {
    setState(() => isMenuOpen = !isMenuOpen);
    isMenuOpen ? animController.forward() : animController.reverse();
  }

  void closeMenu() {
    if (!isMenuOpen) return;
    setState(() => isMenuOpen = false);
    animController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(navIndexProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: UColors.lightGrey,
      body: Stack(
        children: [
          screens[selectedIndex],
          if (isMenuOpen)
            GestureDetector(
              onTap: closeMenu,
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),
          if (isMenuOpen)
            Positioned(
              bottom: 90,
              left: sizes.lg,
              right: sizes.lg,
              child: FadeTransition(
                opacity: fadeAnim,
                child: SlideTransition(
                  position: slideAnim,
                  child: Container(
                    padding: const EdgeInsets.all(sizes.md),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.18),
                          blurRadius: 28,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(sizes.xs),
                              decoration: BoxDecoration(
                                color: UColors.colorPrimary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(sizes.borderRadiusMd),
                              ),
                              child: const Icon(
                                Icons.add_rounded,
                                size: sizes.iconSm,
                                color: UColors.colorPrimary,
                              ),
                            ),
                            const SizedBox(width: sizes.sm),
                            Text(
                              l10n.quickAdd,
                              style: const TextStyle(
                                fontSize: sizes.fontSizeMd,
                                fontWeight: FontWeight.w800,
                                color: UColors.colorPrimary,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: closeMenu,
                              child: const Icon(
                                Icons.close_rounded,
                                size: sizes.iconSm,
                                color: UColors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: sizes.sm),
                        const Divider(height: 1, color: UColors.borderPrimary),
                        const SizedBox(height: sizes.sm),
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: sizes.sm,
                          mainAxisSpacing: sizes.sm,
                          childAspectRatio: 1.65,
                          children: options.map((opt) {
                            return GestureDetector(
                              onTap: () {
                                closeMenu();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => opt.screen),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: opt.color.withOpacity(0.07),
                                  borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
                                  border: Border.all(color: opt.color.withOpacity(0.2)),
                                ),
                                padding: const EdgeInsets.all(sizes.sm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(opt.icon, color: opt.color, size: sizes.iconMd),
                                    const SizedBox(height: sizes.xs),
                                    Text(
                                      opt.label(l10n),
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: opt.color,
                                      ),
                                    ),
                                    Text(
                                      opt.subtitle(l10n),
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: UColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: UColors.grey,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavItem(
                  icon: Icons.home_filled,
                  label: l10n.dashboard,
                  isActive: selectedIndex == 0,
                  onTap: () {
                    closeMenu();
                    ref.read(navIndexProvider.notifier).state = 0;
                  },
                ),
                NavItem(
                  assetIcon: 'lib/core/assets/icons/inventory.png',
                  label: l10n.inventory,
                  isActive: selectedIndex == 1,
                  onTap: () {
                    closeMenu();
                    ref.read(navIndexProvider.notifier).state = 1;
                  },
                ),
                const SizedBox(width: 60),
                NavItem(
                  assetIcon: 'lib/core/assets/icons/cash.png',
                  label: l10n.cash,
                  isActive: selectedIndex == 3,
                  onTap: () {
                    closeMenu();
                    ref.read(navIndexProvider.notifier).state = 3;
                  },
                ),
                NavItem(
                  assetIcon: 'lib/core/assets/icons/breeding.png',
                  label: l10n.breeding,
                  isActive: selectedIndex == 4,
                  onTap: () {
                    closeMenu();
                    ref.read(navIndexProvider.notifier).state = 4;
                  },
                ),
              ],
            ),
            Positioned(
              top: -40,
              child: Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  color: UColors.screenBackground,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: toggleMenu,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 65,
                      height: 65,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF384A24), Color(0xFF5CB85C)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: UColors.colorPrimary,
                            blurRadius: 15,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: AnimatedRotation(
                        turns: isMenuOpen ? 0.125 : 0,
                        duration: const Duration(milliseconds: 250),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData? icon;
  final String? assetIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavItem({
    this.icon,
    this.assetIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? UColors.colorPrimary : Colors.grey;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(icon, color: color)
          else
            Image.asset(assetIcon!, width: 24, height: 24, color: color),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: sizes.fontSizeVerySm,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

