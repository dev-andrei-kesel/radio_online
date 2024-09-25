import 'package:flutter/material.dart';
import 'package:radio_online/common/app_text_styles.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/feature/data/models/radio_type.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class RadioHorizontalListWidget extends StatelessWidget {
  final List<RadioType> types;
  final RadioType? type;
  final Function(RadioType?) onSelected;
  final PageStorageBucket pageStorageBucket;
  final ItemScrollController? itemScrollController;

  const RadioHorizontalListWidget({
    super.key,
    required this.types,
    required this.type,
    required this.onSelected,
    required this.pageStorageBucket,
    required this.itemScrollController,
  });

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      key: const PageStorageKey<String>('country_list'),
      bucket: pageStorageBucket,
      child: SizedBox(
        height: 60.0,
        child: ScrollablePositionedList.builder(
          itemScrollController: itemScrollController,
          scrollDirection: Axis.horizontal,
          itemCount: types.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                checkmarkColor: context.colors.selected,
                selectedColor: context.colors.chipSelected.withOpacity(0.85),
                backgroundColor: context.colors.background,
                labelStyle: TextStyle(color: context.colors.selected),
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(style: context.styles.text, types[index].name ?? ''),
                    const SizedBox(
                      width: 12,
                    ),
                    Icon(
                      size: 12,
                      Icons.radio,
                      color: context.colors.selected,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      style: context.styles.text,
                      types[index].stationcount.toString(),
                    ),
                  ],
                ),
                selected: type?.name == types[index].name &&
                    type?.code == types[index].code &&
                    type?.stationcount == types[index].stationcount,
                onSelected: (selected) {
                  selected ? onSelected(types[index]) : null;
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
