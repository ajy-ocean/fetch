import 'package:fetch/screens/menu/sound_menu/sound_menu.dart';
import 'package:fetch/screens/menu/whistle_menu/whistle_menu.dart';
import 'package:fetch/screens/menu/fake_call_menu/dog_call.dart';
import 'package:fetch/screens/menu/translator_menu/dog_translator_menu.dart';
import 'package:fetch/screens/menu/dog_training_menu/dog_training_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainMenuScreen extends StatelessWidget {
  MainMenuScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    double scaleFactor = screenWidth / 390;
    if (scaleFactor > 1.1) scaleFactor = 1.1;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFFFFBF2),
      drawer: _buildSidebar(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: UnconstrainedBox(
          child: GestureDetector(
            onTap: () => _scaffoldKey.currentState?.openDrawer(),
            child: Image.asset(
              'assets/menu/main_menu/menu_sidebar_icon.png',
              width: 30 * scaleFactor,
              height: 30 * scaleFactor,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: const Text(
          'Dog Voice Translator Prank',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              _buildImage(
                path: 'assets/menu/main_menu/dog_training_menu.png',
                width: 356.35,
                height: 217,
                scale: scaleFactor,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DogTrainingScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildImage(
                      path: 'assets/menu/main_menu/sound_menu.png',
                      width: 165,
                      height: 170,
                      scale: scaleFactor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SoundScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    _buildImage(
                      path: 'assets/menu/main_menu/translator_menu.png',
                      width: 165,
                      height: 170,
                      scale: scaleFactor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DogTranslatorScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildImage(
                path: 'assets/menu/main_menu/groupofpuppies_menu.png',
                width: 350,
                height: 180,
                scale: scaleFactor,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildImage(
                      path: 'assets/menu/main_menu/fake_call_menu.png',
                      width: 165,
                      height: 170,
                      scale: scaleFactor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DogCallScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    _buildImage(
                      path: 'assets/menu/main_menu/whistle_menu.png',
                      width: 165,
                      height: 170,
                      scale: scaleFactor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WhistleScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      width: MediaQuery.of(context).size.width * 0.78,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFFFBF2),
              borderRadius: BorderRadius.only(topRight: Radius.circular(80)),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  // Added Navigation to each sidebar item
                  _sidebarItem('Dog Sounds', Icons.volume_up_rounded, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SoundScreen(),
                      ),
                    );
                  }),
                  _sidebarItem(
                    'Dog Voice Translator',
                    Icons.translate_rounded,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DogTranslatorScreen(),
                        ),
                      );
                    },
                  ),
                  _sidebarItem('Training', Icons.fitness_center_rounded, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DogTrainingScreen(),
                      ),
                    );
                  }),
                  _sidebarItem('Fake Call', Icons.videocam_rounded, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DogCallScreen(),
                      ),
                    );
                  }),
                  _sidebarItem(
                    'Whistle',
                    Icons.settings_input_component_rounded,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WhistleScreen(),
                        ),
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(24, 30, 24, 10),
                    child: Text(
                      'More',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  _sidebarItem('Privacy policy', Icons.privacy_tip_rounded, () {
                    _launchUrl('https://ajy-ocean.github.io/fetch/PRIVACY.md');
                  }),
                  _sidebarItem(
                    'Terms & Conditions',
                    Icons.description_rounded,
                    () {
                      _launchUrl('https://ajy-ocean.github.io/fetch/TERMS.md');
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFFF9800),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Updated to accept an onTap callback
  Widget _sidebarItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: Icon(icon, color: const Color(0xFFFF9800)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      onTap: onTap,
    );
  }

  Widget _buildImage({
    required String path,
    required double width,
    required double height,
    required double scale,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap ?? () => debugPrint("Tapped $path"),
      child: Image.asset(
        path,
        width: width * scale,
        height: height * scale,
        fit: BoxFit.fill,
      ),
    );
  }
}
