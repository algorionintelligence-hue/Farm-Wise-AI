
import 'package:farm_wise_ai/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/Utils/sizes.dart';
import '../../cost_form/view/CostInputsScreen.dart';
import '../../herd_form/view/HerdStepperScreen.dart';
import '../../revenue_form/view/RevenueInputsScreen.dart';
import '../../working_capital/view/WorkingCapitalScreen.dart';
import '../viewmodel/BottomNavViewModel.dart';

// ── Options Data ──────────────────────────────
class _QuickAddOption {
  final String label;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget screen;

  const _QuickAddOption({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.screen,
  });
}

const _options = [
  _QuickAddOption(
    label: "Register Animal",
    subtitle: "Add to herd",
    icon: Icons.pets_rounded,
    color: Color(0xFF384A24),
    screen: HerdStepperScreen(),
  ),
  _QuickAddOption(
    label: "Add Revenue",
    subtitle: "Milk & sales",
    icon: Icons.trending_up_rounded,
    color: Color(0xFF2E7D32),
    screen: RevenueInputsScreen(),
  ),
  _QuickAddOption(
    label: "Add Costs",
    subtitle: "Feed & vet",
    icon: Icons.receipt_long_rounded,
    color: Color(0xFF1565C0),
    screen: CostInputsScreen(),
  ),
  _QuickAddOption(
    label: "Working Capital",
    subtitle: "Cash & payables",
    icon: Icons.account_balance_wallet_rounded,
    color: Color(0xFF6A1B9A),
    screen: WorkingCapitalScreen(),
  ),
];

// ═══════════════════════════════════════════════
// Bottom Navigation
// ═══════════════════════════════════════════════

class BottomNavigation extends ConsumerStatefulWidget {
  const BottomNavigation({super.key});

  @override
  ConsumerState<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends ConsumerState<BottomNavigation>
    with SingleTickerProviderStateMixin {
  bool _isMenuOpen = false;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _fadeAnim =
        CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() => _isMenuOpen = !_isMenuOpen);
    _isMenuOpen ? _animController.forward() : _animController.reverse();
  }

  void _closeMenu() {
    if (!_isMenuOpen) return;
    setState(() => _isMenuOpen = false);
    _animController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(navIndexProvider);

    return Scaffold(
      backgroundColor: UColors.lightGrey,
      body: Stack(
        children: [
          // ── Main Screen ──
          screens[selectedIndex],

          // ── Dim overlay ──
          if (_isMenuOpen)
            GestureDetector(
              onTap: _closeMenu,
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),

          // ── Animated Quick Add Panel ──
          if (_isMenuOpen)
            Positioned(
              bottom: 90,
              left: sizes.lg,
              right: sizes.lg,
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
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
                        // ── Header ──
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(sizes.xs),
                              decoration: BoxDecoration(
                                color: UColors.colorPrimary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(sizes.borderRadiusMd),
                              ),
                              child: const Icon(Icons.add_rounded,
                                  size: sizes.iconSm,
                                  color: UColors.colorPrimary),
                            ),
                            const SizedBox(width: sizes.sm),
                            const Text(
                              "Quick Add",
                              style: TextStyle(
                                fontSize: sizes.fontSizeMd,
                                fontWeight: FontWeight.w800,
                                color: UColors.colorPrimary,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: _closeMenu,
                              child: const Icon(Icons.close_rounded,
                                  size: sizes.iconSm,
                                  color: UColors.darkGrey),
                            ),
                          ],
                        ),

                        const SizedBox(height: sizes.sm),
                        const Divider(height: 1, color: UColors.borderPrimary),
                        const SizedBox(height: sizes.sm),

                        // ── 2x2 Grid ──
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: sizes.sm,
                          mainAxisSpacing: sizes.sm,
                          childAspectRatio: 1.65,
                          children: _options.map((opt) {
                            return GestureDetector(
                              onTap: () {
                                _closeMenu();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => opt.screen),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: opt.color.withOpacity(0.07),
                                  borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
                                  border: Border.all(
                                      color: opt.color.withOpacity(0.2)),
                                ),
                                padding: const EdgeInsets.all(sizes.sm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(opt.icon,
                                        color: opt.color,
                                        size: sizes.iconMd),
                                    const SizedBox(height: sizes.xs),
                                    Text(
                                      opt.label,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: opt.color,
                                      ),
                                    ),
                                    Text(
                                      opt.subtitle,
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

            // ── Nav Icons ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NavItem(
                  icon: Icons.home_filled,
                  label: "Dashboard",
                  isActive: selectedIndex == 0,
                  onTap: () {
                    _closeMenu();
                    ref.read(navIndexProvider.notifier).state = 0;
                  },
                ),
                _NavItem(
                  assetIcon: 'lib/core/assets/icons/inventory.png',
                  label: "Inventory",
                  isActive: selectedIndex == 1,
                  onTap: () {
                    _closeMenu();
                    ref.read(navIndexProvider.notifier).state = 1;
                  },
                ),
                const SizedBox(width: 60),
                _NavItem(
                  assetIcon: 'lib/core/assets/icons/cash.png',
                  label: "Cash",
                  isActive: selectedIndex == 3,
                  onTap: () {
                    _closeMenu();
                    ref.read(navIndexProvider.notifier).state = 3;
                  },
                ),
                _NavItem(
                  assetIcon: 'lib/core/assets/icons/breeding.png',
                  label: "Breeding",
                  isActive: selectedIndex == 4,
                  onTap: () {
                    _closeMenu();
                    ref.read(navIndexProvider.notifier).state = 4;
                  },
                ),
              ],
            ),

            // ── Center FAB ──
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
                    onTap: _toggleMenu,
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
                      // + rotates to X when open
                      child: AnimatedRotation(
                        turns: _isMenuOpen ? 0.125 : 0,
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

// ═══════════════════════════════════════════════
// Reusable Nav Item
// ═══════════════════════════════════════════════

class _NavItem extends StatelessWidget {
  final IconData? icon;
  final String? assetIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
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
