import 'package:candy_sorter/features/candy_sorter/view/game_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: width <= 425
          ? ListView(
              padding: const EdgeInsets.all(40.0),
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                Center(
                  child: Lottie.asset(
                    'assets/candies.json',
                    width: width / 2,
                    fit: BoxFit.fill,
                  ),
                ),
                Center(
                  child: Text(
                    "Candy Sorter",
                    style: TextStyle(
                        color: Colors.black54, fontSize: (width * 0.1)),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Center(
                  child: SizedBox(
                    width: width / 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return const GamePage();
                            },
                            opaque: false,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue.shade500,
                        elevation: 5.0,
                        shadowColor: Colors.blue.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                      ),
                      child: const FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          'New Game',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              letterSpacing: 2.5,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            )
          : Center(
              child: SizedBox(
                width: width / 1.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Lottie.asset(
                          'assets/candies.json',
                          width: width / 3,
                          fit: BoxFit.fill,
                        )
                      ],
                    ),
                    Center(
                      child: SizedBox(
                        width: width / 4,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return const GamePage();
                                },
                                opaque: false,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue.shade500,
                            elevation: 5.0,
                            shadowColor: Colors.blue.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                          ),
                          child: const FittedBox(
                            fit: BoxFit.fill,
                            child: Text(
                              'New Game',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  letterSpacing: 2.5,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
