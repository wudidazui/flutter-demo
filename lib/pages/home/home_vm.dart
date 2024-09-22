import 'dart:async';

import 'package:demo/repository/datas/home_banner_data.dart';
import 'package:demo/http/dio_instance.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../repository/api.dart';
import '../../repository/datas/home_list_data.dart';

class HomeViewModal with ChangeNotifier{
  int pageCount = 0;
  List<BannerItemData?>? bannerList;
  List<HomeListItemData>? listData = [];

  Future getBanner() async{
    List<BannerItemData?>? list = await Api.instance.getBanner();
    bannerList = list ?? [];
    notifyListeners();
  }

  Future initListData(bool loadMore) async{
    if(loadMore){
      pageCount++;
    }else{
      pageCount = 1;
      listData?.clear();
    };
    getTopList(loadMore).then((topList){
      if(!loadMore){
        listData?.addAll(topList ?? []);
      };
      getHomeList(loadMore).then((allList){
        listData?.addAll(allList ?? []);
        notifyListeners();
      });
    });
  }

  Future getHomeList(bool loadMore) async{
    List<HomeListItemData>? list = await Api.instance.getHomeList("$pageCount");
    if(list != null && list.isNotEmpty){
      return list;
    }else{
      if(loadMore && pageCount > 0){
        pageCount--;
      }
      return [];
    }
    listData?.addAll(list ?? []);
    notifyListeners();
  }

  Future getTopList(bool loadMore) async{
    if(loadMore){
      return [];
    }
    List<HomeListItemData>? list = await Api.instance.getHomeTopList();
    return list;
  }

}
