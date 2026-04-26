import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/order_model.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  void loadOrders() {
    emit(OrdersLoading());
    // Dummy data
    final orders = [
      OrderModel(
        id: '#12345',
        title: 'CVS Pharmacy - West Side',
        sourceAddress: '892 Medical Plaza Dr, Suite 400',
        destinationAddress: '142 Oak Avenue, Apt 4B',
        distance: '2.5 km',
        eta: '15 min',
        earning: '\$15.50',
        isPaid: true,
      ),
      OrderModel(
        id: '#12348',
        title: 'Walgreens Health',
        sourceAddress: '4410 Central Ave',
        destinationAddress: '78 Pinecrest Blvd',
        distance: '4.1 km',
        eta: '22 min',
        earning: '\$18.75',
        isPaid: false, // COD
      ),
      OrderModel(
        id: '#12351',
        title: 'Rite Aid Pharmacy',
        sourceAddress: '1.2 km away',
        destinationAddress: '', // Handle empty/missing destination in UI
        distance: '1.2 km',
        eta: '',
        earning: '\$12.00',
        isPaid: true,
      ),
    ];
    emit(OrdersLoaded(orders: orders, activeFilter: 'Nearby'));
  }

  void setFilter(String filter) {
    if (state is OrdersLoaded) {
      emit(OrdersLoaded(
        orders: (state as OrdersLoaded).orders,
        activeFilter: filter,
      ));
    }
  }
}
