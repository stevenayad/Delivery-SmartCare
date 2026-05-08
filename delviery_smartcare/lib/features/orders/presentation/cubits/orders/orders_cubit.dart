import 'package:delviery_smartcare/features/orders/data/repository/oeder_repository_impl.dart';
import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/order_delviery_datum.dart';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrderRepositoryImpl _ordersRepository;
  List<OrderDelvieryShippingDatum> _originalOrders = [];
  String? _lastAcceptedId;
  final _storage = const FlutterSecureStorage();
  static const _activeOrderKey = 'active_order';
  static const _orderHistoryKey = 'order_history';

  OrdersCubit(this._ordersRepository) : super(const OrdersState()) {
    print("Order Cubit Called");
    restoreState();
  }

  Future<void> restoreState() async {
    try {
      final activeOrderStr = await _storage.read(key: _activeOrderKey);
      final historyStr = await _storage.read(key: _orderHistoryKey);

      OrderDelvieryShippingDatum? activeOrder;
      List<OrderDelvieryShippingDatum> orderHistory = [];

      if (activeOrderStr != null) {
        activeOrder = OrderDelvieryShippingDatum.fromJson(
          jsonDecode(activeOrderStr),
        );
      }

      if (historyStr != null) {
        final List<dynamic> decoded = jsonDecode(historyStr);
        orderHistory = decoded
            .map(
              (e) => OrderDelvieryShippingDatum.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();
      }

      emit(
        state.copyWith(activeOrder: activeOrder, orderHistory: orderHistory),
      );
    } catch (e) {}
  }

  Future<void> _saveActiveOrder(OrderDelvieryShippingDatum order) async {
    try {
      print("Saving Order : $order");
      final jsonStr = jsonEncode(order.toJson());
      await _storage.write(key: _activeOrderKey, value: jsonStr);
    } catch (e) {
      // Ignore errors
    }
  }

  Future<void> _moveToHistory() async {
    print('Moving to history');
    if (state.activeOrder != null) {
      final newHistory = List<OrderDelvieryShippingDatum>.from(
        state.orderHistory,
      );
      if (!newHistory.any((o) => o.orderId == state.activeOrder!.orderId)) {
        newHistory.add(state.activeOrder!);
      }

      try {
        final jsonStr = jsonEncode(newHistory.map((e) => e.toJson()).toList());
        await _storage.write(key: _orderHistoryKey, value: jsonStr);
        await _storage.delete(key: _activeOrderKey);
      } catch (e) {
        // Ignore errors
      }

      emit(state.copyWith(orderHistory: newHistory));
    } else {
      await _storage.delete(key: _activeOrderKey);
    }
  }

  void toggleAutoAccept(bool value) {
    emit(state.copyWith(isAutoAcceptEnabled: value));

    if (value) {
      final currentOrders = state.orders.isNotEmpty
          ? state.orders
          : _originalOrders;

      handleAutoAccept(currentOrders);
    }
  }

  void handleAutoAccept(List<OrderDelvieryShippingDatum> orders) {
    if (!state.isAutoAcceptEnabled) return;
    if (orders.isEmpty) return;

    final bestOrder = orders.first;

    if (_lastAcceptedId == bestOrder.orderId) return;

    _lastAcceptedId = bestOrder.orderId;
    _performAutoAccept(bestOrder);
  }

  Future<void> _performAutoAccept(OrderDelvieryShippingDatum order) async {
    final result = await _ordersRepository.AcceptOrder(order.orderId!);

    result.fold(
      (failure) {
        _lastAcceptedId = null;
        emit(
          state.copyWith(
            status: OrdersStatus.error,
            errorType: ErrorType.accepterror,
            errorMessage: failure.errMessage,
          ),
        );
      },
      (message) {
        _saveActiveOrder(order);
        emit(
          state.copyWith(
            status: OrdersStatus.actionSuccess,
            actionType: OrderActionType.accept,
            lastAutoAcceptedOrder: order,
            activeOrder: order,
          ),
        );
      },
    );
  }

  Future<void> loadOrders() async {
    emit(
      state.copyWith(
        status: OrdersStatus.loading,
        clearActionType: true,
        clearAutoAcceptedOrder: true,
        clearErrorType: true,
      ),
    );

    final result = await _ordersRepository.getShippingOrders();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: OrdersStatus.error,
          errorType: ErrorType.loaderror,
          errorMessage: failure.errMessage,
        ),
      ),
      (data) {
        _originalOrders = data;
        emit(
          state.copyWith(
            status: OrdersStatus.success,
            orders: data,
            viewType: OrdersViewType.normal,
          ),
        );
        handleAutoAccept(data);
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
          final scoreA =
              ((a.totalPrice ?? 0.0) * priceWeight) -
              ((a.distanceKm ?? 0.0) * distanceWeight);
          final scoreB =
              ((b.totalPrice ?? 0.0) * priceWeight) -
              ((b.distanceKm ?? 0.0) * distanceWeight);
          return scoreB.compareTo(scoreA);
        });
    } else {
      sortedOrders = _originalOrders;
    }

    emit(
      state.copyWith(
        status: OrdersStatus.success,
        viewType: type,
        orders: sortedOrders,
      ),
    );
    handleAutoAccept(sortedOrders);
  }

  Future<void> acceptOrder(String orderId) async {
    emit(state.copyWith(status: OrdersStatus.loading, clearActionType: true, clearErrorType: true));
    final result = await _ordersRepository.AcceptOrder(orderId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: OrdersStatus.error,
          errorType: ErrorType.accepterror,
          errorMessage: failure.errMessage,
        ),
      ),
      (message) {
        OrderDelvieryShippingDatum? active;
        try {
          active = _originalOrders.firstWhere((o) => o.orderId == orderId);
        } catch (e) {
          active = OrderDelvieryShippingDatum(orderId: orderId);
        }
        _saveActiveOrder(active);

        emit(
          state.copyWith(
            status: OrdersStatus.actionSuccess,
            actionType: OrderActionType.accept,
            activeOrder: active,
          ),
        );
      },
    );
  }

  Future<void> shippingOrder(String orderId) async {
    final result = await _ordersRepository.ShippingOrder(orderId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: OrdersStatus.error,
          errorType: ErrorType.shippingerror,
          errorMessage: failure.errMessage,
        ),
      ),
      (message) => emit(
        state.copyWith(
          status: OrdersStatus.actionSuccess,
          actionType: OrderActionType.shipping,
        ),
      ),
    );
  }

  Future<void> confirmOrder(String orderId) async {
    emit(state.copyWith(
        status: OrdersStatus.loading,
        clearActionType: true,
        clearErrorType: true));
    final result = await _ordersRepository.ConfrimOrder(orderId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: OrdersStatus.error,
          errorType: ErrorType.confirmerror,
          errorMessage: failure.errMessage,
        ),
      ),
      (message) {
        _moveToHistory();
        emit(
          state.copyWith(
            status: OrdersStatus.actionSuccess,
            actionType: OrderActionType.confirm,
            clearActiveOrder: true,
          ),
        );
      },
    );
  }
}
