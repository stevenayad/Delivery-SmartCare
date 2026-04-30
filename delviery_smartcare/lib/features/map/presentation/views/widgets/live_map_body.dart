import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:delviery_smartcare/features/map/presentation/cubits/map_cubit.dart';
import 'package:delviery_smartcare/features/map/presentation/views/widgets/Map_floating_button.dart';
import 'package:delviery_smartcare/features/map/presentation/views/widgets/Map_header.dart';
import 'package:delviery_smartcare/features/map/presentation/views/widgets/map_view.dart'
    show MapViewWidget;
import 'package:delviery_smartcare/features/map/presentation/views/widgets/order_preview_card.dart';

class LiveMapBody extends StatefulWidget {
  const LiveMapBody();

  @override
  State<LiveMapBody> createState() => _LiveMapBodyState();
}

class _LiveMapBodyState extends State<LiveMapBody> {
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<MapCubit>().initializeMap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapViewWidget(onMapCreated: (c) => _mapController = c),
        const MapHeader(),
        const MapFloatingButtons(),
        Positioned(
          bottom: 24,
          left: 16,
          right: 16,
          child: OrderPreviewCard(
            title: 'New Order Available',
            payout: '\$15.50',
            distanceInfo: 'PharmaPlus • 2.5 km away',
            onViewDetails: () {},
            onClose: () {},
          ),
        ),
      ],
    );
  }
}
