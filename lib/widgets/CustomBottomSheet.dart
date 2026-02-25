import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/core/themes/ColorPalette.dart';
import 'package:url_launcher/url_launcher.dart';

class Custombottomsheet extends StatefulWidget {
  final String imageSrc;
  final String description;
  final Uri url;
  const Custombottomsheet({
    super.key,
    required this.imageSrc,
    required this.description, required this.url,
  });

  @override
  State<Custombottomsheet> createState() => _CustombottomsheetState();
}

class _CustombottomsheetState extends State<Custombottomsheet> {
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
                imageUrl: widget.imageSrc,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Text(
                widget.description,
                style: textTheme.titleSmall?.copyWith(
                  color: ColorPalette.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                _launcherUrl(widget.url);
              },
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
  Future<void>_launcherUrl(Uri url)async{
    if(!await launchUrl(url)){
      throw Exception("Could not launch ${url}");
    }
  }
}
