import 'package:flutter/cupertino.dart';
import 'package:flutterapp/view/es_text_widget.dart';
import 'package:flutterapp/view/views_factory.dart';
import 'package:provider/provider.dart';

import 'model/provider_model.dart';
class ProviderTwoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return _ProviderTwoViewState();
  }
}
class _ProviderTwoViewState extends State<ProviderTwoView> {


  @override
  Widget build(BuildContext context) {
      return ESWidgetFactory.scaffold(
        context: context, title: "Provider Demo", body: _bodyWidget());
  }

  Widget _bodyWidget() {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          //provider.of修改model的值
          var widgetModel =
          Provider.of<ProviderModel>(context, listen: false);
          widgetModel.changeModel("provider完成");
        },
        child: ESText(text: "开始"),
      ),
      alignment: Alignment.center,
    );
  }

}