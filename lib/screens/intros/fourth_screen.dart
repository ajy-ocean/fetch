import 'package:flutter/material.dart';
import 'package:fetch/screens/intros/fifth_screen.dart'; 

class FourthScreen extends StatefulWidget {
  const FourthScreen({super.key});

  @override
  State<FourthScreen> createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen>
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
      backgroundColor: Colors.white, 
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20.0,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Terms of Use',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Image.asset(
                      'assets/intros/fourth_screen/fourth_screen_terms.png',
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(
            height: 250, 
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none, 
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/intros/fourth_screen/fourth_screen_group_of_dogs.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),

                Positioned(
                  bottom: 150, 
                  child: GestureDetector(
                    onTapDown: (_) => _controller.forward(),
                    onTapUp: (_) {
                      _controller.reverse();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FifthScreen(),
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
                        'assets/intros/fourth_screen/fourth_screen_accept_bone.png',
                        width: 240,
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