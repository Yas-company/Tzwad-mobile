import 'package:flutter/material.dart';

import 'search_content_list.dart';
import 'search_field_widget.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SearchFieldWidget(),
        Expanded(
          child: SearchContentList(),
        )
      ],
    );
  }
}
