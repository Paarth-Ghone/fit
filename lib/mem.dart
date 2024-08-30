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
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("img/background.png"), // Update this to your gym background
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 320,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                width: MediaQuery.of(context).size.width,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppLargeText(
                          text: "Choose Plan",
                          color: Colors.black.withOpacity(0.7),
                        ),
                        AppLargeText(
                          text: "\₹ ${prices[selectedIndex]}",
                          color: AppColors.mainColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    AppLargeText(
                      text: "Membership Plans",
                      color: Colors.black.withOpacity(0.8),
                      size: 20,
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 10, // Adds space between the buttons horizontally
                      runSpacing: 10, // Adds space between the buttons vertically
                      children: List.generate(plans.length, (index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Adjust padding
                            decoration: BoxDecoration(
                              color: selectedIndex == index ? Colors.black : AppColors.buttonBackground,
                              borderRadius: BorderRadius.circular(10), // Rounded corners for a better look
                              border: Border.all(
                                color: selectedIndex == index ? Colors.black : AppColors.buttonBackground,
                              ),
                            ),
                            child: AppText(
                              text: plans[index],
                              color: selectedIndex == index ? Colors.white : Colors.black,
                              size: 16, // Adjust text size to make it look better
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 20),
                    AppLargeText(
                      text: "Description",
                      color: Colors.black.withOpacity(0.8),
                      size: 20,
                    ),
                    SizedBox(height: 10),
                    AppText(
                      text: "Select a membership plan that best suits your fitness goals.",
                      color: AppColors.mainTextColor,
                    ),
                    SizedBox(height: 20),
                    AppLargeText(
                      text: "Current Plan",
                      color: Colors.black.withOpacity(0.8),
                      size: 20,
                    ),
                    SizedBox(height: 10),
                    AppText(
                      text: "$currentPlan Membership",
                      color: AppColors.mainTextColor,
                    ),
                    SizedBox(height: 10),
                    AppLargeText(
                      text: "Days Remaining",
                      color: Colors.black.withOpacity(0.8),
                      size: 20,
                    ),
                    SizedBox(height: 10),
                    AppText(
                      text: "$daysRemaining days",
                      color: AppColors.mainTextColor,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // Align items to the right
                children: [
                  AppButtons(
                    size: 60,
                    color: AppColors.textColor2,
                    backgroundcolor: Colors.white,
                    bordercolor: AppColors.textColor1,
                    isIcon: true,
                    icon: Icons.shopping_cart,
                  ),
                  SizedBox(width: 20),
                  ResponsiveButton(
                    width: 150,
                    onPressed: () {
                      // Handle purchase action
                    },
                    buttonText: 'Buy Now',
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




