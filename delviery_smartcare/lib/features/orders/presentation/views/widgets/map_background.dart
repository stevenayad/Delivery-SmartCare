import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MapBackground extends StatelessWidget {
  const MapBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return  Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 250,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/map_route.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.4),
                    BlendMode.screen,
                  ),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.teal.withOpacity(0.3), AppColors.background],
                ),
              ),
            ),
          );
  }
}