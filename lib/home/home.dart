import 'dart:async';

import 'package:animationsdemo/cards/cards.dart';
import 'package:animationsdemo/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _menuController;

  late CurvedAnimation _menuCurve;

  late Animation<double> _menuIndicatorParentDimension;
  late Animation<double> _manuIndicatorChildDimension;

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _menuCurve = CurvedAnimation(
      parent: _menuController,
      curve: Curves.easeInOutQuint,
    );
    _menuIndicatorParentDimension =
        Tween<double>(begin: 15, end: 0).animate(_menuCurve);
    _manuIndicatorChildDimension =
        Tween<double>(begin: 7, end: 0).animate(_menuCurve);
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hi',
                          style: GoogleFonts.poppins(
                              fontSize: 24, fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Jon',
                          style: GoogleFonts.poppins(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_menuController.status ==
                            AnimationStatus.completed) {
                          return _menuController.reverse();
                        }
                        unawaited(_menuController.forward());
                        return _menuController.forward();
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/user_one.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _menuController,
                            builder: (context, child) => Container(
                              height: _menuIndicatorParentDimension.value,
                              width: _menuIndicatorParentDimension.value,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                              child: Center(
                                child: Container(
                                  height: _manuIndicatorChildDimension.value,
                                  width: _manuIndicatorChildDimension.value,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: DynamicIslandWidget(
                      width: MediaQuery.of(context).size.width - 32,
                      controller: _menuController,
                    ),
                  ),
                ],
              ),
              CardWidget(
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
