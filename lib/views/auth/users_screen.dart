import 'package:aoun/views/shared/shared_components.dart';
import 'package:aoun/views/shared/shared_values.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Column(
        children: [
          SharedComponents.appBar(
              title: "Users"),
          Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(SharedValues.padding),
                itemCount: 10,
                itemBuilder: (context, index) => InkWell(
                  borderRadius: BorderRadius.circular(SharedValues.borderRadius),
                  onTap: () {},
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    padding: const EdgeInsets.all(SharedValues.padding),
                    margin: const EdgeInsets.all(SharedValues.padding),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(SharedValues.borderRadius),
                        color: Theme.of(context).primaryColor),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Align(
                                        alignment: AlignmentDirectional.centerStart,
                                        child: Text("Bara Ali Ahmed",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3))),
                                Expanded(
                                    child: Align(
                                        alignment: AlignmentDirectional.centerStart,
                                        child: Text("Bara Ali Ahmed",
                                            style:
                                            Theme.of(context).textTheme.button))),
                              ],
                            )),
                        PopupMenuButton<String>(
                            onSelected: (value) {},
                            itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                              for (var item in ["Delete"])
                                PopupMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style:
                                    Theme.of(context).textTheme.subtitle2,
                                  ),
                                )
                            ],
                            child: Icon(
                              Icons.more_vert,
                              color: Theme.of(context).colorScheme.onPrimary,
                            )),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    ));
  }
}
