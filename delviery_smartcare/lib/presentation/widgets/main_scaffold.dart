import 'package:delviery_smartcare/features/orders/presentation/views/order_status_view.dart';
import 'package:delviery_smartcare/presentation/widgets/build_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../features/home/presentation/views/live_map_view.dart';
import '../../features/orders/presentation/views/available_orders_view.dart';
import '../../features/orders/presentation/cubits/orders/orders_cubit.dart';
import '../../features/orders/presentation/cubits/orders/orders_state.dart';
import '../../features/orders/presentation/views/order_details_view.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;
  String? _lastNavigatedOrderId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<OrdersCubit>().loadOrders();
    });
  }

  final List<Widget> _screens = [
    const LiveMapView(),
    const AvailableOrdersView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersCubit, OrdersState>(
      listenWhen: (p, c) =>
          p.activeOrder?.orderId != c.activeOrder?.orderId ||
          p.lastAutoAcceptedOrder?.orderId !=
              c.lastAutoAcceptedOrder?.orderId ||
          (p.status != c.status && c.status == OrdersStatus.actionSuccess),
      listener: (context, state) {
        // Handle Auto Accept
        if (state.status == OrdersStatus.actionSuccess &&
            state.actionType == OrderActionType.accept &&
            state.isAutoAcceptEnabled &&
            state.lastAutoAcceptedOrder != null &&
            _lastNavigatedOrderId != state.lastAutoAcceptedOrder!.orderId) {
          _lastNavigatedOrderId = state.lastAutoAcceptedOrder!.orderId;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OrderDetailsView(order: state.lastAutoAcceptedOrder!),
            ),
          );
        }

        // Handle Active Order (Restore or Resume)
        // Only push if we haven't navigated to this specific order yet
        // AND it's not a manual accept (which is handled in OrderDetailsBody)
        if (state.activeOrder != null &&
            _lastNavigatedOrderId != state.activeOrder!.orderId &&
            state.actionType != OrderActionType.accept) {
          _lastNavigatedOrderId = state.activeOrder!.orderId;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => OrderStatusView(order: state.activeOrder!)),
            (route) => false,
          );
        }

        // Reset tracking when active order is cleared
        if (state.activeOrder == null && state.lastAutoAcceptedOrder == null) {
          _lastNavigatedOrderId = null;
        }
      },
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: Text(
            _currentIndex == 0 ? 'Home' : 'Available Orders',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
                context.read<OrdersCubit>().loadOrders();
              }
            },
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            items: [
              BottomNavigationBarItem(
                icon: buildNavIcon(Icons.map_outlined, 0),
                activeIcon: buildNavIcon(Icons.map, 0, isActive: true),
                label: 'HOME',
              ),
              BottomNavigationBarItem(
                icon: buildNavIcon(Icons.list_alt_outlined, 1),
                activeIcon: buildNavIcon(Icons.list_alt, 1, isActive: true),
                label: 'ORDERS',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
