import 'package:flutter/material.dart';
import 'package:gren_mart/service/terms_and_condition_service.dart';
import 'package:gren_mart/view/utils/app_bars.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gren_mart/view/utils/constant_styles.dart';
import 'package:provider/provider.dart';

class WebViewScreen extends StatelessWidget {
  static const String routeName = 'web view screen';
  WebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeData = ModalRoute.of(context)!.settings.arguments as List;
    final title = routeData[0];
    String url = routeData[1];
    return Scaffold(
        appBar: AppBars().appBarTitled(context, title, () {
          Navigator.of(context).pop();
        }),
        body: FutureBuilder(
          future: Provider.of<TermsAndCondition>(context, listen: false)
              .getTermsAndCondi(url),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingProgressBar();
            }
            if (snapshot.hasData) {}
            return Consumer<TermsAndCondition>(
              builder: (context, tService, child) {
                return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Html(data: tService.html));
              },
            );
          },
        ));
  }
}
