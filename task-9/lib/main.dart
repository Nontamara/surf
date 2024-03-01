import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

const _duration = Duration(milliseconds: 400);
double positionLeft = 50;
double positionUp = 300;
double positionTouch = 0;

/// функция генерации радиуса скругления углов фигуры
double randomBorderRadius() {
  return Random().nextDouble() * 64;
}

/// функция генерации отступов, съедающих часть фигуры (уменьшение размера)
double randomMargin() {
  double margin = Random().nextDouble() * 64;
  margin < 10 ? margin = 10 : margin > 75 ? margin = 75 : margin = margin;
  return margin;
}

/// функция генерации цвета фигуры
Color randomColor() {
  return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
}

void main() {
  runApp(const GestureMasterApp());
}

class GestureMasterApp extends StatelessWidget {
  const GestureMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GestureMaster(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GestureMaster extends StatefulWidget {
  const GestureMaster({Key? key}) : super(key: key);

  @override
  State<GestureMaster> createState() => _GestureMasterState();
}

class _GestureMasterState extends State<GestureMaster> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.elasticOut,
  );
  late Color color;
  late double borderRadius;
  late double margin;

  @override
  void initState() {
    super.initState();
    color = randomColor();
    borderRadius = randomBorderRadius();
    margin = randomMargin();

    _animationController = AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _animationController.addListener(_animationListener);
    _animationController.addStatusListener(_animationStatusListener);
  }

  /// обработчик нажатия на фигуру
  void _handleOnTap() {
    SystemSound.play(SystemSoundType.click);
    HapticFeedback.heavyImpact();
    change();
  }

  /// функция смены параметров фигуры на новосозданные
  void change() {
    setState(() {
      color = randomColor();
      borderRadius = randomBorderRadius();
      margin = randomMargin();
    });
  }

  /// обработчик вертикального перемещения фигуры
  void _handleOnVerticalDrag(details) {
    setState(() {
      if (details.globalPosition.dy-positionTouch > 550) {
        positionUp = 550;
      }
      else if (details.globalPosition.dy-positionTouch < 50) {
        positionUp = 50;
      }
      else {
        positionUp = details.globalPosition.dy-positionTouch;
      }
    });
  }

  void _animationListener() {
    setState(() {});
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _handleOnLongPressUp();
    }
  }

  void _handleOnLongPress() {
    _animationController.forward();
  }

  void _handleOnLongPressUp() {
    _animationController.reset();
  }
  
  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned(
            left: positionLeft,
            top: positionUp,
            child: SizedBox(
              width: 300,
              height: 300,
              child: RotationTransition(
              turns: _animation,
                child: Listener(
                  onPointerDown: (event) {
                    positionTouch = event.localPosition.dy;
                  },
                  child: AnimatedContainer(
                    margin: EdgeInsets.all(margin),
                    duration: _duration,
                    curve: Curves.easeInOutBack,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: color,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                      child: GestureDetector(
                        onTap: _handleOnTap,
                        onVerticalDragUpdate: (details) {
                          _handleOnVerticalDrag(details);
                        },
                        onLongPress: _handleOnLongPress,
                      ),
                    ),
                ),
              ),
            ),
        ),
      ],
    );
  }
}