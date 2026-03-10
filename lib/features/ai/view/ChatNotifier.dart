import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/locale_provider.dart';
import '../model/message_model.dart';

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  ChatNotifier(this.ref) : super([]);

  final Ref ref;

  Future<void> send(String text) async {
    state = [
      ...state,
      ChatMessage(text: text, role: MessageRole.user, time: DateTime.now()),
    ];

    state = [
      ...state,
      ChatMessage(
        text: '',
        role: MessageRole.ai,
        time: DateTime.now(),
        isLoading: true,
      ),
    ];

    await Future.delayed(const Duration(seconds: 2));

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
    final locale = ref.read(localeProvider) ?? const Locale('en');
    final isUrdu = locale.languageCode == 'ur';
    final lower = q.toLowerCase();

    if (lower.contains('profit')) {
      return isUrdu
          ? 'اس مہینے کے ڈیٹا کے مطابق:\n\nآمدن: PKR 85,000\nکل لاگت: PKR 62,400\n\nخالص منافع: PKR 22,600\n\nآپ کا منافع مارجن 26.6٪ ہے۔ فیڈ لاگت کل لاگت کا 42٪ ہے۔'
          : 'Based on this month\'s data:\n\nRevenue: PKR 85,000\nTotal Costs: PKR 62,400\n\nNet Profit: PKR 22,600\n\nYour profit margin is 26.6%. Feed costs are your biggest expense at 42% of total costs.';
    }
    if (lower.contains('money') || lower.contains('going')) {
      return isUrdu
          ? 'آپ کی سب سے بڑی 3 لاگت کیٹیگریز:\n\n1. فیڈ لاگت - 42٪\n2. لیبر - 28٪\n3. ویٹ اور ادویات - 15٪\n\nباقی 15٪ یوٹیلٹیز، بریڈنگ اور دیگر اخراجات میں تقسیم ہے۔'
          : 'Your top 3 cost categories:\n\n1. Feed Costs - 42%\n2. Labour - 28%\n3. Vet & Medicine - 15%\n\nThe remaining 15% is split between utilities, breeding, and miscellaneous.';
    }
    if (lower.contains('pregnancy') || lower.contains('60%')) {
      return isUrdu
          ? 'اگر حمل کی شرح 60٪ سے 75٪ ہو جائے:\n\n+5 مزید کیلونگ فی سال\n+PKR 37,500 دودھ کی آمدن\n-PKR 8,000 ریپیٹ بریڈنگ لاگت\n\nخالص فائدہ: تقریباً PKR 45,500 فی سال'
          : 'Improving pregnancy rate from 60% to 75%:\n\n+5 more calvings/year\n+PKR 37,500 milk revenue\n-PKR 8,000 repeat breeding cost\n\nNet gain: about PKR 45,500/year';
    }
    if (lower.contains('cost per animal') || lower.contains('cost_form per animal')) {
      return isUrdu
          ? 'اس مہینے فی جانور لاگت:\n\nفیڈ: PKR 1,200\nویٹ: PKR 180\nلیبر: PKR 420\nدیگر: PKR 200\n\nکل: PKR 2,000 فی جانور فی ماہ'
          : 'Cost per animal this month:\n\nFeed: PKR 1,200\nVet: PKR 180\nLabour: PKR 420\nOther: PKR 200\n\nTotal: PKR 2,000/animal/month';
    }
    if (lower.contains('3 months') || lower.contains('cash')) {
      return isUrdu
          ? '3 ماہ کی کیش پیش گوئی:\n\nمہینہ 1: PKR 22,600\nمہینہ 2: PKR 19,800\nمہینہ 3: PKR 24,100\n\nمتوقع اختتامی بیلنس: PKR 66,500\n\nنوٹ: دودھ کی قیمت اور فیڈ لاگت کو مستحکم مانا گیا ہے۔'
          : '3-Month Cash Projection:\n\nMonth 1: PKR 22,600\nMonth 2: PKR 19,800\nMonth 3: PKR 24,100\n\nProjected closing balance: PKR 66,500\n\nNote: Assumes stable milk price and feed costs.';
    }
    if (lower.contains('10 animals') || lower.contains('costly')) {
      return isUrdu
          ? 'سب سے زیادہ لاگت والے 3 جانور:\n\n1. Tag #A-112 - PKR 3,400/ماہ (ریپیٹ بریڈنگ)\n2. Tag #B-047 - PKR 3,100/ماہ (کم دودھ پیداوار)\n3. Tag #A-089 - PKR 2,900/ماہ (ویٹ وزٹس)\n\nمکمل فہرست ہرڈ سیکشن میں دیکھیں۔'
          : 'Top 3 highest-cost animals:\n\n1. Tag #A-112 - PKR 3,400/mo (repeat breeding)\n2. Tag #B-047 - PKR 3,100/mo (low milk yield)\n3. Tag #A-089 - PKR 2,900/mo (vet visits)\n\nView full list in the Herd section.';
    }
    if (lower.contains('feed') || lower.contains('15%')) {
      return isUrdu
          ? 'اگر فیڈ قیمت 15٪ بڑھ جائے:\n\n+PKR 7,560/ماہ اضافی لاگت\n\nتجویز کردہ اقدامات:\n1. کنسنٹریٹ 10٪ کم کریں\n2. بھوسہ مقامی سطح پر حاصل کریں\n3. کم پیداوار والے جانوروں کا جائزہ لیں'
          : 'If feed price increases 15%:\n\n+PKR 7,560/month extra cost\n\nRecommended actions:\n1. Reduce concentrate by 10%\n2. Source bhusa locally\n3. Review low-yield animals for culling';
    }
    if (lower.contains('repeat breeding')) {
      return isUrdu
          ? 'ریپیٹ بریڈنگ سے مالی نقصان:\n\nاوسط اضافی لاگت فی سائیکل: PKR 1,200\nاوسط تاخیر فی جانور: 2.3 سائیکل\n\nسالانہ نقصان: PKR 41,400 پورے ریوڑ میں\n\nAI ٹائمنگ بہتر ہو تو تقریباً 70٪ نقصان ریکور ہو سکتا ہے۔'
          : 'Financial loss from repeat breeding:\n\nAvg extra cost/cycle: PKR 1,200\nAvg delays/animal: 2.3 cycles\n\nAnnual loss: PKR 41,400 across your herd\n\nImproving AI timing could recover about 70% of this.';
    }
    if (lower.contains('male calves') || lower.contains('sell')) {
      return isUrdu
          ? 'نر بچھڑے فروخت کرنے کا بہترین وقت:\n\n3 ماہ پر: PKR 12,000 اوسط\n6 ماہ پر: PKR 22,000 اوسط\n12 ماہ پر: PKR 38,000 اوسط\n\nبہترین کیش فلو کے لیے 6 ماہ پر فروخت بہتر ہے۔'
          : 'Best time to sell male calves:\n\nAt 3 months: PKR 12,000 avg\nAt 6 months: PKR 22,000 avg\nAt 12 months: PKR 38,000 avg\n\nFor best cash flow, sell at 6 months.';
    }

    return isUrdu
        ? 'میں آپ کے فارم کا ڈیٹا دیکھ رہا ہوں۔ درست مشوروں کے لیے ریونیو، لاگت اور ہرڈ ریکارڈز اپ ٹو ڈیٹ رکھیں۔'
        : 'I\'m analyzing your farm data. Please keep your revenue, cost, and herd records up to date for accurate insights.';
  }
}
