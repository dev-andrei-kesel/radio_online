import 'package:flutter/material.dart';
import 'package:radio_online/common/app_text_styles.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/core/error/failures/network_failure.dart';

import '../../../common/string_resources.dart';
import '../../../core/error/failures/failure.dart';

class RadioErrorWidget extends StatelessWidget {
  final Failure? failure;
  final VoidCallback? onSwipe;

  const RadioErrorWidget({super.key, this.failure, required this.onSwipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dy > 0) {
          onSwipe != null ? onSwipe!() : null;
        }
      },
      child: Container(
        color: context.colors.background,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                size: 200.0,
                failure is NetworkFailure
                    ? Icons.wifi_tethering_error
                    : Icons.dangerous_rounded,
                color: context.colors.selected,
              ),
              Text(
                failure is NetworkFailure
                    ? StringResources.networkErrorTitle
                    : StringResources.serverErrorTitle,
                style: context.styles.title,
              ),
              Text(
                StringResources.serverErrorMessage,
                style: context.styles.title,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
