import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../themes/app_colors.dart';
import '../utils/sizes.dart';

class LanguageSwitcher extends ConsumerWidget {
  const LanguageSwitcher({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = Localizations.localeOf(context).languageCode;
    final l10n = AppLocalizations.of(context)!;

    return PopupMenuButton<String>(
      tooltip: l10n.switchLanguage,
      onSelected: (languageCode) {
        ref.read(localeProvider.notifier).state = Locale(languageCode);
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: 'en',
          child: Text(l10n.english),
        ),
        PopupMenuItem<String>(
          value: 'ur',
          child: Text(l10n.urdu),
        ),
        PopupMenuItem<String>(
          value: 'sd',
          child: Text(l10n.sindhi),
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? sizes.sm : sizes.md,
          vertical: sizes.xs,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.14),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withOpacity(0.16)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language, size: sizes.iconSm, color: UColors.white),
            const SizedBox(width: sizes.xs),
            Text(
              switch (currentLocale) {
                'ur' => l10n.urdu,
                'sd' => l10n.sindhi,
                _ => 'EN',
              },
              style: const TextStyle(
                color: UColors.white,
                fontSize: sizes.fontSizeSm,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
