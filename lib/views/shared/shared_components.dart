import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/views/shared/assets_variables.dart';
import '/views/shared/shared_values.dart';

class SharedComponents {
  SharedComponents._privateConstructor();
  static final SharedComponents _instance =
      SharedComponents._privateConstructor();
  static SharedComponents get instance => _instance;

  static Widget appBar(
          {required String title,
          String? details,
          bool? withBackBtn,
          Widget? leading}) =>
      Builder(
          builder: (context) => Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(SharedValues.borderRadius * 2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (details == null)
                      SizedBox(
                        height: 50,
                        child: withBackBtn == false
                            ? null
                            : IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.arrow_back)),
                      ),
                    if (details != null)
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            SharedValues.padding * 2,
                            0,
                            SharedValues.padding * 2,
                            SharedValues.padding),
                        child: Align(
                          alignment: AlignmentDirectional.bottomStart,
                          child: Text(
                            details,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      )),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                SharedValues.padding * 2,
                                0,
                                SharedValues.padding * 2,
                                SharedValues.padding),
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                title,
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ),
                          ),
                        ),
                        leading ?? const SizedBox.shrink()
                      ],
                    )),
                  ],
                ),
              ));
  static Future<dynamic> showBottomSheet(BuildContext context,
      {double? height, Widget? child}) {
    return showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(SharedValues.borderRadius * 2))),
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(SharedValues.padding),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(SharedValues.borderRadius * 2)),
                color: Theme.of(context).colorScheme.onPrimary),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: SharedValues.padding * 2),
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius:
                            BorderRadius.circular(SharedValues.borderRadius)),
                  ),
                ),
                child ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  static Future<dynamic> showOverlayLoading(
      BuildContext context, Function() futureFun, {Color? color,Color? progressColor}) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: FutureBuilder(
                future: futureFun(),
                builder: (_, snapshot) {
                  if(snapshot.connectionState==ConnectionState.done){
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pop(context,snapshot.data);
                    });
                  }
                  return SizedBox(
                      height: 200,
                      width: 200,
                      child: Align(
                        child: AvatarGlow(
                          glowColor: color??Theme.of(context).primaryColor,
                          duration: const Duration(
                            milliseconds: 2000,
                          ),
                          repeat: true,
                          showTwoGlows: true,
                          endRadius: 50,
                          child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(120)),
                              child:  CircularProgressIndicator(
                                backgroundColor: progressColor??Theme.of(context).colorScheme.primary,
                                valueColor:
                                AlwaysStoppedAnimation<Color>(color??Theme.of(context).primaryColor),
                              )),
                        ),
                      ));
                }
            ),
          );
        },
      );

  static showSnackBar(context, String text, {Color? backgroundColor}) {
    return WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ));
    });
  }

  static Widget emptyWidget({Color? color}) => Center(
        child: Builder(
            builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.all(SharedValues.padding),
                      child: Icon(Icons.hourglass_empty_sharp,
                          size: 50, color: color??Theme.of(context).primaryColor),
                    )),
                    Flexible(
                        child: Padding(
                            padding: const EdgeInsets.all(SharedValues.padding),
                            child: Text(
                              "No Data !!",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                      color: color??Theme.of(context).primaryColor),
                            )))
                  ],
                )),
      );
}
