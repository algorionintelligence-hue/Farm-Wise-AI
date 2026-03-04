import 'package:farm_wise_ai/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/sizes.dart';
import '../viewmodel/bottom_nav_viewmodel.dart';

class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navIndexProvider);

    return Scaffold(
      backgroundColor: UColors.lightGrey,
      body: screens[selectedIndex],

      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: UColors.grey,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [

            /// ICONS ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                /// Dashboard
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.home_filled,
                        color: selectedIndex == 0
                            ? UColors.colorPrimary
                            : Colors.grey,
                      ),
                      onPressed: () {
                        ref.read(navIndexProvider.notifier).state = 0;
                      },
                    ),
                    Text(
                      "Dashboard",
                      style: TextStyle(
                        color: selectedIndex == 0
                            ? UColors.colorPrimary
                            : Colors.grey,
                        fontSize: sizes.fontSizeVerySm, // small size
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),

                /// Trophy
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'lib/core/assets/icons/inventory.png',
                        width: 24,
                        height: 24,
                        color: selectedIndex == 1
                            ? UColors.colorPrimary
                            : Colors.grey,
                      ),
                      onPressed: () {
                        ref.read(navIndexProvider.notifier).state = 1;
                      },
                    ),
                    Text(
                      "Inventory",
                      style: TextStyle(
                        color: selectedIndex == 1
                            ? UColors.colorPrimary
                            : Colors.grey,
                        fontSize: sizes.fontSizeVerySm, // small size
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),

                const SizedBox(width: 60),

                /// Music
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'lib/core/assets/icons/cash.png',
                        width: 24,
                        height: 24,
                        color: selectedIndex == 3
                            ? UColors.colorPrimary
                            : Colors.grey,
                      ),
                      onPressed: () {
                        ref.read(navIndexProvider.notifier).state = 3;
                      },
                    ),
                    Text(
                      "Cash",
                      style: TextStyle(
                        color: selectedIndex == 3
                            ? UColors.colorPrimary
                            : Colors.grey,
                        fontSize: sizes.fontSizeVerySm, // small size
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),

                Column(
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'lib/core/assets/icons/breeding.png',
                        width: 24,
                        height: 24,
                        color: selectedIndex == 4
                            ? UColors.colorPrimary
                            : Colors.grey, // works only if icon is monochrome
                      ),
                      onPressed: () {
                        ref.read(navIndexProvider.notifier).state = 4;
                      },
                    ),
                    Text(
                      "Breeding",
                      style: TextStyle(
                        color: selectedIndex == 4
                            ? UColors.colorPrimary
                            : Colors.grey,
                        fontSize: sizes.fontSizeVerySm, // small size
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),

            /// CENTER FLOATING BUTTON
            /// CENTER FLOATING BUTTON
            Positioned(
              top: -40,
              child: Container(
                width: 85, // slightly bigger than button
                height: 85,
                decoration: BoxDecoration(
                  color: UColors.screenBackground, // white ring around button
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      ref.read(navIndexProvider.notifier).state = 2;
                    },
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: selectedIndex == 2
                            ? const LinearGradient(
                          colors: [Color(0xFF384A24), Color(0xFF5CB85C)],
                        )
                            : const LinearGradient(
                          colors: [UColors.colorPrimary, UColors.gradientBarGreen2],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: UColors.colorPrimary,
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),          ],
        ),
      ),    );
  }
}