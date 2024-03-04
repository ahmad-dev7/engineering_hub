import 'package:engineering_hub/backend/api_calls.dart';
import 'package:engineering_hub/constants/Kstyledtext.dart';
import 'package:engineering_hub/constants/kbutton.dart';
import 'package:engineering_hub/constants/ksnackbar.dart';
import 'package:engineering_hub/constants/kform_textfield.dart';
import 'package:engineering_hub/constants/kwidgetwrap.dart';
import 'package:engineering_hub/model/items_list.dart';
import 'package:engineering_hub/packages/dropdown_button2.dart';
import 'package:engineering_hub/pages/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  IconData eyeOff = Icons.visibility_off;
  IconData eyeOpen = Icons.visibility;
  String? selectedCollege;
  String? selectedBranch;
  String? selectedSemester;
  bool isLoading = false;
  bool obsecure = true;

  void signup() async {
    //* Checking database if the following number is already in use
    bool isNumberInUse = await Api().checkDatabase(
      name: 'phone',
      value: phoneNumberController.text,
    );

    //* Checking database if the following email is already in use
    bool isEmailInUse = await Api().checkDatabase(
      name: 'email',
      value: emailController.text.trim().toLowerCase(),
    );

    //! Alerting user that number is already in use
    if (isNumberInUse) {
      KSnackBar('Number is already in use').failed();
    }

    //! Alerting user that email is already in use
    if (isEmailInUse) {
      KSnackBar('Email is already in use').failed();
    }

    //* Adding user in database after verifying all details
    if (!isEmailInUse && !isNumberInUse) {
      bool postData = await Api().postData(
        collegeName: selectedCollege!,
        branch: selectedBranch!,
        semester: selectedSemester!,
        name: nameController.text,
        email: emailController.text.trim().toLowerCase(),
        phoneNo: phoneNumberController.text,
        password: passwordController.text,
      );
      if (postData) {
        setState(() {
          isLoading = false;
        });
        KSnackBar('Account created successfully').success();
        Get.offAll(() => const BottomNavigationMenu(),
            transition: Transition.cupertinoDialog,
            duration: const Duration(seconds: 2));
      } else {
        setState(() {
          isLoading = false;
        });
        KSnackBar('Failed to create account. Try again').failed();
      }
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: styledText(
          text: 'Create Account',
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
        ),
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //* College input field
                    KWidgetWrap(
                      child: SearchDropdownButton(
                        buttonHint: 'Select  college',
                        searchHint: 'Find  college',
                        selectedValue: selectedCollege,
                        itemsList: collegeList,
                        onSelect: (college) => setState(
                          () => selectedCollege = college,
                        ),
                      ),
                    ),

                    //* Branch input field
                    KWidgetWrap(
                      child: SearchDropdownButton(
                        buttonHint: 'Select branch',
                        searchHint: 'Find branch',
                        itemsList: branchList,
                        selectedValue: selectedBranch,
                        onSelect: (branch) => setState(
                          () => selectedBranch = branch,
                        ),
                      ),
                    ),

                    //* Semester and name input field
                    KWidgetWrap(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //* Semester input field
                          SizedBox(
                            width: (size.width / 3),
                            child: SelectDropdownButton(
                              buttonHint: 'Select semester',
                              itemsList: semesterList,
                              selectedValue: selectedSemester,
                              onSelect: (semester) =>
                                  setState(() => selectedSemester = semester),
                            ),
                          ),

                          //* Name input field
                          SizedBox(
                            width: (size.width / 1.8),
                            child: KFormTextField(
                              hintText: 'Enter name',
                              inputType: TextInputType.name,
                              capitalization: TextCapitalization.words,
                              controller: nameController,
                              errorIndicator: (value) {
                                String regExp = '^^[A-Z][a-zA-Z ]{2,30}\$';
                                return value.contains(RegExp(regExp));
                              },
                              validator: (value) {
                                return !value.contains(
                                  RegExp('^^[A-Z][a-zA-Z ]{2,30}\$'),
                                )
                                    ? 'Only contains letters and spaces'
                                    : null;
                              },
                              prefixIcon: Icons.person,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //* Phone number input field
                    KWidgetWrap(
                      child: KFormTextField(
                        hintText: 'Enter phone number',
                        inputType: TextInputType.number,
                        controller: phoneNumberController,
                        errorIndicator: (value) {
                          return value.contains(RegExp('[0-9]{10}'));
                        },
                        validator: (value) {
                          return !value.contains(RegExp('[0-9]{10}'))
                              ? 'Enter valid phone number'
                              : null; // Return null if validation passes
                        },
                        prefixIcon: Icons.call,
                      ),
                    ),

                    //* Email input field
                    KWidgetWrap(
                      child: KFormTextField(
                        hintText: 'Enter email address',
                        inputType: TextInputType.emailAddress,
                        controller: emailController,
                        errorIndicator: (value) {
                          return value.isEmail;
                        },
                        validator: (value) {
                          return !value.isEmail
                              ? 'Invalid email address'
                              : null;
                        },
                        prefixIcon: Icons.email,
                      ),
                    ),

                    //* Password input field
                    KWidgetWrap(
                      child: KFormTextField(
                        hintText: 'Create password',
                        inputType: TextInputType.visiblePassword,
                        controller: passwordController,
                        errorIndicator: (value) {
                          return value.length >= 8 && value.length <= 16;
                        },
                        validator: (value) {
                          return value.length < 8 && value.length <= 16
                              ? 'Password length must be between 8 to 16 characters'
                              : null;
                        },
                        prefixIcon: Icons.key,
                      ),
                    ),

                    //* Confirm password input field
                    KWidgetWrap(
                      child: KFormTextField(
                        hintText: 'Confirm password',
                        inputType: TextInputType.visiblePassword,
                        controller: confirmPasswordController,
                        errorIndicator: (value) {
                          return value == passwordController.text;
                        },
                        validator: (value) {
                          return passwordController.text != value
                              ? 'Password didn\'t match'
                              : null;
                        },
                        prefixIcon: Icons.lock,
                        password: obsecure,
                      ),
                    ),

                    //* Submit button
                    KWidgetWrap(
                      height: 0.040,
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Theme.of(context)
                                  .progressIndicatorTheme
                                  .color,
                              strokeWidth: 6,
                            )
                          : KActionButton(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (selectedCollege != null &&
                                      selectedBranch != null &&
                                      selectedSemester != null) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    signup();
                                  } else {
                                    KSnackBar(
                                      'Please select college, branch and semester',
                                    ).failed();
                                  }
                                } else {
                                  KSnackBar('All fields are required').failed();
                                }
                              },
                              child: styledText(text: 'Signup', size: 20),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
