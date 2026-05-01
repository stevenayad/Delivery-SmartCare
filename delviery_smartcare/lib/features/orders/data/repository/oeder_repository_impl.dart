import 'package:dartz/dartz.dart';
import 'package:delviery_smartcare/core/servieces/faliure_services.dart';
import '../../../../core/errors/failure.dart' hide Failure;
import '../../../../core/apiservices/api_service.dart';
import '../models/order_delviery_shippinf/datum.dart';

class OrderRepositoryImpl {
  final ApiService _apiService;

  OrderRepositoryImpl({required ApiService apiService})
    : _apiService = apiService;

  Future<Either<Failure, List<OrderDelvieryShippingDatum>>>
  getShippingOrders() async {
    try {
      final response = await _apiService.get(
        '/api/Delivery/orders/Ready-Of-Ship',
      );

      final dataList = (response['data'] as List?) ?? [];

      final orders = dataList
          .map((e) => OrderDelvieryShippingDatum.fromJson(e))
          .toList();

      return Right(orders);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(servivefailure("Parsing error"));
    }
  }

  Future<Either<Failure, String>> AcceptOrder(String orderId) async {
    try {
      final response = await _apiService.patch(
        '/api/Delivery/orders/Accepted?orderId=${orderId}',
        null,
      );

      final message = response['message'];

      return Right(message);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(servivefailure("Parsing error"));
    }
  }

 Future<Either<Failure, String>> ShippingOrder(String orderId) async {
  try {
    final res = await _apiService.get('/api/orders/details/$orderId');

    final data = res is Map ? res : res.data;

    final status = data['data']['status'];

    print('status = $status');

    if (status == 2) {
      return Right("Delviery Shipping order now");
    } else {
      return Left(servivefailure("Order not ready for shipping"));
    }

  } catch (e) {
    return Left(servivefailure(e.toString()));
  }
}

  Future<Either<Failure, String>> ConfrimOrder(String orderId) async {
    try {
      final response = await _apiService.patch(
        '/api/Delivery/orders/${orderId}/confirm-delivery',
        null,
      );

      final message = response['message'];

      return Right(message);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(servivefailure("Parsing error"));
    }
  }
}
