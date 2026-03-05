import 'package:farm_wise_ai/features/ai/widgets/input_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/providers/auth_providers.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/bg.dart';
import '../model/message_model.dart';
import '../widgets/msg_bar.dart';



// ── Template Questions ─────────────────────────
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

const _templates = [
  _TemplateQuestion(
    label: "Profitable?",
    question: "Am I profitable this month?",
    icon: Icons.trending_up_rounded,
  ),
  _TemplateQuestion(
    label: "Money flow",
    question: "Where is my money going?",
    icon: Icons.account_balance_wallet_rounded,
  ),
  _TemplateQuestion(
    label: "Pregnancy rate",
    question:
    "If I improve pregnancy rate from 60% to 75% what happens?",
    icon: Icons.favorite_rounded,
  ),
  _TemplateQuestion(
    label: "Cost per animal",
    question: "What is my cost per animal?",
    icon: Icons.pets_rounded,
  ),
  _TemplateQuestion(
    label: "Cash in 3 months",
    question: "How much cash will I have after 3 months?",
    icon: Icons.savings_rounded,
  ),
  _TemplateQuestion(
    label: "Top 10 costly",
    question: "Which 10 animals are costing me the most?",
    icon: Icons.bar_chart_rounded,
  ),
  _TemplateQuestion(
    label: "Feed price +15%",
    question:
    "If feed price increases 15% what should I change first?",
    icon: Icons.grass_rounded,
  ),
  _TemplateQuestion(
    label: "Repeat breeding",
    question: "What is the financial loss of repeat breeding?",
    icon: Icons.loop_rounded,
  ),
  _TemplateQuestion(
    label: "Sell male calves",
    question:
    "When should I sell male calves for best cashflow?",
    icon: Icons.sell_rounded,
  ),
];

// ═══════════════════════════════════════════════
// AI Q&A Screen
// ═══════════════════════════════════════════════

class AiQnaScreen extends ConsumerStatefulWidget {
  const AiQnaScreen({super.key});

  @override
  ConsumerState<AiQnaScreen> createState() => _AiQnaScreenState();
}

class _AiQnaScreenState extends ConsumerState<AiQnaScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _showTemplates = true;

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

    // Auto scroll when new message arrives
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return AppScaffold(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          const Text(
            "AI Farm Advisor",
            style: TextStyle(
              fontSize: sizes.fontSizeHeadings,
              fontWeight: FontWeight.bold,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.sm),
          const Text(
            "Ask anything about your farm's finances & herd",
            style: TextStyle(
              fontSize: sizes.fontSizeSm,
              color: UColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: sizes.md),

          // ── Chat Area ──
          Expanded(
            child: messages.isEmpty
                ? _EmptyState(
              showTemplates: _showTemplates,
              onTemplateSelected: _send,
            )
                : Column(
              children: [
                // Messages
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(bottom: sizes.sm),
                    itemCount: messages.length,
                    itemBuilder: (context, i) =>
                        MessageBubble(message: messages[i]),
                  ),
                ),

                // Template chips (after first message)
                if (!_showTemplates)
                  _TemplateChips(onSelected: _send),
              ],
            ),
          ),

          const SizedBox(height: sizes.sm),

          // ── Input Bar ──
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

// ═══════════════════════════════════════════════
// Empty State with Templates
// ═══════════════════════════════════════════════

class _EmptyState extends StatelessWidget {
  final bool showTemplates;
  final void Function(String) onTemplateSelected;

  const _EmptyState({
    required this.showTemplates,
    required this.onTemplateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AI Avatar
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
            child: Icon(Icons.auto_awesome_rounded,
                color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: sizes.md),
        const Text(
          "Ask me anything!",
          style: TextStyle(
            fontSize: sizes.fontSizeLg,
            fontWeight: FontWeight.w800,
            color: UColors.colorPrimary,
          ),
        ),
        const SizedBox(height: sizes.xs),
        const Text(
          "Tap a question below or type your own",
          style: TextStyle(
            fontSize: sizes.fontSizeSm,
            color: UColors.textSecondary,
          ),
        ),
        const SizedBox(height: sizes.lg),

        // Template Grid
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: sizes.sm,
              mainAxisSpacing: sizes.sm,
              childAspectRatio: 2.4,
            ),
            itemCount: _templates.length,
            itemBuilder: (context, i) {
              final t = _templates[i];
              return GestureDetector(
                onTap: () => onTemplateSelected(t.question),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: sizes.sm, vertical: sizes.sm),
                  decoration: BoxDecoration(
                    color: UColors.light,
                    borderRadius:
                    BorderRadius.circular(sizes.cardRadiusMd),
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
                        child: Icon(t.icon,
                            size: sizes.iconXs,
                            color: UColors.colorPrimary),
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

// ═══════════════════════════════════════════════
// Template Chips (shown after chatting starts)
// ═══════════════════════════════════════════════

class _TemplateChips extends StatelessWidget {
  final void Function(String) onSelected;

  const _TemplateChips({required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: sizes.xs),
        itemCount: _templates.length,
        separatorBuilder: (_, __) => const SizedBox(width: sizes.xs),
        itemBuilder: (context, i) {
          final t = _templates[i];
          return GestureDetector(
            onTap: () => onSelected(t.question),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: sizes.sm, vertical: sizes.xs),
              decoration: BoxDecoration(
                color: UColors.colorPrimary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: UColors.colorPrimary.withOpacity(0.25)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(t.icon,
                      size: 12, color: UColors.colorPrimary),
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





