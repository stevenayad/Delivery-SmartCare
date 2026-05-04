import 'package:delviery_smartcare/features/orders/data/repository/oeder_repository_impl.dart';
import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/order_delviery_datum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrderRepositoryImpl _ordersRepository;
  List<OrderDelvieryShippingDatum> _originalOrders = [];

  OrdersCubit(this._ordersRepository) : super(const OrdersState());

  Future<void> loadOrders() async {
    emit(state.copyWith(status: OrdersStatus.loading, clearActionType: true));

    final result = await _ordersRepository.getShippingOrders();

    result.fold(
      (failure) => emit(state.copyWith(
        status: OrdersStatus.error,
        errorMessage: failure.errMessage,
      )),
      (data) {
        _originalOrders = data;
        emit(state.copyWith(
          status: OrdersStatus.success,
          orders: data,
          viewType: OrdersViewType.normal,
        ));
      },
    );
  }

  void changeView(OrdersViewType type) {
    if (state.status != OrdersStatus.success) return;


    const double priceWeight = 1.5;
    const double distanceWeight = 10.0;

    List<OrderDelvieryShippingDatum> sortedOrders;
    
    if (type == OrdersViewType.nearest) {
      sortedOrders = List.from(_originalOrders)
        ..sort((a, b) => (a.distanceKm ?? 0.0).compareTo(b.distanceKm ?? 0.0));
    } else if (type == OrdersViewType.smart) {
      sortedOrders = List.from(_originalOrders)
        ..sort((a, b) {
          final scoreA = ((a.totalPrice ?? 0.0) * priceWeight) - ((a.distanceKm ?? 0.0) * distanceWeight);
          final scoreB = ((b.totalPrice ?? 0.0) * priceWeight) - ((b.distanceKm ?? 0.0) * distanceWeight);
          return scoreB.compareTo(scoreA); 
        });
    } else {
      sortedOrders = _originalOrders;
    }

    emit(state.copyWith(
      status: OrdersStatus.success,
      viewType: type,
      orders: sortedOrders,
    ));
  }

  Future<void> acceptOrder(String orderId) async {
    emit(state.copyWith(status: OrdersStatus.loading, clearActionType: true));
    final result = await _ordersRepository.AcceptOrder(orderId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: OrdersStatus.error, 
        errorMessage: failure.errMessage,
      )),
      (message) => emit(state.copyWith(
        status: OrdersStatus.actionSuccess,
        actionType: OrderActionType.accept,
      )),
    );
  }

  Future<void> shippingOrder(String orderId) async {
    emit(state.copyWith(status: OrdersStatus.loading, clearActionType: true));
    final result = await _ordersRepository.ShippingOrder(orderId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: OrdersStatus.error, 
        errorMessage: failure.errMessage,
      )),
      (message) => emit(state.copyWith(
        status: OrdersStatus.actionSuccess,
        actionType: OrderActionType.shipping,
      )),
    );
  }

  Future<void> confirmOrder(String orderId) async {
    emit(state.copyWith(status: OrdersStatus.loading, clearActionType: true));
    final result = await _ordersRepository.ConfrimOrder(orderId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: OrdersStatus.error, 
        errorMessage: failure.errMessage,
      )),
      (message) => emit(state.copyWith(
        status: OrdersStatus.actionSuccess,
        actionType: OrderActionType.confirm,
      )),
    );
  }
}
