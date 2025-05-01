import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service/country_dropdown_service.dart';
import '../../service/state_dropdown_service.dart';
import '../../service/user_profile_service.dart';
import '../../view/settings/manage_account.dart';
import '../../view/utils/constant_colors.dart';
import '../../view/utils/constant_name.dart';

class SettingScreenAppBar extends StatelessWidget {
  String? image;
  SettingScreenAppBar(this.image, {Key? key}) : super(key: key);

  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    initiateDeviceSize(context);
    return SizedBox(
      height: screenHight / 3,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: screenHight / 4,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: cc.greyYellow,
            ),
          ),
          Positioned(
            top: screenHight / 6,
            right: screenWidth / 2.9,
            child: GestureDetector(
                onTap: () {
                  Provider.of<CountryDropdownService>(context, listen: false)
                      .getContries(context)
                      .then((value) {
                    final userData =
                        Provider.of<UserProfileService>(context, listen: false);
                    print(userData.userProfileData!.country!.id);
                    if (userData.userProfileData!.country != null) {
                      Provider.of<CountryDropdownService>(context,
                              listen: false)
                          .setCountryIdAndValue(
                              userData.userProfileData!.country!.name, context);
                    }
                    if (userData.userProfileData!.state != null) {
                      Provider.of<StateDropdownService>(context, listen: false)
                          .setStateIdAndValue(
                              userData.userProfileData!.state!.name);
                    }
                  });
                  Navigator.of(context).pushNamed(ManageAccount.routeName);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: CachedNetworkImage(
                      height: screenWidth / 3.16,
                      width: screenWidth / 3.16,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      imageUrl: image ?? '',
                      placeholder: (context, url) => Container(
                            color: cc.primaryColor,
                            alignment: Alignment.center,
                            child: Text(
                              Provider.of<UserProfileService>(context)
                                  .userProfileData!
                                  .name
                                  .substring(0, 2)
                                  .toUpperCase()
                                  .trim(),
                              style: TextStyle(
                                  color: cc.pureWhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 45),
                            ),
                          ),
                      errorWidget: (context, url, error) => Container(
                            color: cc.primaryColor,
                            alignment: Alignment.center,
                            child: Text(
                              Provider.of<UserProfileService>(context)
                                  .userProfileData!
                                  .name
                                  .substring(0, 2)
                                  .toUpperCase()
                                  .trim(),
                              style: TextStyle(
                                  color: cc.pureWhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 45),
                            ),
                          )),
                )),
          ),
        ],
      ),
    );
  }
}
