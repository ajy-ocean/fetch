import 'dart:math';
import 'package:fetch/screens/menu/fake_call_menu/dog_call.dart';
import 'package:flutter/material.dart';

class VideoCallScreen extends StatefulWidget {
  final Map<String, String> dog;

  const VideoCallScreen({super.key, required this.dog});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late String randomActress;

  @override
  void initState() {
    super.initState();
    // Randomize the actress image on initialization
    int randomIndex = Random().nextInt(4) + 1;
    randomActress = 'assets/menu/fake_call_menu/actress/act_$randomIndex.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Main Background Dog Image
          Image.asset(widget.dog['image']!, fit: BoxFit.cover),

          // 2. Top UI: Timer and PiP Window
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  // Call Timer
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: const Text(
                        "0:0:20",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),

                  // Square PiP Actress Image
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 120,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white, width: 2),
                        image: DecorationImage(
                          image: AssetImage(randomActress),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3. Bottom Controls
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Camera Toggle Icon
                _circleButton(Icons.videocam_off_outlined),

                // Red Cut Call Button
                GestureDetector(
                  onTap: () {
                    // Navigate back to the list screen
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DogCallScreen(),
                      ),
                      (route) =>
                          false, // This clears the entire history so there's no "back" to the call
                    );
                  },
                  child: Image.asset(
                    'assets/menu/fake_call_menu/popup/cut_call_btn_fake_call_menu.png',
                    width: 75,
                  ),
                ),

                // Mic Toggle Icon
                _circleButton(Icons.mic_none_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black54, size: 28),
    );
  }
}
