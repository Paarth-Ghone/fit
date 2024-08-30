import 'package:flutter/material.dart';
import 'package:untitled1/cal.dart';
import 'package:untitled1/mem.dart';
import 'package:untitled1/misc/colors.dart';
import 'package:untitled1/widgets/app_largetext.dart';
import 'package:untitled1/widgets/app_text.dart';
import 'woklog.dart'; // Import your target pages
import 'profile.dart';
import 'exer.dart';
import 'prog.dart';
import 'settings.dart';
import 'logfood.dart';
import 'bmi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var exploreImages = {
    "background.png": "Progress Tracker",
    "exer.png": "Exercises",
    "note.png": "Note Workout",
  };

  var placesImages = {
    "Designer.png": "Calorie Tracker",
    "bm.png": "Manage Membership",
    "fin.png": "Add Food Intake",
    "bmi.png": "BMI Calculator"
  };

  void navigateToPage(String imageName) {
    Widget page;
    switch (imageName) {
      case "background.png":
        page = ProgressTrackingPage();
        break;
      case "exer.png":
        page = ExerciseTutorialPage();
        break;
      case "note.png":
        page = WorkoutLoggingPage();
        break;
      default:
        page = ProfilePage();
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void navigateToPlacePage(String imageName) {
    Widget page;
    switch (imageName) {
      case "Designer.png":
        page = CalorieTrackingPage();
        break;
      case "bm.png":
        page = MembershipPage();
        break;
      case "fin.png":
        page = FoodIntakeLoggingPage();
        break;
      case "bmi.png":
        page = BMICalculatorPage();
        break;
      default:
        page = CalorieTrackingPage();
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void _onMenuSelected(String value) {
    switch (value) {
      case 'profile':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
      case 'settings':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 1, vsync: this);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E2E2E), Color(0xFF121212)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menu text
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    PopupMenuButton<String>(
                      icon: Icon(Icons.menu, size: 30, color: Colors.white70),
                      onSelected: _onMenuSelected,
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<String>(
                            value: 'profile',
                            child: Text('Profile', style: TextStyle(color: Colors.black)),
                          ),
                          PopupMenuItem<String>(
                            value: 'settings',
                            child: Text('Settings', style: TextStyle(color: Colors.black)),
                          ),
                        ];
                      },
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Explore more section
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppLargeText(
                      text: "Explore Features",
                      size: 22,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Images List
              Container(
                height: 160,
                width: double.maxFinite,
                margin: const EdgeInsets.only(left: 20),
                child: ListView.builder(
                  itemCount: exploreImages.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    String imageName = exploreImages.keys.elementAt(index);
                    String imageDescription = exploreImages.values.elementAt(index);

                    return GestureDetector(
                      onTap: () => navigateToPage(imageName),
                      child: Container(
                        margin: const EdgeInsets.only(right: 30),
                        child: Column(
                          children: [
                            // Gradient border for images
                            Container(
                              padding: const EdgeInsets.all(3), // Padding for the border effect
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.greenAccent, Colors.lightGreen],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Container(
                                width: 80,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[800],
                                  image: DecorationImage(
                                    image: AssetImage("img/" + imageName),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            AppText(
                              text: imageDescription,
                              color: Colors.grey.shade400,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
              // TabBar
              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: TabBar(
                    labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: false,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(text: "More"),
                    ],
                  ),
                ),
              ),
              // TabBarView
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 20),
                height: 320,
                width: double.maxFinite,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                      itemCount: placesImages.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        String imageName = placesImages.keys.elementAt(index);
                        String imageDescription = placesImages.values.elementAt(index);

                        return GestureDetector(
                          onTap: () => navigateToPlacePage(imageName),
                          child: Container(
                            margin: const EdgeInsets.only(right: 15, top: 10),
                            width: 200,
                            height: 320,
                            child: Column(
                              children: [
                                // Gradient border for images
                                Container(
                                  padding: const EdgeInsets.all(4), // Padding for the border effect
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.greenAccent, Colors.lightGreen],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 260,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey[800],
                                      image: DecorationImage(
                                        image: AssetImage("img/" + imageName),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  imageDescription,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
