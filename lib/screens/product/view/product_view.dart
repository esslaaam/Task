import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/componants/custom_drawer.dart';
import 'package:flutter_task/componants/custom_loading.dart';
import 'package:flutter_task/componants/custom_text.dart';
import 'package:flutter_task/componants/style/colors.dart';
import 'package:flutter_task/componants/style/size.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controller/product_cubit.dart';
import '../controller/product_states.dart';

class ProductScreen extends StatelessWidget {
  final int id;

  const ProductScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getProductDetails(context, id),
      child: BlocConsumer<ProductCubit, ProductStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = ProductCubit.get(context);
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                    centerTitle: true,
                    title: state is ProductDetailsLoadingState
                        ? const SizedBox.shrink()
                        : CustomText(
                            text: cubit.productDetailsModel!.data!.name,
                            overflow: TextOverflow.ellipsis)),
                drawer: CustomDrawer(),
                body: state is ProductDetailsLoadingState
                    ? CustomLoading()
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            horizontal: width(context) * 0.035),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height(context) * 0.02),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(cubit.afterCurrentIndex == cubit.afterIndex
                                          ? cubit.productDetailsModel!.data!.moreImage![cubit.afterIndex].image!
                                             :cubit.productDetailsModel!.data!.image!),
                                      fit: BoxFit.fill)),
                              child: Align(
                                alignment: AlignmentDirectional.topEnd,
                                child: SizedBox(
                                  height: height(context) * 0.35,
                                  width: width(context) * 0.2,
                                  child: ListView.separated(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height(context) * 0.01,
                                        horizontal: width(context) * 0.02),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          cubit.getIndex(index);
                                        },
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                                cubit.productDetailsModel!.data!
                                                    .moreImage![index].image!,
                                                width: width(context) * 0.05)),
                                      );
                                    },
                                    shrinkWrap: true,
                                    itemCount: cubit.productDetailsModel!.data!
                                        .moreImage!.length,
                                    physics: const BouncingScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                            height: height(context) * 0.01),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height(context) * 0.025),
                            CustomText(
                                text: cubit.productDetailsModel!.data!.name,
                                fontSize: AppFonts.t3,
                                color: AppColor.blackColor,
                                fontweight: FontWeight.bold),
                            SizedBox(height: height(context) * 0.005),
                            CustomText(
                                text: cubit.productDetailsModel!.data!.price
                                    .toString(),
                                fontSize: AppFonts.t4,
                                color: AppColor.blackColor,
                                fontweight: FontWeight.bold),
                            SizedBox(height: height(context) * 0.005),
                            HtmlWidget(
                                textStyle: TextStyle(
                                  fontSize: AppFonts.t4,
                                ),
                                cubit.productDetailsModel!.data!.description
                                    .toString()),
                            SizedBox(height: height(context) * 0.025),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: height(context) * 0.1,
                                    child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) => Container(
                                          margin: EdgeInsets.symmetric(vertical: height(context) * 0.03),
                                          child: InkWell(
                                                onTap: () {
                                                  cubit.getIndex(index);
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: width(context) * 0.035, vertical: height(context) * 0.005),
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: AppColor.greyColor
                                                                .withOpacity(0.4),
                                                            offset:
                                                            const Offset(1, 1),
                                                            spreadRadius: 1,
                                                            blurRadius: 1),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(15),
                                                      border: Border.all(
                                                          color: cubit.afterCurrentIndex == index
                                                              ? AppColor.blueColor
                                                              : AppColor
                                                                  .whiteColor),
                                                      color: HexColor(cubit
                                                          .productDetailsModel!
                                                          .data!
                                                          .moreImage![index]
                                                          .hex!)),
                                                ),
                                              ),
                                        ),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                                width: width(context) * 0.015),
                                        itemCount: cubit.productDetailsModel!
                                            .data!.moreImage!.length),
                                  ),
                                ),
                                SizedBox(width: width(context)*0.01),
                                Expanded(
                                  child: SizedBox(
                                    height: height(context) * 0.1,
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) => Container(
                                          margin: EdgeInsets.symmetric(vertical: height(context) * 0.025),
                                          child: InkWell(
                                                borderRadius: BorderRadius.circular(7),
                                                onTap: () {
                                                  cubit.changeIndex(index);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: width(context) * 0.02, vertical: height(context) * 0.005),
                                                  decoration: BoxDecoration(
                                                    color: AppColor.whiteColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: AppColor.greyColor
                                                              .withOpacity(0.4),
                                                          offset:
                                                              const Offset(1, 1),
                                                          spreadRadius: 1,
                                                          blurRadius: 1),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(7),
                                                    border: Border.all(
                                                        color:
                                                            cubit.newCurrentIndex ==
                                                                    index
                                                                ? AppColor.blueColor
                                                                : AppColor
                                                                    .whiteColor),
                                                  ),
                                                  child: Center(
                                                      child: CustomText(
                                                          text: cubit.productDetailsModel!
                                                              .data!
                                                              .color![0]
                                                              .size![index]
                                                              .name,
                                                          fontweight:
                                                              FontWeight.bold)),
                                                ),
                                              ),
                                        ),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                                width: width(context) * 0.015),
                                        itemCount: cubit.productDetailsModel!
                                            .data!.color![0].size!.length),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height(context) * 0.05),
                          ],
                        ),
                      ),
              ),
            );
          }),
    );
  }
}
