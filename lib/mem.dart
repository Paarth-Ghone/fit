import 'package:flutter/material.dart';
import 'package:untitled1/misc/colors.dart';
import 'package:untitled1/widgets/app_buttons.dart';
import 'package:untitled1/widgets/app_largetext.dart';
import 'package:untitled1/widgets/app_text.dart';
import 'package:untitled1/widgets/responsive_button.dart';
import 'profile.dart';
import 'settings.dart';

class MembershipPage extends StatefulWidget {
  const MembershipPage({super.key});

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  int selectedIndex = 0;
  final List<String> plans = ["Monthly", "6 Months", "Yearly"];
  final List<double> prices = [1200.0, 6000.0, 12000.0]; // Example prices

  // Example data for the current plan and days remaining
  String currentPlan = "Monthly"; // Replace with actual data
  int daysRemaining = 30; // Replace with actual data

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
                          text: "Choose Plan",
                          color: Colors.white.withOpacity(0.7),
                        ),
                        AppLargeText(
                          text: "₹${prices[selectedIndex]}",
                          color: AppColors.mainColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    AppLargeText(
                      text: "Membership Plans",
                      color: Colors.white.withOpacity(0.8),
                      size: 20,
                    ),
                    SizedBox(height: 10),
                    // Plan Selection Buttons
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
                            child: AppText(
                              text: plans[index],
                              color: selectedIndex == index ? Colors.white : Colors.white70,
                              size: 16,
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 20),
                    AppLargeText(
                      text: "Description",
                      color: Colors.white.withOpacity(0.8),
                      size: 20,
                    ),
                    SizedBox(height: 10),
                    AppText(
                      text: "Select a membership plan that best suits your fitness goals.",
                      color: Colors.white70,
                    ),
                    SizedBox(height: 20),
                    // Current Plan and Days Remaining
                    _buildPlanDetails("Current Plan", "$currentPlan Membership"),
                    _buildPlanDetails("Days Remaining", "$daysRemaining days"),
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
                  // Remove AppColors and define colors directly
                  AppButtons(
                    size: 60,
                    color: Colors.white,  // Updated to white for better visibility on gradient
                    backgroundcolor: Colors.grey.shade400,
                    bordercolor: Colors.green,  // Gradient border color similar to login button's gradient
                    isIcon: true,
                    icon: Icons.shopping_cart,
                  ),
                  SizedBox(width: 20),
                  // Responsive Button with Gradient Background
                  GestureDetector(
                    onTap: () {
                      // Handle purchase action
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
                          color: Colors.white, // Set the text color to white for visibility
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

  // Helper method for displaying plan details
  Widget _buildPlanDetails(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppLargeText(
          text: title,
          color: Colors.white.withOpacity(0.8),
          size: 20,
        ),
        SizedBox(height: 10),
        AppText(
          text: value,
          color: Colors.white70,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
