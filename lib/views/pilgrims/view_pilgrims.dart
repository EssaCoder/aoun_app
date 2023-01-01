import 'package:aoun/views/shared/assets_variables.dart';
import 'package:aoun/views/shared/button_widget.dart';
import 'package:aoun/views/shared/dropdown_field_widget.dart';
import 'package:aoun/views/shared/shared_components.dart';
import 'package:aoun/views/shared/shared_values.dart';
import 'package:aoun/views/shared/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewPilgrims extends StatefulWidget {
  const ViewPilgrims({Key? key}) : super(key: key);

  @override
  State<ViewPilgrims> createState() => _ViewPilgrimsState();
}

class _ViewPilgrimsState extends State<ViewPilgrims> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Column(
        children: [
          SharedComponents.appBar(
              title: "View Pilgrims",
              leading: InkWell(
                onTap: () {
                  int searchType = -1;
                  SharedComponents.showBottomSheet(context,
                      child: StatefulBuilder(builder: (ctx, setStateWidget) {
                    return ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        const SizedBox(height: SharedValues.padding),
                        DropdownFieldWidget(
                            hintText: "Filter by",
                            prefixIcon:
                                const Icon(Icons.keyboard_arrow_down_rounded),
                            items: [
                              DropdownMenuItemModel(
                                  text: "Name or Number", id: 0),
                              DropdownMenuItemModel(
                                  text: "Search by Service", id: 1)
                            ],
                            onChanged: (value) {
                              setStateWidget(() {
                                searchType = value?.id ?? -1;
                              });
                            },
                            keyDropDown: GlobalKey()),
                        const SizedBox(height: SharedValues.padding),
                        if (searchType == 0)
                          TextFieldWidget(
                              controller: TextEditingController(),
                              hintText: "Building name"),
                        if (searchType == 1)
                          DropdownFieldWidget(
                              hintText: "Select Service",
                              prefixIcon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              items: [
                                DropdownMenuItemModel(text: "11", id: 1),
                                DropdownMenuItemModel(text: "22", id: 2)
                              ],
                              onChanged: (value) {},
                              keyDropDown: GlobalKey()),
                        const SizedBox(height: SharedValues.padding * 4),
                        ButtonWidget(
                          child: Text("Search",
                              style: Theme.of(context).textTheme.button),
                          onPressed: () async {},
                        )
                      ],
                    );
                  }));
                },
                child: Container(
                  width: 45,
                  height: 45,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(SharedValues.padding),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius:
                          BorderRadius.circular(SharedValues.borderRadius)),
                  child: SvgPicture.asset(AssetsVariable.filterList,
                      width: 20, height: 20, fit: BoxFit.scaleDown),
                ),
              )),
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
