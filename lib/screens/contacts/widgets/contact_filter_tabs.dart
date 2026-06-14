import 'package:flutter/material.dart';
import 'package:ledjify/constants/app_colors.dart';

class ContactFilterTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const ContactFilterTabs({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = ['All', "You'll Get", "You'll Give", 'Settled'];

    final tabColors = [
      Colors.black,
      AppColors.get,
      AppColors.give,
      Colors.blue,
    ];

    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          tabs.length,
          (index) => GestureDetector(
            onTap: () => onSelected(index),
            child: _TabItem(
              title: tabs[index],
              selected: selectedIndex == index,
              color: tabColors[index],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool selected;
  final Color color;

  const _TabItem({
    required this.title,
    required this.selected,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: selected ? color : AppColors.grey,
            fontWeight:
                selected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 28,
          height: 2,
          color: selected ? color : Colors.transparent,
        ),
      ],
    );
  }
}