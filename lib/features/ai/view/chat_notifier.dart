
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/message_model.dart';

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  ChatNotifier() : super([]);

  Future<void> send(String text) async {
    // Add user message
    state = [
      ...state,
      ChatMessage(
          text: text, role: MessageRole.user, time: DateTime.now()),
    ];

    // Add loading bubble
    state = [
      ...state,
      ChatMessage(
          text: '',
          role: MessageRole.ai,
          time: DateTime.now(),
          isLoading: true),
    ];

    // Simulate AI response delay
    await Future.delayed(const Duration(seconds: 2));

    // Replace loading with mock response
    state = [
      ...state.where((m) => !m.isLoading),
      ChatMessage(
        text: _mockResponse(text),
        role: MessageRole.ai,
        time: DateTime.now(),
      ),
    ];
  }

  String _mockResponse(String q) {
    final lower = q.toLowerCase();
    if (lower.contains('profit')) {
      return "📊 Based on this month's data:\n\nRevenue: PKR 85,000\nTotal Costs: PKR 62,400\n\n✅ Net Profit: PKR 22,600\n\nYour profit margin is 26.6%. Feed costs are your biggest expense at 42% of total costs.";
    }
    if (lower.contains('money') || lower.contains('going')) {
      return "💸 Your top 3 cost categories:\n\n1. Feed Costs — 42%\n2. Labour — 28%\n3. Vet & Medicine — 15%\n\nThe remaining 15% is split between utilities, breeding, and miscellaneous.";
    }
    if (lower.contains('pregnancy') || lower.contains('60%')) {
      return "🐄 Improving pregnancy rate from 60% → 75%:\n\n+5 more calvings/year\n+PKR 37,500 milk revenue\n−PKR 8,000 repeat breeding cost\n\n📈 Net gain: ~PKR 45,500/year";
    }
    if (lower.contains('cost per animal')) {
      return "🐄 Cost per animal this month:\n\nFeed: PKR 1,200\nVet: PKR 180\nLabour: PKR 420\nOther: PKR 200\n\n💰 Total: PKR 2,000/animal/month";
    }
    if (lower.contains('3 months') || lower.contains('cash')) {
      return "💰 3-Month Cash Projection:\n\nMonth 1: PKR 22,600\nMonth 2: PKR 19,800\nMonth 3: PKR 24,100\n\n📌 Projected closing balance: PKR 66,500\n\nNote: Assumes stable milk price & feed costs.";
    }
    if (lower.contains('10 animals') || lower.contains('costly')) {
      return "📋 Top 3 highest-cost animals:\n\n1. Tag #A-112 — PKR 3,400/mo (repeat breeding)\n2. Tag #B-047 — PKR 3,100/mo (low milk yield)\n3. Tag #A-089 — PKR 2,900/mo (vet visits)\n\nView full list in the Herd section.";
    }
    if (lower.contains('feed') || lower.contains('15%')) {
      return "🌾 If feed price increases 15%:\n\n+PKR 7,560/month extra cost\n\nRecommended actions:\n1. Reduce concentrate by 10%\n2. Source bhusa locally\n3. Review low-yield animals for culling";
    }
    if (lower.contains('repeat breeding')) {
      return "🔁 Financial loss from repeat breeding:\n\nAvg extra cost/cycle: PKR 1,200\nAvg delays/animal: 2.3 cycles\n\n💸 Annual loss: PKR 41,400 across your herd\n\nImproving AI timing could recover ~70% of this.";
    }
    if (lower.contains('male calves') || lower.contains('sell')) {
      return "📅 Best time to sell male calves:\n\n• At 3 months: PKR 12,000 avg\n• At 6 months: PKR 22,000 avg\n• At 12 months: PKR 38,000 avg\n\n✅ For best cashflow, sell at 6 months — cost of keeping vs return is most favourable.";
    }
    return "🤖 I'm analysing your farm data. Please make sure your Revenue, Cost, and Herd records are up to date for accurate insights.";
  }
}