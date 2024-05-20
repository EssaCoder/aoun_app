import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import '/views/shared/shared_values.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
              child: AvatarGlow(
                glowColor: Theme.of(context).primaryColor,
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
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    )),
              )),
          const SizedBox(height: SharedValues.padding * 5),
          Text("Loading data...", style: Theme.of(context).textTheme.labelLarge)
        ],
      ),
    );
  }
}
