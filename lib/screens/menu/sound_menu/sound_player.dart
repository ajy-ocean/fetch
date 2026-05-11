import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fetch/model/dog_sound.dart';

class SoundPlayerScreen extends StatefulWidget {
  final DogSound soundData;
  const SoundPlayerScreen({super.key, required this.soundData});

  @override
  State<SoundPlayerScreen> createState() => _SoundPlayerScreenState();
}

class _SoundPlayerScreenState extends State<SoundPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  bool isLoading = true;
  bool isLooping = false; // Added: Track loop state
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  Timer? _countdownTimer;
  String _selectedTimerText = "OFF";

  final Map<String, Duration> _timerOptions = {
    "OFF": Duration.zero,
    "15 s": const Duration(seconds: 15),
    "30 s": const Duration(seconds: 30),
    "45 s": const Duration(seconds: 45),
    "1 m": const Duration(minutes: 1),
    "2 m": const Duration(minutes: 2),
    "5 m": const Duration(minutes: 5),
  };

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer.onDurationChanged.listen((d) => setState(() => _duration = d));
    _audioPlayer.onPositionChanged.listen((p) => setState(() => _position = p));
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
          if (state == PlayerState.playing || state == PlayerState.paused) {
            isLoading = false;
          }
        });
      }
    });

    _playAudio();
  }

  // Added: Function to toggle loop state and player mode
  void _toggleLoop() async {
    setState(() {
      isLooping = !isLooping;
    });
    // ReleaseMode.loop repeats the sound, ReleaseMode.release stops after one play
    await _audioPlayer.setReleaseMode(isLooping ? ReleaseMode.loop : ReleaseMode.release);
  }

  void _startTimer(Duration duration) {
    _countdownTimer?.cancel();
    if (duration == Duration.zero) return;

    _countdownTimer = Timer(duration, () {
      _audioPlayer.stop();
      if (mounted) {
        setState(() {
          _selectedTimerText = "OFF";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Timer finished - Audio stopped")),
        );
      }
    });
  }

  Future<void> _playAudio() async {
    try {
      setState(() => isLoading = true);
      await _audioPlayer.play(UrlSource(widget.soundData.audio));
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset('assets/menu/sound_menu/arrowcircleleft_sound_menu.png', width: 40),
                  ),
                  
                  Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        const Text("Timer", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        
                        Theme(
                          data: Theme.of(context).copyWith(cardColor: Colors.white),
                          child: PopupMenuButton<String>(
                            initialValue: _selectedTimerText,
                            onSelected: (String value) {
                              setState(() {
                                _selectedTimerText = value;
                              });
                              _startTimer(_timerOptions[value]!);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Text(_selectedTimerText, style: const TextStyle(color: Colors.white)),
                                  const Icon(Icons.arrow_drop_down, color: Colors.white),
                                ],
                              ),
                            ),
                            itemBuilder: (BuildContext context) {
                              return _timerOptions.keys.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Center(
                                    child: Text(
                                      choice,
                                      style: TextStyle(
                                        color: choice == _selectedTimerText ? Colors.orange : Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Updated: Swap between normal and deactive assets based on isLooping
                  GestureDetector(
                    onTap: _toggleLoop,
                    child: Image.asset(
                      isLooping 
                        ? 'assets/menu/sound_menu/loop_sound_menu.png' 
                        : 'assets/menu/sound_menu/deactive_loop_sound_menu.png', 
                      width: 40
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),

            Center(
              child: Container(
                width: 220,
                height: 220,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFEBD1),
                ),
                padding: const EdgeInsets.all(25),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(widget.soundData.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            Text(widget.soundData.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),

            Stack(
              alignment: Alignment.center,
              children: [
                // Image.asset('assets/menu/sound_menu/searchbar_sound_menu.png', width: 320),
                SizedBox(
                  width: 280,
                  child: Row(
                    children: [
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                            trackHeight: 4,
                            activeTrackColor: Colors.orange,
                            inactiveTrackColor: Colors.grey.withOpacity(0.3),
                          ),
                          child: Slider(
                            min: 0,
                            max: _duration.inSeconds.toDouble(),
                            value: _position.inSeconds.toDouble().clamp(0.0, _duration.inSeconds.toDouble()),
                            onChanged: (value) async => await _audioPlayer.seek(Duration(seconds: value.toInt())),
                          ),
                        ),
                      ),
                      isLoading 
                        ? const SizedBox(
                            width: 50,
                            height: 50,
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: CircularProgressIndicator(color: Colors.orange, strokeWidth: 3),
                            ),
                          )
                        : GestureDetector(
                            onTap: () => isPlaying ? _audioPlayer.pause() : _playAudio(),
                            child: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled, color: Colors.orange, size: 50),
                          ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Image.asset('assets/menu/sound_menu/bottom_dog_sound_menu.png', fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }
}