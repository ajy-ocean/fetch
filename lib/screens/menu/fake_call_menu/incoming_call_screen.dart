import 'dart:ui';
import 'package:fetch/screens/menu/fake_call_menu/video_call_screen.dart';
import 'package:flutter/material.dart';

class IncomingCallScreen extends StatelessWidget {
  final Map<String, String> dog;

  const IncomingCallScreen({super.key, required this.dog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Blurred Background
          Image.asset(dog['image']!, fit: BoxFit.cover),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),

          // 2. Content Overlay
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // Circle Cropped Image
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(dog['image']!),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                dog['name']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Incoming video call...",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const Spacer(flex: 3),

              // 3. Action Buttons
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 50,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Decline Button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        'assets/menu/fake_call_menu/popup/red_btn_fake_call_menu.png',
                        width: 80,
                      ),
                    ),
                    // Accept Button
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoCallScreen(dog: dog), //
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/menu/fake_call_menu/popup/green_btn_fake_call_menu.png',
                        width: 80,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
