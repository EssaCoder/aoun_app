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
  int menuSelected=2;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: PageView(
              children: [
                HomePage(),
                SizedBox(),
                ProfilePage()
              ],
            ),
            extendBodyBehindAppBar: true,
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0.0,
              backgroundColor: Theme.of(context).primaryColor,
              onTap: (index) =>setState(() {
        menuSelected=index;
        }),
              items: [
                _buildBottomNavigation(AssetsVariable.home,menuSelected==0),
                _buildBottomNavigation(AssetsVariable.barcodeRead,menuSelected==1),
                _buildBottomNavigation(AssetsVariable.user,menuSelected==2),
              ],
            )));
  }

  BottomNavigationBarItem _buildBottomNavigation(String icon,isSelected) {
    return BottomNavigationBarItem(
                icon: Builder(
                  builder: (context) => Container(
                      width: 50,
                      height: 30,
                      padding: const EdgeInsets.all(5),
                      decoration: !isSelected?null:BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SvgPicture.asset(
                        icon,
                        color: isSelected?Theme.of(context).primaryColor:Theme.of(context).colorScheme.onPrimary,
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    )
                ),
                label: '',
              );
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
