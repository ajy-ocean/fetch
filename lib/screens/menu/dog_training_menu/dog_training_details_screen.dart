import 'package:flutter/material.dart';

class TrainingDetailScreen extends StatelessWidget {
  final dynamic item;
  const TrainingDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          item['title'] ?? '',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Simple & Efficient: AspectRatio defines the space immediately
            AspectRatio(
              aspectRatio: 16 / 9, // Standard widescreen ratio
              child: Image.network(
                item['post_image'] ?? '',
                fit: BoxFit.contain, // Ensures NO cropping
                alignment: Alignment.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE65100),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    item['description'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
