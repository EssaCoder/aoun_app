import 'package:aoun/data/models/user.dart';
import 'package:aoun/data/network/data_response.dart';
import 'package:aoun/data/network/http_exception.dart';
import 'package:aoun/data/providers/auth_provider.dart';
import 'package:aoun/data/utils/enum.dart';
import 'package:aoun/data/utils/utils.dart';
import 'package:aoun/views/auth/verify_otp.dart';
import 'package:aoun/views/shared/dropdown_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/views/auth/sign_in_screen.dart';
import '/views/shared/assets_variables.dart';
import '/views/shared/button_widget.dart';
import '/views/shared/shared_components.dart';
import '/views/shared/shared_values.dart';
import '/views/shared/text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, this.user}) : super(key: key);
final User? user;
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController name;
  late TextEditingController phone;
  late TextEditingController identityNumber;
  late TextEditingController email;
  DropdownMenuItemModel? userRole;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    name = TextEditingController(text: widget.user?.name);
    phone = TextEditingController(text: widget.user?.phone);
    identityNumber = TextEditingController(text: widget.user?.identityNumber);
    email = TextEditingController(text: widget.user?.email);
    userRole=DropdownMenuItemModel(text: widget.user?.userRole.name??"");
    password = TextEditingController();
    confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    identityNumber.dispose();
    email.dispose();
    userRole = null;
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
                      controller: name,
                      hintText: "Name",
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
                      controller: identityNumber,
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
                        if (value == null) {
                          return "هذا الحقل مطلوب";
                        } else if (!Utils.validateEmail(value)) {
                          return "ايميل غير صالح";
                        }
                        return null;
                      }),
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
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      } else if (confirmPassword.text != password.text) {
                        return "Password does not match";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(SharedValues.padding),
                  child: ButtonWidget(
                    minWidth: double.infinity,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final user = User(
                            id: DateTime.now().millisecondsSinceEpoch,
                            name: name.text,
                            email: email.text,
                            phone: phone.text,
                            userRole: UserRole.user,
                            identityNumber: identityNumber.text,
                            password: password.text);
                        Result result = await Provider.of<AuthProvider>(context,
                                listen: false)
                            .sendCode(user);
                        if (result is Success) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VerifyOTP(),
                              ),
                              (_) => false);
                        }else if (result is Error&&result.exception is ExistUserException) {
                          String message="User exist please sign in.";
                          // ignore: use_build_context_synchronously
                          SharedComponents.showSnackBar(
                              context, message,
                              backgroundColor:
                              // ignore: use_build_context_synchronously
                              Theme.of(context).colorScheme.error);
                        } else if (result is Error) {
                          String message="Error occurred !!";
                          // ignore: use_build_context_synchronously
                          SharedComponents.showSnackBar(
                              context, message,
                              backgroundColor:
                                  // ignore: use_build_context_synchronously
                                  Theme.of(context).colorScheme.error);
                        }
                      }
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
                            style: Theme.of(context).textTheme.headline5),
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
