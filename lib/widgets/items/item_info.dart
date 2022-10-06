import 'package:flutter/material.dart';

import '/shared/style.dart';

class ItemInfo extends StatelessWidget {
  const ItemInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Mohon Maaf\nFitur Ini Belum Tersedia',
        style: purpleTextStyle.copyWith(
          fontSize: 20,
          fontWeight: semiBold,
          color: cPurpleColor.withOpacity(0.5),
          letterSpacing: 0.4,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }
}
