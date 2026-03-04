import 'package:flutter/material.dart';

import '../constants/sizes.dart';
import '../themes/app_colors.dart';

class DropDownWithBg<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final String Function(T) itemLabelBuilder;
  final ValueChanged<T?> onChanged;
  final Color backgroundColor;
  final Color textColor;
  final double? width;

  const DropDownWithBg({
    super.key,
    required this.value,
    required this.items,
    required this.itemLabelBuilder,
    required this.onChanged,
    this.backgroundColor = UColors.colorPrimary, // Your Primary Color
    this.textColor = Colors.white,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: sizes.md),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(sizes.borderRadiusMd),
        // Adding a slight shadow for depth since it's now a solid color
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          // Making the dropdown popup menu match the theme
          dropdownColor: backgroundColor,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: textColor.withOpacity(0.8),
            size: sizes.iconMd,
          ),
          style: TextStyle(
            color: textColor,
            fontSize: sizes.fontSizeSm,
            fontWeight: FontWeight.w500,
          ),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<T>>((T val) {
            return DropdownMenuItem<T>(
              value: val,
              child: Text(
                itemLabelBuilder(val),
                style: TextStyle(color: textColor),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}