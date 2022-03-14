import 'package:candy_sorter/features/candy_sorter/view/home_menu.dart';
import 'package:candy_sorter/features/candy_sorter/view/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with TickerProviderStateMixin {
  bool isDrawerOpen = false;
  double scaleFactor = 1;
  double xOffset = 0;
  double yOffset = 0;

  late Animation<double> _myAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _myAnimation =
        CurvedAnimation(curve: Curves.decelerate, parent: _controller);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade800],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            SafeArea(
              child: Container(
                width: 200.0,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      child: Image.asset('assets/me.png'),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "deamdeveloper",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            enabled: true,
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const Settings(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(0.0, 1.0);
                                    const end = Offset.zero;
                                    const curve = Curves.easeInOut;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    final curvedAnimation = CurvedAnimation(
                                      parent: animation,
                                      curve: curve,
                                    );
                                    return SlideTransition(
                                      position: tween.animate(curvedAnimation),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            leading: const Icon(
                              Icons.settings,
                              size: 20.0,
                              color: Colors.white,
                            ),
                            contentPadding: const EdgeInsets.all(2.0),
                            dense: true,
                            autofocus: true,
                            minVerticalPadding: 2.0,
                            subtitle: const Text(
                              'Adjust your colors and candies',
                              style: TextStyle(color: Colors.white38),
                            ),
                            horizontalTitleGap: 0,
                            title: const Text(
                              "Settings",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              alignment: Alignment.center,
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(scaleFactor),
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(isDrawerOpen ? 10.0 : 0),
                boxShadow: const [
                  BoxShadow(color: Colors.black54, blurRadius: 20.0)
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 65,
                          child: Row(
                            children: const [
                              Spacer(),
                              Text(
                                'Candy Sorter',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0),
                              ),
                              Spacer()
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        const HomeMenu(),
                        Positioned(
                          top: 10.0,
                          left: 10.0,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (!isDrawerOpen) {
                                  xOffset = 200;
                                  yOffset = 80;
                                  scaleFactor = 0.8;
                                  isDrawerOpen = true;
                                  _controller.forward();
                                } else {
                                  xOffset = 0;
                                  yOffset = 0;
                                  scaleFactor = 1;
                                  isDrawerOpen = false;
                                  _controller.reverse();
                                }
                              });
                            },
                            icon: AnimatedIcon(
                              icon: AnimatedIcons.menu_arrow,
                              color: Colors.black,
                              progress: _myAnimation,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
