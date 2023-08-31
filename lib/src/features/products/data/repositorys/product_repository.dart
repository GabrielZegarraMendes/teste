import 'package:works_app/src/features/products/domain/entities/product_entity.dart';
import 'package:works_app/src/features/products/domain/repositorys/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<ListProductEntity?> getProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return ListProductEntity();
  }
}