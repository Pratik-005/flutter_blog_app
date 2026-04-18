import 'package:blog_app/core/theme/color_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onPressed;
  const AuthGradientButton({
    super.key,
    required this.btnText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppPallete.gradient1, AppPallete.gradient2],
          begin: .bottomLeft,
          end: .topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),

      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(395, 55),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(btnText, style: TextStyle(fontSize: 17, fontWeight: .w600)),
      ),
    );
  }
}
