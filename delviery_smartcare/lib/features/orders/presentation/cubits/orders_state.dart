import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/datum.dart';
import 'package:meta/meta.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersLoaded extends OrdersState {
  final List<OrderDelvieryShippingDatum> orders;
  final String activeFilter;

  OrdersLoaded({required this.orders, required this.activeFilter});
}

final class OrdersError extends OrdersState {
  final String message;
  OrdersError(this.message);
}
