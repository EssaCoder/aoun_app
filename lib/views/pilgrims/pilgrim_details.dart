import 'dart:convert';
import 'dart:ui';
import 'package:aoun/views/home/read_qr_page.dart';
import 'package:aoun/views/shared/pilgrim_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:aoun/data/models/pilgrim.dart';
import 'package:aoun/data/utils/utils.dart';
import 'package:aoun/views/shared/shared_components.dart';
import 'package:aoun/views/shared/shared_values.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PilgrimDetails extends StatefulWidget {
  const PilgrimDetails({Key? key, required this.pilgrim}) : super(key: key);
  final Pilgrim pilgrim;
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
              title: widget.pilgrim.name),
          Expanded(child: PilgrimWidget(pilgrim: widget.pilgrim))
        ],
      ),
    ));
  }
}
