import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF73AEF5),
            Color(0xFF61A4F1),
            Color(0xFF478DE0),
            Color(0xFF398AE5),
          ],
          stops: [0.1, 0.4, 0.7, 0.9],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.network(
              'https://img.freepik.com/free-vector/mobile-login-concept-illustration_114360-135.jpg',
              width: MediaQuery.of(context).size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.network(
              'https://img.freepik.com/free-vector/mobile-login-concept-illustration_114360-135.jpg',
              width: MediaQuery.of(context).size.width * 0.2,
              fit: BoxFit.contain,
            ),
          ),
          child,
        ],
      ),
    );
  }
}