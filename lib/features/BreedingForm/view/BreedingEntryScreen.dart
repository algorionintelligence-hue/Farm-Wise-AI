import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../../l10n/AppLocalizations.dart';
import '../../HerdForm/viewmodel/herd_viewmodel.dart';
import '../../HerdForm/widgets/CustomInput.dart';
import '../../HerdForm/widgets/DatePickerTile.dart';
import '../../HerdForm/widgets/FormDropdownField.dart';
import '../../HerdForm/widgets/SectionCard.dart';
import '../../HerdStore/HerdStore.dart';
import '../../ProductionForm/view/ProductionEntryScreen.dart';


class BreedingEntryScreen extends ConsumerStatefulWidget {
  const BreedingEntryScreen({
    super.key,
    this.continueToProduction = false,
  });

  final bool continueToProduction;

  @override
  ConsumerState<BreedingEntryScreen> createState() => _BreedingEntryScreenState();
}

class _BreedingEntryScreenState extends ConsumerState<BreedingEntryScreen> {
  final _aiServiceCostController = TextEditingController(text: '0');
  final _bullFeeController = TextEditingController(text: '0');
  final _pdFeeController = TextEditingController(text: '0');

  String? _serviceType;
  DateTime? _serviceDate;
  DateTime? _pdDate;
  bool? _pdPositive;
  int _repeatCount = 1;

  DateTime? get _expectedCalvingDate =>
      _serviceDate == null ? null : _serviceDate!.add(const Duration(days: 280));

  int get _expectedCalves {
    if (_pdPositive == true) return 1;
    return 0;
  }

