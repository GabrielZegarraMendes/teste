import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:works_app/src/core/cubit/generic_state.dart';
import 'package:works_app/src/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:works_app/src/features/login/presentation/cubit/login_cubit.dart';
import 'package:works_app/src/features/products/presentation/cubit/product_cubit.dart';
import 'package:works_app/src/shared/utils/loading_component.dart';
import 'package:works_ds/widget/texte_form_field/ec_text_form_field.dart';
import 'package:works_ds/works_ds.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  TextEditingController searchController = TextEditingController();

  late final ProductCubit cubit;
  late final LoginCubit loginCubit;
  late final CartCubit cartCubit;

  @override
  void initState() {
    super.initState();
    cubit = Modular.get<ProductCubit>();
    loginCubit = Modular.get<LoginCubit>();
    cartCubit = Modular.get<CartCubit>();
    cubit.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.colorBrandSecondaryDark,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'products'.i18n(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        leading: InkWell(
          onTap: () => loginCubit.logout(),
          child: const Icon(
            Icons.power_settings_new,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.pushNamed('/cart');
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          )
        ],
        elevation: 0,
      ),
      body: BlocBuilder(
        builder: (context, state) {
          if (state is SuccessState) {
            return cubit.searchProductEntity.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: CustomSizes.sizeXXS,
                      vertical: CustomSizes.sizeM,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ECTextFormField(
                          controller: searchController,
                          icon: Icon(
                            Icons.search,
                            color: CustomColor.colorBrandSecondaryDark,
                          ),
                          hintText: 'search'.i18n(),
                          onChanged: (value) {
                            cubit.setSearchList(value);
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Text(
                          'products'.i18n(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.searchProductEntity.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  cartCubit.add(cubit.searchProductEntity[index]!);
                                  Modular.to.pushNamed('/cart');
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.15,
                                      width: MediaQuery.of(context).size.height *
                                          0.15,
                                      child: Image.network(
                                        cubit.searchProductEntity[index]!.photo ??
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
                                            cubit.searchProductEntity[index]!
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
                                            '${cubit.searchProductEntity[index]!.price!}',
                                            style: TextStyle(
                                              fontSize: CustomSizes.sizeM,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ECTextFormField(
                          controller: searchController,
                          icon: Icon(
                            Icons.search,
                            color: CustomColor.colorBrandSecondaryDark,
                          ),
                          hintText: 'search'.i18n(),
                          onChanged: (value) {
                            cubit.setSearchList(value);
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Text(
                          'product'.i18n(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        const Expanded(
                          child: Center(
                            child: Text('Item indisponível'),
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
