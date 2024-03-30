import 'package:arkeonil/common/colors.dart';
import 'package:arkeonil/common/paths.dart';
import 'package:arkeonil/common/sizes.dart';
import 'package:arkeonil/constants/string_constants.dart';
import 'package:arkeonil/features/auth/controller/auth_controller.dart';
import 'package:arkeonil/features/auth/views/sign_up.dart';
import 'package:arkeonil/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(signInNew), fit: BoxFit.cover),
            ),
          ),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              padding: all15,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: signInColor,
              ),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: vertical10,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          StringConstants.signIn,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(color: whiteColor),
                        ),
                      ),
                      Padding(
                        padding: vertical5,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !value.contains('@') ||
                                value.trim().isEmpty) {
                              return 'Email is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: vertical10,
                              hintText: StringConstants.email,
                              hintStyle: const TextStyle(
                                color: greyColor,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide:
                                      const BorderSide(color: greyColor)),
                              fillColor: whiteColor,
                              filled: true),
                        ),
                      ),
                      Padding(
                        padding: vertical5,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty || value.trim().length < 4) {
                              return 'Password is required';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              contentPadding: vertical10,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide:
                                      const BorderSide(color: borderColor)),
                              hintText: StringConstants.password,
                              hintStyle: const TextStyle(color: greyColor),
                              fillColor: whiteColor,
                              filled: true),
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          return Padding(
                            padding: vertical10,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ref
                                      .read(authControllerProvider)
                                      .signInWithEmailAndPassword(
                                          email: _emailController.text,
                                          password: _passwordController.text)
                                      .then(
                                        (value) => Navigator.of(context)
                                            .pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => const Home(),
                                          ),
                                        ),
                                      );
                                }
                              },
                              color: buttonColor,
                              minWidth: double.infinity,
                              child: const Padding(
                                padding: vertical10,
                                child: Text(
                                  StringConstants.signIn,
                                  style: TextStyle(color: whiteColor),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Container(
                        padding: vertical10,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          StringConstants.forgotPassword,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: whiteColor),
                        ),
                      ),
                      Container(
                        padding: vertical10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              StringConstants.dontHaveAccount,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: whiteColor),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const SignUp(),
                                  ),
                                );
                              },
                              child: const Text(StringConstants.signUp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
