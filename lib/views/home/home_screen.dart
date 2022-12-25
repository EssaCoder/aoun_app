import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/views/shared/assets_variables.dart';
import '/views/shared/button_widget.dart';
import '/views/shared/shared_values.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: SharedValues.padding * 2),
                Padding(
                    padding: const EdgeInsets.all(SharedValues.padding),
                    child: Text("Home",
                        style: Theme.of(context).textTheme.headline2)),
                CarouselSlider(
                    items: [
                      for (var i = 0; i < 5; ++i)
                        Padding(
                          padding: const EdgeInsets.all(SharedValues.padding),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  SharedValues.borderRadius),
                              child: Image.asset(
                                AssetsVariable.testImage,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              )),
                        ),
                    ],
                    options: CarouselOptions(
                      enlargeCenterPage: false,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {});
                      },
                    )),
                const SizedBox(height: SharedValues.padding),
                SizedBox(
                  height: 20,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < 5; ++i) ...[
                          if (i == 2)
                            Container(
                              height: 8,
                              width: 40,
                              margin: const EdgeInsets.all(
                                  SharedValues.padding * 0.5),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          if (i != 2)
                            Container(
                              height: 8,
                              width: 8,
                              margin: const EdgeInsets.all(
                                  SharedValues.padding * 0.25),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  shape: BoxShape.circle),
                            )
                        ]
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: SharedValues.padding),
                Padding(
                    padding: const EdgeInsets.all(SharedValues.padding),
                    child: Text("The Services",
                        style: Theme.of(context).textTheme.headline2)),
                Expanded(
                    child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsetsDirectional.only(start: 100),
                  children: [
                    for (var i = 0; i < 5; ++i)
                      Container(
                        width: 100,
                        height: double.infinity,
                        margin: const EdgeInsets.all(SharedValues.padding),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(
                                SharedValues.borderRadius)),
                        child: Column(
                          children: [
                            Expanded(
                                child: Center(
                              child: RotatedBox(
                                  quarterTurns: -1,
                                  child: Text(
                                    "Create QR Code",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )),
                            )),
                            Padding(
                              padding:
                                  const EdgeInsets.all(SharedValues.padding),
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(
                                        SharedValues.borderRadius)),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.all(SharedValues.padding),
                              child: SvgPicture.asset(AssetsVariable.barcodeAdd,
                                  width: 20, height: 20),
                            ),
                            const SizedBox(height: SharedValues.padding)
                          ],
                        ),
                      ),
                  ],
                ))
              ],
            ),
            extendBodyBehindAppBar: true,
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0.0,
              backgroundColor: Theme.of(context).primaryColor,
              onTap: (index) {},
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AssetsVariable.home,
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 22,
                    height: 22,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AssetsVariable.barcodeRead,
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 22,
                    height: 22,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AssetsVariable.user,
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 22,
                    height: 22,
                  ),
                  label: '',
                ),
              ],
            )));
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
