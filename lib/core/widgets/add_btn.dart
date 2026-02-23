import 'package:farm_wise_ai/core/constants/sizes.dart';
import 'package:flutter/cupertino.dart';

class AddBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  const AddBtn({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: CupertinoColors.activeBlue,
      borderRadius: BorderRadius.circular(sizes.buttonRadius),
      onPressed: () {
        // Add your onPressed logic here
     onPressed;
      },
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
