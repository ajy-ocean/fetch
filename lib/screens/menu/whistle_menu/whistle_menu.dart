import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class WhistleScreen extends StatefulWidget {
  const WhistleScreen({super.key});

  @override
  State<WhistleScreen> createState() => _WhistleScreenState();
}

class _WhistleScreenState extends State<WhistleScreen> {
  late AudioPlayer _audioPlayer;
  bool isWhistleActive = false;
  double frequencyValue = 4871.0; // Initial frequency display

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  void _toggleWhistle() async {
    setState(() {
      isWhistleActive = !isWhistleActive;
    });

    if (isWhistleActive) {
      // Plays the whistle sound from assets
      await _audioPlayer.play(
        AssetSource('menu/whistle_menu/dog_whistle_menu.mp3'),
      );
    } else {
      await _audioPlayer.stop();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF2),
      body: SafeArea(
        child: Column(
          children: [
            // Header with Home Icon and Title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      'assets/menu/whistle_menu/home_icon_whistle_menu.png',
                      width: 40,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Whistle",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Empty space to balance the header layout
                  const SizedBox(width: 40),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Frequency Display Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Text(
                      frequencyValue.toInt().toString(),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Frequency Slider
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 8,
                        ),
                        trackHeight: 6,
                        activeTrackColor: Colors.orange,
                        inactiveTrackColor: Colors.grey,
                      ),
                      child: Slider(
                        value: frequencyValue,
                        min: 0,
                        max: 20000,
                        onChanged: (value) {
                          setState(() => frequencyValue = value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // On/Off Toggle Button
            GestureDetector(
              onTap: _toggleWhistle,
              child: Image.asset(
                isWhistleActive
                    ? 'assets/menu/whistle_menu/btn_on_whistle_menu.png'
                    : 'assets/menu/whistle_menu/btn_off_whistle_menu.png',
                width: 120,
              ),
            ),

            const Spacer(),

            // Bottom Navigation Asset
            Image.asset(
              'assets/menu/whistle_menu/bottom_nav_whistle_menu.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
