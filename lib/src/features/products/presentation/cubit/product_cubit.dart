import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:works_app/src/core/cubit/generic_state.dart';
import 'package:works_app/src/features/products/domain/entities/product_entity.dart';
import 'package:works_app/src/features/products/domain/usecases/product_usecase.dart';

class ProductCubit extends Cubit<GenericState> {
  late ProductUseCase productUseCase;

  ProductCubit(this.productUseCase) : super(InitState());

  ListProductEntity? productEntity;
  List<ProductEntity?> listProductEntity = [];
  List<ProductEntity?> searchProductEntity = [];

  Future<void> getProduct() async {
    emit(LoadingState());
    productEntity = await productUseCase.call();
    if (productEntity != null) {
      listProductEntity = productEntity!.listProductEntity!;
      searchProductEntity = productEntity!.listProductEntity!;
      emit(SuccessState());
    }
    if (productEntity == null) {
      emit(ErrorState());
    }
  }

  void setSearchList(String item) {
    List<ProductEntity?> results = [];
    if (item.isEmpty) {
      results = listProductEntity;
      searchProductEntity = results;
      emit(LoadingState());
      emit(SuccessState());
    } else {
      results = listProductEntity;
      results = results
          .where(
            (results) => results!.name!.toLowerCase().contains(item.toLowerCase()),
          )
          .toList();
      searchProductEntity = results;
      emit(LoadingState());
      emit(SuccessState());
    }
  }
}
