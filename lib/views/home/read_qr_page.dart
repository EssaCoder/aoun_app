import 'package:aoun/data/models/pilgrim.dart';
import 'package:aoun/data/providers/pilgrims_provider.dart';
import 'package:aoun/views/shared/pilgrim_widget.dart';
import 'package:aoun/views/shared/shared_components.dart';
import 'package:aoun/views/shared/shared_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReadQRPage extends StatefulWidget {
  const ReadQRPage({Key? key}) : super(key: key);

  @override
  State<ReadQRPage> createState() => _ReadQRPageState();
}

class _ReadQRPageState extends State<ReadQRPage> {
  final GlobalKey globalKey = GlobalKey();

  Pilgrim? pilgrim;
  @override
  void initState() {
    debugPrint("===============ReadQRPage->initState================");
    final provider=Provider.of<PilgrimsProvider>(context,listen: false);
    pilgrim=provider.pilgrim;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (pilgrim == null) {
        SharedComponents.showOverlayLoading(context, () async {
          pilgrim = await provider
              .scanPilgrim();
          provider.pilgrim=pilgrim;
          setState(() {

          });
        },
            color: Theme.of(context).colorScheme.background,
            progressColor: Theme.of(context).colorScheme.secondary);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PilgrimsProvider>(
      builder: (context, provider, _) =>
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: SharedValues.padding * 2),
        Padding(
            padding: const EdgeInsets.all(SharedValues.padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Flexible(
                  child: Text(pilgrim?.name ?? "Read QR Code",
                      style: Theme.of(context).textTheme.headline2),
                ),
                Flexible(child: InkWell(
                    onTap: () async {
                      provider.clearPilgrim();
                      pilgrim = await provider.scanPilgrim();

                    },child: Icon(Icons.refresh,color: Theme.of(context).colorScheme.background,)))
              ],
            )),
        const SizedBox(height: SharedValues.padding * 3),
        Expanded(
          child: PilgrimWidget(
            onPressed: () async {
              pilgrim = await provider.scanPilgrim();
            },
            pilgrim: pilgrim,
            titleColor: Theme.of(context).colorScheme.background,
            detailsColor: Theme.of(context).colorScheme.background,
          ),
        )
      ]),
    );
  }
}
