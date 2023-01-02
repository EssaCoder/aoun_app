import 'package:aoun/views/home/home_page.dart';
import 'package:aoun/views/home/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/views/shared/assets_variables.dart';
import '/views/shared/button_widget.dart';
import '/views/shared/shared_values.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int menuSelected = 0;
  PageController? controller;
  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: PageView(
              controller: controller,
              onPageChanged: (value) => setState(() {
                menuSelected = value;

              }),
              children:  [HomePage(controller: controller),const SizedBox(),const ProfilePage()],
            ),
            extendBodyBehindAppBar: true,
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0.0,
              backgroundColor: Theme.of(context).primaryColor,
              onTap: (index) => controller?.animateToPage(index, duration: const Duration(milliseconds: 20), curve: Curves.decelerate),
              items: [
                _buildBottomNavigation(AssetsVariable.home, menuSelected == 0),
                _buildBottomNavigation(
                    AssetsVariable.barcodeRead, menuSelected == 1),
                _buildBottomNavigation(AssetsVariable.user, menuSelected == 2),
              ],
            )));
  }

  BottomNavigationBarItem _buildBottomNavigation(String icon, isSelected) {
    return BottomNavigationBarItem(
      icon: Builder(
          builder: (context) => Container(
                width: 50,
                height: 30,
                padding: const EdgeInsets.all(5),
                decoration: !isSelected
                    ? null
                    : BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                child: SvgPicture.asset(
                  icon,
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).colorScheme.onPrimary,
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              )),
      label: '',
    );
  }
}