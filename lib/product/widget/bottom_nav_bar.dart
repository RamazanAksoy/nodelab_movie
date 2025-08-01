import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:nodelab_movie/core/extension/context_extension.dart';

import '../../feature/home/view/home_screen.dart';
import '../../feature/profile/bloc/profile_bloc.dart';
import '../../feature/profile/bloc/profile_event.dart';
import '../../feature/profile/service/profile_service.dart';
import '../../feature/profile/view/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    BlocProvider(create: (_) => ProfileBloc(ProfileService())..add(FetchProfile()), child: const ProfileScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background.withOpacity(0.8),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
        decoration: BoxDecoration(color: context.theme.colorScheme.background.withOpacity(0.12), borderRadius: BorderRadius.circular(24)),
        child: Row(
          children: [
            _navItem(icon: Icons.home, label: "main.home".tr(), index: 0),
            const SizedBox(width: 30),
            _navItem(icon: Icons.person, label: "main.profile".tr(), index: 1),
          ],
        ),
      ),
    );
  }

  Widget _navItem({required IconData icon, required String label, required int index}) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? context.theme.colorScheme.onPrimary : context.theme.colorScheme.onSecondary.withOpacity(0.3),
              width: 1,
            ),
            color: context.theme.colorScheme.onSecondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: isSelected ? context.theme.colorScheme.onPrimary : context.theme.colorScheme.onPrimary.withOpacity(0.7)),
              const SizedBox(width: 5),
              Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}
