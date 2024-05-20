import 'package:aoun/data/network/data_response.dart';
import 'package:aoun/data/network/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/data/models/user.dart';
import '/data/providers/auth_provider.dart';
import '/data/utils/utils.dart';
import '/views/auth/sign_in_screen.dart';
import '/views/auth/verify_otp.dart';
import '/views/shared/button_widget.dart';
import '/views/shared/shared_components.dart';
import '/views/shared/shared_values.dart';
import '/views/shared/text_field_widget.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late TextEditingController phone;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    phone = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phone.dispose();
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
            SharedComponents.appBar(title: "Forget Password"),
            Expanded(
                flex: 2,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(SharedValues.padding),
                    children: [
                      SizedBox(
                        height: 200,
                        child: Center(
                            child: Text("Forget Password",
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(SharedValues.padding),
                        child: TextFieldWidget(
                            controller: phone,
                            hintText: "Phone",
                            prefixIcon:  SizedBox(
                                width: 50, child: Center(child: Text("+966",style: Theme.of(context).textTheme.titleMedium))),
                            keyboardType: TextInputType.number,
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
                          controller: password,
                          hintText: "Password",
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
                            if (value == null || value.isEmpty) {
                              return "This field is required";
                            } else if (confirmPassword.text ==
                                password.text) {
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
                            if (_formKey.currentState!.validate()) {
                              final provider = Provider.of<AuthProvider>(context,
                                  listen: false);
                              Result result = await provider.sendCode(User(
                                  phone: "+966${phone.text}",
                                  password: password.text),true);
                              if (result is Success) {
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const VerifyOTP(isSignUp: false)));
                              } else if (result is Error &&
                                  result.exception is ExistUserException) {
                                String message = "User not exist please sign up";
                                // ignore: use_build_context_synchronously
                                SharedComponents.showSnackBar(context, message,
                                    backgroundColor:
                                    // ignore: use_build_context_synchronously
                                    Theme.of(context).colorScheme.error);
                              }else {
                                // ignore: use_build_context_synchronously
                                SharedComponents.showSnackBar(
                                    context, "An error occurred");
                              }
                            }
                          },
                          child: Text("Save",
                              style: Theme.of(context).textTheme.labelLarge),
                        ),
                      ),
                      const SizedBox(height: SharedValues.padding),
                      Padding(
                        padding: const EdgeInsets.all(SharedValues.padding),
                        child: Row(
                          children: [
                            Text("I already have an account",
                                style: Theme.of(context).textTheme.bodyMedium),
                            TextButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignInScreen()));
                              },
                              child: Text("Sign in?",
                                  style: Theme.of(context).textTheme.headlineSmall),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
