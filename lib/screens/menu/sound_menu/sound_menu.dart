import 'package:fetch/model/dog_sound.dart';
import 'package:fetch/screens/menu/sound_menu/sound_player.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SoundScreen extends StatefulWidget {
  const SoundScreen({super.key});

  @override
  State<SoundScreen> createState() => _SoundScreenState();
}

class _SoundScreenState extends State<SoundScreen> {
  Future<List<DogSound>> fetchSounds() async {
    final response = await http.get(
      Uri.parse(
        'https://appy.trycatchtech.com/v3/dog_translator/all_sound_list',
      ),
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => DogSound.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load sounds');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/menu/sound_menu/home_icon_sound_menu.png',
            ),
          ),
        ),
        title: const Text(
          'All Sounds',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      // Use a Stack or ensure the bottom image is handled properly to avoid overflow
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Image.asset(
              'assets/menu/sound_menu/searchbar_sound_menu.png',
              fit: BoxFit.contain,
            ),
          ),

          Expanded(
            child: FutureBuilder<List<DogSound>>(
              future: fetchSounds(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.orange),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 15,
                      // Adjusted ratio to give text more room, preventing vertical overflow
                      childAspectRatio: 0.75,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final sound = snapshot.data![index];

                      // PLACE THE NAVIGATION CODE HERE
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SoundPlayerScreen(
                                soundData: sound,
                              ), // Pass the API data
                            ),
                          );
                        },
                        child: _buildSoundCircle(
                          sound,
                        ), // Your existing circular UI function
                      );
                    },
                  );
                }
              },
            ),
          ),

          // Fixed Bottom Navigation
          SafeArea(
            top: false,
            child: Image.asset(
              'assets/menu/sound_menu/bottom_nav_sound_menu.png',
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoundCircle(DogSound sound) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth;
        return Column(
          children: [
            Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              clipBehavior:
                  Clip.antiAlias, // Ensures the image stays inside the circle
              child: Image.network(
                sound.image,
                fit: BoxFit.cover,
                // THIS PREVENTS THE CRASH LOGS FROM BREAKING THE UI
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey,
                    child: const Icon(
                      Icons.pets,
                      color: Colors.orange,
                      size: 30,
                    ),
                  );
                },
                // Optional: Show a loader while the dog face is downloading
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              sound.name,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
