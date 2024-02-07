import 'package:flutter/material.dart';

TextStyle menuStyle = const TextStyle(color: Colors.white, fontSize: 20);

class MenuDashboard extends StatelessWidget {
  const MenuDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          createMenu(context),
        ],
      ),
    );
  }

  createMenu(BuildContext context) {
    return Column(
      children: [
        Text(
          "Dashboard",
          style: menuStyle,
        )
      ],
    );
  }
}
