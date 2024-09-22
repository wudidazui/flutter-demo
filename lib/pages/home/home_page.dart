import 'dart:ui';

import 'package:demo/repository/datas/home_banner_data.dart';
import 'package:demo/repository/datas/home_list_data.dart';
import 'package:demo/pages/web_view_page.dart';
import 'package:demo/route/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home_vm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModal viewModal = HomeViewModal();
  RefreshController refreshController = RefreshController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModal.getBanner();
    viewModal.getHomeList(false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModal>(create: (context){
      return viewModal;
    },
    child: Scaffold(
      body: SafeArea(
          child: SmartRefresher(
            controller:refreshController,
            enablePullUp: true,
            enablePullDown: true,
            header: ClassicHeader(),
            footer: ClassicFooter(),
            onLoading: (){

            },
            onRefresh: (){
              viewModal.getBanner().then((value) => {
                viewModal.getHomeList(false).then((value) => {
                  refreshController.refreshCompleted()
                })
              });
            },
            child:SingleChildScrollView(
                  child: Column(
                  children: [
                    _banner(),
                    _homeListView()
                  ],
              ),
            ),
          )
      ),
    ),);
  }

  Widget _homeListView(){
    return Consumer<HomeViewModal>(builder: (context,vm,child){
      return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context,index){
            return _listItemView(vm.listData?[index]);
          },
          physics: NeverScrollableScrollPhysics(),
          itemCount: vm.listData?.length ?? 0
      );
    });
  }

  Widget _banner(){
    return Consumer<HomeViewModal>(builder: (context,vm,child){
      return Container(
        height: 150,
        width: double.infinity,
        child: Swiper(
            itemCount: vm.bannerList?.length ?? 0,
            itemBuilder: (context,index) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.all(15),
                height: 150,
                color: Colors.lightBlue,
                child: Image.network(vm.bannerList?[index]?.imagePath ?? "",fit: BoxFit.fill,),
              );
            }
        ),
      );
    });
  }

  Widget _listItemView(HomeListItemData? item){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, RoutePath.webViewPage,arguments: {
          "name":"add"
        });
        // Navigator.push(context, MaterialPageRoute(builder: (context){
        //   return WebViewPage(title:"首页跳转来的");
        // }));
      },
      child: Container(
        margin: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
        padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12,width: 0.5,),
            borderRadius: BorderRadius.all(Radius.circular(6))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network("https://img.zcool.cn/community/0104c15cd45b49a80121416816f1ec.jpg@1280w_1l_2o_100sh.jpg",width: 30,height: 30,fit: BoxFit.fill,),
                ),
                SizedBox(width: 5,),
                Text(item?.author ?? "",style: TextStyle(color: Colors.black),),
                Expanded(
                    child: SizedBox()
                ),
                Text(item?.niceShareDate ?? "",style: TextStyle(color: Colors.black,fontSize: 12)),
                SizedBox(width: 5,),
                (item?.type?.toInt() == 1) ? Text("置顶",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),):SizedBox()
              ],
            ),
            SizedBox(height: 5,),
            Text(item?.title ?? "",style: TextStyle(color: Colors.black,fontSize: 14)),
            SizedBox(height: 5,),
            Row(
              children: [
                Text(item?.chapterName ?? "",style: TextStyle(color: Colors.green,fontSize: 12),),
                Expanded(
                    child: SizedBox()
                ),
                Image.network("https://img.zcool.cn/community/0104c15cd45b49a80121416816f1ec.jpg@1280w_1l_2o_100sh.jpg",width: 30,height: 30,fit: BoxFit.fill),
              ],
            )
          ],
        ),
      )
    );
  }
}


