import 'package:delviery_smartcare/features/orders/data/repository/oeder_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrderRepositoryImpl _ordersRepository;

  OrdersCubit(this._ordersRepository) : super(OrdersInitial());
  bool _isLoading = false;

  Future<void> loadOrders() async {
    if (_isLoading) return;

    _isLoading = true;
    emit(OrdersLoading());

    final result = await _ordersRepository.getShippingOrders();

    result.fold(
      (failure) => emit(OrdersError(failure.message)),
      (data) => emit(OrdersLoaded(orders: data, activeFilter: 'All')),
    );

    _isLoading = false;
  }
}
