import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:works_app/src/core/cubit/generic_state.dart';
import 'package:works_app/src/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:works_app/src/shared/utils/loading_component.dart';
import 'package:works_ds/widget/bottom/bottom.dart';
import 'package:works_ds/works_ds.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  TextEditingController searchController = TextEditingController();

  late final CartCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = Modular.get<CartCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'cart'.i18n(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: CustomColor.colorBrandSecondaryDark,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: CustomSizes.sizeXL),
        child: ECBottom(
          onTap: () => Modular.to.pop(),
          text: 'goShopping'.i18n(),
          width: MediaQuery.of(context).size.width / 2,
          textSize: 12,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: ECBottom(
          onTap: () {
            cubit.createPdf();
          },
          text: 'checkout'.i18n(),
        ),
      ),
      body: BlocBuilder(
        builder: (context, state) {
          if (state is InitState) {
            return cubit.listProductEntity.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: CustomSizes.sizeXXS,
                      vertical: CustomSizes.sizeM,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Text(
                          'cart'.i18n(),
                          style: TextStyle(
                            fontSize: CustomSizes.sizeM,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.listProductEntity.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: Image.network(
                                      cubit.listProductEntity[index]!.photo ??
                                          CustomIconsConst.notFoundImage,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: CustomSizes.sizeXXS,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cubit.listProductEntity[index]!
                                                  .name ??
                                              '',
                                          style: TextStyle(
                                            fontSize: CustomSizes.sizeL,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        Text(
                                          '${'price'.i18n()}: '
                                          '${'money'.i18n()}\$ ${cubit.listProductEntity[index]!.price!}',
                                          style: TextStyle(
                                            fontSize: CustomSizes.sizeM,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.03,
                                  ),
                                  IconButton(
                                    onPressed: () => cubit.add(cubit.listProductEntity[index]!),
                                    icon: Icon(
                                      Icons.add,
                                      color:
                                      CustomColor.colorFeedbackSuccess,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.02,
                                  ),
                                  IconButton(
                                    onPressed: () => cubit.remove(index),
                                    icon: Icon(
                                      Icons.delete,
                                      color:
                                          CustomColor.colorFeedbackCriticalDark,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: CustomSizes.sizeXXS,
                      vertical: CustomSizes.sizeM,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Text(
                          'cart'.i18n(),
                          style: TextStyle(
                            fontSize: CustomSizes.sizeM,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Expanded(
                          child: Center(
                            child: Text('cartEmpty'.i18n()),
                          ),
                        ),
                      ],
                    ),
                  );
          }
          if (state is LoadingState) {
            return getLoading(context);
          }
          return const SizedBox();
        },
        bloc: cubit,
      ),
    );
  }
}
