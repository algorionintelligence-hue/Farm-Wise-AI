import 'package:farm_wise_ai/core/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';

import '../Utils/sizes.dart';

class AddBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  const AddBtn({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      color: UColors.colorPrimary,
      borderRadius: BorderRadius.circular(sizes.buttonRadius),
      onPressed:
     onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(CupertinoIcons.add, color: CupertinoColors.white),
          SizedBox(width: 8),
          Text(
            'Add',
            style: TextStyle(color: CupertinoColors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
  }
