import 'package:flutter/cupertino.dart';
import 'package:flutterapp/utils/route_utils.dart';
import 'package:flutterapp/view/es_text_widget.dart';
import 'package:flutterapp/view/views_factory.dart';
import 'package:provider/provider.dart';
import 'model/provider_model.dart';

class ProviderOneView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProviderOneViewState();
  }
}

class _ProviderOneViewState extends State<ProviderOneView> {
  @override
  Widget build(BuildContext context) {
    return ESWidgetFactory.scaffold(
        context: context, title: "接口回调Demo", body: _bodyWidget());
  }
//初始化model的值 或者获取model的初始值
  Widget _bodyWidget() {
    return Consumer<ProviderModel>(
      builder: (context, model, child) {
        //ChangeNotifierProvider保证用的是同一个model，
        return ChangeNotifierProvider.value(
          value: model,
          child: Container(
            child: GestureDetector(
              onTap: () {
                RouteUtils.openProviderTwoView(context: context, model: model);
              },
              child: ESText(text: model.providerStr ?? ""),
            ),
            alignment: Alignment.center,
          ),
        );
      },
    );
  }
}
