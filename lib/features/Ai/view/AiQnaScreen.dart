import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/auth_providers.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../l10n/AppLocalizations.dart';
import '../widgets/InputBar.dart';
import '../widgets/MessageBubble.dart';

class _TemplateQuestion {
  final String label;
  final String question;
  final IconData icon;

  const _TemplateQuestion({
    required this.label,
    required this.question,
    required this.icon,
  });
}

class AiQnaScreen extends ConsumerStatefulWidget {
  const AiQnaScreen({super.key});

  @override
  ConsumerState<AiQnaScreen> createState() => _AiQnaScreenState();
}

class _AiQnaScreenState extends ConsumerState<AiQnaScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _showTemplates = true;

  List<_TemplateQuestion> _templates(AppLocalizations l10n) => [
        _TemplateQuestion(
          label: l10n.templateProfitableLabel,
          question: l10n.templateProfitableQuestion,
          icon: Icons.trending_up_rounded,
        ),
        _TemplateQuestion(
          label: l10n.templateMoneyFlowLabel,
          question: l10n.templateMoneyFlowQuestion,
          icon: Icons.account_balance_wallet_rounded,
        ),
        _TemplateQuestion(
          label: l10n.templatePregnancyRateLabel,
          question: l10n.templatePregnancyRateQuestion,
          icon: Icons.favorite_rounded,
        ),
        _TemplateQuestion(
          label: l10n.templateCostPerAnimalLabel,
          question: l10n.templateCostPerAnimalQuestion,
          icon: Icons.pets_rounded,
        ),
        _TemplateQuestion(
          label: l10n.templateCashIn3MonthsLabel,
          question: l10n.templateCashIn3MonthsQuestion,
          icon: Icons.savings_rounded,
        ),
        _TemplateQuestion(
          label: l10n.templateTop10CostlyLabel,
          question: l10n.templateTop10CostlyQuestion,
          icon: Icons.bar_chart_rounded,
        ),
        _TemplateQuestion(
          label: l10n.templateFeedPriceUpLabel,
          question: l10n.templateFeedPriceUpQuestion,
          icon: Icons.grass_rounded,
        ),
        _TemplateQuestion(
          label: l10n.templateRepeatBreedingLabel,
          question: l10n.templateRepeatBreedingQuestion,
          icon: Icons.loop_rounded,
        ),
        _TemplateQuestion(
          label: l10n.templateSellMaleCalvesLabel,
          question: l10n.templateSellMaleCalvesQuestion,
          icon: Icons.sell_rounded,
        ),
      ];

  void _send(String text) {
    if (text.trim().isEmpty) return;
    _controller.clear();
    setState(() => _showTemplates = false);
    ref.read(chatProvider.notifier).send(text.trim());
    Future.delayed(const Duration(milliseconds: 300), _scrollToBottom);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatProvider);
    final l10n = AppLocalizations.of(context)!;
    final templates = _templates(l10n);

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.aiFarmAdvisor,
            style: const TextStyle(
              fontSize: sizes.fontSizeHeadings,
              fontWeight: FontWeight.bold,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.sm),
          Text(
            l10n.askFarmFinance,
            style: const TextStyle(
              fontSize: sizes.fontSizeSm,
              color: UColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: sizes.md),
          Expanded(
            child: messages.isEmpty
                ? _EmptyState(
                    templates: templates,
                    onTemplateSelected: _send,
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.only(bottom: sizes.sm),
                          itemCount: messages.length,
                          itemBuilder: (context, i) => MessageBubble(message: messages[i]),
                        ),
                      ),
                      if (!_showTemplates)
                        _TemplateChips(
                          templates: templates,
                          onSelected: _send,
                        ),
                    ],
                  ),
          ),
          const SizedBox(height: sizes.sm),
          InputBar(
            controller: _controller,
            onSend: _send,
          ),
          const SizedBox(height: sizes.xs),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final List<_TemplateQuestion> templates;
  final void Function(String) onTemplateSelected;

  const _EmptyState({
    required this.templates,
    required this.onTemplateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: UColors.colorPrimary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: UColors.colorPrimary.withOpacity(0.3),
                blurRadius: 16,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Center(
            child: Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: sizes.md),
        Text(
          l10n.askMeAnything,
          style: const TextStyle(
            fontSize: sizes.fontSizeLg,
            fontWeight: FontWeight.w800,
            color: UColors.colorPrimary,
          ),
        ),
        const SizedBox(height: sizes.xs),
        Text(
          l10n.tapQuestionOrType,
          style: const TextStyle(
            fontSize: sizes.fontSizeSm,
            color: UColors.textSecondary,
          ),
        ),
        const SizedBox(height: sizes.lg),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: sizes.sm,
              mainAxisSpacing: sizes.sm,
              childAspectRatio: 2.4,
            ),
            itemCount: templates.length,
            itemBuilder: (context, i) {
              final t = templates[i];
              return GestureDetector(
                onTap: () => onTemplateSelected(t.question),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: sizes.sm, vertical: sizes.sm),
                  decoration: BoxDecoration(
                    color: UColors.light,
                    borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
                    border: Border.all(color: UColors.borderPrimary),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: UColors.colorPrimary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(t.icon, size: sizes.iconXs, color: UColors.colorPrimary),
                      ),
                      const SizedBox(width: sizes.xs),
                      Expanded(
                        child: Text(
                          t.label,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: UColors.colorPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TemplateChips extends StatelessWidget {
  final List<_TemplateQuestion> templates;
  final void Function(String) onSelected;

  const _TemplateChips({required this.templates, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: sizes.xs),
        itemCount: templates.length,
        separatorBuilder: (_, __) => const SizedBox(width: sizes.xs),
        itemBuilder: (context, i) {
          final t = templates[i];
          return GestureDetector(
            onTap: () => onSelected(t.question),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: sizes.sm, vertical: sizes.xs),
              decoration: BoxDecoration(
                color: UColors.colorPrimary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: UColors.colorPrimary.withOpacity(0.25)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(t.icon, size: 12, color: UColors.colorPrimary),
                  const SizedBox(width: 4),
                  Text(
                    t.label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: UColors.colorPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
