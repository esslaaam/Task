import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/componants/custom_drawer.dart';
import 'package:flutter_task/componants/custom_loading.dart';
import 'package:flutter_task/componants/custom_text.dart';
import 'package:flutter_task/componants/images.dart';
import 'package:flutter_task/componants/my_navigate.dart';
import 'package:flutter_task/componants/style/colors.dart';
import 'package:flutter_task/componants/style/size.dart';
import 'package:flutter_task/screens/product/view/product_view.dart';
import '../controller/home_cubit.dart';
import '../controller/home_states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProducts(context),
      child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = HomeCubit.get(context);
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                    centerTitle: true, title: CustomText(text: "My Store")),
                drawer: CustomDrawer(),
                body: state is HomeLoadingState ? CustomLoading(): GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      vertical: height(context) * 0.015,
                      horizontal: width(context) * 0.04,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.4 / 2.5,
                    ),
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            navigateTo(context, ProductScreen(id: cubit.productsModel!.data!.product![index].id!));
                            print( cubit.productsModel!.data!.product![index].id!);
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          AppColor.greyColor.withOpacity(0.4),
                                      offset: const Offset(1, 1),
                                      spreadRadius: 4,
                                      blurRadius: 4),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(cubit.productsModel!.data!.product![index].image!)),
                                  SizedBox(height: height(context) * 0.015),
                                  Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: width(context) * 0.015),
                                      child: CustomText(
                                          text: cubit.productsModel!.data!.product![index].name!,
                                          color: AppColor.blackColor,
                                          fontweight: FontWeight.bold,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: AppFonts.t5)),
                                  SizedBox(height: height(context) * 0.015),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start: width(context) * 0.015),
                                    child: CustomText(
                                        text: cubit.productsModel!.data!.product![index].price!.toInt().toString(),
                                        color: AppColor.blackColor,
                                        fontweight: FontWeight.bold,
                                        fontSize: AppFonts.t5),
                                  ),
                                ],
                              )),
                        ),
                    itemCount: cubit.productsModel!.data!.product!.length),
              ),
            );
          }),
    );
  }
}
