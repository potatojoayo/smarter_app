import 'package:flutter/material.dart';

BottomNavigationBarItem buildBottomNavigationBarItem(
    {required icon,
    required activeIcon,
    required navText,
    activeColor = const Color(0xFF619FF8)}) {
  return BottomNavigationBarItem(
    label: navText,
    icon: Image.asset(
      icon,
      fit: BoxFit.fill,
    ),
    activeIcon: Image.asset(activeIcon),
  );
}
