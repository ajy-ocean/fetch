import 'package:fetch/screens/intros/second_screen.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
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
                    right: -20,
                    child: Image.asset(
                      'assets/intros/first_screen/first_screen_ellipse.png',
                      width: MediaQuery.of(context).size.width * 1.2,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Image.asset(
                      'assets/intros/first_screen/first_screen_dog_hello.png',
                      width: 250,
                      fit: BoxFit.scaleDown,
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
                      'Translate your pup\'s bark!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Communicate with your furry friend &\ndecode your dog\'s thoughts like never before!',
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
            // ANIMATED PAW BUTTON
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: GestureDetector(
                onTapDown: (_) => _controller.forward(),
                onTapUp: (_) {
                  _controller.reverse();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SecondScreen(),
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
                    'assets/intros/first_screen/first_screen_paw.png',
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
