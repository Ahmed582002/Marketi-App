import 'package:flutter/material.dart';
import 'package:store/core/constants/color.dart';

class CustomProfileButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomProfileButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFC2C6D4),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Ink(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: "PlusJakartaSans",
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: AppColors.text,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
