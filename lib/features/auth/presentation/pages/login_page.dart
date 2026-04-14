import 'package:blog_app/core/theme/color_pallete.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 40, fontWeight: .bold),
              ),
              const SizedBox(height: 30),
              AuthField(hintText: 'Email', controller: emailController),
              const SizedBox(height: 30),
              AuthField(
                hintText: 'Password',
                controller: passwordController,
                isObscured: true,
              ),
              const SizedBox(height: 20),
              const AuthGradientButton(btnText: 'Sign In'),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupPage()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account ?  ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppPallete.gradient2,
                              fontWeight: .bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
