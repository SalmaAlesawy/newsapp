import 'package:flutter/material.dart';
import 'package:newsapp/models/ArticleModel.dart';
import 'package:newsapp/models/Category_Data_Model.dart';
import 'package:newsapp/models/sourceDataModel.dart';
import 'package:newsapp/widgets/CustomListView.dart';

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
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        if(snapshot.hasError){
          return Text("Has Error ${snapshot.error}");
        }
        if(!snapshot.hasData||snapshot.data!.isEmpty){
          return Text("No sources Found");
        }
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
                tabs: List.generate(
                  sourceList.length,
                  (index) => Tab(
                    child: Text(
                      sourceList[index].name,
                      style:selectedIndex!=index?textTheme.titleSmall: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (sourceList.isNotEmpty)
              FutureBuilder(
                future: NetworkHandler.getAllArticles(
                  sourceList[selectedIndex].id,
                ),
                builder: (context, snapshot) {
                  print("articels id${sourceList[selectedIndex].id}");
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text("No Data Found");
                  }
                  List<ArticleModel> articleList = snapshot.data ?? [];

                  return Customlistview(articleList: articleList);
                },
              ),
          ],
        );
      },
    );
  }
}
