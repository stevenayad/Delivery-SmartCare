import 'package:meta/meta.dart';
import '../../data/models/order_model.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersLoaded extends OrdersState {
  final List<OrderModel> orders;
  final String activeFilter;

  OrdersLoaded({
    required this.orders,
    required this.activeFilter,
  });
}

final class OrdersError extends OrdersState {
  final String message;
  OrdersError(this.message);
}
