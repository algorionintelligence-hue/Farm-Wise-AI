// ── Template Questions ─────────────────────────
import 'package:flutter/material.dart';

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

const templates = [
  TemplateQuestion(
    label: "Profitable?",
    question: "Am I profitable this month?",
    icon: Icons.trending_up_rounded,
  ),
  TemplateQuestion(
    label: "Money flow",
    question: "Where is my money going?",
    icon: Icons.account_balance_wallet_rounded,
  ),
  TemplateQuestion(
    label: "Pregnancy rate",
    question:
    "If I improve pregnancy rate from 60% to 75% what happens?",
    icon: Icons.favorite_rounded,
  ),
  TemplateQuestion(
    label: "Cost per animal",
    question: "What is my cost_form per animal?",
    icon: Icons.pets_rounded,
  ),
  TemplateQuestion(
    label: "Cash in 3 months",
    question: "How much cash will I have after 3 months?",
    icon: Icons.savings_rounded,
  ),
  TemplateQuestion(
    label: "Top 10 costly",
    question: "Which 10 animals are costing me the most?",
    icon: Icons.bar_chart_rounded,
  ),
  TemplateQuestion(
    label: "Feed price +15%",
    question:
    "If feed price increases 15% what should I change first?",
    icon: Icons.grass_rounded,
  ),
  TemplateQuestion(
    label: "Repeat breeding",
    question: "What is the financial loss of repeat breeding?",
    icon: Icons.loop_rounded,
  ),
  TemplateQuestion(
    label: "Sell male calves",
    question:
    "When should I sell male calves for best cashflow?",
    icon: Icons.sell_rounded,
  ),
];
