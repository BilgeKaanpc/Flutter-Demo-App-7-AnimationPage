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
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    height: 230,
                    child: SizedBox(
                      height: 180,
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          createContainerCard(),
                          createContainerCard(),
                          createContainerCard(),
                        ],
                      ),
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
                          title: Text(
                            "Student $index",
                            style: const TextStyle(color: Colors.white),
                          ),
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

  createContainerCard() {
    return Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(12),
        width: 100,
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.blue, blurRadius: 12)],
          color: Colors.blue,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Padding(
                      padding: EdgeInsets.only(right: 80),
                      child: Text(
                        "Current Balance",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  Text(
                    "BilgeBank",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "\$1253461",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(right: 70),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "6512   6578   2458   8756",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      fontSize: 18),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    children: [
                      Text(
                        "Card Holder",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w200),
                      ),
                      Text(
                        "Bilge Kaan",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 100),
                  child: Column(
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w200),
                      ),
                      Text(
                        "05/26",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
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
