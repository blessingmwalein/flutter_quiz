import 'package:flutter/material.dart';

import 'package:interview1/constants.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 600,
      backgroundColor: kBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                size: 25,
              ),
              alignment: Alignment.topLeft,
            ),
            const SizedBox(
              height: 20,
            ),
            _drawerTile(
                true, "Home", Icons.home_outlined, false, context, () {}),
            _drawerTile(
                false, "Chat", Icons.chat_outlined, true, context, () {}),
            _drawerTile(false, "Emergency", Icons.emergency_outlined, false,
                context, () {}),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 2,
            ),
            _drawerTile(false, "FAQ Bot", Icons.smart_toy_outlined, false,
                context, () {}),
            _drawerTile(false, "Feedback", Icons.drafts_outlined, false,
                context, () {}),
            _drawerTile(false, "Settings", Icons.settings_outlined, false,
                context, () {}),
            _drawerTile(false, "About this App", Icons.info_outline, false,
                context, () {}),
          ],
        ),
      ),
    );
  }

  Widget _drawerTile(bool isSelected, String title, IconData icon,
      bool isTrailing, BuildContext context, VoidCallback onPressed) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? kSelectedColor : kBackgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        child: ListTile(
          leading: Icon(icon, size: 24, color: kDarckColor),
          title: Text(
            title,
            style: const TextStyle(
              color: kDarckColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          selected: true,
          onTap: () {
            onPressed();
          },
          trailing: isTrailing
              ? const Text(
                  '99+',
                  style: TextStyle(
                    color: kDarckColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
