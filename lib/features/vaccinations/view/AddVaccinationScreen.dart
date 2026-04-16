import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../herd_form/widgets/DatePickerTile.dart';
import '../model/vaccination_record.dart';
import '../viewmodel/vaccination_store.dart';

class AddVaccinationScreen extends ConsumerStatefulWidget {
  const AddVaccinationScreen({super.key});

  @override
  ConsumerState<AddVaccinationScreen> createState() => _AddVaccinationScreenState();
}

class _AddVaccinationScreenState extends ConsumerState<AddVaccinationScreen> {
  final _animalCtrl = TextEditingController();
  final _vaccineNameCtrl = TextEditingController();
  final _costCtrl = TextEditingController(text: '0');
  final _batchCtrl = TextEditingController();

  DateTime? _dateGiven;
  DateTime? _nextDueDate;

  @override
  void dispose() {
    _animalCtrl.dispose();
    _vaccineNameCtrl.dispose();
    _costCtrl.dispose();
    _batchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasDue = _nextDueDate != null;
    return AppScaffoldBgBasic(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Vaccination',
            style: TextStyle(
              fontSize: sizes.fontSizeHeadings,
              fontWeight: FontWeight.bold,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Record vaccine given to animal',
            style: TextStyle(fontSize: sizes.fontSizeSm, color: UColors.textSecondary),
          ),
          const SizedBox(height: sizes.defaultSpace),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SearchInput(
                    label: 'Animal *',
                    hintText: 'Search by tag number',
                    controller: _animalCtrl,
                    suffixIcon: Icons.search_rounded,
                  ),
                  _TextInput(
                    label: 'Vaccine name *',
                    hintText: 'e.g. FMD, LSD, Black Quarter...',
                    controller: _vaccineNameCtrl,
                  ),
                  DatePickerTile(
                    icon: Icons.calendar_today_rounded,
                    label: 'Date given *',
                    selectedDate: _dateGiven,
                    onPicked: (d) => setState(() => _dateGiven = d),
                  ),
                  DatePickerTile(
                    icon: Icons.calendar_today_rounded,
                    label: 'Next due date',
                    selectedDate: _nextDueDate,
                    onPicked: (d) => setState(() => _nextDueDate = d),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: sizes.sm),
                    padding: const EdgeInsets.symmetric(horizontal: sizes.md, vertical: 10),
                    decoration: BoxDecoration(
                      color: hasDue ? UColors.colorPrimary.withOpacity(0.08) : UColors.inputBg,
                      borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
                      border: Border.all(
                        color: hasDue ? UColors.colorPrimary : UColors.borderPrimary,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'Next due reminder',
                          style: TextStyle(
                            fontSize: sizes.fontSizeSm,
                            fontWeight: FontWeight.w800,
                            color: UColors.colorPrimary,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          hasDue ? '— reminder set' : '— select dates first',
                          style: TextStyle(
                            fontSize: sizes.fontSizeSm,
                            color: hasDue ? UColors.colorPrimary : UColors.darkGrey,
                            fontWeight: hasDue ? FontWeight.w700 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _TextInput(
                          label: 'Cost (PKR)',
                          hintText: '0',
                          controller: _costCtrl,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        ),
                      ),
                      const SizedBox(width: sizes.sm),
                      Expanded(
                        child: _TextInput(
                          label: 'Batch number',
                          hintText: 'e.g. BN-2024-01',
                          controller: _batchCtrl,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: sizes.spaceBtwSections),
                  PrimaryButton(
                    label: 'Save vaccination',
                    onPressed: () async {
                      final animalRef = _animalCtrl.text.trim();
                      if (animalRef.isEmpty) {
                        _showMessage('Please enter animal tag or ID.');
                        return;
                      }
                      if (_vaccineNameCtrl.text.trim().isEmpty) {
                        _showMessage('Please enter vaccine name.');
                        return;
                      }
                      if (_dateGiven == null) {
                        _showMessage('Please select date given.');
                        return;
                      }

                      final record = VaccinationRecord(
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                        animalRef: animalRef,
                        vaccineName: _vaccineNameCtrl.text.trim(),
                        dateGiven: _dateGiven!,
                        nextDueDate: _nextDueDate,
                        cost: double.tryParse(_costCtrl.text.trim()) ?? 0,
                        batchNumber: _batchCtrl.text.trim(),
                      );

                      await ref.read(vaccinationStoreProvider.notifier).add(record);
                      if (!context.mounted) return;
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Vaccination saved offline.'),
                        ),
                      );
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

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _SearchInput extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final IconData suffixIcon;

  const _SearchInput({
    required this.label,
    required this.hintText,
    required this.controller,
    required this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: sizes.sm),
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
          const SizedBox(height: sizes.xs),
          TextField(
            controller: controller,
            style: const TextStyle(fontSize: sizes.fontSizeSm, color: UColors.textPrimary),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: sizes.fontSizeSm, color: UColors.darkGrey),
              filled: true,
              fillColor: UColors.inputBg,
              contentPadding: const EdgeInsets.symmetric(horizontal: sizes.md, vertical: sizes.md),
              suffixIcon: Icon(suffixIcon, color: UColors.darkGrey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                borderSide: const BorderSide(color: UColors.borderPrimary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                borderSide: const BorderSide(color: UColors.borderPrimary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                borderSide: const BorderSide(color: UColors.colorPrimary, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const _TextInput({
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: sizes.sm),
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
          const SizedBox(height: sizes.xs),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: sizes.fontSizeSm, color: UColors.textPrimary),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: sizes.fontSizeSm, color: UColors.darkGrey),
              filled: true,
              fillColor: UColors.inputBg,
              contentPadding: const EdgeInsets.symmetric(horizontal: sizes.md, vertical: sizes.md),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                borderSide: const BorderSide(color: UColors.borderPrimary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                borderSide: const BorderSide(color: UColors.borderPrimary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                borderSide: const BorderSide(color: UColors.colorPrimary, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

