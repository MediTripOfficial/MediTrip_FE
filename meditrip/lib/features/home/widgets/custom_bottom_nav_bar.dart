import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  static const Color primaryBlue = Color(0xFF0049E6);
  static const Color textDark = Color(0xFF111827);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 118,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 92,
              padding: const EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(34),
                ),
                border: Border.all(
                  color: const Color(0xFFD5DAE3),
                  width: 1,
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavItem(
                    icon: Icons.home_rounded,
                    label: 'Home',
                    isSelected: true,
                  ),
                  _NavItem(
                    icon: Icons.location_on_outlined,
                    label: 'Map',
                  ),
                  SizedBox(width: 78),
                  _NavItem(
                    icon: Icons.add_box_outlined,
                    label: 'Guide',
                  ),
                  _NavItem(
                    icon: Icons.person_outline_rounded,
                    label: 'My',
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 0,
            child: Container(
              width: 86,
              height: 86,
              decoration: BoxDecoration(
                color: primaryBlue,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primaryBlue.withOpacity(0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.document_scanner_outlined,
                color: Colors.white,
                size: 42,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _NavItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? CustomBottomNavBar.textDark
        : CustomBottomNavBar.textDark;

    return SizedBox(
      width: 58,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: color,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}