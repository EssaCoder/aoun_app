import 'package:aoun/views/shared/dropdown_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/views/auth/sign_in_screen.dart';
import '/views/home/main_screen.dart';
import '/views/shared/assets_variables.dart';
import '/views/shared/button_widget.dart';
import '/views/shared/shared_components.dart';
import '/views/shared/shared_values.dart';
import '/views/shared/text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController phone;
  late TextEditingController identityCard;
  late TextEditingController email;
  DropdownMenuItemModel? userType;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    phone = TextEditingController();
    identityCard = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    phone.dispose();
    identityCard.dispose();
    email.dispose();
    userType = null;
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            body: Column(
          children: [
            SharedComponents.appBar(title: "Sign up"),
            Expanded(
                child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(height: SharedValues.padding * 3),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: SvgPicture.asset(AssetsVariable.user,
                        fit: BoxFit.scaleDown),
                  ),
                  const SizedBox(height: SharedValues.padding * 2),
                  Padding(
                    padding: const EdgeInsets.all(SharedValues.padding),
                    child: TextFieldWidget(
                        controller: firstName,
                        hintText: "First Name",
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          }
                          return "This field is required";
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(SharedValues.padding),
                    child: TextFieldWidget(
                        controller: lastName,
                        hintText: "Last Name",
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          }
                          return "This field is required";
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(SharedValues.padding),
                    child: TextFieldWidget(
                        controller: phone,
                        hintText: "Phone",
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          }
                          return "This field is required";
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(SharedValues.padding),
                    child: TextFieldWidget(
                        controller: identityCard,
                        hintText: "Identity card number",
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          }
                          return "This field is required";
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(SharedValues.padding),
                    child: TextFieldWidget(
                        controller: email,
                        hintText: "Email",
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          }
                          return "This field is required";
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(SharedValues.padding),
                    child: DropdownFieldWidget(
                      keyDropDown: GlobalKey(),
                      items: [
                        DropdownMenuItemModel(id: 1, text: "Employee"),
                        DropdownMenuItemModel(id: 2, text: "User")
                      ],
                      hintText: "User Type",
                      onChanged: (value) {
                        userType = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(SharedValues.padding),
                    child: TextFieldWidget(
                      controller: password,
                      hintText: "Password",
                      textInputAction: TextInputAction.none,
                      obscureText: true,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return "This field is required";
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(SharedValues.padding),
                    child: TextFieldWidget(
                      controller: confirmPassword,
                      hintText: "Confirm Password",
                      textInputAction: TextInputAction.none,
                      obscureText: true,
                      validator: (value) {
                        if (confirmPassword.text == password.text) {
                          return null;
                        }
                        return "كلمة المرور غير متطابقة";
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(SharedValues.padding),
                    child: ButtonWidget(
                      minWidth: double.infinity,
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(),
                            ));

                      },
                      child: Text(
                        "Sign up",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(SharedValues.padding),
                    child: Row(
                      children: [
                        Text("I already have an account",
                            style: Theme.of(context).textTheme.bodyText2),
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen()),
                                    (Route<dynamic> route) => false);
                          },
                          child: Text("Sign in?",
                              style: Theme.of(context).textTheme.headline3),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ));
  }
}
