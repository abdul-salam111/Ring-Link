import 'package:flutter/material.dart';
import 'package:ring_link/utils/library.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final void Function(int index) onTabSelected;
  final Color selectedColor;
  final Color unselectedColor;

  final EdgeInsets padding;
  final double height;
  final Color backgroundColor;
  final BorderRadius borderRadius;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    this.selectedColor = AppColors.secondaryColor,
    this.unselectedColor = AppColors.lightgreycardColor,
    this.padding = defaultPadding,
    this.height = 65,
    this.backgroundColor = AppColors.lightgreycardColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final bool isSelected = selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? selectedColor : unselectedColor,
                  borderRadius: borderRadius,
                ),
                child: Center(
                  child: Text(tabs[index],
                      style: context.screenWidth > 420
                          ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              )
                          : Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              )),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
