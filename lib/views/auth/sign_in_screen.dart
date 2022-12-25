import 'package:aoun/views/shared/assets_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/data/network/data_response.dart';
import '/views/auth/sign_up_screen.dart';
import '/views/home/home_screen.dart';
import '/views/shared/button_widget.dart';
import '/views/shared/shared_components.dart';
import '/views/shared/shared_values.dart';
import '/views/shared/text_field_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController studentNumber;
  late TextEditingController password;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    studentNumber = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    studentNumber.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Column(
        children: [
          SharedComponents.appBar(title: "Sign in"),
          Expanded(
              child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        height: 200,
                        child: SvgPicture.asset(AssetsVariable.lock))),
                const SizedBox(height: SharedValues.padding),
                Padding(
                  padding: const EdgeInsets.all(SharedValues.padding),
                  child: TextFieldWidget(
                      controller: studentNumber,
                      keyboardType: TextInputType.number,
                      hintText: "Id Number"),
                ),
                Padding(
                  padding: const EdgeInsets.all(SharedValues.padding),
                  child: TextFieldWidget(
                      controller: password, hintText: "Password"),
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton(
                    onPressed: () {},
                    child: Text("Forget password?",
                        style: Theme.of(context).textTheme.headline3),
                  ),
                ),
                const SizedBox(height: SharedValues.padding),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SharedValues.padding),
                  child: ButtonWidget(
                    minWidth: double.infinity,
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));

                      // if (_formKey.currentState!.validate()) {}
                    },
                    child: Text(
                      "Sign in",
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(SharedValues.padding),
                  child: Row(
                    children: [
                      Text("I don't have an account",
                          style: Theme.of(context).textTheme.bodyText2),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()),
                              (Route<dynamic> route) => false);
                        },
                        child: Text("Sign up?",
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
