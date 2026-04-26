import 'package:flutter/material.dart';
import 'package:delviery_smartcare/features/map/presentation/views/widgets/live_map_body.dart';


class LiveMapView extends StatelessWidget {
  const LiveMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LiveMapBody(),
    );
  }
}