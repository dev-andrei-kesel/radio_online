import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:radio_online/common/app_text_styles.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/feature/domain/entities/radio_station_entity.dart';
import 'package:radio_online/feature/ui/widgets/radio_stations_info_widget.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: context.colors.selected.withOpacity(0.15),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2.0),
                          child: Text(
                            textAlign: TextAlign.start,
                            style: context.styles.text,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            radioStationEntity.name ?? '',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon:
                            const Icon(color: Colors.pink, Icons.info_outline),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => onClick(radioStationEntity),
                  child: Container(
                    color: context.colors.selected.withOpacity(0.20),
                    child: CachedNetworkImage(
                      width: size.width,
                      height: size.height * 0.3,
                      fit: BoxFit.fill,
                      imageUrl: radioStationEntity.favicon ?? '',
                      placeholder: (context, url) => SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: context.colors.background,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => SizedBox(
                        child: Center(
                          child:
                              Image.asset('assets/icons/ic_network_error.png'),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: context.colors.selected.withOpacity(0.15),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    child: RadioStationsInfoWidget(
                      radioStationEntity: radioStationEntity,
                    ),
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
