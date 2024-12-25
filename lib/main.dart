import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      color: Colors.white,
      home: Padding(
        padding: EdgeInsets.all(32.0),
        child: SquareAnimation(),
      ),
    );
  }
}

class SquareAnimation extends StatefulWidget {
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() {
    return SquareAnimationState();
  }
}

class SquareAnimationState extends State<SquareAnimation> {
  // Default Square Size
  static const _squareSize = 50.0;
  // Default OffSet of Square
  double _recOffSet = 0.0;
  // Current State of the animation [Square]
  bool _isAnimating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[300],
                height: 60.0,
              ),
              // Square widget for moving right or left Side
              AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.fastEaseInToSlowEaseOut,
                transform: Matrix4.translationValues(_recOffSet, 0, 0),
                width: _squareSize,
                height: _squareSize,
                decoration: BoxDecoration(color: Colors.red, border: Border.all()),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Move the Square to Left Side
              ElevatedButton(
                onPressed: !_isAnimating && _recOffSet != -100 ? _moveLeft : null,
                child: const Text('Left'),
              ),
              const SizedBox(width: 8),
              // Move the Square to Right Side
              ElevatedButton(
                onPressed: !_isAnimating && _recOffSet != 100 ? _moveRight : null,
                child: const Text('Right'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Square moving the Rigth Side from here,
  void _moveRight() {
    if (_isAnimating) return;
    _enableButtonsAfterDelay();
    setState(() {
      _isAnimating = true;
      _recOffSet = 100;
    });
  }

  // Square moving the Left Side from here,
  void _moveLeft() {
    if (_isAnimating) return;
    _enableButtonsAfterDelay();
    setState(() {
      _isAnimating = true;
      _recOffSet = -100;
    });
  }

  // Button Enable after the Animation Delay
  void _enableButtonsAfterDelay() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isAnimating = false;
      });
    });
  }
}
