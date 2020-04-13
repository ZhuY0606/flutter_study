import 'package:flutter/cupertino.dart';
import 'package:flutterapp/demo/provider/model/provider_model.dart';
import 'package:flutterapp/demo/provider/provider_one_view.dart';
import 'package:provider/provider.dart';

class ProviderMainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return _ProviderMainViewState();
  }
}
class _ProviderMainViewState extends State<ProviderMainView> {
  //在最外层监听多个model
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderModel()),
      ],
      child: ProviderOneView(),
    );
  }

}