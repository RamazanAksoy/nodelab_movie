import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      backgroundColor: Colors.black.withOpacity(0.8),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
        decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(24)),
        child: Row(
          children: [
            _navItem(icon: Icons.home, label: "Anasayfa", index: 0),
            const SizedBox(width: 30),
            _navItem(icon: Icons.person, label: "Profil", index: 1),
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
            border: Border.all(color: isSelected ? Colors.white : Colors.grey.withOpacity(0.3), width: 1),
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(100), // oval köşeler
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: isSelected ? Colors.white : Colors.white70),
              const SizedBox(width: 5),
              Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}
