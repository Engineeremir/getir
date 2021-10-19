import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shop_app/core/base/view/base_widget.dart';
import 'package:shop_app/core/constants/svg/svg_constants.dart';
import 'package:shop_app/core/extension/context_extension.dart';
import 'package:shop_app/core/init/service/user_operations_service.dart';
import 'package:shop_app/view/basket/view/basket_view.dart';
import 'package:shop_app/view/home/view/home_view.dart';
import 'package:shop_app/view/products/view_model/products_view_model.dart';

class ProductsView extends StatefulWidget {
  final int categoryId;
  const ProductsView({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProductsViewModel>(
      viewModel: ProductsViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
        model.getAllProductsByCategoryId(widget.categoryId);
      },
      onPageBuilder: (BuildContext context, ProductsViewModel viewModel) =>
          Scaffold(
        appBar: buildAppBar(context, viewModel),
        body: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Container(
            padding: context.paddingLow,
            child: Observer(
              builder: (_) {
                return viewModel.isLoading
                    ? buildCenter()
                    : AnimationLimiter(
                        child: GridView.count(
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          physics: NeverScrollableScrollPhysics(),
                          childAspectRatio: 1 / 1.3,
                          shrinkWrap: true,
                          children:
                              List.generate(viewModel.products.length, (index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: context.lowerDuration,
                              columnCount: 3,
                              child: ScaleAnimation(
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  margin: context.paddingHighHorizontal * .4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        context.normalRadius),
                                  ),
                                  width: context.width * .46,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              context.normalRadius),
                                          topLeft: Radius.circular(
                                              context.normalRadius),
                                        ),
                                        child: Image.network(
                                          viewModel.products[index].imagePath!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: context.colors.background,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                    context.normalRadius),
                                                bottomRight: Radius.circular(
                                                    context.normalRadius),
                                              )),
                                          width: context.width * .58,
                                          height: context.height * .12,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                  viewModel.products[index]
                                                      .productName!,
                                                  style: GoogleFonts.robotoMono(
                                                      color: context
                                                          .colors.onPrimary)),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  AutoSizeText(
                                                    "${viewModel.products[index].unitPrice!.toStringAsFixed(2)}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: context
                                                            .colors.onPrimary),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      context
                                                          .read<User>()
                                                          .addFirstItemToBasket(
                                                              viewModel
                                                                      .products[
                                                                  index]);
                                                    },
                                                    icon: Icon(
                                                        context.basketIcon),
                                                    color: context
                                                        .colors.onPrimary,
                                                  )
                                                ],
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      );
              },
            ),
          ),
        ),
        // each product have a color
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context, ProductsViewModel viewModel) {
  return AppBar(
    backgroundColor: context.colors.background,
    title: SvgPicture.asset(
      SVGConstants.instance.getir,
      height: 25,
    ),
    centerTitle: true,
    actions: [
      Padding(
        padding: context.paddingLow,
        child: FloatingActionButton.extended(
          backgroundColor: context.colors.onPrimary,
          foregroundColor: context.colors.background,
          label: AutoSizeText(
              "${context.watch<User>().getBasketTotalMoney.toStringAsFixed(2)}"),
          icon: Icon(context.basketIcon),
          onPressed: () {
            viewModel.toBasetView();
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.heighRadius)),
        ),
      )
    ],
  );
}

Center buildCenter() => Center(child: CircularProgressIndicator());
