import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guide/res/custom_colors.dart';
import 'package:guide/screens/register_screen.dart';
import 'package:guide/screens/investorScreen.dart';
import 'package:guide/utils/authentication.dart';
import 'package:guide/utils/validator.dart';

import 'custom_form_field.dart';

class SignInForm extends StatefulWidget {
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  const SignInForm({
    Key? key,
    required this.emailFocusNode,
    required this.passwordFocusNode,
  }) : super(key: key);
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _signInFormKey = GlobalKey<FormState>();

  bool _isSigningIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).backgroundColor),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _signInFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 24.0,
                ),
                child: Column(
                  children: [
                    CustomFormField(
                      controller: _emailController,
                      focusNode: widget.emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      validator: (value) => Validator.validateEmail(
                        email: value,
                      ),
                      label: 'Email',
                      hint: 'Email',
                    ),
                    SizedBox(height: 16.0),

                    CustomFormField(
                      controller: _passwordController,
                      focusNode: widget.passwordFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.done,
                      validator: (value) => Validator.validatePassword(
                        password: value,
                      ),
                      isObscure: true,
                      label: 'Password',
                      hint: 'Password',
                    ),

                    // SizedBox(height: 16.0),
                  ],
                ),
              ),
              _isSigningIn
                  ? Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          CustomColors.firebaseOrange,
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 0.0, right: 0.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            CustomColors.firebaseOrange,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          widget.emailFocusNode.unfocus();
                          widget.passwordFocusNode.unfocus();

                          setState(() {
                            _isSigningIn = true;
                          });

                          if (_signInFormKey.currentState!.validate()) {
                            User? user =
                                await Authentication.signInUsingEmailPassword(
                              context: context,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );

                            if (user != null) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => InvestorScreen(
                                          user: user,
                                        )),
                              );
                            }
                          }

                          setState(() {
                            _isSigningIn = false;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.firebaseGrey,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
                child: Text(
                  'Don\'t have an account? Sign up',
                  style: TextStyle(
                    color: CustomColors.firebaseGrey,
                    letterSpacing: 0.5,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
