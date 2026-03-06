import 'package:farm_wise_ai/features/ai/view/AiQnaScreen.dart';
import 'package:farm_wise_ai/features/auth/view/LoginScreen.dart';
import 'package:farm_wise_ai/features/report_&_pdf_export/view/ReportPdfExportScreen.dart';
import 'package:farm_wise_ai/features/working_capital/view/WorkingCapitalScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../core/Utils/sizes.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/utils/Constants.dart';
import '../../senario_simulator/View/SenarioSimulatorScreen.dart';

// State Provider to track which drawer item is selected
final selectedDrawerItemProvider = StateProvider<String>((ref) => 'Lists');

class SideDrawer extends ConsumerWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(selectedDrawerItemProvider);

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      backgroundColor: UColors.white,
      child: Column(
        children: [
          // Header Section
          _buildHeader(),

          // Menu Items Section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: sizes.md),
              children: [
                 _DrawerItem(
                  icon: Icons.chat_bubble_outline,
                  label: Constants.SCENARIO_SIMULATOR,
                  isSelected: selectedItem == Constants.SCENARIO_SIMULATOR,
                  hasNotification: true,
                  onTap: () {
                    Navigator.pop(context); // close drawer

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScenarioSimulatorScreen(),
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: Icons.show_chart,
                  label: Constants.AI_QA_CHAT,
                  isSelected: selectedItem == Constants.AI_QA_CHAT,
                  hasNotification: true,
                  onTap: () {
                    Navigator.pop(context); // close drawer

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AiQnaScreen(),
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: Icons.list,
                  label: Constants.REPORT_PDF_EXPORT,
                  isSelected: selectedItem == Constants.REPORT_PDF_EXPORT,
                  onTap: () {
                    Navigator.pop(context); // close drawer

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReportpdfExportscreen(),
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: Icons.timeline,
                  label: Constants.WORKING_CAPITAL,
                  isSelected: selectedItem == Constants.WORKING_CAPITAL,
                  onTap: () {
                    Navigator.pop(context); // close drawer

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WorkingCapitalScreen(),
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: Icons.exit_to_app,
                  label: Constants.LOGOUT,
                  isSelected: selectedItem == Constants.LOGOUT,
                  onTap: () {
                    Navigator.pop(context); // close drawer

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  LoginScreen(),
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
      height: sizes.homePrimaryHeaderHeight * 0.7, // Adjusting based on your size class
      decoration: const BoxDecoration(
        color: UColors.colorPrimary, // Matching the purple in your image
        image: DecorationImage(
          image: NetworkImage('https://www.transparenttextures.com/patterns/cubes.png'), // Subtle geometric pattern
          opacity: 0.2,
          repeat: ImageRepeat.repeat,
        ),
      ),
      padding: const EdgeInsets.only(left: sizes.lg, bottom: sizes.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: UColors.white,
            child: CircleAvatar(
              radius: 37,
              backgroundImage: NetworkImage('https://i.imgur.com/8Km9tLL.png'), // Placeholder for user image
            ),
          ),
          const SizedBox(height: sizes.sm),
          const Text(
            'Mubashira',
            style: TextStyle(
              color: UColors.textWhite,
              fontSize: sizes.fontSizeLg,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Text(
                'Rendom Farm',
                style: TextStyle(
                  color: UColors.textWhite.withOpacity(0.8),
                  fontSize: sizes.fontSizeLg,
                ),
              ),
              // const SizedBox(width: sizes.xs),
              // Icon(Icons.people, color: UColors.textWhite.withOpacity(0.8), size: sizes.iconXs),
            ],
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
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
        color: isSelected ? UColors.colorPrimaryLight : Colors.transparent, // Light purple bg for selected
        borderRadius: BorderRadius.circular(sizes.borderRadiusSm),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Stack(
          children: [
            Icon(
              icon,
              color: isSelected ?  UColors.colorPrimary : UColors.darkGrey,
              size: sizes.iconMd,
            ),
            if (hasNotification)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(color: UColors.colorPrimary, shape: BoxShape.circle),
                ),
              ),
          ],
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isSelected ?  UColors.colorPrimary : UColors.black,
            fontSize: sizes.fontSizeMd,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: sizes.lg),
        visualDensity: const VisualDensity(vertical: -2), // Makes the list more compact
      ),
    );
  }
}