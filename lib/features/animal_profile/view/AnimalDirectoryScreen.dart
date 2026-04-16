import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../herd_form/model/herd.dart';
import '../../herd_form/viewmodel/herd_viewmodel.dart';
import '../../herd_store/herd_store.dart';
import '../../health_events/viewmodel/health_event_store.dart';
import '../../vaccinations/viewmodel/vaccination_store.dart';

enum AnimalProfileSection {
  health,
  vaccinations,
  breeding,
  milk,
}

class AnimalDirectoryScreen extends ConsumerWidget {
  const AnimalDirectoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readyState = ref.watch(herdStoreReadyProvider);
    final animals = ref.watch(herdStoreProvider);
    final sortedAnimals = [...animals]
      ..sort((a, b) => _animalTitle(a).compareTo(_animalTitle(b)));

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'All Animals',
            style: TextStyle(
              fontSize: sizes.fontSizeHeadings,
              fontWeight: FontWeight.bold,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.sm),
          const Text(
            'Select an animal to open its profile home and related records.',
            style: TextStyle(
              fontSize: sizes.fontSizeSm,
              color: UColors.textSecondary,
            ),
          ),
          const SizedBox(height: sizes.defaultSpace),
          Expanded(
            child: readyState.when(
              data: (_) => sortedAnimals.isEmpty
                  ? const _EmptyAnimalsState()
                  : ListView.separated(
                      itemCount: sortedAnimals.length,
                      separatorBuilder: (_, __) => const SizedBox(height: sizes.sm),
                      itemBuilder: (context, index) {
                        final animal = sortedAnimals[index];
                        return _AnimalTile(
                          animal: animal,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AnimalProfileHomeScreen(
                                  animal: animal,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
              loading: () => const _LoadingAnimalsState(),
              error: (_, __) => const _LoadErrorState(),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimalProfileHomeScreen extends StatefulWidget {
  const AnimalProfileHomeScreen({
    super.key,
    required this.animal,
  });

  final HerdInputModel animal;

  @override
  State<AnimalProfileHomeScreen> createState() => _AnimalProfileHomeScreenState();
}

class _AnimalProfileHomeScreenState extends State<AnimalProfileHomeScreen> {
  AnimalProfileSection selectedSection = AnimalProfileSection.health;

  bool get _showBreedingButton =>
      widget.animal.gender == GenderKey.female &&
      <String?>{
        StageKey.heifer,
        StageKey.open,
        StageKey.dry,
        StageKey.pregnant,
        StageKey.lactating,
      }.contains(widget.animal.stage);

  bool get _showMilkButton => widget.animal.stage == StageKey.lactating;

  @override
  Widget build(BuildContext context) {
    final animal = widget.animal;

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _animalTitle(animal),
            style: const TextStyle(
              fontSize: sizes.fontSizeHeadings,
              fontWeight: FontWeight.bold,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.sm),
          Text(
            'Animal Profile Home',
            style: TextStyle(
              fontSize: sizes.fontSizeMd,
              fontWeight: FontWeight.w700,
              color: UColors.colorPrimary.withOpacity(0.85),
            ),
          ),
          const SizedBox(height: sizes.md),
          _ProfileSummaryCard(animal: animal),
          const SizedBox(height: sizes.defaultSpace),
          Wrap(
            spacing: sizes.sm,
            runSpacing: sizes.sm,
            children: [
              _ActionButton(
                label: 'Health History',
                icon: Icons.health_and_safety_rounded,
                isActive: selectedSection == AnimalProfileSection.health,
                onTap: () => setState(
                  () => selectedSection = AnimalProfileSection.health,
                ),
              ),
              _ActionButton(
                label: 'Vaccination Schedule',
                icon: Icons.vaccines_rounded,
                isActive: selectedSection == AnimalProfileSection.vaccinations,
                onTap: () => setState(
                  () => selectedSection = AnimalProfileSection.vaccinations,
                ),
              ),
              if (_showBreedingButton)
                _ActionButton(
                  label: 'Breeding History',
                  icon: Icons.favorite_rounded,
                  isActive: selectedSection == AnimalProfileSection.breeding,
                  onTap: () => setState(
                    () => selectedSection = AnimalProfileSection.breeding,
                  ),
                ),
              if (_showMilkButton)
                _ActionButton(
                  label: 'Milk Records',
                  icon: Icons.opacity_rounded,
                  isActive: selectedSection == AnimalProfileSection.milk,
                  onTap: () => setState(
                    () => selectedSection = AnimalProfileSection.milk,
                  ),
                ),
            ],
          ),
          const SizedBox(height: sizes.defaultSpace),
          Expanded(
            child: SingleChildScrollView(
              child: _SectionBody(
                section: selectedSection,
                animal: animal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimalTile extends StatelessWidget {
  const _AnimalTile({
    required this.animal,
    required this.onTap,
  });

  final HerdInputModel animal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
      child: InkWell(
        borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(sizes.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
            border: Border.all(color: UColors.borderPrimary),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: UColors.colorPrimary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(sizes.borderRadiusMd),
                ),
                child: const Icon(
                  Icons.pets_rounded,
                  color: UColors.colorPrimary,
                ),
              ),
              const SizedBox(width: sizes.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _animalTitle(animal),
                      style: const TextStyle(
                        fontSize: sizes.fontSizeMd,
                        fontWeight: FontWeight.bold,
                        color: UColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: sizes.xs),
                    Text(
                      _animalSubtitle(animal),
                      style: const TextStyle(
                        fontSize: sizes.fontSizeSm,
                        color: UColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: sizes.iconSm,
                color: UColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileSummaryCard extends StatelessWidget {
  const _ProfileSummaryCard({required this.animal});

  final HerdInputModel animal;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(sizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
        border: Border.all(color: UColors.borderPrimary),
      ),
      child: Wrap(
        spacing: sizes.md,
        runSpacing: sizes.sm,
        children: [
          _SummaryChip(label: 'Tag', value: animal.tagNumber ?? '-'),
          _SummaryChip(label: 'Animal ID', value: animal.animalId ?? '-'),
          _SummaryChip(label: 'Gender', value: _pretty(animal.gender)),
          _SummaryChip(label: 'Stage', value: _pretty(animal.stage)),
          _SummaryChip(label: 'Breed', value: animal.breed ?? '-'),
        ],
      ),
    );
  }
}

class _SectionBody extends ConsumerWidget {
  const _SectionBody({
    required this.section,
    required this.animal,
  });

  final AnimalProfileSection section;
  final HerdInputModel animal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthReady = ref.watch(healthEventStoreReadyProvider);
    final vaccinationReady = ref.watch(vaccinationStoreReadyProvider);
    final healthItems = ref.watch(healthEventStoreProvider);
    final vaccinationItems = ref.watch(vaccinationStoreProvider);
    final animalHealth = healthItems.where((e) => _matchesAnimalRef(animal, e.animalRef)).toList();
    final animalVaccinations =
        vaccinationItems.where((e) => _matchesAnimalRef(animal, e.animalRef)).toList();

    switch (section) {
      case AnimalProfileSection.health:
        return healthReady.when(
          data: (_) => _TimelineCard(
            title: 'Health History',
            subtitle: 'Sub-list of events',
            items: animalHealth.isEmpty
                ? const ['No health events recorded yet for this animal.']
                : [
                    for (final event in animalHealth)
                      '${_formatDate(event.eventDate)} | ${event.eventType}'
                          '${event.diagnosis.isEmpty ? '' : ' | ${event.diagnosis}'}'
                          '${event.vetName.isEmpty ? '' : ' | Vet: ${event.vetName}'}'
                          ' | Cost: PKR ${event.totalCost.toStringAsFixed(0)}',
                  ],
          ),
          loading: () => const _LoadingAnimalsState(),
          error: (_, __) => const _LoadErrorState(),
        );
      case AnimalProfileSection.vaccinations:
        return vaccinationReady.when(
          data: (_) => _TimelineCard(
            title: 'Vaccination Schedule',
            subtitle: 'Sub-list of vaccines',
            items: animalVaccinations.isEmpty
                ? const ['No vaccination records recorded yet for this animal.']
                : [
                    for (final vaccine in animalVaccinations)
                      '${_formatDate(vaccine.dateGiven)} | ${vaccine.vaccineName}'
                          '${vaccine.batchNumber.isEmpty ? '' : ' | Batch: ${vaccine.batchNumber}'}'
                          '${vaccine.nextDueDate == null ? '' : ' | Next due: ${_formatDate(vaccine.nextDueDate!)}'}'
                          ' | Cost: PKR ${vaccine.cost.toStringAsFixed(0)}',
                  ],
          ),
          loading: () => const _LoadingAnimalsState(),
          error: (_, __) => const _LoadErrorState(),
        );
      case AnimalProfileSection.breeding:
        return _TimelineCard(
          title: 'Breeding History',
          subtitle: 'Female breeding timeline',
          items: [
            _dateLine('Service Date', animal.serviceDate),
            _dateLine('PD Date', animal.pdDate),
            _dateLine('Calving Date', animal.calvingDate),
          ],
        );
      case AnimalProfileSection.milk:
        return _TimelineCard(
          title: 'Milk Records',
          subtitle: 'Current production snapshot',
          items: [
            'Avg milk/day: ${_numberOrDash(animal.avgMilkPerDay)}',
            'Milk price/litre: ${_numberOrDash(animal.milkSalePrice)}',
            'Milk sold %: ${_numberOrDash(animal.milkSoldPercentage)}',
            'Feed cost/month: ${_numberOrDash(animal.feedCost)}',
          ],
        );
    }
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({
    required this.title,
    required this.subtitle,
    required this.items,
  });

  final String title;
  final String subtitle;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(sizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
        border: Border.all(color: UColors.borderPrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: sizes.fontSizeMd,
              fontWeight: FontWeight.bold,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.xs),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: sizes.fontSizeSm,
              color: UColors.textSecondary,
            ),
          ),
          const SizedBox(height: sizes.md),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: sizes.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: const BoxDecoration(
                      color: UColors.colorPrimary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: sizes.sm),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: sizes.fontSizeSm,
                        color: UColors.textPrimary,
                        height: 1.5,
                      ),
                    ),
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

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: sizes.iconSm),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: sizes.md,
          vertical: sizes.sm,
        ),
        foregroundColor: isActive ? Colors.white : UColors.colorPrimary,
        backgroundColor:
            isActive ? UColors.colorPrimary : UColors.colorPrimaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sizes.borderRadiusMd),
        ),
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: sizes.md,
        vertical: sizes.sm,
      ),
      decoration: BoxDecoration(
        color: UColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(sizes.borderRadiusMd),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: UColors.textPrimary),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}

class _EmptyAnimalsState extends StatelessWidget {
  const _EmptyAnimalsState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(sizes.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
        border: Border.all(color: UColors.borderPrimary),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.pets_outlined,
            size: sizes.iconLg,
            color: UColors.colorPrimary,
          ),
          SizedBox(height: sizes.sm),
          Text(
            'No animals found. Add animals first to open their profile home.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: sizes.fontSizeSm,
              color: UColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingAnimalsState extends StatelessWidget {
  const _LoadingAnimalsState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: UColors.colorPrimary),
    );
  }
}

class _LoadErrorState extends StatelessWidget {
  const _LoadErrorState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(sizes.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
        border: Border.all(color: UColors.borderPrimary),
      ),
      child: const Text(
        'Unable to load saved animals from local database.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: sizes.fontSizeSm,
          color: UColors.textSecondary,
          height: 1.5,
        ),
      ),
    );
  }
}

String _animalTitle(HerdInputModel animal) {
  final primary = animal.tagNumber?.trim();
  if (primary != null && primary.isNotEmpty) return primary;

  final secondary = animal.animalId?.trim();
  if (secondary != null && secondary.isNotEmpty) return secondary;

  return 'Unnamed Animal';
}

String _animalSubtitle(HerdInputModel animal) {
  final parts = [
    if ((animal.animalId ?? '').trim().isNotEmpty) 'ID: ${animal.animalId}',
    _pretty(animal.gender),
    _pretty(animal.stage),
    animal.breed ?? '-',
  ];

  return parts.where((part) => part.trim().isNotEmpty).join(' | ');
}

String _pretty(String? value) {
  if (value == null || value.trim().isEmpty) return '-';

  return value
      .split('_')
      .map(
        (part) => part.isEmpty
            ? part
            : '${part[0].toUpperCase()}${part.substring(1)}',
      )
      .join(' ');
}

String _dateLine(String label, DateTime? value) {
  if (value == null) return '$label: -';
  return '$label: ${value.day}/${value.month}/${value.year}';
}

String _numberOrDash(num? value) {
  if (value == null) return '-';
  return value.toString();
}

bool _matchesAnimalRef(HerdInputModel animal, String rawRef) {
  final ref = rawRef.trim().toLowerCase();
  if (ref.isEmpty) return false;

  final candidates = [
    animal.recordKey,
    animal.tagNumber ?? '',
    animal.animalId ?? '',
  ].map((e) => e.trim().toLowerCase()).where((e) => e.isNotEmpty);

  return candidates.contains(ref);
}

String _formatDate(DateTime value) {
  final day = value.day.toString().padLeft(2, '0');
  final month = value.month.toString().padLeft(2, '0');
  return '$day/$month/${value.year}';
}
