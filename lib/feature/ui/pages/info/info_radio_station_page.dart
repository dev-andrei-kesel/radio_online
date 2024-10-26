import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:radio_online/common/app_text_styles.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/feature/domain/entities/radio_station_entity.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/string_resources.dart';

class InfoRadioStationPage extends StatelessWidget {
  final RadioStationEntity radioStationEntity;
  static const String routeName = '/info_page';

  const InfoRadioStationPage({super.key, required this.radioStationEntity});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.background,
        foregroundColor: context.colors.text,
        centerTitle: true,
        title: Text(
          style: context.styles.title,
          maxLines: 2,
          StringResources.stationTitle,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        width: size.width,
        height: size.height,
        color: context.colors.background,
        child: ListView(
          children: [
            const SizedBox(height: 12.0),
            Container(
              decoration: BoxDecoration(
                color: context.colors.selected.withOpacity(0.15),
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              child: CachedNetworkImage(
                width: size.width,
                height: size.height * 0.3,
                fit: BoxFit.fill,
                imageUrl: Uri.parse(radioStationEntity.favicon?.isNotEmpty ==
                            true
                        ? radioStationEntity.favicon ?? StringResources.imageUrl
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
            ),
            if (radioStationEntity.name?.isNotEmpty == true) ...[
              const SizedBox(height: 24.0),
              Text(
                textAlign: TextAlign.start,
                style: context.styles.nameBold,
                StringResources.name,
              ),
              Text(
                textAlign: TextAlign.start,
                style: context.styles.name,
                '${radioStationEntity.name?.trim()}',
              ),
            ],
            if (radioStationEntity.votes != null) ...[
              const SizedBox(height: 12.0),
              Text(
                textAlign: TextAlign.start,
                style: context.styles.nameBold,
                StringResources.votes,
              ),
              Text(
                textAlign: TextAlign.start,
                style: context.styles.name,
                '${radioStationEntity.votes}',
              ),
            ],
            if (radioStationEntity.country?.isNotEmpty == true) ...[
              const SizedBox(height: 12.0),
              Text(
                textAlign: TextAlign.start,
                style: context.styles.nameBold,
                StringResources.country,
              ),
              Text(
                textAlign: TextAlign.start,
                style: context.styles.name,
                '${radioStationEntity.country?.trim()}',
              ),
            ],
            if (radioStationEntity.language?.isNotEmpty == true) ...[
              const SizedBox(height: 12.0),
              Text(
                textAlign: TextAlign.start,
                style: context.styles.nameBold,
                StringResources.language,
              ),
              Text(
                textAlign: TextAlign.start,
                style: context.styles.name,
                '${radioStationEntity.language?.trim()}',
              ),
            ],
            if (radioStationEntity.tags?.isNotEmpty == true) ...[
              const SizedBox(height: 12.0),
              Text(
                textAlign: TextAlign.start,
                style: context.styles.nameBold,
                StringResources.genre,
              ),
              Text(
                textAlign: TextAlign.start,
                style: context.styles.name,
                '${radioStationEntity.tags?.trim().replaceAll(',', ', ')}',
              ),
            ],
            if (radioStationEntity.homepage?.isNotEmpty == true) ...[
              const SizedBox(height: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    style: context.styles.nameBold,
                    StringResources.homepage,
                  ),
                  InkWell(
                    onTap: () async {
                      final Uri url =
                          Uri.parse(radioStationEntity.homepage ?? '');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      }
                    },
                    child: Text(
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                      '${radioStationEntity.homepage}',
                    ),
                  ),
                  const SizedBox(height: 12.0),
                ],
              ),
            ] else ...[
              const SizedBox(),
            ],
          ],
        ),
      ),
    );
  }
}
