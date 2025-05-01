import 'package:flutter/material.dart';

import '../utils/constant_styles.dart';
import '../../view/utils/constant_name.dart';

class AnimatedBox extends StatelessWidget {
  String title;
  bool expanded;
  Map<String, String>? data;
  void Function()? onPressed;
  AnimatedBox(this.title, this.data, this.expanded, {this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            onTap: onPressed,
            dense: false,
            contentPadding: const EdgeInsets.symmetric(horizontal: 18),
            title: Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
                icon: Icon(
                  expanded ? Icons.expand_less : Icons.expand_more,
                ),
                onPressed: onPressed),
          ),
          if (expanded) ...?descriptions(),
          if (expanded) const SizedBox(height: 30)
        ],
      ),
    );
  }

  List<Widget>? descriptions() {
    List<Widget> descriptionList = [];
    if (data!.keys.first == '1') {
      descriptionList = [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          // child: Html(
          //     data: data!.values.first,
          //     onLinkTap: (url, _, map, e) {
          //       if (url != null) {
          //         launchUrl(Uri.parse(url));
          //       }
          //     }),
        ),
      ];
      return descriptionList;
    }
    data!.forEach((key, value) {
      descriptionList.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: key == '0' ? 0 : screenWidth / 4,
              child: Text(
                key == '0' ? '' : '$key :',
                style: TextStyle(
                    color: cc.greyHint,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14),
                maxLines: 2,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              // width: screenWidth - 156,
              child: Text(
                value,
                maxLines: 5,
                style: TextStyle(
                    color: cc.greyHint,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis),
              ),
            )
          ],
        ),
      ));
    });
    return descriptionList;
  }
}
