// ═══════════════════════════════════════════════
// Message Bubble
// ═══════════════════════════════════════════════

import 'package:farm_wise_ai/features/Ai/widgets/TypingIndicator.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/sizes.dart';
import '../../../core/themes/app_colors.dart';
import '../model/ChatMessage.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == MessageRole.user;

    return Padding(
      padding: EdgeInsets.only(
        top: sizes.xs,
        bottom: sizes.xs,
        left: isUser ? 48 : 0,
        right: isUser ? 0 : 48,
      ),
      child: Row(
        mainAxisAlignment:
        isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // AI avatar
          if (!isUser)
            Container(
              width: 28,
              height: 28,
              margin: const EdgeInsets.only(right: sizes.xs),
              decoration: const BoxDecoration(
                color: UColors.colorPrimary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.auto_awesome_rounded,
                  color: Colors.white, size: 14),
            ),

          // Bubble
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: sizes.md,
                vertical: sizes.sm,
              ),
              decoration: BoxDecoration(
                color: isUser
                    ? UColors.colorPrimary
                    : UColors.light,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 16),
                ),
                border: isUser
                    ? null
                    : Border.all(color: UColors.borderPrimary),
              ),
              child: message.isLoading
                  ? const TypingIndicator()
                  : Text(
                message.text,
                style: TextStyle(
                  fontSize: sizes.fontSizeSm,
                  color: isUser
                      ? Colors.white
                      : UColors.textPrimary,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
