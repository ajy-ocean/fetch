import 'package:flutter/material.dart';

class DogCallPopup extends StatefulWidget {
  final Map<String, String> dog;

  const DogCallPopup({super.key, required this.dog});

  @override
  State<DogCallPopup> createState() => _DogCallPopupState();
}

class _DogCallPopupState extends State<DogCallPopup> {
  String _selectedTimer = "Off";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // Main White Container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Overview",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // Dog Portrait
                CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage(widget.dog['image']!),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.dog['name']!,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Set call after:",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 15),

                // Responsive Timer Selection
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: ["Off", "5s", "15s", "30s", "1m", "3m", "5m"].map((
                    time,
                  ) {
                    bool isSelected = _selectedTimer == time;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedTimer = time),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.orange : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.orange, width: 1),
                        ),
                        child: Text(
                          time,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 30),

                // Video Call Button Section
                // Inside dog_call_popup.dart
                GestureDetector(
                  onTap: () {
                    // Just close and tell the caller we want to open permissions
                    Navigator.pop(context, 'show_permission');
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/menu/fake_call_menu/popup/bone_image_fake_call_menu.png',
                        width: 240,
                        fit: BoxFit.contain,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: const Text(
                          "Take a video call",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Top Dog Icon decoration
          Positioned(
            top: -55,
            child: Image.asset(
              'assets/menu/fake_call_menu/popup/dog_icon_fake_call_menu.png',
              height: 110,
            ),
          ),

          // Bottom Close Button
          Positioned(
            bottom: -70,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.grey, size: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
