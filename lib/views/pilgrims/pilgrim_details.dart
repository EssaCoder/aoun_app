import 'dart:convert';
import 'dart:ui';
import 'package:permission_handler/permission_handler.dart';

import 'package:aoun/data/models/pilgrim.dart';
import 'package:aoun/data/utils/utils.dart';
import 'package:aoun/views/shared/assets_variables.dart';
import 'package:aoun/views/shared/button_widget.dart';
import 'package:aoun/views/shared/dropdown_field_widget.dart';
import 'package:aoun/views/shared/shared_components.dart';
import 'package:aoun/views/shared/shared_values.dart';
import 'package:aoun/views/shared/text_field_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PilgrimDetails extends StatefulWidget {
  const PilgrimDetails({Key? key, required this.pilgrim}) : super(key: key);
  final Pilgrim pilgrim;
  @override
  State<PilgrimDetails> createState() => _PilgrimDetailsState();
}

class _PilgrimDetailsState extends State<PilgrimDetails> {
  final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final list = [
      {
        "title": "Full Name",
        "data": widget.pilgrim.name,
      },
      {
        "title": "Address",
        "data": widget.pilgrim.address,
      },
      {
        "title": "Mobile Number",
        "data": widget.pilgrim.phone,
      },
      {
        "title": "Supervisor Phone",
        "data": widget.pilgrim.supervisorPhone,
      },
      {
        "title": "Health Status",
        "data": widget.pilgrim.healthStatus,
      },
      {
        "title": "Health Problrm",
        "data": widget.pilgrim.healthProblem,
      },
    ];
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Column(
        children: [
          SharedComponents.appBar(
              title: widget.pilgrim.name,
              leading: Padding(
                padding: const EdgeInsets.all(SharedValues.padding),
                child: InkWell(
                  onTap: () async {
                    PermissionStatus permissionStatus =
                        await Permission.storage.request();
                    if (permissionStatus.isGranted) {
                      String? path = await Utils.saveWidget(globalKey);
                      // ignore: use_build_context_synchronously
                      SharedComponents.showSnackBar(context, "$path");
                    }
                  },
                  child: const Icon(Icons.download),
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
                    height: 200,
                    margin: const EdgeInsets.all(SharedValues.padding),
                    padding: const EdgeInsets.all(SharedValues.padding),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                        borderRadius:
                            BorderRadius.circular(SharedValues.borderRadius)),
                  ),
                  Expanded(
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
                            Expanded(
                              child: QrImage(
                                data: widget.pilgrim.id.toString(),
                                version: QrVersions.auto,
                                size: 150.0,
                              ),
                            ),
                            Text(
                              "Name: ${widget.pilgrim.name}",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Padding(
                              padding:const EdgeInsets.all(SharedValues.padding),
                              child: Text(
                                "ID: ${widget.pilgrim.id}",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            )
                          ],
                        ),
                      ),
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
                    height: 80 * 4.7,
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
                            for (var item in list) ...[
                              const SizedBox(height: SharedValues.padding),
                              Text(
                                item["title"].toString(),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.all(SharedValues.padding),
                                child: Text(
                                  item["data"].toString(),
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
