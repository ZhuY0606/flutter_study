import 'package:flutter/cupertino.dart';

class ProviderModel extends ChangeNotifier {
  String providerStr="provider Demo";

  changeModel(String providerStr) {
    this.providerStr = providerStr;
    notifyListeners();
  }
}
