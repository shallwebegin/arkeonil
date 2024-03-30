import 'package:arkeonil/common/colors.dart';
import 'package:arkeonil/common/paths.dart';
import 'package:arkeonil/common/sizes.dart';
import 'package:arkeonil/constants/string_constants.dart';
import 'package:arkeonil/features/auth/controller/auth_controller.dart';
import 'package:arkeonil/features/home/home.dart';

import 'package:arkeonil/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpContinue extends StatefulWidget {
  const SignUpContinue({super.key, required this.email});
  final String email;

  @override
  State<SignUpContinue> createState() => _SignUpContinueState();
}

class _SignUpContinueState extends State<SignUpContinue> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _usernameController.dispose();
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
                  image: AssetImage(signUpNew), fit: BoxFit.cover),
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
                          StringConstants.signUp,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(color: whiteColor),
                        ),
                      ),
                      Padding(
                        padding: vertical5,
                        child: TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: vertical10,
                              hintText: StringConstants.name,
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
                          controller: _surnameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Surname is required';
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
                              hintText: StringConstants.surname,
                              hintStyle: const TextStyle(color: greyColor),
                              fillColor: whiteColor,
                              filled: true),
                        ),
                      ),
                      Padding(
                        padding: vertical5,
                        child: TextFormField(
                          controller: _usernameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Username is required';
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
                              hintText: StringConstants.username,
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
                                  UserModel userModel = UserModel(
                                      name: _nameController.text,
                                      surname: _surnameController.text,
                                      username: _usernameController.text,
                                      email: widget.email);
                                  ref
                                      .read(authControllerProvider)
                                      .storeUserInfoFirebase(userModel)
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
                                  StringConstants.signUp,
                                  style: TextStyle(color: whiteColor),
                                ),
                              ),
                            ),
                          );
                        },
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
