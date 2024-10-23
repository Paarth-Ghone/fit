import 'package:flutter/material.dart';
import 'package:untitled1/misc/colors.dart';
import 'package:untitled1/widgets/app_buttons.dart';
import 'package:untitled1/widgets/app_largetext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/widgets/app_text.dart';
import 'package:untitled1/widgets/responsive_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MembershipPage extends StatefulWidget {
  const MembershipPage({super.key});

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  int selectedIndex = 0;
  final List<String> plans = ["Monthly", "6 Months", "Yearly"];
  final List<double> prices = [1200.0, 6000.0, 12000.0]; // Example prices

  String currentPlan = "None"; // Default value if no plan exists
  int daysRemaining = 0; // Default days remaining

  @override
  void initState() {
    super.initState();
    _fetchMembershipDetails();
  }

  // Fetch membership details from the database
  Future<void> _fetchMembershipDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId != null) {
      try {
        final response = await http.get(
          Uri.parse('https://test-tuk7.onrender.com/membership/$userId'),
          headers: {
            "Authorization": "Bearer ${prefs.getString('token')}",
          },
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            currentPlan = data['plan'] ?? "None";
            daysRemaining = data['daysRemaining'] ?? 0;
          });
        } else {
          print('Error fetching membership details: ${response.body}');
        }
      } catch (e) {
        print('Error: $e');
      }
    } else {
      print('User not logged in');
    }
  }

  bool get canPurchase => currentPlan == "None" || daysRemaining <= 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // Background Image
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("img/mem.png"), // Update with your gym background image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Membership Details Container
            Positioned(
              top: 320,
              child: Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.grey[900], // Change background to grey or black
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Plan Details
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppLargeText(
                          text: "Current Plan",
                          color: Colors.white.withOpacity(0.7),
                        ),

                      ],
                    ),
                    AppLargeText(
                      text: currentPlan == "None" ? "No Plan" : "$currentPlan Membership",
                      color: AppColors.mainColor,
                    ),
                    SizedBox(height: 20),
                    AppLargeText(
                      text: "Days Remaining",
                      color: Colors.white.withOpacity(0.8),
                      size: 20,
                    ),
                    SizedBox(height: 10),
                    AppText(
                      text: "$daysRemaining days",
                      color: Colors.white70,
                    ),
                    SizedBox(height: 20),



                    // Buying Options
                    if (canPurchase) _buildPlanSelection(),
                  ],
                ),
              ),
            ),
            // Bottom Button Row
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButtons(
                    size: 60,
                    color: Colors.white,
                    backgroundcolor: Colors.grey.shade400,
                    bordercolor: Colors.green,
                    isIcon: true,
                    icon: Icons.shopping_cart,
                  ),
                  SizedBox(width: 20),
                  // Buy Now Button with Gradient Background
                  GestureDetector(
                    onTap: () async {
                      // Retrieve the userId from SharedPreferences
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      String? userId = prefs.getString('userId');

                      if (userId != null) {
                        String plan = plans[selectedIndex];
                        double price = prices[selectedIndex];

                        try {
                          final response = await http.post(
                            Uri.parse('https://test-tuk7.onrender.com/purchase'),
                            headers: {
                              "Content-Type": "application/json",
                              "Authorization": "Bearer ${prefs.getString('token')}",
                            },
                            body: jsonEncode({
                              "userId": userId,
                              "plan": plan,
                              "price": price,
                            }),
                          );

                          if (response.statusCode == 201) {
                            // Handle successful purchase
                            setState(() {
                              currentPlan = plan;
                              daysRemaining = _getDaysForPlan(plan);
                            });
                            print('Membership purchased successfully');
                          } else {
                            print('Error purchasing membership: ${response.body}');
                          }
                        } catch (e) {
                          print('Error: $e');
                        }
                      } else {
                        print('User not logged in');
                      }
                    },
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00FFCB), Color(0xFF008CFF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: Text(
                        'Buy Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  Widget _buildPlanSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppLargeText(
          text: "Choose Plan",
          color: Colors.white.withOpacity(0.7),
        ),
        SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(plans.length, (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  gradient: selectedIndex == index
                      ? LinearGradient(
                    colors: [Colors.green.shade300, Colors.green.shade700],
                  )
                      : null,
                  color: selectedIndex != index ? Colors.grey[800] : null,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selectedIndex == index ? Colors.transparent : Colors.grey[800]!,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      text: plans[index],
                      color: selectedIndex == index ? Colors.white : Colors.white70,
                      size: 16,
                    ),
                    SizedBox(width: 10),
                    AppText(
                      text: "₹${prices[index]}",  // Display the price
                      color: selectedIndex == index ? Colors.white : Colors.white70,
                      size: 16,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 20),
      ],
    );
  }


  // Helper method for getting the days for each plan
  int _getDaysForPlan(String plan) {
    switch (plan) {
      case "Monthly":
        return 30;
      case "6 Months":
        return 180;
      case "Yearly":
        return 365;
      default:
        return 0;
    }
  }
}

