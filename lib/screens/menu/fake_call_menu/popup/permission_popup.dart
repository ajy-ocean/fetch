import 'package:flutter/material.dart';

class PermissionPopup extends StatelessWidget {
  const PermissionPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // Main Container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Permission Required",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "This app may not work correctly without the requested permissions. Open the app settings screen to modify app permissions.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 30),

                // Bone "Okay" Button
                GestureDetector(
                  onTap: () => Navigator.pop(context, true),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/menu/fake_call_menu/popup/bone_image_fake_call_menu.png',
                        width: 200,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: const Text(
                          "Okay",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Laying Dog Icon on top
          Positioned(
            top: -50,
            child: Image.asset(
              'assets/menu/fake_call_menu/popup/laying_dog_icon_fake_call_menu.png',
              height: 100,
            ),
          ),

          // Bottom Close Button
          Positioned(
            bottom: -60,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
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
