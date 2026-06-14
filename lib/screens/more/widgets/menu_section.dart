import 'package:flutter/material.dart';
import 'package:ledjify/models/menu_item_model.dart';
import 'package:ledjify/screens/more/widgets/menu_tile.dart';

class MenuSection extends StatelessWidget {
  final String title;
  final List<MenuItemData> items;

  const MenuSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
              letterSpacing: .5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .04),
                  blurRadius: 20,
                  spreadRadius: 7,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: List.generate(
                items.length,
                (index) => Column(
                  children: [
                    MenuTile(
                      icon: items[index].icon,
                      color: items[index].color,
                      title: items[index].title,
                      subtitle: items[index].subtitle,
                      onTap: items[index].onTap,
                    ),
                    if (index != items.length - 1)
                      Padding(
                        padding: const EdgeInsets.only( left:70, right: 12),
                        child: Divider(height: 1),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}