import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../l10n/app_localizations.dart';
import '../../herd_form/widgets/ProductionStep.dart';

class ProductionEntryScreen extends StatelessWidget {
  const ProductionEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.productionStepTitle,
            style: const TextStyle(
              fontSize: sizes.fontSizeHeadings,

              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.sm),
          const Expanded(
            child: ProductionStep(),
          ),
        ],
      ),
    );
  }
}
