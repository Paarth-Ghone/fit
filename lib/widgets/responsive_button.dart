import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/misc/colors.dart';
import 'package:untitled1/widgets/app_text.dart';

class ResponsiveButton extends StatelessWidget {
  final bool? isResponsive;
  final double? width;
  final VoidCallback? onPressed; // Add this line

  ResponsiveButton({super.key, this.width = 120, this.isResponsive, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: isResponsive == true ? double.maxFinite : width,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.mainColor,
          ),
          child: Row(
            mainAxisAlignment: isResponsive == true ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
            children: [
              isResponsive == true ? Container(
                margin: const EdgeInsets.only(left: 20),
                child: AppText(text: "Book Trip Now", color: Colors.white),
              ) : Container(),
              Image.asset("img/button-one.png"),
            ],
          ),
        ),
      ),
    );
  }
}