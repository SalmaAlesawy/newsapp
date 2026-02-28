import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/core/constants/ApiConstants.dart';
import 'package:newsapp/core/constants/endPoints.dart';
import 'package:newsapp/models/ArticleModel.dart';
import 'package:newsapp/models/sourceDataModel.dart';

class NetworkHandler {
  static Future<List<SourceData>> getAllSources(String categoryId) async {
    try {
      Map<String, dynamic> queryParameters = {
        "apiKey": Apiconstants.Apikey,
        "category": categoryId,
      };
      final response = await http.get(
        Uri.http(Apiconstants.baseUrl, Endpoints.allSources, queryParameters),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        SourceDataModel sourceDataModel = SourceDataModel.fromjson(data);
        return sourceDataModel.sources;
      } else {
        throw Exception("SomeThing went wrong ${response.body}");
      }
    } catch (error) {
      throw Exception("SomeThing went wrong${error.toString()}");
    }
  }

  static Future<List<ArticleModel>> getAllArticles(
    String sourceId,
  ) async {
    try {
      Map<String, dynamic> queryParameters = {
        "apiKey": Apiconstants.Apikey,
        "sources": sourceId,
      };
      final response = await http.get(
        Uri.http(Apiconstants.baseUrl, Endpoints.allArticles, queryParameters),
      );
      List<ArticleModel> articleList = [];
      if (response.statusCode == 200) {
        print("Articles$articleList");
        var data = jsonDecode(response.body);
        for (var element in data["articles"]) {
          ArticleModel articleModel = ArticleModel.fromJson(element);
          articleList.add(articleModel);
        }
        return articleList;
} else {
throw Exception("SomeThing went wrong");
}
} catch (error) {
throw Exception("SomeThing went wrong");
}
}

static Future<List<ArticleModel>> searchArticles(String query) async {
try {
if (query.trim().isEmpty) return [];
Map<String, dynamic> queryParameters = {
"apiKey": Apiconstants.Apikey,
"q": query,
};
final response = await http.get(
Uri.https(Apiconstants.baseUrl, Endpoints.allArticles, queryParameters),
);
List<ArticleModel> articleList = [];
if (response.statusCode == 200) {
var data = jsonDecode(response.body);
for (var element in data["articles"]) {
ArticleModel articleModel = ArticleModel.fromJson(element);
articleList.add(articleModel);
}
return articleList;
} else {
print("status code ${response.statusCode}");
print("Body:${response.body}");
throw Exception("Api Error");
}
} catch (error) {
throw Exception("search error :$error");
}
}
}
