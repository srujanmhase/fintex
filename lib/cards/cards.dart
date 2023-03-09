import 'package:flutter/cupertino.dart';
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
  late AnimationController _paymentController;

  late Animation<double> _paymentButtonWidth;
  late Animation<double> _sendHeight;
  late Animation<double> _sendArrow;
  late Animation<double> _sendElementsOpacity;
  late Animation<double> _sendElementsVerticalOffset;
  late Animation<Color?> _textColor;

  late Animation<Offset> _profilePictureSendToggle;

  //Payment Offsets
  late Animation<Offset> _profilePaymentOffset;
  late Animation<Offset> _amountPaymentOffset;

  @override
  void initState() {
    super.initState();
    _sendController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _paymentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    final paymentControllerCurve = CurvedAnimation(
      parent: _paymentController,
      curve: Curves.easeInOutQuart,
    );

    final sendCurve = CurvedAnimation(
      parent: _sendController,
      curve: Curves.easeInOutQuint,
    );
    _paymentButtonWidth = Tween<double>(begin: 90, end: widget.width - 92)
        .animate(paymentControllerCurve);
    _sendArrow = Tween<double>(begin: -1.6, end: 1.6).animate(_sendController);
    _sendHeight = Tween<double>(begin: 110, end: 250).animate(sendCurve);
    _sendElementsOpacity =
        Tween<double>(begin: 0, end: 1).animate(_sendController);
    _sendElementsVerticalOffset =
        Tween<double>(begin: 0, end: 20).animate(_sendController);
    _textColor = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_paymentController);
    _profilePictureSendToggle = Tween<Offset>(
      begin: Offset(widget.width - (widget.width * 0.35), 42),
      end: const Offset(35, 117),
    ).animate(sendCurve);

    //Payment Offsets
    _profilePaymentOffset = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(80, 0),
    ).animate(_paymentController);
    _amountPaymentOffset = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(60, 0),
    ).animate(_paymentController);
  }

  @override
  void dispose() {
    _sendController.dispose();
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
              },
              listenWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return Column(
                  children: [
                    //Send Card
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
                                //Enlarging CTA
                                Positioned(
                                  right: 30,
                                  top: 80,
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
                                        if (!state.isTransacting &&
                                            state.isSendActive) {
                                          context.read<AppCubit>().send();
                                        }
                                      },
                                      child: Container(
                                        width: _paymentButtonWidth.value,
                                        height: 130,
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
                                //Send Money header Elements (static)
                                Positioned(
                                  top: 40,
                                  right: 15,
                                  left: 15,
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
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 2.5,
                                            ),
                                            child: ProfileImage(
                                              index: 1,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 2.5,
                                            ),
                                            child: ProfileImage(
                                              index: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                //Name & Amount Column
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
                                        Transform.translate(
                                          offset: _profilePaymentOffset.value,
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 35),
                                              Text(
                                                'JON DOE III',
                                                style: GoogleFonts.inter(
                                                  fontSize: 16,
                                                  color: _textColor.value,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Transform.translate(
                                          offset: _amountPaymentOffset.value,
                                          child: Container(
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
                                                r'$ 82.4',
                                                style: GoogleFonts.inter(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: _textColor.value,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                //Animated Profile Picture
                                Transform.translate(
                                  offset: _profilePaymentOffset.value,
                                  child: Transform.translate(
                                    offset: _profilePictureSendToggle.value,
                                    child: const ProfileImage(
                                      index: 3,
                                    ),
                                  ),
                                ),
                                //Activity Indicator
                                if (state.isSending)
                                  const Positioned(
                                    top: 200,
                                    left: 170,
                                    child: CupertinoActivityIndicator(),
                                  ),
                              ],
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
          Container(
            width: MediaQuery.of(context).size.width - 32,
            height: 200,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xffccff00),
              border: Border.all(color: const Color(0xffa0c800)),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //VISA Logo
                Row(
                  children: [
                    Image.asset(
                      'assets/cib_visa.png',
                      height: 45,
                    ),
                  ],
                ),
                //Card Number
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 3; i++)
                      const ObfuscatedCardNumberElements(elements: 4),
                    Text(
                      '2214',
                      style: GoogleFonts.inter(fontSize: 16),
                    )
                  ],
                ),
                //Account holder name & Bank
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'JON DOE',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.account_balance_outlined,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Bank',
                          style: GoogleFonts.inter(fontSize: 13),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.index});
  final int index;
  String mapLocation(int index) {
    switch (index) {
      case 1:
        return 'one';
      case 2:
        return 'two';
      case 3:
        return 'three';
      default:
        return 'four';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        'assets/user_${mapLocation(index)}.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}

class ObfuscatedCardNumberElements extends StatelessWidget {
  const ObfuscatedCardNumberElements({super.key, required this.elements});
  final int elements;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 5; i++)
          Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff4F4F4F),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 5),
          ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
