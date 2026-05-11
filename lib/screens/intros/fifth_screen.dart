import 'package:fetch/screens/menu/main_menu.dart';
import 'package:flutter/material.dart';

class FifthScreen extends StatefulWidget {
  const FifthScreen({super.key});

  @override
  State<FifthScreen> createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  // 1. Language data and selection state
  String _selectedLanguage = 'English';
  final List<Map<String, String>> _languages = [
    {'name': 'English', 'flag': 'assets/intros/fifth_screen/flags/britain_flag.png'},
    {'name': 'Hindi', 'flag': 'assets/intros/fifth_screen/flags/india_flag.png'},
    {'name': 'Spanish', 'flag': 'assets/intros/fifth_screen/flags/spain_flag.png'},
    {'name': 'French', 'flag': 'assets/intros/fifth_screen/flags/france_flag.png'},
    {'name': 'Portugese', 'flag': 'assets/intros/fifth_screen/flags/portuguese_flag.png'},
    {'name': 'Korean', 'flag': 'assets/intros/fifth_screen/flags/south_korea_flag.png'},
    {'name': 'Russian', 'flag': 'assets/intros/fifth_screen/flags/russia.png'},
    {'name': 'Japanese', 'flag': 'assets/intros/fifth_screen/flags/nihon_flag.png'},
  ];

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

  // 2. Helper to build individual language rows
  Widget _buildLanguageItem(String name, String flagPath) {
    bool isSelected = _selectedLanguage == name;

    return GestureDetector(
      onTap: () => setState(() => _selectedLanguage = name),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Image.asset(flagPath, width: 45, height: 30, fit: BoxFit.contain),
            const SizedBox(width: 15),
            Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            // 3. Custom Radio-style Selection
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.orange : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Center(
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor: Colors.orange,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF2),
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Select Language',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // 4. Scrollable language list
                  Expanded(
                    child: ListView.builder(
                      itemCount: _languages.length,
                      itemBuilder: (context, index) {
                        return _buildLanguageItem(
                          _languages[index]['name']!,
                          _languages[index]['flag']!,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 350,
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/intros/fifth_screen/fifth_screen_bottom_puppy.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),

                Positioned(
                  bottom: 250,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapDown: (_) => _controller.forward(),
                    onTapUp: (_) {
                      _controller.reverse();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainMenuScreen(),
                        ),
                      );
                    },
                    onTapCancel: () => _controller.reverse(),
                    child: ScaleTransition(
                      scale: Tween<double>(
                        begin: 1.0,
                        end: 0.9,
                      ).animate(_controller),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/intros/fifth_screen/fifth_screen_continue_bone.png',
                            width: 280,
                          ),
                        ],
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