import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gren_mart/service/product_details_service.dart';
import 'package:gren_mart/service/review_service.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../utils/constant_name.dart';
import '../utils/constant_styles.dart';
import '../utils/text_themes.dart';

class ReviewBox extends StatelessWidget {
  bool expanded;
  void Function()? onPressed;
  dynamic id;
  ReviewBox(this.expanded, this.id, {this.onPressed, Key? key})
      : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          onTap: onPressed,
          dense: false,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18),
          title: Text(
            asProvider.getString('Review'),
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
          ),
          trailing: IconButton(
              icon: Icon(
                expanded ? Icons.expand_less : Icons.expand_more,
              ),
              onPressed: onPressed),
        ),
        if (expanded &&
            !(Provider.of<ProductDetailsService>(context, listen: false)
                .productDetails!
                .userRatedAlready) &&
            Provider.of<ProductDetailsService>(context, listen: false)
                    .productDetails!
                    .userHasItem ==
                true)
          submitReview(context),
        if (expanded &&
            !(Provider.of<ProductDetailsService>(context, listen: false)
                .productDetails!
                .userRatedAlready) &&
            Provider.of<ProductDetailsService>(context, listen: false)
                    .productDetails!
                    .userHasItem ==
                true)
          SizedBox(
            height: 20,
          ),
        if (expanded)
          ...descriptions(Provider.of<ProductDetailsService>(context)),
        const SizedBox(height: 20)
      ],
    );
  }

  List<Widget> descriptions(ProductDetailsService pService) {
    List<Widget> reviewList = [];
    for (var element in pService.productDetails!.ratings) {
      reviewList.add(Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(element.user.name.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: cc.greyParagraph)),
              const SizedBox(height: 8),
              RatingBar.builder(
                ignoreGestures: true,
                itemSize: 12,
                initialRating: (element.rating).toDouble(),
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                itemBuilder: (context, _) => SvgPicture.asset(
                  'assets/images/icons/star.svg',
                  color: cc.orangeRating,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const SizedBox(height: 8),
              Text(
                element.reviewMsg,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextThemeConstrants.paragraphText,
              ),
              const SizedBox(height: 10),
              Text(timeago.format(element.createdAt),
                  style: TextStyle(color: cc.greyHint, fontSize: 11)),
              // const Divider(),
            ],
          ),
        ),
      ));
    }
    // for (var element in pService.productDetails!.ratings ?? []) {

    // }
    return reviewList.isEmpty
        ? [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Text(
                asProvider.getString('No Review submitted yet'),
                style: TextStyle(
                    color: cc.greyHint,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ]
        : reviewList;
  }

  Widget submitReview(BuildContext context) {
    initiateDeviceSize(context);
    final textTheme = TextStyle(
        fontSize: 17, fontWeight: FontWeight.bold, color: cc.greyParagraph);
    return Form(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: cc.whiteGrey),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(asProvider.getString('Your rating'), style: textTheme),
          const SizedBox(height: 10),
          RatingBar.builder(
            // ignoreGestures: true,
            itemSize: 17,
            initialRating: 1,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 1),
            itemBuilder: (context, _) => SvgPicture.asset(
              'assets/images/icons/star.svg',
              color: cc.orangeRating,
            ),
            onRatingUpdate: (rating) {
              print(rating);
              Provider.of<ReviewService>(context, listen: false)
                  .setRating(rating.toStringAsFixed(0));
            },
          ),
          const SizedBox(height: 10),
          Text(asProvider.getString('Your review'), style: textTheme),
          const SizedBox(height: 10),
          SizedBox(
            height: screenHight / 7,
            // margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Consumer<ReviewService>(builder: (context, rService, child) {
              return TextField(
                maxLines: 4,
                controller: _controller,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: asProvider.getString('Write yor feedback.'),
                  hintStyle: TextStyle(color: cc.greyHint, fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: cc.greyBorder2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: cc.greyBorder2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: cc.primaryColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: cc.pink),
                  ),
                ),
                onChanged: (value) {
                  Provider.of<ReviewService>(context, listen: false)
                      .setComment(value);
                },
                onSubmitted: (_) {
                  rService.toggleLaodingSpinner(true);
                  FocusScope.of(context).unfocus();
                  rService.submitReview(id.toString(), context).onError(
                      (error, stackTrace) => snackBar(
                          context, asProvider.getString('Connection failed'),
                          backgroundColor: cc.orange));
                  rService.toggleLaodingSpinner(false);
                },
              );
            }),
          ),
          const SizedBox(height: 30),
          Consumer<ReviewService>(builder: (context, rService, child) {
            return Stack(
              children: [
                customContainerButton(
                  Provider.of<ReviewService>(context).isLoading
                      ? ''
                      : asProvider.getString('Submit'),
                  double.infinity,
                  Provider.of<ReviewService>(context).isLoading
                      ? () {}
                      : () async {
                          if (rService.comment.isEmpty) {
                            snackBar(
                                context,
                                asProvider
                                    .getString('Please write a feedback'));
                            return;
                          }
                          rService.toggleLaodingSpinner(true);
                          FocusScope.of(context).unfocus();
                          await rService
                              .submitReview(id.toString(), context)
                              .onError((error, stackTrace) => snackBar(context,
                                  asProvider.getString('Connection failed'),
                                  backgroundColor: cc.orange));
                          rService.toggleLaodingSpinner(false);
                        },
                ),
                if (Provider.of<ReviewService>(context).isLoading)
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Center(
                          child: loadingProgressBar(
                              size: 30, color: cc.pureWhite)))
              ],
            );
          }),
          const SizedBox(height: 20),
        ],
      ),
    ));
  }
}
