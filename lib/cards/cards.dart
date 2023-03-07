import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key, required this.width});
  final double width;
  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with TickerProviderStateMixin {
  bool isPaying = false;

  late AnimationController _sendController;
  late AnimationController _txnController;
  late AnimationController _cardController;

  late Animation<double> _sendHeight;
  late Animation<double> _sendArrow;
  late Animation<double> _txnHeight;
  late Animation<double> _cardRadians;

  late AnimationController _photoControllerOpenClose;
  late Animation<double> _photoOpenCloseX;
  late Animation<double> _photoOpenCloseY;

  late AnimationController _paymentController;
  late Animation<double> _photoPaymentX;
  late Animation<double> _photoPaymentY;

  late Animation<double> _paymentButtonWidth;

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
    _photoControllerOpenClose = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _photoOpenCloseX =
        Tween<double>(begin: 0, end: -130).animate(_photoControllerOpenClose);
    _photoOpenCloseY =
        Tween<double>(begin: 0, end: 80).animate(_photoControllerOpenClose);
    _sendArrow = Tween<double>(begin: -1.6, end: 1.6).animate(_sendController);
    _paymentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _photoPaymentX = Tween<double>(begin: 0, end: 60).animate(
      _paymentController,
    );
    _photoPaymentY = Tween<double>(begin: 0, end: 10).animate(
      _paymentController,
    );
    _paymentButtonWidth = Tween<double>(begin: 60, end: widget.width - 92)
        .animate(_paymentController);
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
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _sendController,
                  builder: (context, child) => GestureDetector(
                    onTap: () {
                      if (_sendController.status == AnimationStatus.completed &&
                          !isPaying) {
                        _photoControllerOpenClose.reverse();
                        _sendController.reverse();
                      } else if (!isPaying) {
                        _photoControllerOpenClose.forward();
                        _sendController.forward();
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
                      child: Stack(
                        children: [
                          () {
                            if (_sendController.status ==
                                AnimationStatus.completed) {
                              return Positioned(
                                right: 30,
                                top: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            if (!isPaying) {
                                              setState(() {
                                                isPaying = true;
                                              });
                                              await _paymentController
                                                  .forward();
                                              await Future.delayed(
                                                  const Duration(seconds: 2),
                                                  () async {
                                                await _paymentController
                                                    .reverse();
                                              });
                                              setState(() {
                                                isPaying = false;
                                              });
                                            }
                                          },
                                          child: AnimatedBuilder(
                                            animation: _paymentController,
                                            builder: (context, child) =>
                                                Container(
                                              width: _paymentButtonWidth.value,
                                              height: 110,
                                              color: Colors.white,
                                              child: const Text('data'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                            return const SizedBox();
                          }(),
                          Column(
                            children: [
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
                                          child: Container(
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
                                        AnimatedBuilder(
                                          animation: _photoControllerOpenClose,
                                          builder: (context, child) =>
                                              Transform.translate(
                                            offset: Offset(
                                              _photoOpenCloseX.value,
                                              _photoOpenCloseY.value,
                                            ),
                                            child: child,
                                          ),
                                          child: AnimatedBuilder(
                                            animation: _paymentController,
                                            builder: (context, child) =>
                                                Transform.translate(
                                              offset: Offset(
                                                _photoPaymentX.value,
                                                _photoPaymentY.value,
                                              ),
                                              child: child,
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/user_two.jpg',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                if (_photoControllerOpenClose
                                                    .isAnimating)
                                                  const SizedBox(
                                                    width: 25,
                                                  ),
                                                if (_photoControllerOpenClose
                                                        .status ==
                                                    AnimationStatus.completed)
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                if (_photoControllerOpenClose
                                                        .status ==
                                                    AnimationStatus.completed)
                                                  Text(
                                                    'Jon Doe II',
                                                    style: TextStyle(
                                                      color: isPaying
                                                          ? Colors.black
                                                          : Colors.white,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Container(
                                            height: 25,
                                            width: 25,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Container(
                                            height: 25,
                                            width: 25,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(-(widget.width / 2 - 46), 100),
                                child: const Text(
                                  'data',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -20),
                  child: AnimatedBuilder(
                    animation: _txnController,
                    builder: (context, child) => GestureDetector(
                      onTap: () =>
                          _txnController.status == AnimationStatus.completed
                              ? _txnController.reverse()
                              : _txnController.forward(),
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
                    'data',
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
