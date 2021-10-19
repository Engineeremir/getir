// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/base/view/base_widget.dart';
import 'package:shop_app/core/constants/svg/svg_constants.dart';
import 'package:shop_app/core/extension/context_extension.dart';
import 'package:shop_app/view/home/view_model/home_view_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_app/view/products/view/products_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: HomeViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
        model.getAllCategories();
      },
      onPageBuilder: (BuildContext context, HomeViewModel viewModel) =>
          Scaffold(
              appBar: buildAppBar(context),
              body: buildBody(context, viewModel)),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.background,
      title: SvgPicture.asset(
        SVGConstants.instance.getir,
        height: 25,
      ),
      centerTitle: true,
    );
  }

  Widget buildBody(BuildContext context, HomeViewModel viewModel) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Container(
            height: context.heighValue * .8,
            width: double.infinity,
            color: context.colors.onBackground,
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                      width: context.width * .7,
                      height: context.heighValue,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(context.heighRadius),
                          topRight: Radius.circular(context.heighRadius),
                        ),
                      ),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Ev",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("368. Sok. No: 6/6",
                              style: TextStyle(color: Colors.grey)),
                          Icon(
                            Icons.chevron_right,
                            color: context.colors.background,
                          )
                        ],
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  width: context.normalValue,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "TVS",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: context.colors.background),
                    ),
                    Text(
                      "11dk",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: context.colors.background),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: context.normalValue,
          ),
          Observer(
            builder: (_) {
              return viewModel.isLoading
                  ? buildCenter()
                  : AnimationLimiter(
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 10,
                        childAspectRatio: 1 / 1.4,
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        children: List.generate(
                          viewModel.categories.length,
                          (int index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: context.normalDuration,
                              columnCount: 3,
                              child: ScaleAnimation(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductsView(
                                                  categoryId: viewModel
                                                      .categories[index]!
                                                      .categoryId!,
                                                )));
                                  },
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: context.lowValue),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          context.normalRadius),
                                    ),
                                    width: context.width * .46,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductsView(
                                              categoryId: viewModel
                                                  .categories[index]!
                                                  .categoryId!,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    context.normalRadius)),
                                            child: Image.network(viewModel
                                                .categories[index]!.imagePath!),
                                          ),
                                          Container(
                                              padding: context.paddingLowTop,
                                              width: context.width * .56,
                                              height: context.height * .04,
                                              child: AutoSizeText(
                                                viewModel.categories[index]!
                                                    .categoryName!,
                                                textAlign: TextAlign.center,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}

Center buildCenter() => Center(child: CircularProgressIndicator());
