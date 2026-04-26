import 'dart:io';
import 'package:flutter/material.dart';
import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'final_stage_view.dart';
import 'widgets/eta_overlay.dart';
import 'widgets/map_controls.dart';
import 'widgets/tracking_bottom_card.dart';

class TrackingOrderView extends StatelessWidget {
  const TrackingOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full Screen Map
          Positioned.fill(
            child: Image.asset(
              'assets/images/map_tracking.png',
              fit: BoxFit.cover,
            ),
          ),

          // Top Overlay
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15),
                boxShadow: AppColors.softShadow,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Tracking Order',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Heading to Destination',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none),
                    onPressed: () {},
                  ),
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?u=driver',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ETA Overlay
          const Positioned(
            top: 130,
            left: 20,
            child: ETAOverlay(
              eta: '8 MIN',
              distanceRemaining: '0.4 miles remaining',
            ),
          ),

          // Map Controls
          const Positioned(top: 130, right: 20, child: MapControls()),

          // Bottom Card
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: TrackingBottomCard(
              address: '404 Lincoln Park',
              cityZip: 'Lincoln Park, Chicago, IL 60614',
              recipientName: 'Mrs. Sarah Jenkins',
              onCall: () {},
              onReached: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FinalStageView(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
