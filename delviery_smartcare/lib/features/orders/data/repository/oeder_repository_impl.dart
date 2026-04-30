import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/datum.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/apiservices/api_service.dart';

class OrderRepositoryImpl {
  final ApiService _apiService;

  OrderRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  Future<Either<Failure, List<OrderDelvieryShippingDatum>>>
      getShippingOrders() async {
    try {
      final result = await _apiService.get('/Delivery/orders/Ready-Of-Ship');

      return result.fold(
        (failure) =>
            Left<Failure, List<OrderDelvieryShippingDatum>>(failure),

        (response) {
          try {
            final raw = response.data;

            if (raw == null || raw.toString().isEmpty) {
              return Left<Failure, List<OrderDelvieryShippingDatum>>(
                ParseFailure('Empty response body'),
              );
            }

            final json = raw is String ? jsonDecode(raw) : raw;

            if (json is! Map<String, dynamic>) {
              return Left<Failure, List<OrderDelvieryShippingDatum>>(
                ParseFailure('Invalid response format'),
              );
            }

            final dataList = (json['data'] as List?) ?? [];

            final orders = dataList
                .map((e) => OrderDelvieryShippingDatum.fromJson(
                    e as Map<String, dynamic>))
                .toList();

            return Right<Failure, List<OrderDelvieryShippingDatum>>(orders);
          } catch (e) {
            return Left<Failure, List<OrderDelvieryShippingDatum>>(
              ParseFailure('Parsing error: $e'),
            );
          }
        },
      );
    } catch (e) {
      return Left<Failure, List<OrderDelvieryShippingDatum>>(
        FailureHandler.handleException(e),
      );
    }
  }
}