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
      (failure) => emit(OrdersError(failure.errMessage)),
      (data) => emit(OrdersLoaded(orders: data, activeFilter: 'All')),
    );

    _isLoading = false;
  }
   Future<void> AcceptOrder(String orderId) async {
    if (_isLoading) return;

    _isLoading = true;
    emit(OrdersLoading());

    final result = await _ordersRepository.AcceptOrder(orderId);

    result.fold(
      (failure) => emit(OrdersError(failure.errMessage)),
      (data) => emit(OrderAccepted(data)),
    );

    _isLoading = false;
  }

   Future<void>  ShippingOrder(String orderId) async {
    if (_isLoading) return;

    _isLoading = true;
    emit(OrdersLoading());

    final result = await _ordersRepository.ShippingOrder(orderId);

    result.fold(
      (failure) => emit(OrdersError(failure.errMessage)),
      (data) => emit(OrderShipping(data)),
    );

    _isLoading = false;
  }

   Future<void> ConforimOrder(String orderId) async {
    if (_isLoading) return;

    _isLoading = true;
    emit(OrdersLoading());

    final result = await _ordersRepository.ConfrimOrder(orderId);

    result.fold(
      (failure) => emit(OrdersError(failure.errMessage)),
      (data) => emit(OrdeConfrimed(data)),
    );

    _isLoading = false;
  }




}
