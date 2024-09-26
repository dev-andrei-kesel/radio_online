import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/feature/ui/widgets/radio_station_widget.dart';

import '../../domain/entities/radio_station_entity.dart';

class RadioVerticalListWidget extends StatefulWidget {
  final AudioHandler? audioHandler;
  final bool isFavoriteScreen;
  final List<RadioStationEntity>? stations;
  final Size size;
  final Function(RadioStationEntity?) onClick;
  final Function(RadioStationEntity?)? onDeleteStation;
  final VoidCallback? onPaging;
  final bool? isLoadData;
  final bool isSearch;

  const RadioVerticalListWidget(
    this.onDeleteStation, {
    super.key,
    required this.size,
    required this.stations,
    required this.onClick,
    required this.isFavoriteScreen,
    required this.onPaging,
    required this.audioHandler,
    required this.isLoadData,
    required this.isSearch,
  });

  @override
  State<StatefulWidget> createState() {
    return _RadioVerticalListWidgetState();
  }
}

class _RadioVerticalListWidgetState extends State<RadioVerticalListWidget> {
  ScrollController? _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _scrollController?.addListener(
          () {
            if (_isLoadData == true) {
              widget.onPaging?.call();
            }
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16.0),
      controller: _scrollController,
      itemCount: widget.stations?.length ?? 0,
      itemBuilder: (context, index) {
        return Column(
          children: [
            RadioStationWidget(
              isFavoriteScreen: widget.isFavoriteScreen,
              radioStationEntity: widget.stations?[index],
              size: widget.size,
              onClick: widget.onClick,
              widget.onDeleteStation,
              audioHandler: widget.audioHandler,
            ),
            index == widget.stations!.length - 1 &&
                    !widget.isFavoriteScreen &&
                    widget.isLoadData == true && !widget.isSearch
                ? SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: CircularProgressIndicator(
                      color: context.colors.text,
                    ),
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  bool get _isLoadData {
    if (_scrollController == null || _scrollController?.hasClients == false) {
      return false;
    }
    if (_scrollController!.position.hasContentDimensions) {
      final maxScroll = _scrollController!.position.maxScrollExtent;
      final currentScroll = _scrollController!.offset;
      return currentScroll == maxScroll;
    } else {
      return false;
    }
  }
}
