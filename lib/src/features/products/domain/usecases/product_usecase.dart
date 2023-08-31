
import 'package:works_app/src/features/products/domain/entities/product_entity.dart';
import 'package:works_app/src/features/products/domain/repositorys/product_repository.dart';

abstract class ProductUseCase {
  Future<ListProductEntity?>call();
}

class ProductUseCaseImpl implements ProductUseCase{

  final ProductRepository repository;
  ProductUseCaseImpl(this.repository);

  @override
  Future<ListProductEntity?> call() async{
    var result = await repository.getProducts();
    return result;
  }
}