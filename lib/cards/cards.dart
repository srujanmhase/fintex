import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_cubit.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key, required this.width});
  final double width;
  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with TickerProviderStateMixin {
  //bool isPaying = false;

  late AnimationController _sendController;
  late AnimationController _txnController;
  late AnimationController _cardController;
  late AnimationController _paymentController;

  late Animation<double> _paymentButtonWidth;
  late Animation<double> _paymentButtonHeight;

  late Animation<double> _sendHeight;
  late Animation<double> _sendArrow;
  late Animation<double> _txnHeight;
  late Animation<double> _cardRadians;
  late Animation<double> _sendElementsOpacity;
  late Animation<double> _sendElementsVerticalOffset;
  late Animation<Color?> _textColor;

  @override
  void initState() {
    super.initState();
    _sendController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _txnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _sendArrow = Tween<double>(begin: -1.6, end: 1.6).animate(_sendController);
    _paymentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    final paymentControllerCurve = CurvedAnimation(
      parent: _paymentController,
      curve: Curves.easeInOutQuart,
    );
    _paymentButtonWidth = Tween<double>(begin: 90, end: widget.width - 92)
        .animate(paymentControllerCurve);
    _paymentButtonHeight =
        Tween<double>(begin: 110, end: 180).animate(paymentControllerCurve);
    final sendCurve = CurvedAnimation(
      parent: _sendController,
      curve: Curves.easeInOut,
    );
    final txnCurve = CurvedAnimation(
      parent: _txnController,
      curve: Curves.easeInOut,
    );
    _sendHeight = Tween<double>(begin: 110, end: 250).animate(sendCurve);
    _txnHeight = Tween<double>(begin: 110, end: 250).animate(txnCurve);
    _cardRadians = Tween<double>(begin: 1, end: 0).animate(_cardController);
    _sendElementsOpacity =
        Tween<double>(begin: 0, end: 1).animate(_sendController);
    _sendElementsVerticalOffset =
        Tween<double>(begin: 0, end: 20).animate(_sendController);
    _textColor = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_paymentController);
  }

  @override
  void dispose() {
    _sendController.dispose();
    _txnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      height: 400,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 180,
            left: 0,
            child: BlocConsumer<AppCubit, AppState>(
              listener: (context, state) {
                if (state.isSendActive && !state.isTransacting) {
                  _sendController.forward();
                }

                if (!state.isSendActive && !state.isTransacting) {
                  _sendController.reverse();
                }

                if (state.isTransacting) {
                  _paymentController.forward();
                }

                if (!state.isTransacting) {
                  _paymentController.reverse();
                }

                if (state.isRecentsActive) {
                  _txnController.forward();
                }

                if (!state.isRecentsActive) {
                  _txnController.reverse();
                }
              },
              listenWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return Column(
                  children: [
                    AnimatedBuilder(
                      animation: _sendController,
                      builder: (context, child) => GestureDetector(
                        onTap: () {
                          if (!state.isTransacting) {
                            context.read<AppCubit>().sendToggle();
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 32,
                          height: _sendHeight.value,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ),
                          ),
                          child: AnimatedBuilder(
                            animation: _paymentController,
                            builder: (context, child) => Stack(
                              children: [
                                Positioned(
                                  right: 30,
                                  top: 100,
                                  child: AnimatedBuilder(
                                    animation: _sendController,
                                    builder: (context, child) {
                                      return Transform.translate(
                                        offset: Offset(
                                          0,
                                          _sendElementsVerticalOffset.value,
                                        ),
                                        child: Opacity(
                                          opacity: _sendElementsOpacity.value,
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: GestureDetector(
                                      onTap: () {
                                        if (!state.isTransacting) {
                                          context.read<AppCubit>().send();
                                        }
                                      },
                                      child: Container(
                                        width: _paymentButtonWidth.value,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: (!state.isTransacting)
                                            ? const Center(
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                ),
                                              )
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 100,
                                  left: 30,
                                  child: AnimatedBuilder(
                                    animation: _sendController,
                                    builder: (context, child) {
                                      return Transform.translate(
                                        offset: Offset(
                                          0,
                                          _sendElementsVerticalOffset.value,
                                        ),
                                        child: Opacity(
                                          opacity: _sendElementsOpacity.value,
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: const BoxDecoration(
                                                color: Colors.grey,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              'JON DOE III',
                                              style: GoogleFonts.inter(
                                                fontSize: 16,
                                                color: _textColor.value,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          width: widget.width * 0.45,
                                          height: 65,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              r'$ 82',
                                              style: GoogleFonts.inter(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: _textColor.value,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    // Arrow and Icons (static)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 40,
                                        left: 15,
                                        right: 15,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              AnimatedBuilder(
                                                animation: _sendController,
                                                builder: (context, child) =>
                                                    Transform.rotate(
                                                  angle: _sendArrow.value,
                                                  child: child,
                                                ),
                                                child: SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: Transform.translate(
                                                    offset: const Offset(5, 0),
                                                    child: const Icon(
                                                      Icons.arrow_back_ios,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Send Money',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                ),
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.grey,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                ),
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.grey,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -20),
                      child: AnimatedBuilder(
                        animation: _txnController,
                        builder: (context, child) => GestureDetector(
                          onTap: () => context.read<AppCubit>().recentToggle(),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 32,
                            height: _txnHeight.value,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          AnimatedBuilder(
            animation: _cardController,
            builder: (context, child) => Transform(
              // transform: Matrix4.skew(_cardRadians.value, _cardRadians.value),
              transform:
                  Matrix4.rotationX((1 - _cardRadians.value) * math.pi / 2),
              alignment: Alignment.center,

              child: child,
            ),
            child: GestureDetector(
              onTap: () => _cardController
                  .forward()
                  .then((value) => _cardController.reverse()),
              child: Container(
                width: MediaQuery.of(context).size.width - 32,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xffccff00),
                  border: Border.all(color: const Color(0xffa0c800)),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Text(
                    'VISA',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
