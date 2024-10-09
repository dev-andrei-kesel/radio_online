import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_online/common/app_text_styles.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/feature/domain/entities/radio_station_entity.dart';
import 'package:radio_online/feature/ui/pages/info/info_radio_station_page.dart';
import 'package:radio_online/feature/ui/widgets/radio_stations_info_widget.dart';

import '../../../audio/audio_player_handler.dart';
import '../../../common/string_resources.dart';

class RadioStationWidget extends StatelessWidget {
  final AudioHandler? audioHandler;
  final bool isFavoriteScreen;
  final RadioStationEntity? radioStationEntity;
  final Size size;
  final Function(RadioStationEntity?) onClick;
  final Function(RadioStationEntity?)? onDeleteStation;

  const RadioStationWidget(
    this.onDeleteStation, {
    super.key,
    required this.radioStationEntity,
    required this.size,
    required this.onClick,
    required this.isFavoriteScreen,
    required this.audioHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: context.colors.selected.withOpacity(0.20),
                width: 0.8,
              ),
              borderRadius: BorderRadius.circular(17.0),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              child: Column(
                children: [
                  Container(
                    height: 48.0,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: context.colors.selected.withOpacity(0.15),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16.0),
                        topLeft: Radius.circular(16.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: Text(
                          textAlign: TextAlign.start,
                          style: context.styles.text,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          radioStationEntity?.name ?? '',
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder<String>(
                    stream: (audioHandler as AudioPlayerHandler).checkUrlStream,
                    builder: (context, snapshot) {
                      final checkUrl = snapshot.data;
                      return InkWell(
                        onTap: () => onClick(radioStationEntity),
                        onLongPress: () => onDeleteStation != null
                            ? onDeleteStation!(radioStationEntity)
                            : null,
                        child: Container(
                          color: context.colors.selected.withOpacity(0.20),
                          child: Stack(children: [
                            CachedNetworkImage(
                              width: size.width,
                              height: size.height * 0.3,
                              fit: BoxFit.fill,
                              imageUrl: Uri.parse(
                                      radioStationEntity?.favicon?.isNotEmpty ==
                                              true
                                          ? radioStationEntity?.favicon ??
                                              StringResources.imageUrl
                                          : StringResources.imageUrl)
                                  .toString(),
                              placeholder: (context, url) => SizedBox(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: context.colors.background,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Icon(
                                  color: context.colors.unselected,
                                  Icons.radio,
                                  size: size.height * 0.3,
                                ),
                              ),
                            ),
                            if (checkUrl == radioStationEntity?.url)
                              Container(
                                width: size.width,
                                height: size.height * 0.3,
                                color: Colors.black.withOpacity(0.30),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ]),
                        ),
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: context.colors.selected.withOpacity(0.15),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(16.0),
                        bottomLeft: Radius.circular(16.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RadioStationsInfoWidget(
                          radioStationEntity: radioStationEntity,
                        ),
                        Row(
                          children: [
                            isFavoriteScreen
                                ? IconButton(
                                    onPressed: () => onDeleteStation != null
                                        ? onDeleteStation!(radioStationEntity)
                                        : null,
                                    icon: Icon(
                                        color: context.colors.selected,
                                        Icons.delete),
                                  )
                                : const SizedBox(),
                            IconButton(
                              onPressed: () {
                                context.push(InfoRadioStationPage.routeName,
                                    extra: radioStationEntity);
                              },
                              icon: Icon(
                                  color: context.colors.selected,
                                  Icons.remove_red_eye),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
