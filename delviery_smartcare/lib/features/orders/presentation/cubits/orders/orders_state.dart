import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/order_delviery_datum.dart';
import 'package:meta/meta.dart';

enum OrdersViewType { normal, nearest, smart }

enum OrdersStatus { initial, loading, success, error, actionSuccess }

enum OrderActionType { accept, shipping, confirm }

enum ErrorType { loadingerror, accepterror, shippingerror, confirmerror, loaderror }

@immutable
class OrdersState {
  final List<OrderDelvieryShippingDatum> orders;
  final OrdersViewType viewType;
  final OrdersStatus status;
  final OrderActionType? actionType;
  final ErrorType? errorType;
  final String? errorMessage;
  final bool isAutoAcceptEnabled;
  final OrderDelvieryShippingDatum? lastAutoAcceptedOrder;
  final OrderDelvieryShippingDatum? activeOrder;
  final List<OrderDelvieryShippingDatum> orderHistory;

  const OrdersState({
    this.orders = const [],
    this.viewType = OrdersViewType.normal,
    this.status = OrdersStatus.initial,
    this.actionType,
    this.errorMessage,
    this.isAutoAcceptEnabled = false,
    this.lastAutoAcceptedOrder,
    this.activeOrder,
    this.orderHistory = const [],
    this.errorType,
  });

  OrdersState copyWith({
    List<OrderDelvieryShippingDatum>? orders,
    OrdersViewType? viewType,
    OrdersStatus? status,
    OrderActionType? actionType,
    ErrorType? errorType,
    String? errorMessage,
    bool? isAutoAcceptEnabled,
    OrderDelvieryShippingDatum? lastAutoAcceptedOrder,
    OrderDelvieryShippingDatum? activeOrder,
    List<OrderDelvieryShippingDatum>? orderHistory,
    bool clearActionType = false,
    bool clearAutoAcceptedOrder = false,
    bool clearActiveOrder = false,
    bool clearErrorType = false,
  }) {
    return OrdersState(
      orders: orders ?? this.orders,
      viewType: viewType ?? this.viewType,
      status: status ?? this.status,
      actionType: clearActionType ? null : (actionType ?? this.actionType),
      errorType: clearErrorType ? null : (errorType ?? this.errorType),
      errorMessage: errorMessage ?? this.errorMessage,
      isAutoAcceptEnabled: isAutoAcceptEnabled ?? this.isAutoAcceptEnabled,
      lastAutoAcceptedOrder: clearAutoAcceptedOrder
          ? null
          : (lastAutoAcceptedOrder ?? this.lastAutoAcceptedOrder),
      activeOrder: clearActiveOrder ? null : (activeOrder ?? this.activeOrder),
      orderHistory: orderHistory ?? this.orderHistory,
    );
  }
}
