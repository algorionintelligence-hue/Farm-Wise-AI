import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/bg.dart';
import '../../../core/widgets/btn.dart';
import '../../herd/widgets/custom_input.dart';
import '../../herd/widgets/readonly4.dart';
import '../../herd/widgets/section_card.dart';


class WorkingCapitalScreen extends ConsumerStatefulWidget {
  const WorkingCapitalScreen({super.key});

  @override
  ConsumerState<WorkingCapitalScreen> createState() =>
      _WorkingCapitalScreenState();
}

class _WorkingCapitalScreenState
    extends ConsumerState<WorkingCapitalScreen> {
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

  // Net Working Capital = Cash + Receivables - Payables - Loan
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
    return AppScaffold(
      showBackButton: Navigator.canPop(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          const Text(
            "Working Capital",
            style: TextStyle(
              fontSize: sizes.fontSizeHeadings,
              fontWeight: FontWeight.bold,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.sm),
          const Text(
            "Track your farm's short-term financial position",
            style: TextStyle(
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
                  // ── Inputs ──
                  SectionCard(
                    icon: Icons.account_balance_wallet_rounded,
                    title: "Working Capital",
                    subtitle: "Starting position & short-term obligations",
                    children: [
                      CustomInput(
                        label: "Cash on Hand (Starting)",
                        controller: _cashOnHandCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                      ),
                      CustomInput(
                        label: "Receivables (Milk Buyers)",
                        controller: _receivablesMilkCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                      ),
                      CustomInput(
                        label: "Payables (Feed Supplier)",
                        controller: _payablesFeedCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                      ),
                      CustomInput(
                        label: "Loan Instalments, if any (expense only)",
                        controller: _loanInstalmentsCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                      ),
                    ],
                  ),

                  const SizedBox(height: sizes.spaceBtwItems),

                  // ── Info Note ──
                  Container(
                    padding: const EdgeInsets.all(sizes.md),
                    decoration: BoxDecoration(
                      color: UColors.colorPrimary.withOpacity(0.05),
                      borderRadius:
                      BorderRadius.circular(sizes.cardRadiusMd),
                      border: Border.all(
                        color: UColors.colorPrimary.withOpacity(0.2),
                      ),
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
                        const Expanded(
                          child: Text(
                            "Loan instalments are recorded as an expense only — this is not a lending feature.",
                            style: TextStyle(
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

                  // ── Net Working Capital Summary ──
                  SectionCard(
                    icon: Icons.summarize_rounded,
                    title: "Net Working Capital",
                    subtitle: "Cash + Receivables − Payables − Loan",
                    children: [
                      ReadOnlyField(
                        label: "Net Working Capital (auto)",
                        value: _netWorkingCapital,
                        icon: Icons.calculate_rounded,
                      ),
                    ],
                  ),

                  const SizedBox(height: sizes.spaceBtwSections),

                  PrimaryButton(
                    label: "Save Working Capital",
                    onPressed: () {
                      // TODO: save logic
                    },
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