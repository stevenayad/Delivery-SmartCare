import 'package:flutter/material.dart';

class MapControls extends StatelessWidget {
  const MapControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildControlIcon(Icons.my_location),
        const SizedBox(height: 12),
        _buildControlIcon(Icons.layers),
      ],
    );
  }

  Widget _buildControlIcon(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
          ),
        ],
      ),
      child: Icon(icon, color: Colors.grey[700]),
    );
  }
}
