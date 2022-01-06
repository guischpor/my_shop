import 'package:flutter/material.dart';

class ListTileDrawer extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function() onTap;

  const ListTileDrawer({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
