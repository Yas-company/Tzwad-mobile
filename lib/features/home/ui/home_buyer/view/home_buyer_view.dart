import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';


class HomeBuyerView extends StatelessWidget {
  const HomeBuyerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffoldWidget(
      body: Center(
        child: Text('Home Buyer'),
      ),
      // appBar: HomeAppBarWidget(),
      // body: HomeBuyerViewBody(),
    );
  }
}
