// ═══════════════════════════════════════════════
// Typing Indicator (3 dots)
// ═══════════════════════════════════════════════

import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator();

  @override
  State<TypingIndicator> createState() => TypingIndicatorState();
}

class TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
          (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      ),
    );
    _animations = _controllers
        .map((c) => Tween<double>(begin: 0, end: 6).animate(
      CurvedAnimation(parent: c, curve: Curves.easeInOut),
    ))
        .toList();

    // Stagger the dots
    for (int i = 0; i < 3; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        return AnimatedBuilder(
          animation: _animations[i],
          builder: (_, __) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: 7,
            height: 7 + _animations[i].value,
            decoration: BoxDecoration(
              color: UColors.colorPrimary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
