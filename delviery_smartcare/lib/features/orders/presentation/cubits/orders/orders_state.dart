import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/order_delviery_datum.dart';
import 'package:meta/meta.dart';

enum OrdersViewType { normal, nearest, smart }

enum OrdersStatus { initial, loading, success, error, actionSuccess }

enum OrderActionType { accept, shipping, confirm }

@immutable
class OrdersState {
  final List<OrderDelvieryShippingDatum> orders;
  final OrdersViewType viewType;
  final OrdersStatus status;
  final OrderActionType? actionType;
  final String? errorMessage;

  const OrdersState({
    this.orders = const [],
    this.viewType = OrdersViewType.normal,
    this.status = OrdersStatus.initial,
    this.actionType,
    this.errorMessage,
  });

  OrdersState copyWith({
    List<OrderDelvieryShippingDatum>? orders,
    OrdersViewType? viewType,
    OrdersStatus? status,
    OrderActionType? actionType,
    String? errorMessage,
    bool clearActionType = false,
  }) {
    return OrdersState(
      orders: orders ?? this.orders,
      viewType: viewType ?? this.viewType,
      status: status ?? this.status,
      actionType: clearActionType ? null : (actionType ?? this.actionType),
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
