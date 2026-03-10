import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../utils/sizes.dart';
import '../themes/app_colors.dart';
import 'language_switcher.dart';

class CustomHeaderRowDashboard extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const CustomHeaderRowDashboard({super.key, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      color: UColors.colorPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: sizes.md),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 28),
            onPressed: () {
              scaffoldKey?.currentState?.openDrawer();
            },
          ),
          Expanded(
            child: Text(
              l10n.appName,
              style: const TextStyle(
                color: UColors.white,
                fontSize: sizes.fontSizeHeadings,
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: sizes.sm),
          const LanguageSwitcher(compact: true),
        ],
      ),
    );
  }
}
