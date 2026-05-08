import 'package:delviery_smartcare/core/servieces/location_serviecs.dart';
import 'package:delviery_smartcare/core/servieces/tracking_services.dart';
import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/order_delviery_datum.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_state.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/tracking/tracking_cubit_cubit.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/build_marker.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/build_polyline.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/button_tracking.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/top_section_tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class TrackingOrderView extends StatefulWidget {
  const TrackingOrderView({super.key, required this.order});

  final OrderDelvieryShippingDatum order;

  @override
  State<TrackingOrderView> createState() => _TrackingOrderViewState();
}

class _TrackingOrderViewState extends State<TrackingOrderView> {
  LocationData? locationData;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    final loc = await LocationServices.getlocationData();

    setState(() {
      locationData = loc;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (locationData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (widget.order.storeLatitude == null ||
        widget.order.storeLongitude == null ||
        widget.order.clientLatitude == null ||
        widget.order.clientLongitude == null) {
      return const Scaffold(body: Center(child: Text("Invalid location data")));
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<TrackingCubit>(
          create: (_) => TrackingCubit(TrackingService())
            ..initialize(
              driverLat: locationData!.latitude!,
              driverLng: locationData!.longitude!,
              storeLat: widget.order.storeLatitude!,
              storeLng: widget.order.storeLongitude!,
              userLat: widget.order.clientLatitude!,
              userLng: widget.order.clientLongitude!,
            ),
        ),

        BlocProvider.value(value: context.read<OrdersCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<TrackingCubit, TrackingState>(
            listenWhen: (p, c) => p.driverPosition != c.driverPosition,
            listener: (context, state) {
              _mapController?.animateCamera(
                CameraUpdate.newLatLng(state.driverPosition),
              );
            },
          ),

          BlocListener<OrdersCubit, OrdersState>(
            listener: (context, state) {
              if (state.status == OrdersStatus.actionSuccess && 
                  state.actionType == OrderActionType.shipping) {
                context.read<TrackingCubit>().moveToUser();
              }

              if (state.status == OrdersStatus.error && state.errorType == ErrorType.shippingerror) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? "Error"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
        child: Scaffold(
          body: Stack(
            children: [
              BlocBuilder<TrackingCubit, TrackingState>(
                builder: (context, state) {
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: state.driverPosition,
                      zoom: 14,
                    ),
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    markers: buildMarkers(state),
                    polylines: buildPolylines(state),
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                  );
                },
              ),

              const TopSectionTracking(),

              ButtonTracking(order: widget.order),
            ],
          ),
        ),
      ),
    );
  }
}
