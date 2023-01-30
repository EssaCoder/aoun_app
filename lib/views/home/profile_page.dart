import 'package:aoun/data/providers/auth_provider.dart';
import 'package:aoun/data/utils/enum.dart';
import 'package:aoun/views/auth/sign_up_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '/views/shared/assets_variables.dart';
import '/views/shared/button_widget.dart';
import '/views/shared/shared_values.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    debugPrint("===============ProfilePage->initState================");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: SharedValues.padding * 2),
        Padding(
            padding: const EdgeInsets.all(SharedValues.padding),
            child:
                Text("Profile", style: Theme.of(context).textTheme.headline2)),
        const SizedBox(height: SharedValues.padding * 3),
        Align(
          alignment: AlignmentDirectional.topCenter,
          child: SizedBox(
            width: 100,
            height: 100,
            child: SvgPicture.asset(AssetsVariable.user,
                color: Theme.of(context).colorScheme.onPrimary,
                fit: BoxFit.scaleDown),
          ),
        ),
        const SizedBox(height: SharedValues.padding),
        Align(
          alignment: AlignmentDirectional.topCenter,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Bara Ali Ahmed",
                style: Theme.of(context).textTheme.headline3,
              ),
              IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(user: provider.user,)));
              }, icon: const Icon(Icons.edit))
            ],
          ),
        ),
        Align(
          alignment: AlignmentDirectional.topCenter,
          child: Divider(
              thickness: 2,
              color: Theme.of(context).colorScheme.error,
              indent: MediaQuery.of(context).size.width * 0.25,
              endIndent: MediaQuery.of(context).size.width * 0.25),
        ),
        _buildInfoCard("Full Name", provider.user!.name),
        _buildInfoCard("User Type", () {
          if (provider.user!.userRole == UserRole.employee) {
            return "Employee";
          } else if (provider.user!.userRole == UserRole.superAdmin) {
            return "Super Admin";
          } else {
            return "User";
          }
        }()),
      ],
    );
  }

  Builder _buildInfoCard(String title, String subTitle) {
    return Builder(builder: (context) {
      return Container(
        height: 90,
        padding: const EdgeInsets.all(SharedValues.padding),
        margin: const EdgeInsets.all(SharedValues.padding),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
            borderRadius: BorderRadius.circular(SharedValues.borderRadius)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                title,
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsets.all(SharedValues.padding),
                child: Text(
                  subTitle,
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(fontSize: 12),
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            margin:
                const EdgeInsets.symmetric(horizontal: SharedValues.padding),
            color: Theme.of(context).colorScheme.onPrimary,
          )
        ]),
      );
    });
  }
}
