import 'package:aoun/data/models/user.dart';
import 'package:aoun/data/network/data_response.dart';
import 'package:aoun/data/providers/auth_provider.dart';
import 'package:aoun/data/utils/enum.dart';
import 'package:aoun/views/shared/shared_components.dart';
import 'package:aoun/views/shared/shared_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late AuthProvider provider;
  @override
  void initState() {
    provider = Provider.of<AuthProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedComponents.showOverlayLoading(context, () async {
        await provider.showUsers();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Column(
        children: [
          SharedComponents.appBar(title: "Users"),
          Expanded(
              child: Selector<AuthProvider, List<User>>(
                  selector: (p0, p1) => p1.users,
                  builder: (context, users, child) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(SharedValues.padding),
                      itemCount: users.length,
                      itemBuilder: (ctx, index) => InkWell(
                        borderRadius:
                            BorderRadius.circular(SharedValues.borderRadius),
                        onTap: () {},
                        child: Container(
                          height: 80,
                          width: double.infinity,
                          padding: const EdgeInsets.all(SharedValues.padding),
                          margin: const EdgeInsets.all(SharedValues.padding),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  SharedValues.borderRadius),
                              color: Theme.of(context).primaryColor),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Text(users[index].name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3))),
                                  Expanded(
                                      child: Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Text(users[index].email,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button))),
                                ],
                              )),
                              PopupMenuButton<String>(
                                  onSelected: (value) async {
                                    if (value == "Disable") {
                                      users[index].userRole = UserRole.disable;
                                      final result = await SharedComponents
                                          .showOverlayLoading(
                                          context,
                                              () async => await provider
                                              .changePermission(
                                              users[index]));
                                      if (result is Success) {
                                        // ignore: use_build_context_synchronously
                                        SharedComponents.showSnackBar(
                                            context, "User Disable");
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        SharedComponents.showSnackBar(context,
                                            "Error occurred during operation");
                                      }
                                    } else if (value == "Upgrade To Employee") {
                                      users[index].userRole = UserRole.employee;
                                      final result = await SharedComponents
                                          .showOverlayLoading(
                                              context,
                                              () async => await provider
                                                  .changePermission(
                                                      users[index]));
                                      if (result is Success) {
                                        // ignore: use_build_context_synchronously
                                        SharedComponents.showSnackBar(context,
                                            "Success upgrade employee");
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        SharedComponents.showSnackBar(context,
                                            "Error occurred during operation");
                                      }
                                    }
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<String>>[
                                        for (var item in [
                                          "Disable",
                                          "Upgrade To Employee"
                                        ])
                                          PopupMenuItem(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                          )
                                      ],
                                  child: Icon(
                                    Icons.more_vert,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    ));
  }
}
