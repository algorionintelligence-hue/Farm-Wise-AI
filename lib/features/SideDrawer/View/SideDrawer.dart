import 'package:farm_wise_ai/features/ai/view/AiQnaScreen.dart';
import 'package:farm_wise_ai/features/animal_profile/view/AnimalDirectoryScreen.dart';
import 'package:farm_wise_ai/features/auth/view/LoginScreen.dart';
import 'package:farm_wise_ai/features/asset_form/view/AssetInputsScreen.dart';
import 'package:farm_wise_ai/features/health_events/view/AddHealthEventScreen.dart';
import 'package:farm_wise_ai/features/inventory_form/view/InventoryInputsScreen.dart';
import 'package:farm_wise_ai/features/report_&_pdf_export/view/ReportPdfExportScreen.dart';
import 'package:farm_wise_ai/features/revenue_form/view/RevenueInputsScreen.dart';
import 'package:farm_wise_ai/features/vaccinations/view/AddVaccinationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../l10n/app_localizations.dart';
import '../../senario_simulator/view/SenarioSimulatorScreen.dart';

final selectedDrawerItemProvider = StateProvider<String?>((ref) => null);

class SideDrawer extends ConsumerWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(selectedDrawerItemProvider);
    final l10n = AppLocalizations.of(context)!;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      backgroundColor: UColors.white,
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: sizes.md),
              children: [
                _DrawerItem(
                  icon: const Icon(
                    Icons.list_alt_rounded,
                    size: sizes.iconMdLg,
                    color: UColors.colorPrimary,
                  ),
                  label: 'All Animals',
                  isSelected: selectedItem == 'All Animals',
                  onTap: () {
                    ref.read(selectedDrawerItemProvider.notifier).state = 'All Animals';
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AnimalDirectoryScreen(),
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: Image.asset(
                    'lib/core/assets/icons/scenario.png',
                    width: sizes.iconMdLg,
                    height: sizes.iconMdLg,
                  ),
                  label: l10n.scenarioSimulator,
                  isSelected: selectedItem == l10n.scenarioSimulator,
                  hasNotification: true,
                  onTap: () {
                    ref.read(selectedDrawerItemProvider.notifier).state = l10n.scenarioSimulator;
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScenarioSimulatorScreen(),
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: Image.asset(
                    'lib/core/assets/icons/chatbot.png',
                    width: sizes.iconMdLg,
                    height: sizes.iconMdLg,
                  ),
                  label: l10n.aiQaChat,
                  isSelected: selectedItem == l10n.aiQaChat,
                  hasNotification: true,
                  onTap: () {
                    ref.read(selectedDrawerItemProvider.notifier).state = l10n.aiQaChat;
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AiQnaScreen(),
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: Image.asset(
                    'lib/core/assets/icons/pdf.png',
                    width: sizes.iconMdLg,
                    height: sizes.iconMdLg,
                  ),
                  label: l10n.reportPdfExport,
                  isSelected: selectedItem == l10n.reportPdfExport,
                  onTap: () {
                    ref.read(selectedDrawerItemProvider.notifier).state = l10n.reportPdfExport;
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReportpdfExportscreen(),
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: const Icon(
                    Icons.health_and_safety_rounded,
                    size: sizes.iconMdLg,
                    color: UColors.colorPrimary,
                  ),
                  label: 'Health Events',
                  isSelected: selectedItem == 'Health Events',
                  onTap: () {
                    ref.read(selectedDrawerItemProvider.notifier).state = 'Health Events';
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddHealthEventScreen(),
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: const Icon(
                    Icons.vaccines_rounded,
                    size: sizes.iconMdLg,
                    color: UColors.colorPrimary,
                  ),
                  label: 'Vaccinations',
                  isSelected: selectedItem == 'Vaccinations',
                  onTap: () {
                    ref.read(selectedDrawerItemProvider.notifier).state = 'Vaccinations';
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddVaccinationScreen(),
                      ),
                    );
                  },
                ),

                _DrawerItem(
                  icon: const Icon(
                    Icons.precision_manufacturing_rounded,
                    size: sizes.iconMdLg,
                    color: UColors.colorPrimary,
                  ),
                  label: 'Farm Assets',
                  isSelected: selectedItem == 'Farm Assets',
                  onTap: () {
                    ref.read(selectedDrawerItemProvider.notifier).state = 'Farm Assets';
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AssetInputsScreen(),
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: Image.asset(
                    'lib/core/assets/icons/inventory.png',
                    width: sizes.iconMdLg,
                    height: sizes.iconMdLg,
                  ),
                  label: l10n.inventory,
                  isSelected: selectedItem == l10n.inventory,
                  onTap: () {
                    ref.read(selectedDrawerItemProvider.notifier).state = l10n.inventory;
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InventoryInputsScreen(),
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: Image.asset(
                    'lib/core/assets/icons/revenue.png',
                    width: sizes.iconMdLg,
                    height: sizes.iconMdLg,
                  ),
                  label: l10n.revenueInput,
                  isSelected: selectedItem == l10n.revenueInput,
                  onTap: () {
                    ref.read(selectedDrawerItemProvider.notifier).state = l10n.revenueInput;
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RevenueInputsScreen(),
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: Image.asset(
                    'lib/core/assets/icons/logout.png',
                    width: sizes.iconMdLg,
                    height: sizes.iconMdLg,
                  ),
                  label: l10n.logout,
                  isSelected: selectedItem == l10n.logout,
                  onTap: () {
                    ref.read(selectedDrawerItemProvider.notifier).state = l10n.logout;
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: sizes.homePrimaryHeaderHeight * 0.7,
      decoration: const BoxDecoration(
        color: UColors.colorPrimary,
        image: DecorationImage(
          image: NetworkImage('https://www.transparenttextures.com/patterns/cubes.png'),
          opacity: 0.2,
          repeat: ImageRepeat.repeat,
        ),
      ),
      padding: const EdgeInsets.only(left: sizes.lg, bottom: sizes.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(
              'lib/core/assets/images/logo_without_bg.png',
              fit: BoxFit.contain,
            ),
          ),
          const Text(
            'Ali Ahmed',
            style: TextStyle(
              color: UColors.textWhite,
              fontSize: sizes.fontSizeLg,
              fontWeight: FontWeight.bold,
            ),
          ),
          Builder(
            builder: (context) {
              return Text(
                AppLocalizations.of(context)!.farmProfile,
                style: TextStyle(
                  color: UColors.textWhite.withOpacity(0.8),
                  fontSize: sizes.fontSizeLg,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool isSelected;
  final bool hasNotification;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    this.hasNotification = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: sizes.sm, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? UColors.colorPrimaryLight : Colors.transparent,
        borderRadius: BorderRadius.circular(sizes.borderRadiusSm),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Stack(
          children: [
            icon,
            if (hasNotification)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: UColors.colorPrimary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isSelected ? UColors.colorPrimary : UColors.black,
            fontSize: sizes.fontSizeMd,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: sizes.lg),
        visualDensity: const VisualDensity(vertical: -2),
      ),
    );
  }
}
