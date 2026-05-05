import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primary,
      child: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(top: 64.0, bottom: 64.0),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, size: 80, color: Colors.white70),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(color: Colors.white24),
              ),
              BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, state) {
                  return SwitchListTile(
                    title: const Text(
                      'Auto Accept Orders',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    subtitle: const Text(
                      'Best orders will be accepted automatically',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    value: state.isAutoAcceptEnabled,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.greenAccent,
                    onChanged: (value) {
                      context.read<OrdersCubit>().toggleAutoAccept(value);
                    },
                  );
                },
              ),
              const Spacer(),
              DefaultTextStyle(
                style: const TextStyle(fontSize: 12, color: Colors.white54),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  child: const Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildNavIcon(IconData icon, int index, {bool isActive = false}) {
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
