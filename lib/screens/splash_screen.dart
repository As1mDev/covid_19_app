import 'dart:async';

import 'package:covid_19_app/screens/worldstates_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return const WorldStatesScreen();
      }));
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 39, 39),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: controller,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width * .6,
              child: const Center(
                  child: Image(image: AssetImage('assets/images/virus.png'))),
            ),
            builder: (context, child) {
              return Transform.rotate(
                angle: controller.value * 1.0 * math.pi,
                child: child,
              );
            },
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Covid-19 \n Tracker App',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
          )
        ],
      )),
    );
  }
}
