import 'package:flutter/material.dart';
import '../constants/theme.dart';

class LocationSelector extends StatelessWidget {
  const LocationSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          color: AppTheme.primaryRed,
        ),
        const SizedBox(width: 8),
        Text(
          'Current Location',
          style: AppTheme.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Icon(
          Icons.keyboard_arrow_down,
          color: AppTheme.primaryRed,
        ),
      ],
    );
  }
} 