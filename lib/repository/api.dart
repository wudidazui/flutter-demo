import 'package:demo/repository/datas/home_list_data.dart';
import 'package:dio/dio.dart';

import '../http/dio_instance.dart';
import 'datas/home_banner_data.dart';

class Api{
  static Api instance = Api._();

  Api._();

  Future<List<BannerItemData>?> getBanner() async{
    Response response = await DioInstance.instance().get(path: "banner/json");
    HomeBannerData bannerData =  HomeBannerData.fromJson(response.data);
    return bannerData.data;
  }

  Future<List<HomeListItemData>?> getHomeList(String pageCount) async{
    Response response = await DioInstance.instance().get(path: "article/list/$pageCount/json");
    HomeData homeData =  HomeData.fromJson(response.data);
    return homeData.data?.datas;
  }

  Future<List<HomeListItemData>?> getHomeTopList() async{
    Response response = await DioInstance.instance().get(path: "article/top/json");
    HomeTopListData homeData =  HomeTopListData.fromJson(response.data);
    return homeData.topList;
  }
}