import 'package:aoun/data/models/pilgrim.dart';
import 'package:aoun/data/network/data_response.dart';
import 'package:aoun/data/providers/pilgrims_provider.dart';
import 'package:aoun/views/pilgrims/add_pilgrims.dart';
import 'package:aoun/views/pilgrims/pilgrim_details.dart';
import 'package:aoun/views/shared/assets_variables.dart';
import 'package:aoun/views/shared/button_widget.dart';
import 'package:aoun/views/shared/dropdown_field_widget.dart';
import 'package:aoun/views/shared/loading_widget.dart';
import 'package:aoun/views/shared/shared_components.dart';
import 'package:aoun/views/shared/shared_values.dart';
import 'package:aoun/views/shared/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ViewPilgrims extends StatefulWidget {
  const ViewPilgrims({Key? key}) : super(key: key);

  @override
  State<ViewPilgrims> createState() => _ViewPilgrimsState();
}

class _ViewPilgrimsState extends State<ViewPilgrims> {
  final searchItems = [
    DropdownMenuItemModel(text: "My account", id: 0),
    DropdownMenuItemModel(text: "Name or Number", id: 1),
  ];

  late TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PilgrimsProvider>(context, listen: false);
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
                            value: searchItems.first,
                            items: searchItems,
                            onChanged: (value) {
                              setStateWidget(() {
                                searchType = value?.id ?? -1;
                              });
                            },
                            keyDropDown: GlobalKey()),
                        const SizedBox(height: SharedValues.padding),
                        if (searchType == 1) ...[
                          TextFieldWidget(
                              controller: searchController,
                              hintText: "Pilgrim name/number"),
                          const SizedBox(height: SharedValues.padding * 4)
                        ],
                        ButtonWidget(
                          child: Text("Search",
                              style: Theme.of(context).textTheme.button),
                          onPressed: () async {
                            if (searchType == 1) {
                              provider.searchPilgrims(
                                  search: searchController.text);
                            } else {
                              provider.searchPilgrims(isMyAccount: true);
                            }
                            Navigator.pop(ctx);
                          },
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
              child: FutureBuilder(
                  future: provider.getPilgrims(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingWidget();
                    } else {
                      if (provider.pilgrims.isEmpty) {
                        return SharedComponents.emptyWidget();
                      }
                      return Selector<PilgrimsProvider, List<Pilgrim>>(
                        selector: (p0, p1) => p1.pilgrims,
                        builder: (ctx, pilgrims, child) => ListView.builder(
                          padding: const EdgeInsets.all(SharedValues.padding),
                          itemCount: pilgrims.length,
                          itemBuilder: (context, index) => InkWell(
                            borderRadius: BorderRadius.circular(
                                SharedValues.borderRadius),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PilgrimDetails(
                                        pilgrim: pilgrims[index]),
                                  ));
                            },
                            child: Container(
                              height: 80,
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.all(SharedValues.padding),
                              margin:
                                  const EdgeInsets.all(SharedValues.padding),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      SharedValues.borderRadius),
                                  color: Theme.of(context).primaryColor),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Align(
                                              alignment: AlignmentDirectional
                                                  .centerStart,
                                              child: Text(pilgrims[index].name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline3))),
                                      Expanded(
                                          child: Align(
                                              alignment: AlignmentDirectional
                                                  .centerStart,
                                              child: Text(pilgrims[index].phone,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .button))),
                                    ],
                                  )),
                                  PopupMenuButton<String>(
                                      onSelected: (value) async {
                                        if (value == "Delete") {
                                          pilgrims[index].deleteAt =
                                              DateTime.now();
                                         final result=await SharedComponents.showOverlayLoading(context, () async => await provider
                                              .updatePilgrim(pilgrims[index]));
                                         if(result is Success){
                                           // ignore: use_build_context_synchronously
                                           SharedComponents.showSnackBar(
                                               context, "Pilgrim deleted");
                                         }
                                        } else if (value == "Edit") {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddPilgrims(
                                                        pilgrim:
                                                            pilgrims[index]),
                                              ));
                                        }
                                      },
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<String>>[
                                            for (var item in ["Delete", "Edit"])
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }))
        ],
      ),
    ));
  }
}
