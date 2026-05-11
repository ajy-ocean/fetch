import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:fetch/screens/menu/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

enum TranslatorState { idle, recording, translated }

class DogTranslatorScreen extends StatefulWidget {
  const DogTranslatorScreen({super.key});

  @override
  State<DogTranslatorScreen> createState() => _DogTranslatorScreenState();
}

class _DogTranslatorScreenState extends State<DogTranslatorScreen> {
  final Color _bgColor = const Color(0xFFFFFBF2);
  final Color _paleOrangeBox = const Color(0xFFFDECDD);
  final Color _orangeColor = const Color(0xFFE65100);

  TranslatorState _currentState = TranslatorState.idle;
  bool _isHumanToDog = false;
  bool _isLoading = false;
  bool _showProgressBar = false;
  List<dynamic> _audioList = [];
  final AudioPlayer _audioPlayer = AudioPlayer();

  Timer? _recordingTimer;
  int _seconds = 0;
  double _audioProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchAudioData();

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _audioProgress = 1.0;
        _isLoading = false;
      });
      _showResultPopup();
    });

    _audioPlayer.onPositionChanged.listen((Duration p) async {
      Duration? total = await _audioPlayer.getDuration();
      if (total != null && total.inMilliseconds > 0) {
        setState(() {
          _audioProgress = p.inMilliseconds / total.inMilliseconds;
        });
      }
    });
  }

  Future<void> _fetchAudioData() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://appy.trycatchtech.com/v3/dog_translator/voice_translator_list',
        ),
      );
      if (response.statusCode == 200) {
        setState(() => _audioList = json.decode(response.body));
      }
    } catch (e) {
      debugPrint("API Error: $e");
    }
  }

  // --- Popup 1: Watch Ad (Cross goes to MainMenu) ---
  void _showWatchAdPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Close popup
                _startRecording(); // Proceed to record
              },
              child: Image.asset(
                'assets/menu/translator_menu/popup/watch_ad_popup.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navigates explicitly to MainMenuScreen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  MainMenuScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.black, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Popup 2: Retake Result (Cross goes to MainMenu) ---
  void _showResultPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                // Resets the current screen for a new recording
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DogTranslatorScreen(),
                  ),
                );
              },
              child: Image.asset(
                'assets/menu/translator_menu/popup/retake_popup.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navigates explicitly to MainMenuScreen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  MainMenuScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.black, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startRecording() {
    setState(() {
      _currentState = TranslatorState.recording;
      _showProgressBar = false;
      _seconds = 0;
    });
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds++);
    });
  }

  void _stopRecording() {
    _recordingTimer?.cancel();
    setState(() => _currentState = TranslatorState.translated);
  }

  void _translateAndPlay() async {
    if (_audioList.isEmpty) return;
    setState(() {
      _isLoading = true;
      _showProgressBar = true;
      _audioProgress = 0.0;
    });
    final randomItem = _audioList[Random().nextInt(_audioList.length)];
    try {
      await _audioPlayer.play(UrlSource(randomItem['post_audio']));
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildTranslatorWidget(),
                  const SizedBox(height: 30),
                  _buildActionSection(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildBottomNavigation(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Text(
            "Dog Voice Translator",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset(
                'assets/menu/translator_menu/home_icon_translator_menu.png',
                width: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTranslatorWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              _isHumanToDog
                  ? 'assets/menu/translator_menu/human_to_dog_translate.png'
                  : 'assets/menu/translator_menu/header_translator_menu.png',
              fit: BoxFit.contain,
            ),
            GestureDetector(
              onTap: () => setState(() => _isHumanToDog = !_isHumanToDog),
              child: Image.asset(
                'assets/menu/translator_menu/paw_translator_menu.png',
                width: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 180),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
            decoration: BoxDecoration(
              color: _paleOrangeBox,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(child: _buildBoxContent()),
          ),
          const SizedBox(height: 40),
          _buildMainButton(),
        ],
      ),
    );
  }

  Widget _buildBoxContent() {
    if (_currentState == TranslatorState.recording) {
      return Text(
        _formatTime(_seconds),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      );
    } else if (_showProgressBar) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _isLoading ? "Loading Audio..." : "Translating...",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          _isLoading
              ? const CircularProgressIndicator(color: Color(0xFFE65100))
              : LinearProgressIndicator(
                  value: _audioProgress,
                  backgroundColor: Colors.white,
                  color: _orangeColor,
                  minHeight: 10,
                ),
        ],
      );
    } else if (_currentState == TranslatorState.translated) {
      return const Text(
        "Tap on the button to translate",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      );
    } else {
      return const Text(
        "Tap on the mic to record the voice",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      );
    }
  }

  Widget _buildMainButton() {
    switch (_currentState) {
      case TranslatorState.idle:
        return GestureDetector(
          onTap: _showWatchAdPopup, // Show Ad Popup before recording starts
          child: Image.asset(
            'assets/menu/translator_menu/mic_translator_menu.png',
            width: 120,
          ),
        );
      case TranslatorState.recording:
        return GestureDetector(
          onTap: _stopRecording,
          child: Image.asset(
            'assets/menu/translator_menu/record_translate_menu.png',
            width: 120,
          ),
        );
      case TranslatorState.translated:
        return GestureDetector(
          onTap: _translateAndPlay,
          child: Image.asset(
            'assets/menu/translator_menu/btn_translate_menu.png',
            width: 170,
          ),
        );
    }
  }

  Widget _buildBottomNavigation() {
    return Image.asset(
      'assets/menu/translator_menu/bottom_nav_translator_menu.png',
      width: double.infinity,
      fit: BoxFit.contain,
    );
  }

  @override
  void dispose() {
    _recordingTimer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final mins = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$mins:$secs";
  }
}
