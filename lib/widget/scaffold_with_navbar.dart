import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    int currentIndex = 0;
    if (currentLocation.startsWith('/byAuthor')) {
      currentIndex = 0;
    } else if (currentLocation.startsWith('/byTitle')) {
      currentIndex = 1;
    } else if (currentLocation.startsWith('/profile')) {
      currentIndex = 2;
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'By Author',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'By Title',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/byAuthor');
              break;
            case 1:
              context.go('/byTitle');
              break;
            case 2:
              context.go('/profile');
              break;
          }
        },
      ),
    );
  }
}