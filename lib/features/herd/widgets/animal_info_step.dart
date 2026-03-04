import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/sizes.dart';
import '../viewmodel/herd_viewmodel.dart';
import 'custom_input.dart';

class AnimalInfoStep extends ConsumerWidget {
  const AnimalInfoStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(herdProvider.notifier);

    return Padding(
      padding: const EdgeInsets.only(top: sizes.md),

      child: Column(
        children: [
          CustomInput(
            label: "Animal ID",
            controller: vm.animalIdController,
          ),
          CustomInput(
            label: "Weight",
            controller: vm.weightController,
          ),
        ],
      ),
    );
  }
}