import 'package:flutter/material.dart';
import 'package:radio_online/common/app_text_styles.dart';
import 'package:radio_online/common/colors_dark.dart';

import '../../../common/string_resources.dart';

class RadioEmptyWidget extends StatelessWidget {
  final double? height;
  const RadioEmptyWidget({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: context.colors.background,
      child: Center(
        key: const Key('radioEmptyWidgetCenter'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible( // Using Flexible
              child: Icon(
                size: 150.0, // Reduced size
                Icons.headset_off,
                color: context.colors.selected,
              ),
            ),
            Flexible( // Using Flexible
              child: Text(
                StringResources.emptyMessage,
                style: context.styles.title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}