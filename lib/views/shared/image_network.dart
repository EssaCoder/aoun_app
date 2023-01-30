import 'package:aoun/views/shared/assets_variables.dart';
import 'package:aoun/views/shared/shared_values.dart';
import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork({Key? key, required this.url, this.height, this.width, this.borderRadius, this.fit}) : super(key: key);
 final String url;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(url,
      fit: fit??BoxFit.contain,
      height: height,
      width: width,
      errorBuilder: (context, url, error) {
        return Image.asset(AssetsVariable.lock);
      },
      loadingBuilder: (context, url, downloadProgress) {
        if (downloadProgress == null) return url;
        return Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        );
      },

    );
  }
}
