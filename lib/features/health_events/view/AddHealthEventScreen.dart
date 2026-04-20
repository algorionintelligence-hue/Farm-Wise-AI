import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../herd_form/widgets/CustomInput.dart';
import '../../herd_form/widgets/DatePickerTile.dart';
import '../model/health_event_record.dart';
import '../viewmodel/health_event_store.dart';

class AddHealthEventScreen extends ConsumerStatefulWidget {
  const AddHealthEventScreen({
    super.key,
    this.initialAnimalRef,
    this.nextScreenBuilder,
  });

  final String? initialAnimalRef;
  final WidgetBuilder? nextScreenBuilder;

  @override
  ConsumerState<AddHealthEventScreen> createState() => _AddHealthEventScreenState();
}

class _AddHealthEventScreenState extends ConsumerState<AddHealthEventScreen> {
  final _animalCtrl = TextEditingController();
  final _diagnosisCtrl = TextEditingController();
  final _vetNameCtrl = TextEditingController();
  final _vetFeeCtrl = TextEditingController(text: '0');
  final _medicineCostCtrl = TextEditingController(text: '0');
  final _notesCtrl = TextEditingController();

  DateTime? _eventDate;
  String? _eventType;

  @override
  void initState() {
    super.initState();
    if (widget.initialAnimalRef != null && widget.initialAnimalRef!.isNotEmpty) {
      _animalCtrl.text = widget.initialAnimalRef!;
    }
  }

  @override
  void dispose() {
    _animalCtrl.dispose();
    _diagnosisCtrl.dispose();
    _vetNameCtrl.dispose();
    _vetFeeCtrl.dispose();
    _medicineCostCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  double get _totalCost {
    final vet = double.tryParse(_vetFeeCtrl.text) ?? 0;
    final med = double.tryParse(_medicineCostCtrl.text) ?? 0;
    return vet + med;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldBgBasic(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Health Event',
            style: TextStyle(
              fontSize: sizes.fontSizeHeadings,
              fontWeight: FontWeight.bold,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Log vet visit, illness or treatment',
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
                  DatePickerTile(
                    icon: Icons.calendar_today_rounded,
                    label: 'Event date *',
                    selectedDate: _eventDate,
                    onPicked: (d) => setState(() => _eventDate = d),
                  ),
                  _SelectTile(
                    label: 'Event type *',
                    value: _eventType,
                    placeholder: 'Select',
                    onTap: () async {
                      final picked = await _pickFromSheet(
                        context,
                        title: 'Event type',
                        options: const [
                          'Vet visit',
                          'Illness',
                          'Treatment',
                          'Injury',
                          'Other',
                        ],
                      );
                      if (picked != null) setState(() => _eventType = picked);
                    },
                  ),
                  CustomInput(
                    label: 'Diagnosis',
                    hintText: 'e.g. Mastitis, Foot rot...',
                    controller: _diagnosisCtrl,
                  ),
                  CustomInput(
                    label: 'Vet name',
                    hintText: 'Doctor / clinic name',
                    controller: _vetNameCtrl,
                  ),
                  const SizedBox(height: sizes.xs),
                  const _CostLabel('Costs (PKR)'),
                  const SizedBox(height: sizes.xs),
                  Row(
                    children: [
                      Expanded(
                        child: CustomInput(
                          label: 'Vet fee',
                          controller: _vetFeeCtrl,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      const SizedBox(width: sizes.sm),
                      Expanded(
                        child: CustomInput(
                          label: 'Medicine cost',
                          controller: _medicineCostCtrl,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                    ],
                  ),
                  _TotalBar(
                    label: 'Total cost',
                    value: 'PKR ${_totalCost.toStringAsFixed(0)}',
                  ),
                  _NotesField(
                    label: 'Notes',
                    hintText: 'Treatment details, follow-up instructions...',
                    controller: _notesCtrl,
                  ),
                  const SizedBox(height: sizes.spaceBtwSections),
                  PrimaryButton(
                    label: 'Save health event',
                    onPressed: () async {
                      final animalRef = _animalCtrl.text.trim();
                      if (animalRef.isEmpty) {
                        _showMessage('Please enter animal tag or ID.');
                        return;
                      }
                      if (_eventDate == null) {
                        _showMessage('Please select event date.');
                        return;
                      }
                      if (_eventType == null || _eventType!.trim().isEmpty) {
                        _showMessage('Please select event type.');
                        return;
                      }

                      final record = HealthEventRecord(
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                        animalRef: animalRef,
                        eventDate: _eventDate!,
                        eventType: _eventType!.trim(),
                        diagnosis: _diagnosisCtrl.text.trim(),
                        vetName: _vetNameCtrl.text.trim(),
                        vetFee: double.tryParse(_vetFeeCtrl.text.trim()) ?? 0,
                        medicineCost:
                            double.tryParse(_medicineCostCtrl.text.trim()) ?? 0,
                        notes: _notesCtrl.text.trim(),
                      );

                      await ref.read(healthEventStoreProvider.notifier).add(record);
                      if (!context.mounted) return;
                      if (widget.nextScreenBuilder != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: widget.nextScreenBuilder!),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Health event saved.'),
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Health event saved offline.'),
                          ),
                        );
                      }
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

class _CostLabel extends StatelessWidget {
  final String text;
  const _CostLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: UColors.error,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: sizes.fontSizeSm,
            fontWeight: FontWeight.w800,
            color: UColors.colorPrimary,
          ),
        ),
      ],
    );
  }
}

class _TotalBar extends StatelessWidget {
  final String label;
  final String value;

  const _TotalBar({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: sizes.sm),
      padding: const EdgeInsets.symmetric(horizontal: sizes.md, vertical: sizes.sm),
      decoration: BoxDecoration(
        color: UColors.inputBg,
        borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
        border: Border.all(color: UColors.borderPrimary),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: sizes.fontSizeSm,
              fontWeight: FontWeight.w700,
              color: UColors.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: sizes.fontSizeSm,
              fontWeight: FontWeight.w800,
              color: UColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotesField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;

  const _NotesField({
    required this.label,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          maxLines: 4,
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

class _SelectTile extends StatelessWidget {
  final String label;
  final String? value;
  final String placeholder;
  final VoidCallback onTap;

  const _SelectTile({
    required this.label,
    required this.value,
    required this.placeholder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null && value!.trim().isNotEmpty;

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
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: sizes.md),
              decoration: BoxDecoration(
                color: hasValue ? UColors.colorPrimary.withOpacity(0.06) : UColors.inputBg,
                borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                border: Border.all(
                  color: hasValue ? UColors.colorPrimary : UColors.borderPrimary,
                  width: hasValue ? 1.5 : 1.0,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      hasValue ? value! : placeholder,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: sizes.fontSizeSm,
                        color: hasValue ? UColors.textPrimary : UColors.darkGrey,
                        fontWeight: hasValue ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                  Icon(
                    hasValue ? Icons.check_circle_rounded : Icons.keyboard_arrow_down_rounded,
                    color: hasValue ? UColors.colorPrimary : UColors.darkGrey,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<String?> _pickFromSheet(
  BuildContext context, {
  required String title,
  required List<String> options,
}) {
  return showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    backgroundColor: Colors.white,
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(sizes.md, sizes.sm, sizes.md, sizes.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: sizes.fontSizeMd,
                  fontWeight: FontWeight.w800,
                  color: UColors.colorPrimary,
                ),
              ),
              const SizedBox(height: sizes.sm),
              ...options.map(
                (opt) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(opt, style: const TextStyle(fontWeight: FontWeight.w600)),
                  onTap: () => Navigator.pop(context, opt),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

