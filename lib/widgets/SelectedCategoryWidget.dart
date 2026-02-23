import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/ArticleModel.dart';
import 'package:newsapp/models/Category_Data_Model.dart';
import 'package:newsapp/models/sourceDataModel.dart';

import '../Network Handler/Network_Handler.dart';
import '../core/themes/ColorPalette.dart';

class Selectedcategorywidget extends StatefulWidget {
  const Selectedcategorywidget({super.key, required this.categoryDataModel});
  final CategoryDataModel categoryDataModel;

  @override
  State<Selectedcategorywidget> createState() => _SelectedcategorywidgetState();
}

class _SelectedcategorywidgetState extends State<Selectedcategorywidget> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return FutureBuilder(
      future: NetworkHandler.getAllSources(widget.categoryDataModel.id),
      builder: (context, snapshot) {
        List<SourceData> sourceList = snapshot.data ?? [];
        return Column(
          children: [
            DefaultTabController(
              length: sourceList.length,
              child: TabBar(
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorColor: ColorPalette.black,
                labelColor: ColorPalette.black,
                labelStyle: textTheme.titleMedium,
                unselectedLabelStyle: textTheme.titleSmall,
                tabs: List.generate(
                  sourceList.length,
                  (index) => Tab(child: Text(sourceList[index].name)),
                ),
              ),
            ),
            if (sourceList.isNotEmpty)
              FutureBuilder(
                future: NetworkHandler.getAllArticles(
                  sourceList[selectedIndex].id,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text("No Data Found");
                  }
                  List<ArticleModel> articleList = snapshot.data ?? [];

                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        print(" image: ${articleList[index].urlToImage}");
                        return Container(
                          margin: EdgeInsets.all(8),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusGeometry.circular(16),
                            border: Border.all(color: ColorPalette.black),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    12,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: articleList[index].urlToImage,
                                    placeholder: (context, url) =>
                                    SizedBox(
                                      height: 200,
                                      width: 200,
                                      child: CircularProgressIndicator(),),
                                    errorWidget: (context, url, error) =>
                                       SizedBox(height:200,width:200,child: Icon(Icons.error),)
                                  ),
                                ),
                                Text(
                                  articleList[index].title,
                                  style: textTheme.titleMedium,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      articleList[index].sourceName,
                                      style: textTheme.bodySmall,
                                    ),
                                    Text(
                                      articleList[index].publishedAt,
                                      style: textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 5);
                      },
                      itemCount: articleList.length,
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
