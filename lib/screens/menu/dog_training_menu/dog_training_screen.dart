import 'dart:convert';
import 'package:fetch/screens/menu/dog_training_menu/dog_training_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DogTrainingScreen extends StatefulWidget {
  const DogTrainingScreen({super.key});

  @override
  State<DogTrainingScreen> createState() => _DogTrainingScreenState();
}

class _DogTrainingScreenState extends State<DogTrainingScreen> {
  // UI Colors from your design
  final Color _bgColor = const Color(0xFFFFFBF2);
  final Color _orangeColor = const Color(0xFFE65100);

  Future<List<dynamic>> _fetchTrainings() async {
    final response = await http.get(
      Uri.parse(
        'https://appy.trycatchtech.com/v3/dog_translator/trainings_list',
      ),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load training data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: _fetchTrainings(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No training data found'),
                        );
                      }

                      final trainings = snapshot.data!;
                      return ListView.builder(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 10,
                          bottom: 120,
                        ),
                        itemCount: trainings.length,
                        itemBuilder: (context, index) {
                          final item = trainings[index];
                          return _buildTrainingCard(item);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            // Fixed Bottom Navigation
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
            "Dog Training",
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

  Widget _buildTrainingCard(dynamic item) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrainingDetailScreen(item: item),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        // Using a fixed height for the card is more efficient than IntrinsicHeight
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.05,
              ), // Updated from withOpacity
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: SizedBox(
                width: 120,
                child: Image.network(
                  item['post_image'] ?? '',
                  fit: BoxFit.cover,
                  // Placeholder prevents the semantics error by keeping the size stable
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.pets),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['title'] ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _orangeColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item['description'] ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Image.asset(
      'assets/menu/translator_menu/bottom_nav_translator_menu.png',
      width: double.infinity,
      fit: BoxFit.contain,
    );
  }
}
