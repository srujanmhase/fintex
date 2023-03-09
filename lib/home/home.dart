import 'dart:async';

import 'package:animationsdemo/app_cubit.dart';
import 'package:animationsdemo/cards/cards.dart';
import 'package:animationsdemo/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            FittedBox(
                              child: Icon(
                                Icons.account_balance_outlined,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                            FittedBox(
                              child: Icon(
                                Icons.account_circle_outlined,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                            FittedBox(
                              child: Icon(
                                Icons.login_outlined,
                                color: Colors.white,
                                size: 35,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              PaidNotification(
                width: MediaQuery.of(context).size.width - 32,
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

class PaidNotification extends StatefulWidget {
  const PaidNotification({
    super.key,
    required this.width,
  });
  final double width;
  @override
  State<PaidNotification> createState() => _PaidNotificationState();
}

class _PaidNotificationState extends State<PaidNotification>
    with TickerProviderStateMixin {
  //Notification Panel Body
  late AnimationController _controller;
  late CurvedAnimation _curve;

  late Animation<double> _height;
  late Animation<double> _width;

  //Notification Timer
  late AnimationController _timerController;
  late Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    //Notification Panel Body
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutQuint,
    );

    _height = Tween<double>(begin: 0, end: 77).animate(_curve);
    _width = Tween<double>(begin: 0.01, end: widget.width).animate(_curve);

    //Notification Timer
    _timerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _progress = Tween<double>(begin: 0, end: 1).animate(_timerController);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state.isSent) {
          _controller.forward().then((value) {
            _timerController.forward();
            Future.delayed(
              const Duration(seconds: 3),
              () {
                _timerController.reset();
                _controller.reverse();
              },
            );
          });
        }
      },
      listenWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              children: [
                SizedBox(
                  width: _width.value,
                  height: _height.value,
                  child: child,
                ),
                SizedBox(
                  height: _height.value / 3,
                ),
              ],
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xffEFEFEF),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                FittedBox(
                  child: RichText(
                    text: TextSpan(
                      style:
                          GoogleFonts.inter(fontSize: 16, color: Colors.black),
                      children: [
                        const TextSpan(text: 'Sent'),
                        TextSpan(
                          text: r'$ 82.4',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const TextSpan(text: ' to '),
                        TextSpan(
                          text: 'Jon Doe III ',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const TextSpan(text: 'successfully')
                      ],
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _timerController,
                  builder: (context, child) => Row(
                    children: [
                      FittedBox(
                        child: Container(
                          height: 6,
                          width: (widget.width * _progress.value) < 0.1
                              ? 0.1
                              : widget.width * _progress.value,
                          decoration: const BoxDecoration(
                            color: Color(0xff1F9900),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
