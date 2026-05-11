import 'package:fetch/screens/intros/fourth_screen.dart';
import 'package:flutter/material.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen>
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
      body: Stack(
        children: [
          Positioned(
            bottom: -50,
            left: -100,
            child: Image.asset(
              'assets/intros/third_screen/third_screen_ellipse.png',
              width: MediaQuery.of(context).size.width * 1.2,
              fit: BoxFit.contain,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/intros/third_screen/third_screen_dog_voice.png',
                      width: 240,
                      fit: BoxFit.contain,
                    ),
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
                          'Capture hilarious moments!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Record your dog's funny yet precious\nmoments & cherish the unspoken bond!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
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
                          builder: (context) => const FourthScreen(),
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
                        'assets/intros/third_screen/third_screen_lets_get_started_bone.png',
                        width: 280,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
