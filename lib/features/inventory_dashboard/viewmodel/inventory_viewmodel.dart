import 'package:flutter_riverpod/flutter_riverpod.dart';

// Simple state for Inventory
final inventoryProvider = Provider((ref) => {
  'health': [
    {'label': 'Feed Days Cover', 'value': '21 days', 'alert': false},
    {'label': 'Medicine Stock', 'value': '45 days', 'alert': false},
    {'label': 'Minerals Stock', 'value': '12 days', 'alert': true},
  ],
  'trends': {
    'feed': 0.85, // percentage for progress bar
    'milk': 0.60,
  },
  'aiInsight': "Feed increased 12% but milk only 2%. Possible efficiency issue."
});
