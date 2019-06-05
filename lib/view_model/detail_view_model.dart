import 'package:live_data/lifecycle.dart';
import 'package:live_data/lifecycle_owner.dart';
import 'package:live_data/live_data.dart';
import 'package:live_data/view_model.dart';
import 'package:live_data_test/view_model/detail_model.dart';
import 'package:english_words/english_words.dart';

class DetailViewModel extends ViewModel {
  DetailLiveData detailLiveData;

  DetailLiveData getDetailData() {
    if (detailLiveData == null) {
      detailLiveData = take("DetailLiveData<List<ListModel>>");
      if (detailLiveData == null) {
        detailLiveData = DetailLiveData();
        putLiveData("MutableLiveData<List<ListModel>>", detailLiveData);
      }
    }
    return detailLiveData;
  }
}

class DetailLiveData extends LiveData {
  DetailModel detailModel;

  @override
  void onLifecycleStateChange(LifecycleOwner lifecycleOwner) {
    // TODO: implement onLifecycleStateChange
    if (lifecycleOwner.lifecycle.currentState == Lifecycle.STARTED) {
      String detail = WordPair.random().asLowerCase;
      for (var i = 0; i < 50; i++) {
        detail = detail + " " + WordPair.random().asLowerCase;
      }
      detailModel = DetailModel(detail: detail);
      setValue(detailModel);
    }
  }

  @override
  void setValue(value) {
    // TODO: implement setValue
    detailModel = value;
    for (String key in observerMap.keys) {
      observerMap[key].onValueChange(value);
    }
  }
}
