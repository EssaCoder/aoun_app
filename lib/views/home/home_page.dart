import 'package:aoun/data/providers/auth_provider.dart';
import 'package:aoun/views/auth/auth_screen.dart';
import 'package:aoun/views/auth/users_screen.dart';
import 'package:aoun/views/pilgrims/add_pilgrims.dart';
import 'package:aoun/views/pilgrims/view_pilgrims.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '/views/shared/assets_variables.dart';
import '/views/shared/shared_values.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.controller}) : super(key: key);
  final PageController? controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: SharedValues.padding * 2),
        PopupMenuButton<int>(
            onSelected: (value) async {
              await Provider.of<AuthProvider>(context, listen: false).signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthScreen(),
                  ),
                  (route) => false);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      "Sign Out",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  )
                ],
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: SharedValues.padding),
              child: Icon(
                Icons.more_vert,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )),
        const SizedBox(height: SharedValues.padding * 2),
        Padding(
            padding: const EdgeInsets.all(SharedValues.padding),
            child: Text("Home", style: Theme.of(context).textTheme.headline2)),
        CarouselSlider(
            items: [
              for (var i = 0; i < 5; ++i)
                Padding(
                  padding: const EdgeInsets.all(SharedValues.padding),
                  child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(SharedValues.borderRadius),
                      child: Container(
                        padding: const EdgeInsets.all(SharedValues.padding),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(
                                SharedValues.borderRadius)),
                        child: Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [
                            Column(
                              children: [
                                Expanded(
                                    child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  padding: const EdgeInsets.all(
                                      SharedValues.padding),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(
                                              SharedValues.borderRadius))),
                                  child: Text("Missing ad",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .error)),
                                )),
                                Expanded(
                                    child: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text:
                                                  "Name: Ali Ahmed Abdullah\n\n"),
                                          TextSpan(text: "ID: 121316465798")
                                        ],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5),
                                  ),
                                ))
                              ],
                            ),
                            Container(
                              height: 120,
                              width: 120,
                              margin:
                                  const EdgeInsets.all(SharedValues.padding),
                              decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground)
                                ],
                                shape: BoxShape.circle,
                              ),
                            )
                          ],
                        ),
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
                      margin: const EdgeInsets.all(SharedValues.padding * 0.5),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  if (i != 2)
                    Container(
                      height: 8,
                      width: 8,
                      margin: const EdgeInsets.all(SharedValues.padding * 0.25),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimary,
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
            _buildHomeButton("Create QR Code", AssetsVariable.barcodeAdd, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddPilgrims()));
            }),
            _buildHomeButton("Read QR Code", AssetsVariable.barcodeRead, () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AddPilgrims()));
            }),
            _buildHomeButton("View Pilgrims", AssetsVariable.listCheck, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewPilgrims()));
            }),
            _buildHomeButton("Show Users", AssetsVariable.user, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UsersScreen()));
            }),
            _buildHomeButton("Show Profile", AssetsVariable.user, () {
              widget.controller?.animateToPage(2,
                  duration: const Duration(milliseconds: 20),
                  curve: Curves.decelerate);
            }),
          ],
        ))
      ],
    );
  }

  Widget _buildHomeButton(
      String title, String icon, GestureTapCallback? onTap) {
    return Builder(builder: (context) {
      return InkWell(
        borderRadius: BorderRadius.circular(SharedValues.borderRadius),
        onTap: onTap,
        child: Container(
          width: 100,
          height: double.infinity,
          margin: const EdgeInsets.all(SharedValues.padding),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(SharedValues.borderRadius)),
          child: Column(
            children: [
              Expanded(
                  child: Center(
                child: RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
              )),
              Padding(
                padding: const EdgeInsets.all(SharedValues.padding),
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius:
                          BorderRadius.circular(SharedValues.borderRadius)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(SharedValues.padding),
                child: SvgPicture.asset(icon, width: 20, height: 20),
              ),
              const SizedBox(height: SharedValues.padding)
            ],
          ),
        ),
      );
    });
  }
}
