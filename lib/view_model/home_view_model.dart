import 'package:live_data/lifecycle.dart';
import 'package:live_data/lifecycle_owner.dart';
import 'package:live_data/live_data.dart';
import 'package:live_data/view_model.dart';
import 'package:live_data_test/view_model/list_model.dart';
import 'package:english_words/english_words.dart';

class HomeViewModel extends ViewModel {
  ListModelLiveData liveData;

  ListModelLiveData getListModelData() {
    if (liveData == null) {
      liveData = take("MutableLiveData<List<ListModel>>");
      if (liveData == null) {
        liveData = ListModelLiveData();
        putLiveData("MutableLiveData<List<ListModel>>", liveData);
      }
    }
    return liveData;
  }
}

class ListModelLiveData extends LiveData {
  List<ListModel> listModels = List();

  @override
  void onLifecycleStateChange(LifecycleOwner lifecycleOwner) {
    if (lifecycleOwner.lifecycle.currentState == Lifecycle.STARTED) {
      listModels.clear();
      for (var i = 0; i < 10; i++) {
        ListModel listModel = ListModel(
            title: WordPair.random().asUpperCase,
            subTitle: WordPair.random().asLowerCase);
        listModels.add(listModel);
      }
      setValue(listModels);
    }
  }

  @override
  void setValue(value) {
    // TODO: implement setValue
    listModels = value;
    for (String key in observerMap.keys) {
      observerMap[key].onValueChange(value);
    }
  }
}
