import 'package:flutter/material.dart';
import 'package:live_data/lifecycle_owner.dart';
import 'package:live_data/live_data.dart';
import 'package:live_data_test/view_model/detail_model.dart';
import 'package:live_data_test/view_model/detail_view_model.dart';

class DetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage>
    with LiveDataObserver<DetailModel>, LifecycleOwner {
  DetailViewModel _detailViewModel;
  DetailModel _detailModel;

  DetailPageState() {
    _detailViewModel = DetailViewModel();
    _detailViewModel.getDetailData().addObserver(this, this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    start();
    return Scaffold(
      appBar: AppBar(
        title: Text("详情"),
        actions: <Widget>[
          GestureDetector(
            child: Center(
              child: Text("下一篇"),
            ),
            onTap: () {
              start();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Text(_detailModel == null ? "" : _detailModel.detail),
      ),
    );
  }

  @override
  void onValueChange(value) {
    // TODO: implement onValueChange
    _detailModel = value;
    setState(() {});
  }
}
