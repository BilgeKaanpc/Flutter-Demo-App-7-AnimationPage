import 'package:flutter/material.dart';

TextStyle menuStyle = const TextStyle(color: Colors.white, fontSize: 20);
Color bgColor = const Color(0xff343442);

class MenuDashboard extends StatefulWidget {
  const MenuDashboard({super.key});

  @override
  State<MenuDashboard> createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard>
    with SingleTickerProviderStateMixin {
  late double screenHigh, screenWidth;
  bool menuOpen = false;
  late AnimationController controller;
  late Animation<double> scaleAnim;
  late Animation<double> scaleMenuAnim;
  late Animation<Offset> ofsetAnim;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    scaleAnim = Tween(begin: 1.0, end: 0.6).animate(controller);
    scaleMenuAnim = Tween(begin: 0.0, end: 1.0).animate(controller);
    ofsetAnim = Tween(begin: const Offset(-1, 0), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHigh = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            createMenu(context),
            createDashboard(context),
          ],
        ),
      ),
    );
  }

  createDashboard(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      top: 0,
      bottom: 0,
      left: menuOpen ? 0.4 * screenWidth : 0,
      right: menuOpen ? -0.4 * screenWidth : 0,
      child: ScaleTransition(
        scale: scaleAnim,
        child: Material(
          borderRadius:
              menuOpen ? const BorderRadius.all(Radius.circular(40)) : null,
          elevation: 8,
          color: bgColor,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (menuOpen) {
                              controller.reverse();
                            } else {
                              controller.forward();
                            }
                            menuOpen = !menuOpen;
                          });
                        },
                        child: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "My Cards",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      const Icon(
                        Icons.add,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 200,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          color: Colors.blue,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.yellow,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.pink,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.verified_user),
                          title: Text("Student $index",style: const TextStyle(color: Colors.white),),
                          trailing: const Icon(Icons.add),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: 50)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  createMenu(BuildContext context) {
    return SlideTransition(
      position: ofsetAnim,
      child: ScaleTransition(
        scale: scaleMenuAnim,
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dashboard",
                  style: menuStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Mesajlar",
                  style: menuStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Utility Bills",
                  style: menuStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Fund Transfer",
                  style: menuStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Branches",
                  style: menuStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
