// import 'package:flutter/material.dart';
//
// import '../../../core/constants/sizes.dart';
// import '../../../core/themes/app_colors.dart';
//
// class StepNavigationButtons extends StatelessWidget {
//   final VoidCallback onNext;
//   final VoidCallback onBack;
//   final bool isLast;
//   final bool isFirst;
//
//   const StepNavigationButtons({
//     super.key,
//     required this.onNext,
//     required this.onBack,
//     required this.isLast,
//     required this.isFirst,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 16),
//       child: Row(
//         children: [
//           // Back button — outlined, colorPrimary border
//           if (!isFirst) ...[
//             Expanded(
//               child: OutlinedButton(
//                 onPressed: onBack,
//                 style: OutlinedButton.styleFrom(
//                   foregroundColor: UColors.colorPrimary,
//                   side: const BorderSide(color: UColors.colorPrimary),
//                   padding: const EdgeInsets.symmetric(vertical: 13),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(sizes.buttonRadius),
//                   ),
//                 ),
//                 child: const Text(
//                   "Back",
//                   style: TextStyle(
//                     fontSize: sizes.fontSizeMd,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//           ],
//
//           // Next / Dashboard — PrimaryButton style
//           Expanded(
//             child: ElevatedButton(
//               onPressed: onNext,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: UColors.colorPrimary,
//                 foregroundColor: UColors.white,
//                 elevation: 0,
//                 padding: const EdgeInsets.symmetric(vertical: 13),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(sizes.buttonRadius),
//                 ),
//               ),
//               child: Text(
//                 isLast ? "Dashboard" : "Next",
//                 style: const TextStyle(
//                   fontSize: sizes.fontSizeMd,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 0.3,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }