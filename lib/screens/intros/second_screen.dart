import 'package:fetch/screens/intros/third_screen.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF2),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: -50,
                    left: -20,
                    child: Image.asset(
                      'assets/intros/second_screen/second_screen_ellipse.png',
                      width: MediaQuery.of(context).size.width * 1.2,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Image.asset(
                      'assets/intros/second_screen/second_screen_good_job_dog.png',
                      width: 260,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Amazing Dog Trainer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Unlock the secret language of dogs, train\nthem efficiently, & get their attention with\nour whistle feature!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: GestureDetector(
                onTapDown: (_) => _controller.forward(),
                onTapUp: (_) {
                  _controller.reverse();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThirdScreen(),
                    ),
                  );
                },
                onTapCancel: () => _controller.reverse(),
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 1.0,
                    end: 0.9,
                  ).animate(_controller),
                  child: Image.asset(
                    'assets/intros/second_screen/second_screen_paw.png',
                    width: 80,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
