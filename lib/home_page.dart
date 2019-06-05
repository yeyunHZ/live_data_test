import 'package:flutter/material.dart';
import 'package:live_data/lifecycle_owner.dart';
import 'package:live_data_test/detail_page.dart';
import 'package:live_data_test/view_model/home_view_model.dart';

import 'package:live_data_test/view_model/list_model.dart';
import 'package:live_data/live_data.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    HomePageState homePageState = HomePageState();
    return homePageState;
  }
}

class HomePageState extends State<HomePage>
    with LiveDataObserver<List<ListModel>>, LifecycleOwner {
  List<ListModel> _list;
  HomeViewModel _homeViewModel;

  HomePageState() {
    _homeViewModel = HomeViewModel();
    _homeViewModel.getListModelData().addObserver(this, this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    start();
    return Scaffold(
        appBar: AppBar(
          title: Text("列表"),
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: buildItem(_list),
          ),
        ));
  }

  List<Widget> buildItem(List<ListModel> listModels) {
    List<Widget> list = new List();
    if (listModels != null) {
      for (ListModel listModel in listModels) {
        list.add(GestureDetector(
          child: Center(
            child: ListTile(
              leading: Icon(Icons.list),
              subtitle: Text(listModel.subTitle),
              title: Text(listModel.title),
              trailing: Icon(Icons.arrow_right),
            ),
          ),
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => DetailPage()));
          },
        ));
      }
    }
    return list;
  }

  @override
  void onValueChange(List<ListModel> value) {
    this._list = value;
    setState(() {});
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {}
}
