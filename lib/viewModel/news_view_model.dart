import 'package:news_app/models/newchannel_headlines.dart';
import 'package:news_app/models/news_category_model.dart';
import 'package:news_app/models/news_tech_headlines.dart';
import 'package:news_app/repository/news_respository.dart';

class NewsViewModel {
  final _rep = NewsRepository();
  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlineApi(
      String channelName) async {
    final response = await _rep.fetchNewsChannelHeadlineApi(channelName);
    return response;
  }

  Future<NewsCategoriesModel> fetchNewsCategoryApi(String category) async {
    final response = await _rep.fetchNewsCategoryApi(category);
    return response;
  }

  Future<NewsTechHeadlinesModel> fetchNewsTechHeadlinesApi() async {
    final respones = await _rep.fetchNewsTechHeadlinesApi();
    return respones;
  }
}
