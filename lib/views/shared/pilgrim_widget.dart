import 'package:aoun/data/models/pilgrim.dart';
import 'package:aoun/data/providers/auth_provider.dart';
import 'package:aoun/data/utils/enum.dart';
import 'package:aoun/data/utils/utils.dart';
import 'package:aoun/views/shared/button_widget.dart';
import 'package:aoun/views/shared/shared_components.dart';
import 'package:aoun/views/shared/shared_values.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PilgrimWidget extends StatefulWidget {
  const PilgrimWidget(
      {Key? key,
      this.pilgrim,
      this.titleColor,
      this.detailsColor,
      this.onPressed})
      : super(key: key);

  final Pilgrim? pilgrim;
  final Color? titleColor;
  final Color? detailsColor;
  final Function()? onPressed;
  @override
  State<PilgrimWidget> createState() => _PilgrimWidgetState();
}

class _PilgrimWidgetState extends State<PilgrimWidget> {
  final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final list = [
      {
        "title": "Full Name",
        "data": widget.pilgrim?.name,
      },
      if(Provider.of<AuthProvider>(context,listen: false).user!.userRole!=UserRole.user)
        {
        "title": "Address",
        "data": widget.pilgrim?.address,
      },
      if(Provider.of<AuthProvider>(context,listen: false).user!.userRole!=UserRole.user)
        {
        "title": "Mobile Number",
        "data": widget.pilgrim?.phone,
      },
      {
        "title": "Supervisor Phone",
        "data": widget.pilgrim?.supervisorPhone,
      },
      {
        "title": "Health Status",
        "data": widget.pilgrim?.healthStatus,
      },
      if(Provider.of<AuthProvider>(context,listen: false).user!.userRole!=UserRole.user)
      {
        "title": "Health Problem",
        "data": widget.pilgrim?.healthProblem,
      },
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          child: ListView(
        padding: const EdgeInsets.all(SharedValues.padding),
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Row(
                children: [
                  if (widget.pilgrim?.id != null)
                    Container(
                      width: 2,
                      height: 200,
                      margin: const EdgeInsets.fromLTRB(
                          SharedValues.padding,
                          SharedValues.padding,
                          SharedValues.padding,
                          SharedValues.padding * 2),
                      padding: const EdgeInsets.all(SharedValues.padding),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.error,
                          borderRadius:
                              BorderRadius.circular(SharedValues.borderRadius)),
                    ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                          bottom: SharedValues.padding * 2),
                      child: RepaintBoundary(
                        key: globalKey,
                        child: Align(
                          child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.75,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(
                                    SharedValues.borderRadius)),
                            child: Column(
                              children: [
                                if (widget.pilgrim?.id == null)
                                  Expanded(
                                    child: ButtonWidget(
                                      minWidth: 70,
                                      height: 70,
                                      color: Theme.of(context).primaryColor,
                                      shape: const CircleBorder(),
                                      onPressed: widget.onPressed,
                                      child: Icon(Icons.refresh,
                                          size: 50,
                                          color:
                                          Theme.of(context).colorScheme.background),
                                    ),
                                  )
                                else ...[
                                  Expanded(
                                    child: QrImage(
                                      data:
                                          "${widget.pilgrim?.id.toString() ?? 0}",
                                      version: QrVersions.auto,
                                      size: 150.0,
                                    ),
                                  ),
                                  Text(
                                    "Name: ${widget.pilgrim?.name}",
                                    style:
                                        Theme.of(context).textTheme.headlineSmall,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(
                                        SharedValues.padding),
                                    child: Text(
                                      "ID: ${widget.pilgrim?.id}",
                                      style:
                                          Theme.of(context).textTheme.headlineSmall,
                                    ),
                                  )
                                ]
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (widget.pilgrim?.id != null)
                ButtonWidget(
                  color: Theme.of(context).colorScheme.background,
                  progressColor: Theme.of(context).primaryColor,
                  shape: const CircleBorder(),
                  onPressed: () async {
                    PermissionStatus permissionStatus =
                        await Permission.storage.request();
                    if (permissionStatus.isGranted) {
                      String? path = await Utils.saveWidget(globalKey);
                      // ignore: use_build_context_synchronously
                      SharedComponents.showSnackBar(context, "$path");
                    }
                  },
                  child: Container(
                    width: SharedValues.padding * 5,
                    height: SharedValues.padding * 5,
                    padding: const EdgeInsets.all(SharedValues.padding),
                    margin: const EdgeInsets.symmetric(
                        horizontal: SharedValues.padding),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.download,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
            ],
          ),
          const SizedBox(height: SharedValues.padding * 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.pilgrim?.id != null)
                Container(
                  width: 2,
                  height: 80 * 4.7,
                  margin: const EdgeInsets.all(SharedValues.padding),
                  padding: const EdgeInsets.all(SharedValues.padding),
                  decoration: BoxDecoration(
                      color:
                          widget.titleColor ?? Theme.of(context).primaryColor,
                      borderRadius:
                          BorderRadius.circular(SharedValues.borderRadius)),
                ),
              Expanded(child: Align(
                child: Builder(builder: (context) {
                  if (widget.pilgrim?.id == null) {
                    return SizedBox(
                        height: 250,
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: SharedComponents.emptyWidget(
                            color: Theme.of(context).colorScheme.background));
                  } else {
                    return SizedBox(
                        height: 500,
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var item in list) ...[
                                const SizedBox(height: SharedValues.padding),
                                Text(
                                  item["title"].toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: widget.titleColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(
                                      SharedValues.padding),
                                  child: Text(
                                    item["data"].toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: widget.detailsColor),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  width: double.infinity,
                                  color: Theme.of(context).primaryColor,
                                )
                              ]
                            ]));
                  }
                }),
              ))
            ],
          ),
        ],
      ))
    ]);
  }
}
