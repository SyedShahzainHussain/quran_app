import 'package:flutter/material.dart';
import 'package:holy_quran_app/utils/routes/route_name.dart';

class DrawerUtils {
  static const List item = [
    {
      'title': 'Surah Index',
      'icon': Icons.format_list_numbered_outlined,
      'route': RouteName.surah,
    },
    {
      'title': 'Juz Index',
      'icon': Icons.list,
      'route': RouteName.juz,
    },
    {
      'title': 'Bookmarks',
      'icon': Icons.bookmark_outline,
      'route': "",
    },
    {
      'title': 'Help Guide',
      'icon': Icons.help_outline,
      'route': "",
    },
    {
      'title': 'Introduction',
      'icon': Icons.info_outline,
      'route': "",
    },
    {
      'title': 'Share App',
      'icon': Icons.share_outlined,
      'route': RouteName.share,
    },
  ];
}
