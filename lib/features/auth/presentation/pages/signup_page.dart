import 'package:blog_app/core/theme/color_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/core/widgets/Loader.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        
        builder: (context, state) {
          if (state is AuthLoading) {
            return Loader();
          }

          return Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 40, fontWeight: .bold),
                  ),
                  const SizedBox(height: 30),
                  AuthField(hintText: 'Name', controller: nameController),
                  const SizedBox(height: 30),
                  AuthField(hintText: 'Email', controller: emailController),
                  const SizedBox(height: 30),
                  AuthField(
                    hintText: 'Password',
                    controller: passwordController,
                    isObscured: true,
                  ),
                  const SizedBox(height: 20),
                  AuthGradientButton(
                    btnText: 'Sign Up',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthSignup(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            name: nameController.text.trim(),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account  ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: "Sign In",
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
          );
        },
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackbar(context, state.message);
          }
        },
      ),
    );
  }
}
