import 'package:flutter/material.dart';
import 'package:newsapp/core/themes/ColorPalette.dart';
import 'package:newsapp/models/ArticleModel.dart';
import 'package:newsapp/models/Category_Data_Model.dart';
import 'package:newsapp/widgets/SelectedCategoryWidget.dart';

import '../Network Handler/Network_Handler.dart';
import '../core/gen/assets.gen.dart';
import '../widgets/CategoryCardWidget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
   bool isSearch=false;
  List<CategoryDataModel> categoryList = [
    CategoryDataModel(
      image: Assets.images.generalDark.keyName,
      title: "General",
      darkimg: Assets.images.general.keyName,
      id: 'General',
    ),
    CategoryDataModel(
      image: Assets.images.busniessDark.keyName,
      title: "Business",
      darkimg: Assets.images.busniess.keyName,
      id: 'Business',
    ),
    CategoryDataModel(
      image: Assets.images.sportDark.keyName,
      title: "Sports",
      darkimg: Assets.images.sport.keyName,
      id: 'Sports',
    ),
    CategoryDataModel(
      image: Assets.images.entertainmentDark.keyName,
      title: "Entertainment",
      darkimg: Assets.images.entertainment.keyName,
      id: 'Entertainment',
    ),
    CategoryDataModel(
      image: Assets.images.helthDark.keyName,
      title: "Health",
      darkimg: Assets.images.helth.keyName,
      id: 'Health',
    ),
    CategoryDataModel(
      image: Assets.images.scienceDark.keyName,
      title: "Science",
      darkimg: Assets.images.science.keyName,
      id: 'Science',
    ),
    CategoryDataModel(
      image: Assets.images.technologyDark.keyName,
      title: "Technology",
      darkimg: Assets.images.technology.keyName,
      id: 'Technology',
    ),
  ];
  CategoryDataModel? selectedCategory;
 late final CategoryDataModel categoryDataModel;
 late final ArticleModel articleModel;
 ArticleModel? selectedArticle;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar:isSearch==true?AppBar(
          title: SearchAnchor(builder: (BuildContext context,SearchController controller){
            return SearchBar(
              onTap: controller.openView,
              onChanged: (_)=>controller.openView(),
              hintText: "Search",
              controller: controller,
              leading: IconButton(onPressed: (){}, icon: Assets.icons.searchIcn.svg()),
              trailing: <Widget>[
                Tooltip(
                  message: "Close search",
                  child: IconButton(onPressed: (){
                    setState(() {
                      isSearch=false;
                    });
                  }, icon: Icon(Icons.close)),
                )
              ]
            );
          }, suggestionsBuilder: (BuildContext context,SearchController controller){
            if(controller.text.trim().isEmpty){
              return [
                Text("Start typing to search")
              ];
            }
            return [
              FutureBuilder(future: NetworkHandler.searchArticles(controller.text), builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Text("waiting...");

                }
                if (snapshot.hasError){
                  print("SomeThing went wrong${snapshot.error}");
                  return Text("SomeThing went wrong${snapshot.error}");
                }
                if (!snapshot.hasData|| snapshot.data==null||snapshot.data!.isEmpty){
                  return Text("No matching articles");
                }
                final result =snapshot.data!;
                return Column(
                  children: result.map((item) {
                    return ListTile(
                      title: Text(item.title),
                      onTap: () {
                        controller.text = item.title;
                        selectedArticle=item;
                        controller.closeView(item.title);
                      },
                    );
                  }).toList(),
                );
              })
            ];
          })
        ): AppBar(
          title: Text(selectedCategory?.title ?? "Home"),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {
              setState(() {
                isSearch=true;
              });

            }, icon: Assets.icons.searchIcn.svg()),
          ],
        ),
        drawer: Drawer(
          backgroundColor: ColorPalette.black,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                color: ColorPalette.white,
                child: Center(
                  child: Text("News App", style: textTheme.headlineSmall),
                ),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    selectedCategory=null;
                    Navigator.pop(context);
                  });

                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Assets.icons.homeIcn.svg(),
                      SizedBox(width: 10),
                      Text("Go To Home", style: textTheme.titleLarge),
                    ],
                  ),
                ),
              ),
              Divider(
                color: ColorPalette.white,
                indent: 10,
                endIndent: 10,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  spacing: 8,
                  children: [
                    Assets.icons.themeIcn.svg(),
                    Text("Theme", style: textTheme.titleLarge),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.transparent,
                  border: Border.all(color: ColorPalette.white),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Dark", style: textTheme.titleLarge),
                    Assets.icons.arrowDown.svg(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Divider(
                color: ColorPalette.white,
                indent: 10,
                endIndent: 10,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Assets.icons.languageIcn.svg(),
                    SizedBox(width: 8),
                    Text("Language", style: textTheme.titleLarge),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.transparent,
                  border: Border.all(color: ColorPalette.white),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("English", style: textTheme.titleLarge),
                    Assets.icons.arrowDown.svg(),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: selectedCategory == null
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Morning \n Here is Some News For You",
                      style: textTheme.headlineSmall,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Categorycardwidget(
                            onTap: onSelectCategory,
                            isLeft: index % 2 == 0,
                            categoryDataModel: categoryList[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                        itemCount: categoryList.length,
                      ),
                    ),
                  ],
                ),
              ):
            Selectedcategorywidget(categoryDataModel: selectedCategory!,)
      ),
    );
  }

  void onSelectCategory(CategoryDataModel categoryDataModel) {
    setState(() {
      selectedCategory = categoryDataModel;
    });
  }
}
