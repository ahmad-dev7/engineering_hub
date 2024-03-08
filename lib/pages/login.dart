import 'package:engineering_hub/backend/api_calls.dart';
import 'package:engineering_hub/constants/Kstyledtext.dart';
import 'package:engineering_hub/constants/kbutton.dart';
import 'package:engineering_hub/theme/theme_data.dart';
import 'package:engineering_hub/constants/ksnackbar.dart';
import 'package:engineering_hub/constants/kform_textfield.dart';
import 'package:engineering_hub/theme/theme_changer.dart';
import 'package:engineering_hub/constants/kwidgetwrap.dart';
import 'package:engineering_hub/pages/navigation.dart';
import 'package:engineering_hub/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool obsecure = true;
  IconData eyeOff = Icons.visibility_off;
  IconData eyeOpen = Icons.visibility;
  //* login function
  login({required String email, required String password}) async {
    bool dataFound = await Api().getData(email: email, password: password);
    if (dataFound) {
      KSnackBar("You are successfully logged-in").success();
      Get.offAll(() => const BottomNavigationMenu());
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      KSnackBar("Login credential is wrong, please try again").failed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: styledText(
          text: 'ENGINEERING HUB',
          lSpacing: 3,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
        ),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: const [
          ThemeChangerWidget(),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //* header image
                  Opacity(
                    opacity: provider.isDarkMode ? 0.8 : 1.0,
                    child: Image.asset('images/login.png'),
                  ),

                  //* Email input field
                  KWidgetWrap(
                    height: 0.040,
                    child: KFormTextField(
                      hintText: 'Enter email',
                      inputType: TextInputType.emailAddress,
                      controller: emailController,
                      errorIndicator: (value) {
                        return value.isEmail;
                      },
                      validator: (value) {
                        return !value.isEmail
                            ? 'Please enter valid email'
                            : null;
                      },
                      prefixIcon: Icons.email,
                    ),
                  ),

                  //* Password input field
                  KWidgetWrap(
                    height: 0.040,
                    child: KFormTextField(
                      hintText: 'Enter password',
                      inputType: TextInputType.visiblePassword,
                      prefixIcon: Icons.key,
                      errorIndicator: (value) {
                        return false;
                      },
                      validator: (value) {
                        return value.isEmpty ? 'Please enter password' : null;
                      },
                      controller: passwordController,
                      password: obsecure,
                      suffixIcon: InkWell(
                        onTap: () => setState(() {
                          obsecure = !obsecure;
                        }),
                        child: Icon(
                          obsecure ? eyeOpen : eyeOff,
                          color: Theme.of(context).hoverColor.withAlpha(50),
                        ),
                      ),
                    ),
                  ),

                  //* Login button
                  KWidgetWrap(
                    height: 0.070,
                    child: KActionButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          login(
                            email: emailController.text.trim().toLowerCase(),
                            password: passwordController.text,
                          );
                        }
                      },
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : styledText(
                              text: 'Login',
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                    ),
                  ),

                  //* Create account text button
                  KWidgetWrap(
                    height: 0.060,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(width: 2),
                        TextButton(
                          onPressed: () => Get.to(() => const SignupPage()),
                          child: styledText(
                            text: 'Create account',
                            weight: FontWeight.bold,
                            size: 15,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            decorationColor: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.3),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
