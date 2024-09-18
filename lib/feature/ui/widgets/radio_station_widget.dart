import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:radio_online/common/app_text_styles.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/feature/domain/entities/radio_station_entity.dart';

class RadioStationWidget extends StatelessWidget {
  final RadioStationEntity radioStationEntity;
  final Size size;
  final Function(RadioStationEntity) onClick;

  const RadioStationWidget(
      {super.key,
      required this.radioStationEntity,
      required this.size,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(radioStationEntity),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Column(
              children: [
                Container(
                  height: size.width / (size.width / 100).toInt(),
                  width: size.width / (size.width / 100).toInt(),
                  color: context.colors.onBackground,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: radioStationEntity.favicon ?? '',
                    placeholder: (context, url) => SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: context.colors.unselected,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => SizedBox(
                      child: Center(
                        child: Image.asset('assets/icons/ic_network_error.png'),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 48,
                  width: size.width / (size.width / 100).toInt(),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    style: context.styles.text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    radioStationEntity.name ?? '',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
