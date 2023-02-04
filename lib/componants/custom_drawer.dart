import 'package:flutter/material.dart';
import 'package:flutter_task/componants/custom_text.dart';
import 'package:flutter_task/componants/images.dart';
import 'package:flutter_task/componants/my_navigate.dart';
import 'package:flutter_task/componants/style/colors.dart';
import 'package:flutter_task/componants/style/size.dart';
import 'package:flutter_task/core/local/app_cached.dart';
import 'package:flutter_task/screens/home/view/home_view.dart';
import 'package:flutter_task/screens/login/view/login_view.dart';
import 'package:flutter_task/shared/local/cache_helper.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: width(context) * 0.77,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
        ),
        height: height(context),
        child: Column(
          children: [
            CacheHelper.getData(key: AppCached.token) != null
                ? SizedBox(
                    width: width(context),
                    child: DrawerHeader(
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(15)),
                        color: AppColor.whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColor.whiteColor,
                            backgroundImage: CacheHelper.getData(key: AppCached.image).toString() != ""
                                ? NetworkImage(CacheHelper.getData(key: AppCached.image).toString())
                                : AssetImage(AppImages.profile)
                                    as ImageProvider,
                            radius: 40,
                          ),
                          SizedBox(height: height(context) * 0.015),
                          CustomText(
                              text: CacheHelper.getData(key: AppCached.name)
                                  .toString(),
                              color: AppColor.blackColor,
                              fontSize: AppFonts.t5),
                          SizedBox(height: height(context) * 0.01),
                          CustomText(
                              text: CacheHelper.getData(key: AppCached.email)
                                  .toString(),
                              color: AppColor.blackColor,
                              fontSize: AppFonts.t5),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            SizedBox(height: height(context) * 0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width(context) * 0.06),
              child: InkWell(
                onTap: () {
                  navigateAndFinish(context: context, widget: HomeScreen());
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: AppColor.greyColor.withOpacity(0.4),
                          offset: const Offset(1, 1),
                          spreadRadius: 1,
                          blurRadius: 1),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: width(context) * 0.02,
                      vertical: height(context) * 0.01),
                  child: Row(
                    children: [
                      SizedBox(width: width(context) * 0.03),
                      CustomText(
                          text: "Home",
                          color: AppColor.blackColor,
                          fontSize: AppFonts.t4),
                      const Spacer(),
                      const Icon(Icons.home,
                          size: 27, color: AppColor.blackColor),
                      SizedBox(width: width(context) * 0.03),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height(context) * 0.02),
            CacheHelper.getData(key: AppCached.token) != null
                ? const SizedBox.shrink()
                : Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: width(context) * 0.06),
                    child: InkWell(
                      onTap: () {
                        navigateTo(context, LoginScreen());
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.greyColor.withOpacity(0.4),
                                offset: const Offset(1, 1),
                                spreadRadius: 1,
                                blurRadius: 1),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: width(context) * 0.02,
                            vertical: height(context) * 0.01),
                        child: Row(
                          children: [
                            SizedBox(width: width(context) * 0.03),
                            CustomText(
                                text: "Login",
                                color: AppColor.blackColor,
                                fontSize: AppFonts.t4),
                            const Spacer(),
                            const Icon(Icons.login,
                                size: 27, color: AppColor.blackColor),
                            SizedBox(width: width(context) * 0.03),
                          ],
                        ),
                      ),
                    ),
                  ),
            CacheHelper.getData(key: AppCached.token) != null
                ? const SizedBox.shrink()
                :SizedBox(height: height(context) * 0.02),
            CacheHelper.getData(key: AppCached.token) != null
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: width(context) * 0.06),
                    child: InkWell(
                      onTap: () {
                        CacheHelper.removeData(AppCached.token);
                        navigateAndFinish(context: context, widget: LoginScreen());
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.greyColor.withOpacity(0.4),
                                offset: const Offset(1, 1),
                                spreadRadius: 1,
                                blurRadius: 1),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: width(context) * 0.02,
                            vertical: height(context) * 0.01),
                        child: Row(
                          children: [
                            SizedBox(width: width(context) * 0.03),
                            CustomText(
                                text: "Logout",
                                color: AppColor.blackColor,
                                fontSize: AppFonts.t4),
                            const Spacer(),
                            const Icon(Icons.logout_outlined,
                                size: 27, color: AppColor.blackColor),
                            SizedBox(width: width(context) * 0.015),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
