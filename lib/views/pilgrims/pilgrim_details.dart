import 'package:aoun/views/shared/assets_variables.dart';
import 'package:aoun/views/shared/button_widget.dart';
import 'package:aoun/views/shared/dropdown_field_widget.dart';
import 'package:aoun/views/shared/shared_components.dart';
import 'package:aoun/views/shared/shared_values.dart';
import 'package:aoun/views/shared/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PilgrimDetails extends StatefulWidget {
  const PilgrimDetails({Key? key}) : super(key: key);

  @override
  State<PilgrimDetails> createState() => _PilgrimDetailsState();
}

class _PilgrimDetailsState extends State<PilgrimDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Column(
        children: [
          SharedComponents.appBar(
              title: "Bara Ali Ahmed",
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
              child: ListView(
            padding: const EdgeInsets.all(SharedValues.padding),
            children: [
              Row(
                children: [
                  Container(
                    width: 2,
                    height: 145,
                    margin: const EdgeInsets.all(SharedValues.padding),
                    padding: const EdgeInsets.all(SharedValues.padding),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                        borderRadius:
                            BorderRadius.circular(SharedValues.borderRadius)),
                  ),
                  Expanded(
                      child: Align(
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.75,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 2),
                          borderRadius:
                              BorderRadius.circular(SharedValues.borderRadius)),
                    ),
                  ))
                ],
              ),
              const SizedBox(height: SharedValues.padding * 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 2,
                    height: 80 * 4,
                    margin: const EdgeInsets.all(SharedValues.padding),
                    padding: const EdgeInsets.all(SharedValues.padding),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius:
                            BorderRadius.circular(SharedValues.borderRadius)),
                  ),
                  Expanded(
                      child: Align(
                    child: SizedBox(
                      height: 500,
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i = 0; i < 5; ++i) ...[
                              const SizedBox(height: SharedValues.padding),
                              Text(
                                "Full Name",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.all(SharedValues.padding),
                                child: Text(
                                  "Bara Ali Ahmed",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: Theme.of(context).primaryColor,
                              )
                            ]
                          ]),
                    ),
                  ))
                ],
              ),
            ],
          ))
        ],
      ),
    ));
  }
}
