import 'package:farm_wise_ai/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/bottom_nav_viewmodel.dart';

class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navIndexProvider);
    Size size = MediaQuery.of(context).size;

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
                IconButton(
                  icon: Icon(
                    Icons.dashboard_outlined,
                    color: selectedIndex == 0
                        ? UColors.colorPrimary
                        : Colors.grey,
                  ),
                  onPressed: () {
                    ref.read(navIndexProvider.notifier).state = 0;
                  },
                ),

                /// Trophy
                IconButton(
                  icon: Icon(
                    Icons.emoji_events_outlined,
                    color: selectedIndex == 1
                        ? UColors.colorPrimary
                        : Colors.grey,
                  ),
                  onPressed: () {
                    ref.read(navIndexProvider.notifier).state = 1;
                  },
                ),

                const SizedBox(width: 60),

                /// Music
                IconButton(
                  icon: Icon(
                    Icons.music_note_outlined,
                    color: selectedIndex == 3
                        ? UColors.colorPrimary
                        : Colors.grey,
                  ),
                  onPressed: () {
                    ref.read(navIndexProvider.notifier).state = 3;
                  },
                ),

                /// Profile
                IconButton(
                  icon: Icon(
                    Icons.person_outline,
                    color: selectedIndex == 4
                        ? UColors.colorPrimary
                        : Colors.grey,
                  ),
                  onPressed: () {
                    ref.read(navIndexProvider.notifier).state = 4;
                  },
                ),
              ],
            ),

            /// CENTER FLOATING BUTTON
            Positioned(
              top: -25,
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
                      colors: [UColors.colorPrimary, UColors.colorPrimary],
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
                    Icons.home,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),    );
  }
}