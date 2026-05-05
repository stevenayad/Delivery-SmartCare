import 'package:delviery_smartcare/features/map/presentation/cubits/nearest_store/neareststore_cubit.dart';
import 'package:delviery_smartcare/features/map/presentation/cubits/nearest_store/neareststore_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:delviery_smartcare/features/map/presentation/cubits/map_init/map_cubit.dart';
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
        MapViewWidget(),
       // const MapHeader(),
        const MapFloatingButtons(),
        Positioned(
          bottom: 24,
          left: 16,
          right: 16,
          child: BlocBuilder<NeareststoreCubit, NearestStoreState>(
            builder: (context, state) {
              if (state is NearestStoreSuccess) {
                return OrderPreviewCard(
                  store: state.store, 
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
