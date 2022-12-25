import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/views/shared/assets_variables.dart';
import '/views/shared/button_widget.dart';
import '/views/shared/shared_components.dart';
import '/views/shared/shared_values.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              SharedComponents.appBar(title: "TV Smart Session"),
              Expanded(
                  child: Column(
                    children: [
                      const Expanded(child: SizedBox.shrink()),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildButtonWidget(
                                  onPressed: () {
                                  },
                                  text: "Interactive Map",
                                  image: AssetsVariable.user),
                            ),
                            Expanded(
                              child: _buildButtonWidget(
                                  onPressed: () {

                                  },
                                  text: "Cody Chatbot", image: AssetsVariable.user),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildButtonWidget(
                                  onPressed: () {},
                                  text: "Academic Advisor",
                                  image: AssetsVariable.user),
                            ),
                            Expanded(
                              child: _buildButtonWidget(
                                  onPressed: () {

                                  },
                                  text: "Digital Wallet", image: AssetsVariable.user),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(SharedValues.padding),
                          child: ButtonWidget(
                            minWidth: double.infinity,
                            child: Text("FAQ",
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    ?.copyWith(decoration: TextDecoration.underline)),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  Widget _buildButtonWidget(
      {required String image, required String text, VoidCallback? onPressed}) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(SharedValues.padding),
        child: ButtonWidget(
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(SharedValues.padding),
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: SvgPicture.asset(
                          height: 100,
                          width: 100,
                          fit: BoxFit.scaleDown,
                          image)),
                  Expanded(
                    child:
                    Text(text, style: Theme.of(context).textTheme.button),
                  ),
                ],
              ),
            )),
      );
    });
  }
}
