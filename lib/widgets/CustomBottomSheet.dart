import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/core/themes/ColorPalette.dart';

class Custombottomsheet extends StatelessWidget {
  final String imageSrc;
  final String description;
  const Custombottomsheet({
    super.key,
    required this.imageSrc,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(16),
        color: ColorPalette.black,
      ),

      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: CachedNetworkImage(
                imageUrl: imageSrc,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Text(
                description,
                style: textTheme.titleSmall?.copyWith(
                  color: ColorPalette.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                textStyle: WidgetStatePropertyAll(textTheme.titleMedium),
                foregroundColor: WidgetStatePropertyAll(ColorPalette.black),
                padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                  ),
                ),
              ),
              child: Text(
                "View Full Article",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
