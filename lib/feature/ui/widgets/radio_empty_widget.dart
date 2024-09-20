import 'package:flutter/material.dart';
import 'package:radio_online/common/app_text_styles.dart';
import 'package:radio_online/common/colors_dark.dart';

import '../../../common/string_resources.dart';

class RadioEmptyWidget extends StatelessWidget {
  const RadioEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.background,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            size: 200.0,
            Icons.headset_off,
            color: context.colors.selected,
          ),
          Text(
            StringResources.emptyMessage,
            style: context.styles.title,
          ),
        ],
      )),
    );
  }
}
