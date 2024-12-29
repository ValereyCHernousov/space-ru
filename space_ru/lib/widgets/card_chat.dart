import 'package:flutter/material.dart';
import 'package:space_ru/models/list_item.dart';

class CardExample extends StatelessWidget {
  const CardExample({super.key, required this.items});
  final List<ListItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return ListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
        );
      },
    );
  }
}
