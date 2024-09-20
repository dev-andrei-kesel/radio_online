import 'package:flutter/cupertino.dart';
import 'package:radio_online/common/app_text_styles.dart';

class RadioRatingWidget extends StatelessWidget {
  final IconData icon;
  final String? value;
  final Color color;

  const RadioRatingWidget(
      {super.key,
      required this.icon,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: color,
        ),
        const SizedBox(width: 2),
        Text(
          textAlign: TextAlign.center,
          style: context.styles.header,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          value ?? "",
        ),
      ],
    );
  }
}
