
import 'package:flutter_modular/flutter_modular.dart';
import 'package:works_app/src/features/cart/presentation/cart_page.dart';
import 'package:works_app/src/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:works_app/src/features/login/data/providers/auth_database.dart';
import 'package:works_app/src/features/login/data/repositorys/login_repository.dart';
import 'package:works_app/src/features/login/domain/usecases/login_usecase.dart';
import 'package:works_app/src/features/login/presentation/cubit/login_cubit.dart';
import 'package:works_app/src/features/products/data/providers/product_database.dart';
import 'package:works_app/src/features/products/data/repositorys/product_repository.dart';
import 'package:works_app/src/features/products/domain/usecases/product_usecase.dart';
import 'package:works_app/src/features/products/presentation/cubit/product_cubit.dart';
import 'package:works_app/src/features/products/presentation/product_page.dart';

import '../features/login/presentation/login_page.dart';

class AppModule extends Module {

  @override
  List<Bind> get binds => [
        //Bind((i) => SplashCubit()),
        Bind.singleton((i) => LoginCubit(i.get())),
        Bind((i) => LoginDatasourceImpl()),
        Bind((i) => LoginRepositoryImpl()),
        Bind((i) => LoginUseCaseImpl(i.get())),
        Bind.singleton((i) => ProductCubit(i.get())),
        Bind((i) => ProductDatasourceImpl()),
        Bind((i) => ProductRepositoryImpl()),
        Bind((i) => ProductUseCaseImpl(i.get())),
        Bind.singleton((i) => CartCubit()),
      ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const LoginPage(),),
    ChildRoute('${Modular.initialRoute}product',
        child: (context, args) => const ProductsPage(),),
    ChildRoute('${Modular.initialRoute}cart',
      child: (context, args) => const CartPage(),),
  ];
}