  @override
  void dispose() {
    _aiServiceCostController.dispose();
    _bullFeeController.dispose();
    _pdFeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vm = ref.watch(herdProvider.notifier);

    _serviceDate ??= vm.serviceDate;
    _pdDate ??= vm.pdDate;

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.addBreeding,
              style: const TextStyle(
                fontSize: sizes.fontSizeHeadings,
                fontWeight: FontWeight.bold,
                color: UColors.colorPrimary,
              ),
            ),
            const SizedBox(height: sizes.sm),
            Text(
              l10n.breedingDatesSubtitle,
              style: const TextStyle(
                fontSize: sizes.fontSizeSm,
                color: UColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: sizes.defaultSpace),
            SectionCard(
              icon: Icons.favorite_rounded,
              title: l10n.breedingDatesTitle,
              subtitle: l10n.breedingDatesSubtitle,
              children: [
                // Removed Mother Picker as per requirement
                FormDropdownField(
                  label: l10n.serviceType,
                  hint: 'Select service type',
                  value: _serviceType,
                  items: const ['Ai', 'natural', 'ivf'],
                  itemLabels: const ['AI / Service', 'Natural Service', 'IVF'],
                  onChanged: (value) {
                    setState(() {
                      _serviceType = value;
                    });
                  },
                ),
                DatePickerTile(
                  icon: Icons.event_available_rounded,
                  label: l10n.serviceDate,
                  selectedDate: _serviceDate,
                  onPicked: (date) {
                    setState(() {
                      _serviceDate = date;
                    });
                  },
                ),
                DatePickerTile(
                  icon: Icons.medical_services_rounded,
                  label: l10n.pdDate,
                  selectedDate: _pdDate,
                  onPicked: (date) {
                    setState(() {
                      _pdDate = date;
                    });
                  },
                ),
                const SizedBox(height: sizes.xs),
                const Text(
                  'PD Result',
                  style: TextStyle(
                    fontSize: sizes.fontSizeSm,
                    fontWeight: FontWeight.w800,
                    color: UColors.colorPrimary,
                  ),
                ),
                const SizedBox(height: sizes.xs),
                Row(
                  children: [
                    Expanded(
                      child: _ResultChip(
                        label: '+ve',
                        selected: _pdPositive == true,
                        onTap: () {
                          setState(() {
                            _pdPositive = true;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: sizes.sm),
                    Expanded(
                      child: _ResultChip(
                        label: '-ve',
                        selected: _pdPositive == false,
                        onTap: () {
                          setState(() {
                            _pdPositive = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: sizes.md),
                _ExpectedCalvesCard(
                  value: _expectedCalves,
                  helperText: _pdPositive == null
                      ? 'Set PD result to calculate'
                      : 'Auto-calculated from PD result',
                ),
                const SizedBox(height: sizes.md),
                const Divider(height: 1, color: UColors.borderPrimary),
                const SizedBox(height: sizes.md),
                const Text(
                  'Costs (PKR)',
                  style: TextStyle(
                    fontSize: sizes.fontSizeSm,
                    fontWeight: FontWeight.w800,
                    color: UColors.colorPrimary,
                  ),
                ),
                const SizedBox(height: sizes.sm),
                Row(
                  children: [
                    Expanded(
                      child: CustomInput(
                        label: 'AI / Service',
                        controller: _aiServiceCostController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: sizes.sm),
                    Expanded(
                      child: CustomInput(
                        label: 'Bull Fee',
                        controller: _bullFeeController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: sizes.sm),
                    Expanded(
                      child: CustomInput(
                        label: 'PD Fee',
                        controller: _pdFeeController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: sizes.xs),
                const Text(
                  'Repeat Count (services given)',
                  style: TextStyle(
                    fontSize: sizes.fontSizeSm,
                    fontWeight: FontWeight.w800,
                    color: UColors.colorPrimary,
                  ),
                ),
                const SizedBox(height: sizes.sm),
                Row(
                  children: [
                    _CounterButton(
                      icon: Icons.remove,
                      onTap: _repeatCount > 1
                          ? () {
                              setState(() {
                                _repeatCount -= 1;
                              });
                            }
                          : null,
                    ),
                    Container(
                      width: 52,
                      alignment: Alignment.center,
                      child: Text(
                        '$_repeatCount',
                        style: const TextStyle(
                          fontSize: sizes.fontSizeLg,
                          fontWeight: FontWeight.w800,
                          color: UColors.textPrimary,
                        ),
                      ),
                    ),
                    _CounterButton(
                      icon: Icons.add,
                      onTap: () {
                        setState(() {
                          _repeatCount += 1;
                        });
                      },
                    ),
                    const SizedBox(width: sizes.xs),
                    const Text(
                      'times',
                      style: TextStyle(
                        fontSize: sizes.fontSizeSm,
                        color: UColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: sizes.md),
                _ReadOnlyDateCard(
                  label: 'Expected Calving Date',
                  date: _expectedCalvingDate,
                  helperText: _serviceDate == null
                      ? 'Auto from service date + 280d'
                      : 'Auto-calculated from service date + 280d',
                ),
              ],
            ),
            const SizedBox(height: sizes.spaceBtwSections),
            PrimaryButton(
              label:
                  widget.continueToProduction ? l10n.continueButton : l10n.save,
              onPressed: () async {
                if (_serviceType == null || _serviceType!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select service type.'),
                    ),
                  );
                  return;
                }
                if (_serviceDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select service date.'),
                    ),
                  );
                  return;
                }

                vm.serviceDate = _serviceDate;
                vm.pdDate = _pdDate;
                vm.calvingDate = _expectedCalvingDate;
                vm.refreshDates();
                vm.save();
                await ref.read(herdStoreProvider.notifier).upsert(vm.state);
                if (!context.mounted) return;

                if (widget.continueToProduction) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProductionEntryScreen(),
                    ),
                  );
                  return;
                }

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.animalRegisteredSuccess)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpectedCalvesCard extends StatelessWidget {
  const _ExpectedCalvesCard({
    required this.value,
    required this.helperText,
  });

  final int value;
  final String helperText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(sizes.md),
      decoration: BoxDecoration(
        color: UColors.colorPrimary,
        borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(sizes.sm),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(sizes.borderRadiusMd),
            ),
            child: const Icon(
              Icons.pets_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: sizes.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Expected Calves',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: sizes.fontSizeHeadings,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Text(
                helperText,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReadOnlyDateCard extends StatelessWidget {
  const _ReadOnlyDateCard({
    required this.label,
    required this.date,
    required this.helperText,
  });

  final String label;
  final DateTime? date;
  final String helperText;

  @override
  Widget build(BuildContext context) {
    final dateText = date == null
        ? helperText
        : '${date!.day}/${date!.month}/${date!.year}';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: sizes.md,
        vertical: sizes.md,
      ),
      decoration: BoxDecoration(
        color: UColors.inputBg,
        borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
        border: Border.all(color: UColors.borderPrimary),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: sizes.fontSizeSm,
                    fontWeight: FontWeight.w800,
                    color: UColors.colorPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date == null ? helperText : dateText,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                        date == null ? FontWeight.normal : FontWeight.w600,
                    color:
                        date == null ? UColors.darkGrey : UColors.colorPrimary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            date == null
                ? Icons.calendar_today_rounded
                : Icons.check_circle_rounded,
            size: 18,
            color: date == null ? UColors.darkGrey : UColors.colorPrimary,
          ),
        ],
      ),
    );
  }
}

class _ResultChip extends StatelessWidget {
  const _ResultChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(sizes.buttonRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? UColors.colorPrimaryLight : Colors.white,
          borderRadius: BorderRadius.circular(sizes.buttonRadius),
          border: Border.all(
            color: selected ? UColors.plantaGreen : UColors.borderPrimary,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: sizes.fontSizeSm,
            fontWeight: FontWeight.w700,
            color: selected ? UColors.colorPrimary : UColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  const _CounterButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: onTap == null ? UColors.grey : UColors.light,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: UColors.borderPrimary),
        ),
        child: Icon(
          icon,
          size: sizes.iconSm,
          color: onTap == null ? UColors.darkGrey : UColors.colorPrimary,
        ),
      ),
    );
  }
}
