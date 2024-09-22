import 'package:demo/pages/home/home_page.dart';
import 'package:demo/pages/web_view_page.dart';
import 'package:flutter/material.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutePath.home:
        return pageRoute(HomePage(),settings: settings);
      case RoutePath.webViewPage:
        return pageRoute(WebViewPage(title: "首页跳转来的"),settings: settings);
    }
    return pageRoute(
      Scaffold(
        body: SafeArea(
          child: Center(child: Text("route path ${settings.name} 不存在"),),
        ),
      )
    );
  }


  static MaterialPageRoute pageRoute(Widget page,{
    RouteSettings? settings,
    bool? fullscreenDialog,
    bool? maintainState,
    bool? allowSnapshotting,
  }){
    return MaterialPageRoute(builder: (context){
      return page;
    },
    settings: settings,
    fullscreenDialog: fullscreenDialog ?? false,
    maintainState: maintainState ?? true,
    allowSnapshotting: allowSnapshotting ?? true
    );
  }
}


class RoutePath{
  static const String home = "/";
  static const String webViewPage = "/web_view_page";
}
