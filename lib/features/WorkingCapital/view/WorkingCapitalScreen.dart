import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../../l10n/AppLocalizations.dart';
import '../../HerdForm/widgets/CustomInput.dart';
import '../../HerdForm/widgets/ReadOnlyField.dart';
import '../../HerdForm/widgets/SectionCard.dart';


class WorkingCapitalScreen extends ConsumerStatefulWidget {
  const WorkingCapitalScreen({super.key});

  @override
  ConsumerState<WorkingCapitalScreen> createState() => _WorkingCapitalScreenState();
}

class _WorkingCapitalScreenState extends ConsumerState<WorkingCapitalScreen> {
  final _cashOnHandCtrl = TextEditingController();
  final _receivablesMilkCtrl = TextEditingController();
  final _payablesFeedCtrl = TextEditingController();
  final _loanInstalmentsCtrl = TextEditingController();

  @override
  void dispose() {
    _cashOnHandCtrl.dispose();
    _receivablesMilkCtrl.dispose();
    _payablesFeedCtrl.dispose();
    _loanInstalmentsCtrl.dispose();
    super.dispose();
  }

  String get _netWorkingCapital {
    final cash = double.tryParse(_cashOnHandCtrl.text) ?? 0;
    final receivables = double.tryParse(_receivablesMilkCtrl.text) ?? 0;
    final payables = double.tryParse(_payablesFeedCtrl.text) ?? 0;
    final loan = double.tryParse(_loanInstalmentsCtrl.text) ?? 0;
    final net = cash + receivables - payables - loan;
    return net.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.workingCapital,
            style: const TextStyle(
              fontSize: sizes.fontSizeHeadings,
              fontWeight: FontWeight.bold,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.sm),
          Text(
            l10n.workingCapitalSubtitle,
            style: const TextStyle(
              fontSize: sizes.fontSizeSm,
              color: UColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: sizes.defaultSpace),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionCard(
                    icon: Icons.account_balance_wallet_rounded,
                    title: l10n.workingCapital,
                    subtitle: l10n.workingCapitalSectionSubtitle,
                    children: [
                      CustomInput(
                        label: l10n.cashOnHandStarting,
                        controller: _cashOnHandCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                      ),
                      CustomInput(
                        label: l10n.receivablesMilkBuyers,
                        controller: _receivablesMilkCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                      ),
                      CustomInput(
                        label: l10n.payablesFeedSupplier,
                        controller: _payablesFeedCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                      ),
                      CustomInput(
                        label: l10n.loanInstalmentsExpenseOnly,
                        controller: _loanInstalmentsCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                      ),
                    ],
                  ),
                  const SizedBox(height: sizes.spaceBtwItems),
                  Container(
                    padding: const EdgeInsets.all(sizes.md),
                    decoration: BoxDecoration(
                      color: UColors.colorPrimary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
                      border: Border.all(color: UColors.colorPrimary.withOpacity(0.2)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: sizes.iconSm,
                          color: UColors.colorPrimary.withOpacity(0.7),
                        ),
                        const SizedBox(width: sizes.sm),
                        Expanded(
                          child: Text(
                            l10n.loanInfoNote,
                            style: const TextStyle(
                              fontSize: 12,
                              color: UColors.textSecondary,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: sizes.spaceBtwItems),
                  SectionCard(
                    icon: Icons.summarize_rounded,
                    title: l10n.netWorkingCapital,
                    subtitle: l10n.netWorkingCapitalFormula,
                    children: [
                      ReadOnlyField(
                        label: l10n.netWorkingCapitalAuto,
                        value: _netWorkingCapital,
                        icon: Icons.calculate_rounded,
                      ),
                    ],
                  ),
                  const SizedBox(height: sizes.spaceBtwSections),
                  PrimaryButton(
                    label: l10n.saveWorkingCapital,
                    onPressed: () {},
                  ),
                  const SizedBox(height: sizes.defaultSpace),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
