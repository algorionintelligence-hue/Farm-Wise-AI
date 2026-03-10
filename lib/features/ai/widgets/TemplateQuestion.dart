import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class TemplateQuestion {
  final String label;
  final String question;
  final IconData icon;

  const TemplateQuestion({
    required this.label,
    required this.question,
    required this.icon,
  });
}

List<TemplateQuestion> buildTemplateQuestions(AppLocalizations l10n) => [
      TemplateQuestion(
        label: l10n.templateProfitableLabel,
        question: l10n.templateProfitableQuestion,
        icon: Icons.trending_up_rounded,
      ),
      TemplateQuestion(
        label: l10n.templateMoneyFlowLabel,
        question: l10n.templateMoneyFlowQuestion,
        icon: Icons.account_balance_wallet_rounded,
      ),
      TemplateQuestion(
        label: l10n.templatePregnancyRateLabel,
        question: l10n.templatePregnancyRateQuestion,
        icon: Icons.favorite_rounded,
      ),
      TemplateQuestion(
        label: l10n.templateCostPerAnimalLabel,
        question: l10n.templateCostPerAnimalQuestion,
        icon: Icons.pets_rounded,
      ),
      TemplateQuestion(
        label: l10n.templateCashIn3MonthsLabel,
        question: l10n.templateCashIn3MonthsQuestion,
        icon: Icons.savings_rounded,
      ),
      TemplateQuestion(
        label: l10n.templateTop10CostlyLabel,
        question: l10n.templateTop10CostlyQuestion,
        icon: Icons.bar_chart_rounded,
      ),
      TemplateQuestion(
        label: l10n.templateFeedPriceUpLabel,
        question: l10n.templateFeedPriceUpQuestion,
        icon: Icons.grass_rounded,
      ),
      TemplateQuestion(
        label: l10n.templateRepeatBreedingLabel,
        question: l10n.templateRepeatBreedingQuestion,
        icon: Icons.loop_rounded,
      ),
      TemplateQuestion(
        label: l10n.templateSellMaleCalvesLabel,
        question: l10n.templateSellMaleCalvesQuestion,
        icon: Icons.sell_rounded,
      ),
    ];
