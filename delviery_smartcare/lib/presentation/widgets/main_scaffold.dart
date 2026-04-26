import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../features/map/presentation/views/live_map_view.dart';
import '../../features/orders/presentation/views/available_orders_view.dart';
import '../../features/orders/presentation/cubits/orders_cubit.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const LiveMapView(),
    const AvailableOrdersView(),
    const Center(child: Text('Profile Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            if (index == 1) {
              // Refresh orders when switching to orders tab
              context.read<OrdersCubit>().loadOrders();
            }
          },
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: [
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.map_outlined, 0),
              activeIcon: _buildNavIcon(Icons.map, 0, isActive: true),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.list_alt_outlined, 1),
              activeIcon: _buildNavIcon(Icons.list_alt, 1, isActive: true),
              label: 'ORDERS',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.person_outline, 2),
              activeIcon: _buildNavIcon(Icons.person, 2, isActive: true),
              label: 'PROFILE',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index, {bool isActive = false}) {
    if (!isActive) return Icon(icon);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: AppColors.primary),
    );
  }
}
