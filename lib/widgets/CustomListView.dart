import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/themes/ColorPalette.dart';
import '../models/ArticleModel.dart';
import 'CustomBottomSheet.dart';

class Customlistview extends StatefulWidget {
 final List<ArticleModel> articleList;
  const Customlistview({super.key, required this.articleList});

  @override
  State<Customlistview> createState() => _CustomlistviewState();
}

class _CustomlistviewState extends State<Customlistview> {
  late TextTheme textTheme=Theme.of(context).textTheme;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                _showBottomSheet(context,widget.articleList[index]);
              });
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              width: double.infinity,
              decoration:  BoxDecoration(
                borderRadius: BorderRadiusGeometry.circular(16),
                border: Border.all(color: ColorPalette.black),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12),
                      child: CachedNetworkImage(
                        imageUrl:widget.articleList[index].urlToImage,
                        placeholder: (context, url) => const SizedBox(
                          height: 200,
                          width: 200,
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const SizedBox(
                          height: 200,
                          width: 200,
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                    Text(
                      widget.articleList[index].title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.articleList[index].sourceName,
                          style: textTheme.bodySmall,
                        ),
                        Text(
                         widget.articleList[index].publishedAt,
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 5);
        },
        itemCount:widget.articleList.length,
      ),
    );
  }
  void _showBottomSheet(BuildContext context, ArticleModel article) async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        gapPadding: 20,
      ),
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: SafeArea(
          child: FractionallySizedBox(
            widthFactor: 0.98,
            heightFactor: 0.9,
            child: Custombottomsheet(
              url: Uri.parse(article.url),
              imageSrc: article.urlToImage,
              description: article.content,
            ),
          ),
        ),
      ),
    );
  }

}
