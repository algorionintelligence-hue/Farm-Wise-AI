import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/sizes.dart';
import '../viewmodel/herd_viewmodel.dart';
import 'CustomInput.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/sizes.dart';
import '../../../core/themes/app_colors.dart';
import '../viewmodel/herd_viewmodel.dart';
import '../widgets/CustomInput.dart';

class AnimalInfoStep extends ConsumerWidget {
  const AnimalInfoStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(herdProvider.notifier);

    return Padding(
      padding: const EdgeInsets.only(top: sizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Animal ID — text keyboard
          CustomInput(
            label: "Animal ID",
            controller: vm.animalIdController,
            keyboardType: TextInputType.text,
          ),

          // Weight — number keyboard
          CustomInput(
            label: "Weight (kg)",
            controller: vm.weightController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
    );
  }
}
