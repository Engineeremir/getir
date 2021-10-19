// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/src/provider.dart';
import 'package:shop_app/core/base/view/base_widget.dart';
import 'package:shop_app/core/extension/context_extension.dart';
import 'package:shop_app/core/init/model/product_model.dart';
import 'package:shop_app/core/init/service/user_operations_service.dart';
import 'package:shop_app/view/basket/view_model/basket_view_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class BasketView extends StatelessWidget {
  const BasketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<BasketViewModel>(
      viewModel: BasketViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, BasketViewModel value) => Scaffold(
        bottomNavigationBar: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AutoSizeText(
                "Toplam Fiyat",
                style: TextStyle(color: context.colors.onPrimary, fontSize: 25),
              ),
              AutoSizeText(
                "${context.watch<User>().getBasketTotalMoney.toStringAsFixed(2)}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: context.colors.background),
              ),
            ],
          ),
          height: context.heighValue,
          margin: EdgeInsets.fromLTRB(30, 20, 30, 10),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  stops: [0.4, 0.2],
                  end: Alignment.bottomLeft,
                  begin: Alignment.bottomRight,
                  colors: [Colors.white, context.colors.background]),
              borderRadius: BorderRadius.circular(context.normalRadius)),
        ),
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: AnimationLimiter(
            child: ListView.builder(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                shrinkWrap: true,
                itemCount: context.watch<User>().basketItems.length,
                itemBuilder: (context, index) {
                  final product = context.watch<User>().basketItems[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    delay: context.lowerDuration,
                    child: SlideAnimation(
                      duration: context.highDuration,
                      curve: Curves.fastLinearToSlowEaseIn,
                      verticalOffset: -150,
                      child: ScaleAnimation(
                        duration: context.normalDuration,
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: buildListTile(context, product),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  Container buildListTile(BuildContext context, Product product) {
    return Container(
      padding: context.paddingNormal,
      child: Center(
        child: ListTile(
          leading: ClipRRect(
              borderRadius: BorderRadius.circular(context.lowRadius),
              child: Image.network(product.imagePath!)),
          title: AutoSizeText(
            product.productName!,
            style: TextStyle(color: context.colors.secondary),
          ),
          subtitle: buildListTileSubTitle(context, product),
          trailing: buildTrailingIcons(context, product),
        ),
      ),
    );
  }

  AutoSizeText buildListTileSubTitle(BuildContext context, Product product) {
    return AutoSizeText(
      "${context.watch<User>().basketProducts[product]} * ${product.unitPrice!.toStringAsFixed(2)}",
      style: TextStyle(
          fontWeight: FontWeight.bold, color: context.colors.background),
    );
  }

  Container buildTrailingIcons(BuildContext context, Product product) {
    return Container(
      height: 30,
      width: context.heighValue * 1.3,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          InkWell(
            child: Icon(
              Icons.remove,
              color: context.colors.background,
            ),
            onTap: () {
              context.read<User>().increaseProduct(product);
            },
          ),
          Text(
            "${context.watch<User>().basketProducts[product] ?? 0}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: context.colors.background),
          ),
          InkWell(
            child: Icon(
              Icons.add,
              color: context.colors.background,
            ),
            onTap: () {
              context.read<User>().incrementProduct(product);
            },
          )
        ],
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: context.colors.background,
    title: Text("SEPET", style: TextStyle(color: context.colors.onPrimary)),
    centerTitle: true,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.arrow_back,
      ),
      color: context.colors.onPrimary,
    ),
  );
}
