import 'package:fetch/screens/menu/fake_call_menu/incoming_call_screen.dart';
import 'package:fetch/screens/menu/fake_call_menu/popup/permission_popup.dart';
import 'package:flutter/material.dart';
import 'package:fetch/screens/menu/fake_call_menu/popup/dog_call_popup.dart';

class DogCallScreen extends StatefulWidget {
  const DogCallScreen({super.key});

  @override
  State<DogCallScreen> createState() => _DogCallScreenState();
}

class _DogCallScreenState extends State<DogCallScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _allDogs = [
    {
      'name': 'Husky',
      'image': 'assets/menu/fake_call_menu/husky_fake_call_menu.jpg',
    },
    {
      'name': 'Chihuahua',
      'image': 'assets/menu/fake_call_menu/chihuahua_fake_call_menu.jpg',
    },
    {
      'name': 'Labrador',
      'image': 'assets/menu/fake_call_menu/labrador_fake_call_menu.jpg',
    },
    {
      'name': 'Golden',
      'image': 'assets/menu/fake_call_menu/goldenretriever_fake_call_menu.jpg',
    },
    {
      'name': 'Shi Tzu',
      'image': 'assets/menu/fake_call_menu/shitzu_fake_call_menu.jpg',
    },
  ];

  List<Map<String, String>> _filteredDogs = [];

  @override
  void initState() {
    super.initState();
    _filteredDogs = _allDogs;
  }

  void _filterDogs(String query) {
    setState(() {
      _filteredDogs = _allDogs
          .where(
            (dog) => dog['name']!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF2),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      'assets/menu/fake_call_menu/home_icon_fake_call_menu.png',
                      width: 40,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Dog Call",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            // Enhanced Responsive Search Bone
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Center(
                child: SizedBox(
                  width: screenWidth * 0.9,
                  height: 100, // Large height for the bone
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background bone asset
                      Image.asset(
                        'assets/menu/fake_call_menu/search_bone.png',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                      ),

                      // Controllable Search Row
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                          left: 60,
                          right: 60,
                          top: 5,
                          bottom: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 24,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: _filterDogs,
                                cursorColor: Colors.orange,
                                cursorHeight: 16,
                                cursorWidth: 1.2,
                                decoration: const InputDecoration(
                                  hintText: "Search here",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Dog List Section
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filteredDogs.length,
                itemBuilder: (context, index) {
                  final dog = _filteredDogs[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: AssetImage(dog['image']!),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            dog['name']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          // Trigger the popup in a clean way
                          // Inside your main screen's camera icon onTap
                          // Inside DogCallScreen (Main List)
                          GestureDetector(
                            onTap: () async {
                              // 1. Show Overview Popup
                              final overviewResult = await showDialog<String>(
                                context: context,
                                builder: (context) => DogCallPopup(dog: dog),
                              );

                              if (!mounted ||
                                  overviewResult != 'show_permission')
                                return;

                              // 2. Show Permission Popup
                              final permissionResult = await showDialog<bool>(
                                context: context,
                                builder: (context) => const PermissionPopup(),
                              );

                              if (!mounted || permissionResult != true) return;

                              // 3. Navigate to Call Screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      IncomingCallScreen(dog: dog),
                                ),
                              );
                            },
                            child: Image.asset(
                              'assets/menu/fake_call_menu/camera_icon_fake_call_menu.png',
                              width: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Image.asset(
              'assets/menu/fake_call_menu/bottom_nav_fake_call_menu.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
