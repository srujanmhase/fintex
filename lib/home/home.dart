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
  late AnimationController _controller;
  late AnimationController _menuIndicatorController;

  late Animation<double> _menuIndicatorDimension;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _menuIndicatorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _menuIndicatorDimension =
        Tween<double>(begin: 10, end: 0).animate(_menuIndicatorController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _menuIndicatorController.dispose();
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
                        if (_controller.status == AnimationStatus.completed) {
                          unawaited(_menuIndicatorController.reverse());
                          return _controller.reverse();
                        }
                        unawaited(_menuIndicatorController.forward());
                        return _controller.forward();
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
                            animation: _menuIndicatorController,
                            builder: (context, child) => Container(
                              height: _menuIndicatorDimension.value,
                              width: _menuIndicatorDimension.value,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
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
                      controller: _controller,
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
