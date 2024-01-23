import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/newchannel_headlines.dart';
import 'package:news_app/models/news_category_model.dart';
import 'package:news_app/models/news_tech_headlines.dart';

class NewsRepository {
  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlineApi(
      String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=5e6127dc2ae0485e8afcbd546557d1bb';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    } else {
      throw Exception('Error fetching data');
    }
  }

  Future<NewsCategoriesModel> fetchNewsCategoryApi(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=$category&apiKey=5e6127dc2ae0485e8afcbd546557d1bb';
    final respones = await http.get(Uri.parse(url));
    if (respones.statusCode == 200) {
      final body = jsonDecode(respones.body);
      return NewsCategoriesModel.fromJson(body);
    } else {
      throw Exception('Error in fetching data');
    }
  }

  Future<NewsTechHeadlinesModel> fetchNewsTechHeadlinesApi() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=5e6127dc2ae0485e8afcbd546557d1bb';
    final respone = await http.get(Uri.parse(url));
    if (respone.statusCode == 200) {
      final body = jsonDecode(respone.body);
      return NewsTechHeadlinesModel.fromJson(body);
    } else {
      throw Exception('Error in fetchimg data');
    }
  }
}
